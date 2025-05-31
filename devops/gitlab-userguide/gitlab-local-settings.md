# 데브옵스 설정 - 로컬 환경

## GitLab 설치

- Git 저장소
- 프로젝트 관리
- CI/CD 파이프라인 정의 및 스케줄링
- 프로젝트 루트에 `.gitlab-ci.yml` 파일을 만들어 CI/CD Job을 정의
  - CI/CD 를 실행하면 Job을 **GitLab Runner** 에게 전달

### 도커 볼륨 디렉토리 생성

GitLab 컨테이너의 볼륨으로 사용할 디렉토리를 준비한다.

- 사용자 홈에 볼륨용 디렉토리 생성

```bash
mkdir -p ~/gitlab
```

- 환경 변수 설정

```bash
echo 'export GITLAB_HOME=~/gitlab' >> ~/.zshrc
source ~/.zshrc
```

- 확인하기

```bash
echo $GITLAB_HOME
```

**GitLab 컨테이너** 는 호스트에 연결된 볼륨을 사용한다.

- `$GITLAB_HOME/data`
  - `/var/opt/gitlab`
  - 애플리케이션 데이터를 보관한다.
- `$GITLAB_HOME/logs`
  - `/var/log/gitlab`
  - 로그를 보관한다.
- `$GITLAB_HOME/config`
  - `/etc/gitlab`
  - GitLab 설정 파일을 보관한다.

### 도커 컴포즈(`docker-compose.yml`) 파일 생성

- [docker-compose.yml](./docker-compose.yml)

### 도커 컨테이너 생성 및 실행

- **GitLab** 컨테이너 생성 및 실행

```bash
docker compose up -d
```

- 웹브라우저에서 **GitLab** 컨테이너 접속 확인

```
http://localhost:8929
```

- **GitLab** `root` 사용자 암호 알아내기

```bash
sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

## GitLab Runner 설치

- GitLab 에서 정의한 CI/CD Job을 실제로 수행하는 에이전트이다.
- `npm install`, `docker build`, `kubectl apply` 등을 실행한다.

### 개요

- `Helm`
  - 쿠버네티스 애플리케이션을 정의하고, 설치하고, 관리할 수 있게 해주는 패키지 관리자다.
  - `apt`, `yum`, `brew` 같은 역할을 수행한다.
- `Helm chart`
  - **쿠버네티스 애플리케이션의 설치 패키지**(정의서, 템플릿, 설정값 포함) 이다.
  - `deb`, `rpm`, `formula` 같은 역할이다.
  - `Helm` 을 통해 설치된다.
- [ArtifactHub](https://artifacthub.io/)
  - `Helm chart` 저장소이다.

### `values.yml` 설정 파일 준비하기

- `GitLab` 등록 토큰 확인하기

  - GitLab 웹 UI에서 등록 토큰 준비
    - 프로젝트 레벨: Settings > CI/CD > Runners > Set up a specific Runner manually
    - 인스턴스 레벨 (Admin only): Admin Area > Runners > Registration token
    - 예) `YG_N9n-9TxCyBJm7tu5B`

- 설정파일 참조

  - macOS(Apple Silicon): [gitlab-runner-values-macos.yml](./gitlab-runner-values-macos.yml)
  - Windows(Intel): [gitlab-runner-values-windows.yml](./gitlab-runner-values-windows.yml)

- Windows 특별 고려사항:
  - Docker 소켓: Windows Docker Desktop에서 Docker 소켓 경로가 정확한지 확인
  - 방화벽: Windows 방화벽이 Docker Desktop과 Kubernetes 통신을 차단하지 않는지 확인
  - WSL2: Windows에서 Docker Desktop이 WSL2 백엔드를 사용하는 경우 추가 네트워크 설정이 필요할 수 있음

### Helm char를 이용하여 쿠버네티스에 GitLab Runner 설치하기

- `GitLab Runner` Helm 저장소를 추가한다.

```bash
helm repo add gitlab https://charts.gitlab.io
helm repo update
```

- 설치 가능한 `GitLab Runner` 버전 조회하기

```bash
helm search repo -l gitlab/gitlab-runner

# 만약 최신 버전이 보이지 않으면 저장소를 update 한다.
helm repo update gitlab
```

- 현재 kubectl 이 어떤 클러스터에 연결되었는지 확인하기
  - `docker-desktop` 이면 도커 데스크톱 내장 쿠버네티스에 연결된 상태다.

```bash
kubectl config current-context
```

- 네임스페이스 생성하기

```bash
kubectl create namespace gitlab-runner
```

- 생성된 네임스페이스 확인하기

```bash
kubectl get namespaces
```

- **GitLab Runner** 설치

```bash
# values.yml 파일로 설치할 때
helm install gitlab-runner gitlab/gitlab-runner \
  --namespace gitlab-runner \
  --values values.yml
```

- **GitLab Runner** 삭제

```bash
helm uninstall gitlab-runner -n gitlab-runner
# 또는
helm delete --namespace gitlab-runner gitlab-runner
```

- 설치 확인

```bash
# 러너 상태 확인
kubectl get pods -n gitlab-runner

# 로그 확인
kubectl logs -n gitlab-runner <runner-pod-name>
# 또는
kubectl logs -f deployment/gitlab-runner -n gitlab-runner

# 노드 아키텍처 확인
kubectl get nodes -o wide

# 러너 등록 확인
kubectl describe configmap gitlab-runner -n gitlab-runner
```

- 로그 확인

```bash
kubectl logs -n gitlab-runner <runner-pod-name>
```

## Docker Desktop 에 NGINX Ingress Controller 설치

### 설치 확인

- ingress-nginx 네임스페이스 존재 확인

```bash
kubectl get namespaces | grep ingress
```

- Ingress Controller Pod 확인

```bash
# ingress-nginx 네임스페이스의 모든 리소스 확인
kubectl get all -n ingress-nginx

# 또는 Pod만 확인
kubectl get pods -n ingress-nginx
```

- Service 확인

```bash
kubectl get svc -n ingress-nginx
```

- Ingress Class 확인

```bash
kubectl get ingressclass
```

### 설치하기

```bash
# NGINX Ingress Controller 설치
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# 설치 진행 상황 확인
kubectl get pods -n ingress-nginx -w

# 설치 완료까지 대기 (보통 1-2분)
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s
```

### 설치 후 테스트

- Ingress Controller 상태 확인

```bash
# Controller Pod 로그 확인
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller

# Service 외부 접속 확인
curl -I http://localhost/healthz
```

- 빠른 확인 명령어

```bash
# 한 번에 모든 상태 확인
echo "=== Namespaces ===" && kubectl get ns | grep ingress
echo "=== Pods ===" && kubectl get pods -n ingress-nginx
echo "=== Services ===" && kubectl get svc -n ingress-nginx
echo "=== IngressClass ===" && kubectl get ingressclass
```

## 참고

### JDK 배포판 도커 이미지

- `17-jdk`
  - Ubuntu
  - (최신)큰 편
  - 호환성 좋음, 안정적
  - 크기가 큼
- `17-jdk-noble`
  - Ubuntu 24.04
  - 큰 편
  - 최신 패키지
  - 상대적으로 새로움
- `17-jdk-jammy`
  - Ubuntu 22.04
  - 큰 편
  - 검증된 안정성
  - 크기가 큼
- `17-jdk-focal`
  - Ubuntu 20.04
  - 큰 편
  - 레거시 호환성
  - 구버전
- `17-jdk-alpine`
  - Alpine
  - 작음
  - 매우 가벼움
  - 호환성 이슈 가능
