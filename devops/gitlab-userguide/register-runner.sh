#!/bin/bash
# register-runner.sh - GitLab Runner 등록 스크립트 (v17.11.3 호환)

set -e

NAMESPACE="devops"
GITLAB_URL="http://gitlab-service.devops.svc.cluster.local"

echo "=== GitLab Runner 등록 시작 ==="

# GitLab이 준비될 때까지 대기
echo "⏳ GitLab 서비스 준비 상태 확인 중..."
kubectl wait --for=condition=ready pod -l app=gitlab -n ${NAMESPACE} --timeout=600s

echo "✅ GitLab이 준비되었습니다."

# Registration token 확인
echo "🔑 Registration token 확인 중..."
REGISTRATION_TOKEN=$(kubectl exec -n ${NAMESPACE} deployment/gitlab -- gitlab-rails runner "
puts Gitlab::CurrentSettings.runners_registration_token
" 2>/dev/null | tail -n 1)

if [ -z "$REGISTRATION_TOKEN" ] || [ "$REGISTRATION_TOKEN" = "nil" ]; then
    echo "❌ Registration token을 가져올 수 없습니다."
    echo ""
    echo "수동으로 등록하세요:"
    echo "1. http://localhost:8929/admin/runners 접속"
    echo "2. Registration token 복사"
    echo "3. 아래 명령어 실행:"
    echo ""
    echo "kubectl exec -n ${NAMESPACE} -it deployment/gitlab-runner -- gitlab-runner register \\"
    echo "  --url \"${GITLAB_URL}\" \\"
    echo "  --registration-token \"YOUR_TOKEN\" \\"
    echo "  --executor \"kubernetes\" \\"
    echo "  --description \"Local DevOps Runner\" \\"
    echo "  --tag-list \"kubernetes,docker,local\" \\"
    echo "  --run-untagged=\"true\" \\"
    echo "  --locked=\"false\" \\"
    echo "  --kubernetes-namespace \"${NAMESPACE}\" \\"
    echo "  --kubernetes-image \"ubuntu:20.04\" \\"
    echo "  --kubernetes-privileged"
    exit 1
fi

echo "✅ Registration token: ${REGISTRATION_TOKEN}"

# Runner 등록 시도 (v17.11.3 호환)
echo "🚀 GitLab Runner 등록 중..."

kubectl exec -n ${NAMESPACE} deployment/gitlab-runner -- gitlab-runner register \
  --non-interactive \
  --url "${GITLAB_URL}" \
  --registration-token "${REGISTRATION_TOKEN}" \
  --executor "kubernetes" \
  --description "Local DevOps Runner" \
  --tag-list "kubernetes,docker,local" \
  --run-untagged="true" \
  --locked="false" \
  --kubernetes-namespace "${NAMESPACE}" \
  --kubernetes-image "ubuntu:20.04" \
  --kubernetes-privileged="true" \
  --kubernetes-pull-policy "if-not-present"

echo "✅ GitLab Runner 등록 완료!"

# Runner 상태 확인
echo ""
echo "📋 등록된 Runner 목록:"
kubectl exec -n ${NAMESPACE} deployment/gitlab-runner -- gitlab-runner list

echo ""
echo "🎉 등록 완료! GitLab에서 Runner 상태를 확인하세요:"
echo "   http://localhost:8929/admin/runners"