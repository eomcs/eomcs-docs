# NCP(Naver Cloud Platform) 사용법

## 네트워크 준비

### VPC 준비

- bitcamp-vpc: 10.0.0.0/16

### Network ACL 준비

- bitcamp-vpc-web-nacl: 외부 접속 제어
  - Inbound 규칙
    - 15, TCP, 10.0.0.0/16, 1-65535, 허용
    - 20, TCP, myIP, 1-65535, 허용
    - 199, TCP, 0.0.0.0/0, 22, 차단
  - Outbound 규칙
    - 0, ICMP, 0.0.0.0/0, 허용
    - 10, TCP, 0.0.0.0/0, 허용
    - 20, UDP, 0.0.0.0/0, 허용
- bitcamp-vpc-public-lb-nacl: 로드밸런서용 외부 접속 제어
  - Inbound 규칙
    - 10, TCP, 0.0.0.0/0, 1-65535, 허용
  - Outbound 규칙
    - 10, TCP, 0.0.0.0/0, 1-65535, 허용
- bitcamp-vpc-privatre-lb-nacl: 로드밸런서용 내부 접속 제어
  - Inbound 규칙
    - 0, ICMP, 0.0.0.0/0, 허용
    - 10, TCP, 10.0.0.0/16, 1-65535, 허용
    - 10, UDP, 10.0.0.0/16, 1-65535, 허용
  - Outbound 규칙
    - 0, ICMP, 0.0.0.0/0, 허용
    - 10, TCP, 0.0.0.0/0, 허용
    - 20, UDP, 0.0.0.0/0, 허용

### Subnet 준비

- bitcamp-vpc-web: 외부 접속 서버
  - VPC: bitcamp-vpc
  - IP 주소 범위: 10.0.1.0/24
  - 가용 Zone: KR-2
  - Network ACL: bitcamp-vpc-web-nacl
  - Internet Gatway: Y
  - 용도 : 일반
- bitcamp-vpc-public-lb-subnet: 외부 접속 로드밸런서용 서브넷
  - VPC: bitcamp-vpc
  - IP 주소 범위: 10.0.255.0/24
  - 가용 Zone: KR-2
  - Network ACL: bitcamp-vpc-public-lb-nacl
  - Internet Gatway: Y
  - 용도: LoadBalancer
- bitcamp-vpc-private-lb-subnet: 내부 접속 로드밸런서용 서브넷
  - VPC: bitcamp-vpc
  - IP 주소 범위: 10.0.6.0/24
  - 가용 Zone: KR-2
  - Network ACL: bitcamp-vpc-private-lb-nacl
  - Internet Gatway: N
  - 용도: LoadBalancer

## 작업 Host 준비

### ACG 생성 및 설정

- Server > ACG 선택 > ACG 생성
  - ACG 이름: bitcamp-vpc-web-acg
  - VPC: bitcamp-vpc
  - 메모: 웹 접근 제어
  - 생성
- ACG 설정
  - Inbound 규칙
    - ICMP, 0.0.0.0/0, 허용
    - TCP, 0.0.0.0/16, 80, 허용
    - TCP, myIp, 22, 허용
    - TCP, 10.0.0.0/16, 22, 허용
  - Outbound 규칙
    - 0, ICMP, 0.0.0.0/0, 1-65535, 허용
    - 10, TCP, 0.0.0.0/0, 1-65535, 허용
    - 20, UDP, 0.0.0.0/0, 1-65535, 허용

### 서버 생성

- Server > Server > 서버 생성
  - 서버 이미지: ubuntu-24.04
    - 다음
  - 서버 설정
    - VPC: bitcamp-vpc
    - Subnet: bitcamp-vpc-web
    - 서버 스텍: High-CPU, c2-g3(vCPU 2EA, Memory 4GB)
    - 요금제: 시간 요금제
    - 서버 대수: 1
    - 서버 이름: bitcamp-server1
    - 입력하신 서버 이름으로 hostname을 설정: 체크
    - Network Interface IP: 10.0.1.100
    - 공인 IP: 새로운 공인 IP 할당
    - 물리 배치 그룹: 미사용
    - 반납 보호: 해제
    - 메모:
    - Script 선택:
    - 다음
  - 스토리지 설정
    - 크기: 50GB
    - 다음
  - 인증키 설정
    - 새로운 인증키 생성
      - 인증키 이름: bitcamp-teacher01
    - 다음
  - 네트워크 접근 설정
    - eth0: bitcamp-vpc-web-acg
    - 다음
  - 최종 확인
    - 서버 생성

### 사용자 등록

- 사용자 생성
  - `$ adduser bitcamp`
- 사용자에게 sudo 권한 부여
  - `$ visudo`
  - 편집기에서 다음 항목 추가
    - `bitcamp ALL=(ALL) ALL`

## Container Registry

### Object Storage Bucket 생성

- Services > Storage > Object Storage > 버킷 생성
- 버킷 이름 : docker-image-(내가원하는영문자or숫자)

### 이미지 저장소 생성

- services> Containers> Container Registry > 레지스트리 생성
- 레지스트리 이름 : k8s-edu-(내가원하는영문자or숫자)
- 버킷 : docker-image 로 시작하는 위에서 만든 버킷 선택
- ‘생성’ 버튼 클릭

### 로그인 하기

```bash
$ sudo docker login k8s-edu-camp71.kr.ncr.ntruss.com
Username: Access Key ID
Password: Secret Key
```

### 이미지에 태깅하기

```bash
$ sudo docker tag local-image:tagname new-repo:tagname
$ sudo docker tag myproject-backend-auth k8s-edu-camp71.kr.ncr.ntruss.com/myproject-backend-auth
```

#### 저장소에 이미지 올리기

```bash
$ sudo docker push k8s-edu-camp71.kr.ncr.ntruss.com/<TARGET_IMAGE[:TAG]>
$ sudo docker push k8s-edu-camp71.kr.ncr.ntruss.com/myproject-backend-auth
```

#### 저장소에 업로드한 이미지 가져오기

```bash
$ sudo docker pull k8s-edu-camp71.kr.ncr.ntruss.com/<TARGET_IMAGE[:TAG]>
$ sudo docker pull k8s-edu-camp71.kr.ncr.ntruss.com/myproject-backend-auth
```

#### 가져온 이미지로 컨테이너 생성, 실행 및 접속

도커 이미지 목록 확인하기

```bash
$ sudo docker images
```

도커 이미지로 컨테이너 생성 및 실행

```bash
$ sudo docker run -d --env-file .env -p 8010:8010 --name auth-server k8s-edu-118.kr.ncr.ntruss.com/myproject-backend-auth
```

## NCloud Kubernetes Service

### 준비

#### Kubectl 설치

`kube-userguide.md` 참조

### NKS 생성

#### 클러스터 생성

- 클러스터 기본 정보 입력
  - 클러스터 이름: k8s-실습날짜
  - 하이퍼바이저: KVM
  - 클러스터 버전: 가장 최신 버전
  - CNI Plugin: cilium
  - VPC: bitcamp-vpc
  - 가용 zone: KR-2
  - 네트워크 타입: Public
  - subnet: bitcamp-vpc-web
  - LB private subnet: lb-private-subnet
  - LB public subnet: bitcamp-vpc-lb-subnet
  - Audit Log : 미설정
  - 반납보호: 미설정
- 노드 풀 추가
  - 노드 풀 이름: default-pool
  - 서버 이미지: Ubuntu 22.04
  - 서버타입: [Standard] s2-g3
  - 노드 수: 1
  - Subnet: 자동 할당
  - Storage Size: 100
  - Node IAM Role, Kubernetes, Taint: 설정 안함
  - 추가
- 로그인 키 설정
- 생성

#### ncp-iam-autthenticator 설치

1. 설치파일 다운로드

```bash
cd ~
curl -o ncp-iam-authenticator https://kr.object.ncloudstorage.com/nks-download/ncp-iam-authenticator/v1.0.0/linux/amd64/ncp-iam-authenticator
```

2. 바이너리 실행 권한 추가

```bash
chmod +x ./ncp-iam-authenticator
```

3. $HOME/bin/ncp-iam-authenticator를 생성하고 $PATH에 추가

```bash
mkdir -p $HOME/bin && cp ./ncp-iam-authenticator $HOME/bin/ncp-iam-authenticator && export PATH=$PATH:$HOME/bin
```

4. Shell Profile에 PATH를 추가 후 명령어가 잘 작동하는지 확인

```bash
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile
ncp-iam-authenticator help
```

5. API 인증키값 설정
   다음 작업을 위해 임시적으로 필요

```bash
export NCLOUD_ACCESS_KEY=<사용자의 Access key>
export NCLOUD_SECRET_KEY=<사용자의 Secret key>
export NCLOUD_API_GW=https://ncloud.apigw.ntruss.com
```

6. 사용자 환경 홈 디렉터리의 .ncloud 폴더에 configure 파일 생성

```bash
mkdir .ncloud
nano ~/.ncloud/configure
```

```
[DEFAULT]
ncloud_access_key_id = <사용자의 Access key>
ncloud_secret_access_key = <사용자의 Secret key>
ncloud_api_url = https://ncloud.apigw.ntruss.com
```

7. ncp-iam-authenticator create-kubeconfig 명령을 사용하여 kubeconfig를 생성
   `clusterUuid`는 Kubernetes Service / clusters 화면에서 확인한다.

```bash
ncp-iam-authenticator create-kubeconfig --region KR --clusterUuid <cluster-uuid> > kubeconfig.yml
```

8. Kubeconfig 파일이 생성되면 kubectl 명령어를 테스트

```bash
kubectl get namespaces --kubeconfig kubeconfig.yml
```

9. Kubeconfig 파일이 지정이 번거로울 경우, 아래와 같이 bash_profile 에 alias로 명시

```bash
nano ~/.bashrc
alias kubectl2='kubectl --kubeconfig=$HOME/kubeconfig.yml'   -> 파일 맨 밑에 alias 내용 추가
source ~/.bashrc
kubectl2 get namespaces
```

#### Container Registry의 Access/Scret Key를 저장한 Secret 옵브젝트 생성

```bash
kubectl2 create secret docker-registry regcred \
--docker-server=<private-registry-end-point> \
--docker-username=<access-key-id> \
--docker-password=<secret-key> \
--docker-email=<your-email>

kubectl get secret
```

### Pod, Deployment, Service 생성

## SourceBuild 사용법

### node.js 최신 lts 버전 설치(빌드 컨테이너 만들 때)

```bash
apt-get update
apt-get install -y curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v
nvm current
npm -v
apt-get install -y git wget zip build-essential apt-transport-https
# node가 설치된 파일 경로를 /usr/bin/ 폴더에 링크 추가해야 한다.
```

### 빌드 프로젝트 생성

- 기본 설정
  - 빌드 프로젝트 이름: `auth-server`
  - 빌드 프로젝트 설명: `사용자 인증 백엔드 서버 프로젝트`
  - 빌드 대상: SourceCommit
  - 리포지토리: myproject-backend-auth
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
- 빌드 명령어 설정
  - 빌드 전 명령어: 없음
  - 빌드 명령어: `./gradlew bootJar`
  - 빌드 후 명령어: 없음
  - 도커 이미지 빌드 설정: 사용
    - Dockerfile 경로: `./Dockerfile`
    - Container Registry: `k8s-edu-camp71`
    - 이미지 이름: `myproject-backend-auth`
    - 이미지 태그: `latest`
      - latest로 설정: 체크
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
- 추가 상품 연동
  - 로그 상품 연동
    - Cloud Log Analytics 연동: 연동함
    - 최근 30일 간의 로그를 저장함.
    - 연동하지 않는 경우, 가장 최신 빌드 로그만 제공한다.
  - 보안 상품 연동
    - File Safer (File Filter) 연동: 사용 안함
- 최종 확인
  - 생성

### 프로젝트 빌드

- 프로젝트 선택
  - `빌드로 이동` 클릭
- `빌드 시작하기`

## SourceDeploy 사용법

### 배포 프로젝트 생성

- 배포 프로젝트 생성
  - 기본 설정
    - 프로젝트 이름: myproject-backend-auth
- 배포 환경 설정
  - 배포 Stage
    - dev: 설정 안함
    - test: 설정 안함
    - real: 설정
      - 배포 타겟: Ncloud Kubernetes Service
      - Cluster: k8s-20250417
- 최종 확인
  - 배포 프로젝트 생성

### 배포 시나리오 생성

- 기본 설정
  - 배포 프로젝트 이름: myproject-backend-auth
  - 배포 stage: real
  - 배포 시나리오 이름: `kube-deployment`
  - 배포 시나리오 설명: `쿠버네티스에 배포하기`
- 매니페스트 설정
  - 매니페스트 파일 저장소: SourceCommit
  - 리포지토리 선택:
    - 리포지토리: `myproject-backend-auth`
    - 브랜치: `main`
  - 매니페스트 파일 위치
    - 파일경로: `./kube/auth-server-secret.yml`
    - 파일경로: `./kube/auth-server-deployment.yml`
- 배포 전략 설정
  - 배포 전략: Rolling 선택
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

- 기본 설정
  - 파이프라인 이름: `myproject-backend-auth`
  - 파이프라인 설명: `사용자 인증 백엔드 프로젝트 파이프라인`
- 파이프라인 구성
  - 작업추가
    - 이름: `build-001`
    - 타입: `SourceBuild`
    - 프로젝트: `auth-server`
    - 연결정보
      - 타입: SourceCommit
      - 리포지토리: myproject-backend-auth
      - 브랜치: main
    - 확인
  - 작업추가
    - 이름: `deploy-001`
    - 타입: `SourceDeploy`
    - 프로젝트: `myproject-backend-auth`
    - 스테이지: `real`
    - 시나리오: `kube-deployment`
    - 연결정보
      - 타입: nks
      - 정보: ./kube/auth-server-secret.yml
    - 확인
  - 선행작업
    - build-001: 선행작업 없음
    - deploy-001: `build-001`
  - 트리거 설정
    - 종류: Push 체크
    - Push 설정
      - 리포지토리 종류: sourcecommit
      - 리포지토리 이름: myproject-backend-auth
      - 브랜치: main
      - 추가
  - 다음
- 최종확인
  - 파이프라인 생성
