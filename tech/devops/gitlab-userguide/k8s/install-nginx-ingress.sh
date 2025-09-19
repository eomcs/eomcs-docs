#!/bin/bash
# install-nginx-ingress.sh - Helm으로 NGINX Ingress Controller 설치

set -e

# 변수 설정
NAMESPACE="ingress-nginx"
RELEASE_NAME="ingress-nginx"
VALUES_FILE="ingress-nginx-values.yml"
CHART_REPO="ingress-nginx"
CHART_NAME="ingress-nginx/ingress-nginx"

echo "=== NGINX Ingress Controller Helm 설치 ==="
echo "네임스페이스: ${NAMESPACE}"
echo "릴리스명: ${RELEASE_NAME}"
echo "Values 파일: ${VALUES_FILE}"
echo ""

# 1. 사전 요구사항 확인
echo "🔧 사전 요구사항 확인 중..."

# Helm 설치 확인
if ! command -v helm &> /dev/null; then
    echo "❌ 오류: Helm이 설치되어 있지 않습니다."
    echo "Helm 설치 가이드: https://helm.sh/docs/intro/install/"
    exit 1
fi
echo "✅ Helm 확인: $(helm version --short)"

# kubectl 설치 확인
if ! command -v kubectl &> /dev/null; then
    echo "❌ 오류: kubectl이 설치되어 있지 않습니다."
    exit 1
fi
echo "✅ kubectl 확인: $(kubectl version --client --short)"

# Kubernetes 클러스터 연결 확인
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ 오류: Kubernetes 클러스터에 연결할 수 없습니다."
    echo "Docker Desktop에서 Kubernetes가 활성화되어 있는지 확인하세요."
    exit 1
fi
echo "✅ Kubernetes 클러스터 연결 확인"

# values 파일 존재 확인
if [ ! -f "$VALUES_FILE" ]; then
    echo "❌ 오류: ${VALUES_FILE} 파일이 존재하지 않습니다."
    echo "현재 디렉토리에 ${VALUES_FILE} 파일을 생성하세요."
    exit 1
fi
echo "✅ Values 파일 확인: ${VALUES_FILE}"

# 2. Helm 저장소 설정
echo ""
echo "📦 Helm 저장소 설정 중..."
helm repo add ${CHART_REPO} https://kubernetes.github.io/ingress-nginx
helm repo update
echo "✅ Helm 저장소 업데이트 완료"

# 3. 기존 설치 확인
echo ""
echo "🔍 기존 설치 확인 중..."
if kubectl get namespace ${NAMESPACE} &> /dev/null; then
    echo "⚠️  네임스페이스 '${NAMESPACE}'가 이미 존재합니다."
    
    if helm list -n ${NAMESPACE} | grep -q ${RELEASE_NAME}; then
        echo "⚠️  릴리스 '${RELEASE_NAME}'가 이미 설치되어 있습니다."
        echo ""
        echo "기존 설치 정보:"
        helm list -n ${NAMESPACE}
        echo ""
        
        read -p "기존 설치를 업그레이드하시겠습니까? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            INSTALL_MODE="upgrade"
        else
            echo "설치를 취소합니다."
            exit 0
        fi
    else
        INSTALL_MODE="install"
    fi
else
    INSTALL_MODE="install"
fi

# 4. 네임스페이스 생성 (필요한 경우)
if [ "$INSTALL_MODE" = "install" ]; then
    echo ""
    echo "🏗️ 네임스페이스 생성 중..."
    kubectl create namespace ${NAMESPACE}
    echo "✅ 네임스페이스 '${NAMESPACE}' 생성 완료"
fi

# 5. NGINX Ingress Controller 설치/업그레이드
echo ""
if [ "$INSTALL_MODE" = "install" ]; then
    echo "🚀 NGINX Ingress Controller 설치 중..."
    helm install ${RELEASE_NAME} ${CHART_NAME} \
        --namespace ${NAMESPACE} \
        --values ${VALUES_FILE} \
        --wait \
        --timeout=300s
    echo "✅ 설치 완료!"
else
    echo "⬆️ NGINX Ingress Controller 업그레이드 중..."
    helm upgrade ${RELEASE_NAME} ${CHART_NAME} \
        --namespace ${NAMESPACE} \
        --values ${VALUES_FILE} \
        --wait \
        --timeout=300s
    echo "✅ 업그레이드 완료!"
fi

# 6. 설치 상태 확인
echo ""
echo "📋 설치 상태 확인 중..."
echo ""

echo "Helm 릴리스 상태:"
helm status ${RELEASE_NAME} -n ${NAMESPACE}
echo ""

echo "Helm 릴리스 목록:"
helm list -n ${NAMESPACE}
echo ""

echo "Pod 상태:"
kubectl get pods -n ${NAMESPACE} -o wide
echo ""

echo "Service 상태:"
kubectl get svc -n ${NAMESPACE}
echo ""

echo "IngressClass 확인:"
kubectl get ingressclass
echo ""

# 7. 연결 테스트
echo "🧪 연결 테스트 중..."
echo "Controller 서비스 연결 대기 중..."

# NodePort 확인
HTTP_PORT=$(kubectl get svc ${RELEASE_NAME}-controller -n ${NAMESPACE} -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
HTTPS_PORT=$(kubectl get svc ${RELEASE_NAME}-controller -n ${NAMESPACE} -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')

echo "✅ HTTP 포트: ${HTTP_PORT}"
echo "✅ HTTPS 포트: ${HTTPS_PORT}"

# 기본 백엔드 테스트
echo ""
echo "기본 백엔드 테스트 중..."
sleep 10
if curl -s -o /dev/null -w "%{http_code}" http://localhost:${HTTP_PORT} | grep -q "404"; then
    echo "✅ NGINX Ingress Controller가 정상적으로 응답하고 있습니다."
else
    echo "⚠️  NGINX Ingress Controller 응답을 확인할 수 없습니다."
    echo "잠시 후 다시 시도하세요: curl http://localhost:${HTTP_PORT}"
fi

# 8. 사용 정보 출력
echo ""
echo "🎉 NGINX Ingress Controller 설치 완료!"
echo ""
echo "📋 접속 정보:"
echo "  - HTTP 포트: ${HTTP_PORT}"
echo "  - HTTPS 포트: ${HTTPS_PORT}"
echo "  - 네임스페이스: ${NAMESPACE}"
echo "  - 릴리스명: ${RELEASE_NAME}"
echo "  - IngressClass: nginx"
echo ""
echo "🔧 관리 명령어:"
echo "  - 상태 확인: helm status ${RELEASE_NAME} -n ${NAMESPACE}"
echo "  - 업그레이드: helm upgrade ${RELEASE_NAME} ${CHART_NAME} -n ${NAMESPACE} --values ${VALUES_FILE}"
echo "  - 제거: helm uninstall ${RELEASE_NAME} -n ${NAMESPACE}"
echo "  - 로그 확인: kubectl logs -n ${NAMESPACE} -l app.kubernetes.io/name=ingress-nginx"
echo ""
echo "🧪 테스트 명령어:"
echo "  - curl http://localhost:${HTTP_PORT}"
echo "  - curl -H 'Host: example.local' http://localhost:${HTTP_PORT}"
echo ""
echo "📚 다음 단계:"
echo "  1. /etc/hosts에 도메인 추가 (필요시)"
echo "  2. Ingress 리소스 생성하여 애플리케이션 라우팅 설정"
echo "  3. SSL/TLS 인증서 설정 (HTTPS 사용시)"