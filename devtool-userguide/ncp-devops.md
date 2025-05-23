# NCP(Naver Cloud Platform) 데브옵스

## Container Registry 생성

도커 이미지를 저장할 저장소를 생성한다. 테라폼으로 생성할 수 없기 때문에 콘솔 웹 화면에서 직접 작업해야 한다.

- services> Containers> Container Registry > 레지스트리 생성
- 레지스트리 이름 : k8s-edu-(내가원하는영문자or숫자)
- 버킷 : `docker-image-xxx` 로 시작하는 위에서 만든 버킷 선택
- ‘생성’ 버튼 클릭

### 로그인 하기

```bash
$ sudo docker login k8s-edu-camp71.kr.ncr.ntruss.com
Username: Access Key ID
Password: Secret Key
```

## SourceCommit 사용법

### 외부 리포지토리 복사

#### 테스트용 백엔드 애플리케이션

- 기본 설정
  - 리포지토리 이름: `hello-api`
  - 리포지토리 설명: `백엔드 애플리케이션`
  - 복사할 Git URL: `https://github.com/eomjinyoung/hello-api.git`
  - Git 연결 확인: 확인 클릭
  - 다음
- 보안상품 연동
  - 다음
- Object Storage 연동
  - 다음
- 최종 확인
  - 생성
- Object Storage 연동 설정
  - `Object Storage 연동 설정` 버튼 클릭
  - 버킷: `source-commit-xxx` 버킷 선택
  - 설정
- `hello-api` 리포지토리 선택
  - `설정 변경` 버튼 클릭
  - `Git LFS를 Object Storage 버킷과 연동하기` 선택
  - 저장

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

### GIT 저장소 접속 암호 설정

- `GIT 계정/GIT SSH 설정` 버튼 클릭
  - Password: 접속암호
  - Confirm Password: 접속암호
  - 적용

### 로컬에 리포지토리 복제

- 백엔드 애플리케이션

```bash
$ git clone https://devtools.ncloud.com/3051993/hello-api.git
Cloning into 'hello-api'...
Username for 'https://devtools.ncloud.com': 사용자아이디
Password for 'https://teacher01@devtools.ncloud.com': 위에서설정한접속암호
```

- 프론트엔드 애플리케이션

```bash
$ git clone https://devtools.ncloud.com/3051993/hello-api.git
Cloning into 'hello-api'...
Username for 'https://devtools.ncloud.com': 사용자아이디
Password for 'https://teacher01@devtools.ncloud.com': 위에서설정한접속암호
```

## SourceBuild 사용법

### 백엔드 프로젝트 빌드

#### 빌드 프로젝트 생성

- 필수 준비 사항
  - Object Storage: 사용중
  - 다음
- 기본 설정
  - 빌드 프로젝트 이름: `hello-api`
  - 빌드 프로젝트 설명: `백엔드 프로젝트`
  - 빌드 대상: SourceCommit
  - 리포지토리: hello-api
  - 브랜치: main
  - 알림: 체크 안함
  - 다음
- 빌드 환경 설정
  - 빌드 환경 이미지: SourceBuild에서 관리되는 이미지
  - 운영체제: ubuntu 16.04(x64)
  - 빌드 런타임: java
  - 빌드 런타임 버전: 17
  - 도커 이미지 빌드: 체크
  - 도커 엔진 버전: Docker 최신 버전
  - 컴퓨팅 유형: 2vCpu 4GB 메모리
  - 타임 아웃: 10분
  - 환경 변수 등록: 없음
  - 다음
- 빌드 명령어 설정
  - 빌드 전 명령어: `chmod +x ./gradlew`
  - 빌드 명령어: `./gradlew bootJar`
  - 빌드 후 명령어: 없음
  - 도커 이미지 빌드 설정: 사용
    - Dockerfile 경로: `./Dockerfile`
    - Container Registry: `k8s-edu-xxx`
    - 이미지 이름: `hello-api`
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
    - `hello-api` 라는 이름의 도커 이미지가 등록된 것을 확인

### 프론트엔드 프로젝트 빌드

#### 작업 호스트 준비

- 도커 설치 스크립트 다운로드

```bash
$ sudo apt-get update
$ sudo apt-get install curl
$ curl https://get.docker.com > docker-install.sh
$ chmod 755 docker-install.sh
```

- 도커 설치

```bash
$ sudo ./docker-install.sh
```

#### next.js 빌드 컨테이너 생성 및 등록

- `Dockerfile` 파일

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
  - 빌드 전 명령어: `npm install`
  - 빌드 명령어: `npm run build`
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

### 작업 호스트 준비

#### kubectl 바이너리 설치

- 최신 릴리즈 다운로드

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

- 다운로드 받은 파일 검증

```bash
# 체크섬 파일 다운로드
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# 다운로드 파일의 체크섬과 비교
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```

- kubectl 설치

```bash
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

- 버전 확인

```bash
kubectl version --client

# 설치된 버전의 상세 내용 확인
kubectl version --client --output=yaml
```

#### ncp-iam-autthenticator 설치

- 설치파일 다운로드

```bash
cd ~
curl -o ncp-iam-authenticator https://kr.object.ncloudstorage.com/nks-download/ncp-iam-authenticator/v1.0.0/linux/amd64/ncp-iam-authenticator
```

- 바이너리 실행 권한 추가

```bash
chmod +x ./ncp-iam-authenticator
```

- $HOME/bin/ncp-iam-authenticator를 생성하고 $PATH에 추가

```bash
mkdir -p $HOME/bin && cp ./ncp-iam-authenticator $HOME/bin/ncp-iam-authenticator && export PATH=$PATH:$HOME/bin
```

- Shell Profile에 PATH를 추가 후 명령어가 잘 작동하는지 확인

```bash
$ nano .bash_profile
# .bashrc 파일이 존재하면 실행
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# 사용자 bin 디렉토리를 PATH에 추가
export PATH="$PATH:$HOME/bin"
```

```bash
source ~/.bash_profile # 현재 쉘에 변경사항 적용
ncp-iam-authenticator help # PATH에 잘 설정되었는지 확인
```

- 사용자 환경 홈 디렉터리의 .ncloud 폴더에 configure 파일 생성

```bash
$ mkdir .ncloud
$ nano ~/.ncloud/configure
[DEFAULT]
ncloud_access_key_id = <사용자의 Access key>
ncloud_secret_access_key = <사용자의 Secret key>
ncloud_api_url = https://ncloud.apigw.ntruss.com
```

- ncp-iam-authenticator create-kubeconfig 명령을 사용하여 kubeconfig를 생성
  `clusterUuid`는 Kubernetes Service / clusters 화면에서 확인한다.

```bash
# kubeconfig.yml 파일을 생성할 때 당장 사용해야 하기 때문에 임시 설정할 필요가 있다.
$ export NCLOUD_ACCESS_KEY=<사용자의 Access key>
$ export NCLOUD_SECRET_KEY=<사용자의 Secret key>
$ export NCLOUD_API_GW=https://ncloud.apigw.ntruss.com
$ ncp-iam-authenticator create-kubeconfig --region KR --clusterUuid <cluster-uuid> > kubeconfig.yml
```

- Kubeconfig 파일이 생성되면 kubectl 명령어를 테스트

```bash
kubectl get namespaces --kubeconfig kubeconfig.yml
```

- Kubeconfig 파일이 지정이 번거로울 경우, 아래와 같이 bash_profile 에 alias로 명시

```bash
echo "alias kubectl2='kubectl --kubeconfig=\$HOME/kubeconfig.yml'" >> ~/.bashrc
source ~/.bashrc
kubectl2 get namespaces
```

#### K8S에 Container Registry 저장소의 접근키 등록

```bash
kubectl2 create secret docker-registry regcred \
--docker-server=<private-registry-end-point> \
--docker-username=<access-key-id> \
--docker-password=<secret-key> \
--docker-email=<your-email>

kubectl2 get secret
```

### k8s 배포 파일 변경

- 백엔드 프로젝트 배포 파일: `k8s-deployment.yml`

```yml
생략...
containers:
  - name: hello-api
    image: <Container Registry 저장소의 Private Endpoint>/hello-api
    ports:
      - containerPort: 8080
생략...
```

- 프론트엔드 프로젝트 배포 파일: `k8s-deployment.yml`

```yml
생략...
containers:
  - name: hello-ui
    image: <Container Registry 저장소의 Private Endpoint>/hello-ui
    ports:
      - containerPort: 3000
생략...
```

### 배포 프로젝트 생성 및 시나리오 등록

#### 백엔드 프로젝트

- 배포 프로젝트 생성
  - 기본 설정
    - 프로젝트 이름: `hello-api`
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
    - 배포 프로젝트 이름: `hello-api`
    - 배포 stage: `real`
    - 배포 시나리오 이름: `k8s-deployment`
    - 배포 시나리오 설명: `쿠버네티스에 배포하기`
  - 매니페스트 설정
    - 매니페스트 파일 저장소: `SourceCommit`
    - 리포지토리 선택:
      - 리포지토리: `hello-api`
      - 브랜치: `main`
    - 매니페스트 파일 위치
      - 파일경로: `./k8s-deployment.yml` 파일 추가
      - 다음
  - 배포 전략 설정
    - 배포 전략: `Rolling` 선택
      - Rolling: 모든 Object 배포 가능
      - 블루/그린: Pod, Deployment, ReplicaSet, ReplicationController, DaemonSet, StatefulSet, Service 배포 가능
      - Canary: Pod, Deployment, ReplicaSet, ReplicationController, Service 배포 가능
  - 최종 확인
    - 배포 시나리오 생성

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
      - 파일경로: `./k8s-deployment.yml` 파일 추가
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

#### 백엔드 프로젝트

- 기본 설정
  - 파이프라인 이름: `hello-api`
  - 파이프라인 설명: `백엔드 프로젝트 파이프라인`
- 파이프라인 구성
  - 작업추가
    - 이름: `build-001`
    - 타입: `SourceBuild`
    - 프로젝트: `hello-api`
    - 연결정보
      - 타입: SourceCommit
      - 리포지토리: hello-api
      - 브랜치: main
    - 확인
  - 작업추가
    - 이름: `deploy-001`
    - 타입: `SourceDeploy`
    - 프로젝트: `hello-api`
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
      - 리포지토리 이름: `hello-api`
      - 브랜치: main
      - 추가
  - 다음
- 최종확인
  - 파이프라인 생성

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

## Helm 설치

```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
helm version
```

## NGINX Ingress Controller 설치

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --kubeconfig ~/kubeconfig.yml
```

- 이전에 설치한 것 삭제하기

```bash
helm uninstall ingress-nginx --namespace ingress-nginx --kubeconfig ~/kubeconfig.yml
```

- 설치 확인

```bash
kubectl2 get pods -n ingress-nginx
```

- 외부 IP 확인

```bash
kubectl2 get svc -n ingress-nginx
```

## Cert-Manager 설치

```bash
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --kubeconfig ~/kubeconfig.yml
```

- 설치 확인

```bash
kubectl2 get pods -n cert-manager
```

- 삭제

```bash
helm uninstall cert-manager --namespace cert-manager --kubeconfig ~/kubeconfig.yml
kubectl2 delete crd certificaterequests.cert-manager.io \
  certificates.cert-manager.io \
  challenges.acme.cert-manager.io \
  clusterissuers.cert-manager.io \
  issuers.cert-manager.io \
  orders.acme.cert-manager.io \
  --kubeconfig ~/kubeconfig.yml
kubectl2 get crd --kubeconfig ~/kubeconfig.yml | grep cert-manager
```

## Let's Encrypt ClusterIssuer 생성

- production 환경용

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: your-email@example.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod-account-key
    solvers:
      - http01:
          ingress:
            class: nginx
```

- 적용

```bash
kubectl2 apply -f cluster-issuer-prod.yml
```
