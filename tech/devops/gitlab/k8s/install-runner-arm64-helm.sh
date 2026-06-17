#!/bin/bash
# install-runner-helm.sh - GitLab Runner Helm 설치 스크립트 (ARM64 호환)

set -e

NAMESPACE="devops"
RUNNER_NAME="gitlab-runner"
VALUES_FILE="gitlab-runner-values-arm64.yml"

echo "=== GitLab Runner Helm 설치 시작 (ARM64 호환) ==="

# 필수 도구 확인
echo "🔧 필수 도구 확인 중..."

if ! command -v helm &> /dev/null; then
    echo "❌ 오류: Helm이 설치되어 있지 않습니다."
    exit 1
fi

if ! kubectl get namespace ${NAMESPACE} &> /dev/null; then
    echo "❌ 오류: ${NAMESPACE} 네임스페이스가 존재하지 않습니다."
    echo "먼저 GitLab을 배포하세요: ./deploy-devops-helm.sh"
    exit 1
fi

echo "✅ 사전 요구사항 확인 완료"

# GitLab 준비 상태 확인
echo "⏳ GitLab 서비스 준비 상태 확인 중..."
kubectl wait --for=condition=ready pod -l app=gitlab -n ${NAMESPACE} --timeout=600s

echo "✅ GitLab이 준비되었습니다."

# Registration Token 자동 확인 시도
echo "🔑 Registration token 확인 중..."
REGISTRATION_TOKEN=$(kubectl exec -n ${NAMESPACE} deployment/gitlab -- gitlab-rails runner "
puts Gitlab::CurrentSettings.runners_registration_token
" 2>/dev/null | tail -n 1 | tr -d '\r\n')

if [ -z "$REGISTRATION_TOKEN" ] || [ "$REGISTRATION_TOKEN" = "nil" ]; then
    echo "⚠️  자동으로 Registration token을 가져올 수 없습니다."
    echo ""
    echo "수동으로 token을 확인하세요:"
    echo "1. http://localhost:8929 접속"
    echo "2. root 계정으로 로그인"
    echo "3. Admin Area → Runners → Registration token 복사"
    echo ""
    read -p "Registration token을 입력하세요: " MANUAL_TOKEN
    
    if [ -z "$MANUAL_TOKEN" ]; then
        echo "❌ Token이 입력되지 않았습니다."
        exit 1
    fi
    
    REGISTRATION_TOKEN="$MANUAL_TOKEN"
fi

echo "✅ Registration token: ${REGISTRATION_TOKEN}"

# values.yml 파일에서 token 업데이트 (runnerRegistrationToken만)
echo "📝 ${VALUES_FILE} 파일 업데이트 중..."
if [ ! -f "$VALUES_FILE" ]; then
    echo "❌ 오류: $VALUES_FILE 파일이 존재하지 않습니다."
    exit 1
fi

# Registration Token 업데이트 (Helm이 자동으로 config에 전달)
sed "s/runnerRegistrationToken: \".*\"/runnerRegistrationToken: \"${REGISTRATION_TOKEN}\"/" "$VALUES_FILE" > "${VALUES_FILE}.tmp"
mv "${VALUES_FILE}.tmp" "$VALUES_FILE"

echo "✅ Token 업데이트 완료"

# Helm 저장소 확인
echo "📦 Helm 저장소 확인 중..."
helm repo add gitlab https://charts.gitlab.io/ 2>/dev/null || true
helm repo update

# 기존 Runner 제거 (있는 경우)
echo "🧹 기존 Runner 정리 중..."
helm uninstall ${RUNNER_NAME} -n ${NAMESPACE} 2>/dev/null || echo "기존 Runner가 없습니다."

# Runner 설치
echo "🚀 GitLab Runner 설치 중 (ARM64 호환)..."
helm install ${RUNNER_NAME} gitlab/gitlab-runner \
  --namespace ${NAMESPACE} \
  --values ${VALUES_FILE}

echo "⏳ Runner 시작 대기 중..."
kubectl wait --for=condition=ready pod -l app=${RUNNER_NAME} -n ${NAMESPACE} --timeout=300s

# 설치 상태 확인
echo "📋 설치 상태 확인:"
echo ""
echo "Helm 릴리스:"
helm list -n ${NAMESPACE}
echo ""
echo "Pods:"
kubectl get pods -n ${NAMESPACE}
echo ""
echo "Services:"
kubectl get svc -n ${NAMESPACE}

# Runner 설정 확인
echo ""
echo "🔧 Runner 설정 확인:"
kubectl exec -n ${NAMESPACE} deployment/${RUNNER_NAME} -- gitlab-runner list 2>/dev/null || echo "Runner 목록을 가져올 수 없습니다."

# Config 파일 확인
echo ""
echo "📄 Runner 설정 파일:"
kubectl exec -n ${NAMESPACE} deployment/${RUNNER_NAME} -- cat /etc/gitlab-runner/config.toml 2>/dev/null || echo "설정 파일을 읽을 수 없습니다."

echo ""
echo "🎉 GitLab Runner 설치 완료!"
echo ""
echo "확인 사항:"
echo "1. GitLab 웹 UI에서 Runner 확인:"
echo "   http://localhost:8929/admin/runners"
echo ""
echo "2. Runner 로그 확인:"
echo "   kubectl logs -n ${NAMESPACE} deployment/${RUNNER_NAME} -f"
echo ""
echo "3. CI/CD 테스트:"
echo "   프로젝트에 .gitlab-ci.yml 파일을 추가하고 push하세요."
echo ""
echo "관리 명령어:"
echo "- Runner 업그레이드: helm upgrade ${RUNNER_NAME} gitlab/gitlab-runner -n ${NAMESPACE} --values ${VALUES_FILE}"
echo "- Runner 제거: helm uninstall ${RUNNER_NAME} -n ${NAMESPACE}"
echo "- 상태 확인: kubectl get pods -n ${NAMESPACE}"