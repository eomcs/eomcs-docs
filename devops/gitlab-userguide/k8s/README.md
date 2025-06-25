# 데브옵스 설정 - 로컬 쿠버네티스 클러스터에 구축하기

로컬 Docker Desktop에 내장된 구버네티스 클러스터에 GibLab를 설치하여 CI/CD 개발 환경을 구축하는 것.

관련 파일
- k8s manifest 파일: gitlab-devops-complete.yml
- deploy shell script 파일: deploy-devops.sh
- gitlab runner 등록 파일: register-runner.sh

## GitLab 개요

- Git 저장소
- 프로젝트 관리
- CI/CD 파이프라인 정의 및 스케줄링
- 프로젝트 루트에 `.gitlab-ci.yml` 파일을 만들어 CI/CD Job을 정의
  - CI/CD 를 실행하면 Job을 **GitLab Runner** 에게 전달

## GitLab 설치

### 파일들

- `gitlab.yml`: GitLab 설치 manifest 파일
- `gitlab-runner-values-arm64.yml`: ARM64 호환 Helm values
- `deploy-helm.sh`: Helm을 이용한 GitLab 배포 쉘스크립트
- `cleanup-helm.sh`: Helm으로 설정한 자원들의 삭제 및 정리
- `install-runner-helm.sh`: Helm을 이용한 GitLab Runner 설치

### 1. GitLab 배포

```bash
# 쿠버네티스에 gitlab 서버 배치하기
chmod +x *.sh
./deploy-helm.sh

# 참고: 호스트의 경로를 pod와 연결할 수 있는지 시험하기
./check-hostpath.sh
```

### 2. GitLab 준비 대기 (5-10분)

```bash
# 로그 모니터링
kubectl logs -n devops deployment/gitlab -f

# 준비 상태 확인
kubectl get pods -n devops
```

### 3. Registration Token 확인

```bash
# 자동 확인 시도
kubectl exec -n devops deployment/gitlab -- gitlab-rails runner "puts Gitlab::CurrentSettings.runners_registration_token"

# 또는 웹 UI에서 확인
# http://localhost:8929/admin/runners
```

### 4. Runner 설치

```bash
chmod +x install-runner-helm.sh
./install-runner-helm.sh
```

### 4. 확인

```bash
# Helm 릴리스 확인
helm list -n devops

# Runner 상태 확인
kubectl get pods -n devops
```

## GitLab 로그인

```bash
# root 암호 알아내기 방법1:
kubectl exec -n devops deployment/gitlab -- cat /etc/gitlab/initial_root_password

# root 암호 알아내기 방법2:
find /Users/eomjinyoung/gitlab-devops -name 'initial_root_password' -exec cat {} \;
```

## 관리 명령어

```bash
# Runner 업그레이드
helm upgrade gitlab-runner gitlab/gitlab-runner -n devops --values values-arm64.yml

# Runner 상태 확인
helm status gitlab-runner -n devops

# Runner 제거
helm uninstall gitlab-runner -n devops

# 전체 환경 정리
./cleanup-helm.sh

# 로그 확인
kubectl logs -n devops <runner-pod-name>
```

## NGINX Ingress Controller 설치

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
