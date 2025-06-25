#!/bin/bash
# deploy-devops-helm.sh - 로컬 DevOps 환경 배포 스크립트 (Helm 사용)

set -e

NAMESPACE="devops"
GITLAB_PORT="8929"
SSH_PORT="2222"
CURRENT_USER=$(whoami)
GITLAB_DATA_DIR="/Users/${CURRENT_USER}/gitlab-devops"

echo "=== 로컬 DevOps 환경 배포 시작 (Helm 방식) ==="
echo "사용자: ${CURRENT_USER}"
echo "GitLab: http://localhost:${GITLAB_PORT}"
echo "SSH: localhost:${SSH_PORT}"
echo "데이터 디렉토리: ${GITLAB_DATA_DIR}"
echo ""

# 필수 도구 확인
echo "🔧 필수 도구 확인 중..."

# Kubernetes 확인
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ 오류: Kubernetes 클러스터에 연결할 수 없습니다."
    echo "Docker Desktop에서 Kubernetes가 활성화되어 있는지 확인하세요."
    exit 1
fi
echo "✅ Kubernetes 클러스터 연결 확인"

# Helm 확인
if ! command -v helm &> /dev/null; then
    echo "❌ 오류: Helm이 설치되어 있지 않습니다."
    echo "Helm을 설치하세요: https://helm.sh/docs/intro/install/"
    exit 1
fi
echo "✅ Helm 설치 확인 ($(helm version --short))"

# 호스트 디렉토리 생성
echo "📁 GitLab 데이터 디렉토리 준비 중..."
if [ ! -d "${GITLAB_DATA_DIR}" ]; then
    echo "   디렉토리 생성: ${GITLAB_DATA_DIR}"
    mkdir -p "${GITLAB_DATA_DIR}"/{config,logs,data}
    chmod -R 755 "${GITLAB_DATA_DIR}"
    echo "   ✅ 디렉토리 생성 완료"
else
    echo "   ✅ 디렉토리 이미 존재"
    # 하위 디렉토리 확인 및 생성
    for subdir in config logs data; do
        if [ ! -d "${GITLAB_DATA_DIR}/${subdir}" ]; then
            mkdir -p "${GITLAB_DATA_DIR}/${subdir}"
            echo "   📁 생성: ${GITLAB_DATA_DIR}/${subdir}"
        fi
    done
fi

# 권한 설정
echo "🔐 디렉토리 권한 설정 중..."
chmod -R 755 "${GITLAB_DATA_DIR}"
echo "   ✅ 권한 설정 완료"

# GitLab 배포
echo "🚀 GitLab 배포 중..."
kubectl apply -f gitlab.yml

echo "⏳ GitLab 서비스 시작 대기 중..."
sleep 10

# 포트 포워딩 설정
echo "🔗 포트 포워딩 설정 중..."

# 기존 포트 포워딩 프로세스 종료
pkill -f "kubectl.*port-forward.*gitlab" 2>/dev/null || true

# GitLab HTTP 포트 포워딩 (백그라운드)
kubectl port-forward -n ${NAMESPACE} svc/gitlab-service ${GITLAB_PORT}:80 > /dev/null 2>&1 &
GITLAB_HTTP_PID=$!

# GitLab SSH 포트 포워딩 (백그라운드)
kubectl port-forward -n ${NAMESPACE} svc/gitlab-service ${SSH_PORT}:22 > /dev/null 2>&1 &
GITLAB_SSH_PID=$!

echo "✅ 포트 포워딩 설정 완료"
echo "   - HTTP: PID ${GITLAB_HTTP_PID}"
echo "   - SSH: PID ${GITLAB_SSH_PID}"

# GitLab Runner Helm 저장소 추가
echo "📦 GitLab Runner Helm 저장소 설정 중..."
helm repo add gitlab https://charts.gitlab.io/ 2>/dev/null || true
helm repo update

echo "✅ Helm 저장소 설정 완료"

# 상태 확인 함수
check_status() {
    echo ""
    echo "📋 배포 상태 확인:"
    echo "Namespace: ${NAMESPACE}"
    kubectl get pods -n ${NAMESPACE}
    echo ""
    kubectl get svc -n ${NAMESPACE}
    echo ""
    echo "💾 호스트 데이터 디렉토리:"
    ls -la "${GITLAB_DATA_DIR}/"
}

# 초기 상태 확인
check_status

echo ""
echo "🔧 GitLab 초기 설정 및 Runner 설치 가이드:"
echo ""
echo "1. GitLab 시작 대기 (5-10분 소요):"
echo "   kubectl logs -n ${NAMESPACE} deployment/gitlab -f"
echo ""
echo "2. GitLab 접속 정보:"
echo "   URL: http://localhost:${GITLAB_PORT}"
echo "   사용자명: root"
echo ""
echo "3. 초기 패스워드 확인:"
echo "   kubectl exec -n ${NAMESPACE} deployment/gitlab -- cat /etc/gitlab/initial_root_password"
echo ""
echo "4. Registration Token 확인:"
echo "   GitLab 로그인 후 Admin Area → Runners → Registration token 복사"
echo "   또는: kubectl exec -n ${NAMESPACE} deployment/gitlab -- gitlab-rails runner \"puts Gitlab::CurrentSettings.runners_registration_token\""
echo ""
echo "5. values-arm64.yml에서 Registration Token 업데이트:"
echo "   runnerRegistrationToken: \"YOUR_ACTUAL_TOKEN\""
echo ""
echo "6. GitLab Runner 설치 (Helm):"
echo "   helm install gitlab-runner gitlab/gitlab-runner \\"
echo "     --namespace ${NAMESPACE} \\"
echo "     --values gitlab-runner-values-arm64.yml"
echo ""
echo "7. Runner 상태 확인:"
echo "   kubectl get pods -n ${NAMESPACE}"
echo "   helm list -n ${NAMESPACE}"
echo ""
echo "8. 환경 정리:"
echo "   helm uninstall gitlab-runner -n ${NAMESPACE}"
echo "   kubectl delete namespace ${NAMESPACE}"
echo ""

# GitLab 준비 상태 확인 옵션
read -p "🔍 GitLab 준비 상태를 확인하시겠습니까? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "GitLab 로그 모니터링 시작 (Ctrl+C로 종료):"
    kubectl logs -n ${NAMESPACE} deployment/gitlab -f
fi

echo ""
echo "🎉 GitLab 배포 완료! "
echo "GitLab이 완전히 시작되면 Registration Token을 확인하고 Runner를 설치하세요."