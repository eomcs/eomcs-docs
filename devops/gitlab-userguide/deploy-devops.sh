#!/bin/bash
# deploy-devops.sh - 로컬 DevOps 환경 배포 스크립트

set -e

NAMESPACE="devops"
GITLAB_PORT="8929"
SSH_PORT="2222"
CURRENT_USER=$(whoami)
GITLAB_DATA_DIR="/Users/${CURRENT_USER}/gitlab-devops"

echo "=== 로컬 DevOps 환경 배포 시작 ==="
echo "사용자: ${CURRENT_USER}"
echo "GitLab: http://localhost:${GITLAB_PORT}"
echo "SSH: localhost:${SSH_PORT}"
echo "데이터 디렉토리: ${GITLAB_DATA_DIR}"
echo ""

# Docker Desktop Kubernetes 확인
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ 오류: Kubernetes 클러스터에 연결할 수 없습니다."
    echo "Docker Desktop에서 Kubernetes가 활성화되어 있는지 확인하세요."
    exit 1
fi

echo "✅ Kubernetes 클러스터 연결 확인"

# 호스트 디렉토리 생성 (안전을 위해)
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

# 권한 확인
echo "🔐 디렉토리 권한 설정 중..."
chmod -R 755 "${GITLAB_DATA_DIR}"
echo "   ✅ 권한 설정 완료"

# 리소스 확인
echo "📊 현재 리소스 상태:"
kubectl top nodes 2>/dev/null || echo "메트릭 서버가 없어 리소스 정보를 확인할 수 없습니다."

# 매니페스트 적용
echo "🚀 GitLab 및 GitLab Runner 배포 중..."
kubectl apply -f gitlab-devops-complete.yml

echo "⏳ 서비스 시작 대기 중..."
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
echo "🔧 GitLab 초기 설정 가이드:"
echo ""
echo "1. GitLab 시작 대기 (5-10분 소요):"
echo "   kubectl logs -n ${NAMESPACE} deployment/gitlab -f"
echo ""
echo "2. 접속 정보:"
echo "   URL: http://localhost:${GITLAB_PORT}"
echo "   사용자명: root"
echo ""
echo "3. 초기 패스워드 확인:"
echo "   kubectl exec -n ${NAMESPACE} deployment/gitlab -- cat /etc/gitlab/initial_root_password"
echo "   또는 호스트에서: find ${GITLAB_DATA_DIR} -name 'initial_root_password' -exec cat {} \;"
echo ""
echo "4. SSH Clone 설정:"
echo "   git clone git@localhost:${SSH_PORT}:username/project.git"
echo ""
echo "5. GitLab Runner 등록:"
echo "   ./register-runner.sh"
echo ""
echo "6. 상태 모니터링:"
echo "   kubectl get pods -n ${NAMESPACE} -w"
echo ""
echo "7. 데이터 위치:"
echo "   호스트: ${GITLAB_DATA_DIR}"
echo "   ├── config/    (GitLab 설정)"
echo "   ├── logs/      (GitLab 로그)"
echo "   └── data/      (GitLab 데이터)"
echo ""
echo "8. 환경 정리:"
echo "   ./cleanup-devops.sh"
echo ""

# 모니터링 옵션 제공
read -p "🔍 실시간 로그를 확인하시겠습니까? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "GitLab 로그 모니터링 시작 (Ctrl+C로 종료):"
    kubectl logs -n ${NAMESPACE} deployment/gitlab -f
fi

echo ""
echo "🎉 배포 완료! GitLab이 완전히 시작되면 http://localhost:${GITLAB_PORT} 에서 접속하세요."