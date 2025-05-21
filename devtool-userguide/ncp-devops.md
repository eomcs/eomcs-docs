# NCP(Naver Cloud Platform) 데브옵스

## SourceBuild 사용법

###

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

## Helm 설치

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
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

- 설치 확인

```bash
kubectl2 get pods -n ingress-nginx
```

- 외부 IP 확인

```bash
kubectl2 get svc -n ingress-nginx
```

## Cert-Manager 섶치

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
