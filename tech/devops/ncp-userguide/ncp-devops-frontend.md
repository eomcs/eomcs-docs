# NCP(Naver Cloud Platform) 데브옵스 - 프론트엔드 프로젝트

## SourceCommit 사용법

### 외부 리포지토리 복사

#### 테스트용 프론트엔드 애플리케이션

- 기본 설정
  - 리포지토리 이름: `hello-ui`
  - 리포지토리 설명: `프론트엔드 애플리케이션`
  - 복사할 Git URL: `https://github.com/eomjinyoung/hello-ui.git`
  - Git 연결 확인: 확인 클릭
  - 다음
- 보안상품 연동
  - 다음
- Object Storage 연동
  - `Object Storage 버킷 연동하기` 선택
  - 다음
- 최종 확인
  - 생성
- Object Storage 연동 설정(안했으면)
  - `Object Storage 연동 설정` 버튼 클릭
  - 버킷: `source-commit-xxx` 버킷 선택
  - 설정
- `hello-ui` 리포지토리 선택(안했으면)
  - `설정 변경` 버튼 클릭
  - `Git LFS를 Object Storage 버킷과 연동하기` 선택
  - 저장  

### GIT 저장소 접속 암호 설정(안했으면)

- `GIT 계정/GIT SSH 설정` 버튼 클릭
  - Password: 접속암호
  - Confirm Password: 접속암호
  - 적용

### 로컬에 리포지토리 복제

```bash
$ git clone https://devtools.ncloud.com/3051993/hello-ui.git
Cloning into 'hello-ui'...
Username for 'https://devtools.ncloud.com': 사용자아이디
Password for 'https://teacher01@devtools.ncloud.com': 위에서설정한접속암호
```

## SourceBuild 사용법

### next.js 빌드 컨테이너 생성 및 등록

- `Dockerfile` 파일
  - 작업 호스트에서 수행한다.
```dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl ca-certificates gnupg build-essential git \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# bash를 기본 커맨드로 설정해서 docker run -it 할 때 바로 셸을 사용하도록
CMD ["/bin/bash"]
```

- 도커 이미지 빌드

```bash
$ sudo docker build -t nextjs-builder .
```

- 도커 이미지 태깅
  - `sudo docker tag local-image:tagname new-repo:tagname`

```bash
$ sudo docker tag nextjs-builder <Container Registry 저장소의 Public Endpoint>/nextjs-builder
```

- Container Registry 로그인

```bash
$ sudo docker login <Container Registry 저장소의 Public Endpoint>
Username: Access Key ID
Password: Secret Key
```

- Container Registry에 도커 이미지 등록

```bash
$ sudo docker push <Container Registry 저장소의 Public Endpoint>/nextjs-builder
```

- Container Registry에 등록된 도커 이미지 확인

### 프론트엔드 프로젝트 빌드

### 도커 이미지 빌드 파일 생성

- 프로젝트루트/`Dockerfile`
  - 예제 파일: [Dockerfile](./frontend/Dockerfile) 
- git 저장소에 push

### `.env.production` 파일 변경

- 백엔드 REST API 서버 주소 변경

```js
# Backend Server
NEXT_PUBLIC_REST_API_URL=https://api.eomcs.com
```

#### 빌드 프로젝트 생성

- 필수 준비 사항
  - Object Storage: 사용중
  - 다음
- 기본 설정
  - 빌드 프로젝트 이름: `hello-ui`
  - 빌드 프로젝트 설명: `프론트엔드 프로젝트`
  - 빌드 대상: SourceCommit
  - 리포지토리: hello-ui
  - 브랜치: main
  - 알림: 체크 안함
  - 다음
- 빌드 환경 설정
  - 빌드 환경 이미지: `Container Registry 의 이미지`
  - 운영체제: Linux 이미지만 사용 가능합니다.
  - 레지스트리: `k8s-edu-xxx`
  - 이미지: `nextjs-builder`
  - 태그: `latest`
  - 도커 이미지 빌드: 체크
  - 도커 엔진 버전: Docker 최신 버전
  - 컴퓨팅 유형: 4vCpu 8GB 메모리
  - 타임 아웃: 20분
  - 환경 변수 등록: 없음
  - 다음
- 빌드 명령어 설정
  - 빌드 전 명령어: 
    - `npm ci`
  - 빌드 명령어: 
    - `export NEXT_TELEMETRY_DISABLED=1 `
    - `npm run build`
  - 빌드 후 명령어: 없음
  - 도커 이미지 빌드 설정: 사용
    - Dockerfile 경로: `./Dockerfile`
    - Container Registry: `k8s-edu-xxx`
    - 이미지 이름: `hello-ui`
    - 이미지 태그: `1.0.#`
      - latest로 설정: 체크
    - 다음
- 업로드 설정
  - 결과물 업로드 설정
    - 빌드 결과물: 결과물 저장 안함
  - 빌드 완료 후 이미지 업로드 설정
    - 빌드 이미지: 이미지 저장 안함
      - 빌드 환경 자체를 이미지로 저장하여 업로드 하는 것.
        - 빌드에 필요한 패키지를 다운로드
        - 빌드에 사용할 환경변수를 설정
      - 즉 빌드를 위해 준비한 상태 그대로 백업한다.
      - 이후에 빌드 준비 과정을 수행할 필요가 없기 때문에 빌드 시간을 줄일 수 있다.
      - 빌드 셋업이 복잡하지 않을 경우 저장할 필요 없음.
  - 다음
- 추가 상품 연동
  - 로그 상품 연동
    - Cloud Log Analytics 연동: 연동함
      - 최근 30일 간의 로그를 저장함.
      - 연동하지 않는 경우, 가장 최신 빌드 로그만 제공한다.
  - 보안 상품 연동
    - File Safer (File Filter) 연동: 사용 안함
  - 다음
- 최종 확인
  - 생성

#### 프로젝트 빌드 테스트

- 프로젝트 선택
  - `빌드로 이동` 클릭
  - `빌드 시작하기` 클릭
  - 빌드 로그 확인
- Container Registry에 도커 이미지 등록 확인
  - 레지스트리 목록에서
    - `이미지 리스트` 컬럼의 `이동` 버튼 클릭
    - `hello-ui` 라는 이름의 도커 이미지가 등록된 것을 확인

## SourceDeploy 사용법

### 쿠버네티스 매니페스트 파일 생성

- 프로젝트루트/`k8s-deployment.yml`
  - 예제 파일: [k8s-deployment.yml](./frontend/k8s-deployment.yml)

### 쿠버네티스 매니페스트 파일 변경

- `k8s-deployment.yml` 변경

```yml
생략...
containers:
  - name: hello-ui
    image: <Container Registry 저장소의 Private Endpoint>/hello-ui
    ports:
      - containerPort: 3000
생략...
```

### HTTPS NGINX Ingress 매니페시스 파일 생성

- 프로젝트루트/`nginx-ingress-https.yml`
  - 예제 파일: [nginx-ingress-https.yml](./frontend/nginx-ingress-https.yml)


### 배포 프로젝트 생성 및 시나리오 등록

#### 프론트엔드 프로젝트

- 배포 프로젝트 생성
  - 기본 설정
    - 프로젝트 이름: `hello-ui`
  - 배포 환경 설정
    - 배포 Stage
      - dev: 설정 안함
      - test: 설정 안함
      - real: 설정
        - 배포 타겟: Ncloud Kubernetes Service
        - Cluster: `k8s-20250417`
  - 최종 확인
    - 배포 프로젝트 생성
- 배포 시나리오 생성
  - 배포 프로젝트 선택
  - 배포 시나리오 `생성` 버튼 클릭
  - 기본 설정
    - 배포 프로젝트 이름: `hello-ui`
    - 배포 stage: `real`
    - 배포 시나리오 이름: `k8s-deployment`
    - 배포 시나리오 설명: `쿠버네티스에 배포하기`
  - 매니페스트 설정
    - 매니페스트 파일 저장소: `SourceCommit`
    - 리포지토리 선택:
      - 리포지토리: `hello-ui`
      - 브랜치: `main`
    - 매니페스트 파일 위치
      - 파일경로: 
        - `./k8s-deployment.yml` 파일 추가
        - `./nginx-ingress-https.yml` 파일 추가
      - 다음
  - 배포 전략 설정
    - 배포 전략: `Rolling` 선택
      - Rolling: 모든 Object 배포 가능
      - 블루/그린: Pod, Deployment, ReplicaSet, ReplicationController, DaemonSet, StatefulSet, Service 배포 가능
      - Canary: Pod, Deployment, ReplicaSet, ReplicationController, Service 배포 가능
  - 최종 확인
    - 배포 시나리오 생성

### 프로젝트 배포

- 배포 프로젝트 선택
  - 배포로 이동
- 배포 시나리오 선택
  - 배포 시작하기

## SourcePipeline 사용법

### 파이프라인 생성

#### 프론트엔드 프로젝트

- 기본 설정
  - 파이프라인 이름: `hello-ui`
  - 파이프라인 설명: `프론트엔드 프로젝트 파이프라인`
- 파이프라인 구성
  - 작업추가
    - 이름: `build-001`
    - 타입: `SourceBuild`
    - 프로젝트: `hello-ui`
    - 연결정보
      - 타입: SourceCommit
      - 리포지토리: hello-ui
      - 브랜치: main
    - 확인
  - 작업추가
    - 이름: `deploy-001`
    - 타입: `SourceDeploy`
    - 프로젝트: `hello-ui`
    - 스테이지: `real`
    - 시나리오: `k8s-deployment`
    - 연결정보
      - 타입: nks
      - 정보: ./k8s-deployment.yml
    - 확인
  - 선행작업
    - build-001: 선행작업 없음
    - deploy-001: `build-001`
  - 트리거 설정
    - 종류: Push 체크
    - Push 설정
      - 리포지토리 종류: sourcecommit
      - 리포지토리 이름: `hello-ui`
      - 브랜치: main
      - 추가
  - 다음
- 최종확인
  - 파이프라인 생성

