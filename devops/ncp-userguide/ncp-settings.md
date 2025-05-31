# NCP(Naver Cloud Platform) 설정

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
    - 20, UDP, 10.0.0.0/16, 1-65535, 허용
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
    - TCP, 0.0.0.0/0, 80, 허용
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

### 도커 이미지 저장소 생성

- services> Containers> Container Registry > 레지스트리 생성
- 레지스트리 이름 : k8s-edu-(내가원하는영문자or숫자)
- 버킷 : docker-image 로 시작하는 위에서 만든 버킷 선택
- ‘생성’ 버튼 클릭

## NCloud Kubernetes Service

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
  - LB private subnet: bitcamp-vpc-private-lb-subnet
  - LB public subnet: bitcamp-vpc-public-lb-subnet
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
