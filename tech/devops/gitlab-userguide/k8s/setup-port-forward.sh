#!/bin/bash
# setup-port-forward.sh - GitLab 포트 포워딩 설정 스크립트

set -e

NAMESPACE="devops"
GITLAB_PORT="8929"
SSH_PORT="2222"

echo "=== GitLab 포트 포워딩 설정 ==="

# 기존 포트 포워딩 프로세스 정리
echo "🧹 기존 포트 포워딩 프로세스 정리 중..."
pkill -f "kubectl.*port-forward.*gitlab" 2>/dev/null || true
sleep 2

# 포트 사용 중인지 확인
echo "🔍 포트 ${GITLAB_PORT} 사용 상태 확인..."
if lsof -i :${GITLAB_PORT} >/dev/null 2>&1; then
    echo "⚠️  포트 ${GITLAB_PORT}가 이미 사용 중입니다:"
    lsof -i :${GITLAB_PORT}
    read -p "계속 진행하시겠습니까? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# GitLab 서비스 상태 확인
echo "🔧 GitLab 서비스 상태 확인 중..."
if ! kubectl get svc gitlab-service -n ${NAMESPACE} >/dev/null 2>&1; then
    echo "❌ GitLab 서비스가 존재하지 않습니다."
    echo "먼저 GitLab을 배포하세요: ./deploy-devops-helm.sh"
    exit 1
fi

# Pod 준비 상태 확인
echo "⏳ GitLab Pod 준비 상태 확인 중..."
kubectl wait --for=condition=ready pod -l app=gitlab -n ${NAMESPACE} --timeout=60s || {
    echo "⚠️  GitLab Pod가 준비되지 않았지만 포트 포워딩을 시도합니다..."
}

# HTTP 포트 포워딩 설정
echo "🔗 HTTP 포트 포워딩 설정 (${GITLAB_PORT}:80)..."
kubectl port-forward -n ${NAMESPACE} svc/gitlab-service ${GITLAB_PORT}:80 > /tmp/gitlab-http-pf.log 2>&1 &
HTTP_PID=$!

# SSH 포트 포워딩 설정
echo "🔗 SSH 포트 포워딩 설정 (${SSH_PORT}:22)..."
kubectl port-forward -n ${NAMESPACE} svc/gitlab-service ${SSH_PORT}:22 > /tmp/gitlab-ssh-pf.log 2>&1 &
SSH_PID=$!

# 포트 포워딩 안정화 대기
echo "⏳ 포트 포워딩 안정화 대기 중..."
sleep 5

# 연결 테스트
echo "🧪 연결 테스트 중..."
HTTP_STATUS=""
for i in {1..10}; do
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:${GITLAB_PORT} >/dev/null 2>&1; then
        HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${GITLAB_PORT})
        break
    fi
    echo "   시도 ${i}/10 - 대기 중..."
    sleep 3
done

# 결과 출력
echo ""
echo "📊 포트 포워딩 상태:"
echo "   HTTP PID: ${HTTP_PID}"
echo "   SSH PID: ${SSH_PID}"
echo ""

if [ -n "$HTTP_STATUS" ]; then
    echo "✅ HTTP 연결 성공! (Status: ${HTTP_STATUS})"
    echo "🌐 GitLab 접속: http://localhost:${GITLAB_PORT}"
else
    echo "❌ HTTP 연결 실패"
    echo "로그 확인: tail -f /tmp/gitlab-http-pf.log"
fi

echo ""
echo "📋 관리 명령어:"
echo "   - 프로세스 확인: ps aux | grep port-forward"
echo "   - 로그 확인: tail -f /tmp/gitlab-*-pf.log"
echo "   - 프로세스 종료: kill ${HTTP_PID} ${SSH_PID}"
echo "   - 전체 정리: pkill -f 'kubectl.*port-forward'"
echo ""

# GitLab 시작 상태 확인
echo "🔍 GitLab 시작 상태 확인:"
kubectl logs -n ${NAMESPACE} deployment/gitlab --tail=5 | grep -E "(ready|started|listening)" || echo "GitLab이 아직 시작 중일 수 있습니다."

echo ""
echo "💡 GitLab이 완전히 시작되려면 5-10분이 소요될 수 있습니다."
echo "   로그 모니터링: kubectl logs -n ${NAMESPACE} deployment/gitlab -f"