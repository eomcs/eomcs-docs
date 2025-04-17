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

#### Subnet 준비

- bitcamp-vpc-web: 10.0.1.0/24

### NKS 생성

#### 클러스터 생성

NCE Lab 가이드 참조

```
kubectl create secret docker-registry regcred \
--docker-server=<private-registry-end-point> \
--docker-username=<access-key-id> \
--docker-password=<secret-key> \
--docker-email=<your-email>
```

#### Load Balancer Subnet 준비

- All Product > Networking > Load Balancer > Target Group > +Target Group 생성 클릭
  - Target Group 이름 : bitcamp-tg-8010
  - Target 유형 : VPC Server(10.0.0.0/16)
  - VPC : bitcamp-vpc
  - 프로토콜 : HTTP
  - 포트 : 8010
  - Health Check 설정
    - 프로토콜 : HTTP
    - 포트 : 8010
    - URL Path : /
    - HTTP Method : Head
    - Health Check : 30

#### NAT Gateway 준비

#### Cloud Log Analytics 준비
