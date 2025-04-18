# NCP(Naver Cloud Platform) 사용법

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

#### VPC 준비

- bitcamp-vpc: 10.0.0.0/16

#### Network ACL 준비

- bitcamp-vpc-web-nacl: 외부 접속 제어
  - Inbound 규칙
    - 15, TCP, 10.0.0.0/16, 1-65535, 허용
    - 20, TCP, myIP, 1-65535, 허용
    - 199, TCP, 0.0.0.0/0, 22, 차단
  - Outbound 규칙
    - 0, ICMP, 0.0.0.0/0, 허용
    - 10, TCP, 0.0.0.0/0, 허용
    - 20, UDP, 0.0.0.0/0, 허용
- bitcamp-vpc-lb-nacl: 로드밸러서용 외부 접속 제어
  - Inbound 규칙
    - 10, TCP, 0.0.0.0/0, 1-65535, 허용
  - Outbound 규칙
    - 10, TCP, 0.0.0.0/0, 1-65535, 허용
- bitcamp-vpc-privatre-nacl: 로드밸런서용 내부 접속 제어
  - Inbound 규칙
    - 0, ICMP, 0.0.0.0/0, 허용
    - 10, TCP, 10.0.0.0/16, 1-65535, 허용
    - 10, UDP, 10.0.0.0/16, 1-65535, 허용
  - Outbound 규칙
    - 0, ICMP, 0.0.0.0/0, 허용
    - 10, TCP, 0.0.0.0/0, 허용
    - 20, UDP, 0.0.0.0/0, 허용

#### Subnet 준비

- bitcamp-vpc-web: 외부 접속 서버
  - VPC: bitcamp-vpc
  - IP 주소 범위: 10.0.1.0/24
  - Network ACL: bitcamp-vpc-web-nacl
  - Internet Gatway: Y
  - 로드밸런서 전용 여부: N
- bitcamp-vpc-lb-subnet: 외부 접속 로드밸런서용 서브넷
  - VPC: bitcamp-vpc
  - IP 주소 범위: 10.0.255.0/24
  - Network ACL: bitcamp-vpc-lb-nacl
  - Internet Gatway: Y
  - 로드밸런서 전용 여부: Y
- lb-private-subnet: 내부 접속 로드밸런서용 서브넷
  - VPC: bitcamp-vpc
  - IP 주소 범위: 10.0.6.0/24
  - Network ACL: bitcamp-vpc-private-nacl
  - Internet Gatway: N
  - 로드밸런서 전용 여부: Y

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
  - Storage Size: 100
  - 노드 수: 1
  - Subnet: 자동 할당
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
kubectl get namespaces
```

#### Container Registry의 Access/Scret Key를 저장한 Secret 옵브젝트 생성

```bash
kubectl create secret docker-registry regcred \
--docker-server=<private-registry-end-point> \
--docker-username=<access-key-id> \
--docker-password=<secret-key> \
--docker-email=<your-email>

kubectl get secret
```

### Pod, Deployment, Service 생성
