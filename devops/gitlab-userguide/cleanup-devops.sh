#!/bin/bash
# cleanup-devops.sh - 로컬 DevOps 환경 정리 스크립트

set -e

NAMESPACE="devops"
GITLAB_PORT="8929"
SSH_PORT="2222"
CURRENT_USER=$(whoami)
GITLAB_DATA_DIR="/Users/${CURRENT_USER}/gitlab-devops"

echo "=== 로컬 DevOps 환경 정리 시작 ==="
echo "사용자: ${CURRENT_USER}"
echo "네임스페이스: ${NAMESPACE}"
echo "데이터 디렉토리: ${GITLAB_DATA_DIR}"
echo ""

# 확인 메시지
echo "⚠️  주의: 이 작업은 다음을 삭제합니다:"
echo "   - Kubernetes 리소스 (Pod, Service, PVC, PV 등)"
echo "   - 포트 포워딩 프로세스"
echo "   - 옵션: 호스트 데이터 디렉토리"
echo ""

read -p "❓ 정말로 DevOps 환경을 정리하시겠습니까? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "🚫 정리 작업이 취소되었습니다."
    exit 0
fi

# Docker Desktop Kubernetes 확인
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ 오류: Kubernetes 클러스터에 연결할 수 없습니다."
    echo "Docker Desktop에서 Kubernetes가 활성화되어 있는지 확인하세요."
    exit 1
fi

echo "✅ Kubernetes 클러스터 연결 확인"

# 현재 상태 확인
echo ""
echo "📋 현재 DevOps 환경 상태:"
echo "Namespace: ${NAMESPACE}"

if kubectl get namespace ${NAMESPACE} &> /dev/null; then
    echo "📦 Pod 상태:"
    kubectl get pods -n ${NAMESPACE} 2>/dev/null || echo "   파드 없음"
    
    echo ""
    echo "🔗 Service 상태:"
    kubectl get svc -n ${NAMESPACE} 2>/dev/null || echo "   서비스 없음"
    
    echo ""
    echo "💾 PVC 상태:"
    kubectl get pvc -n ${NAMESPACE} 2>/dev/null || echo "   PVC 없음"
    
    echo ""
    echo "🗄️ PV 상태:"
    kubectl get pv | grep -E "(gitlab|devops)" 2>/dev/null || echo "   GitLab PV 없음"
else
    echo "   네임스페이스 '${NAMESPACE}'가 존재하지 않습니다."
fi

echo ""

# 포트 포워딩 프로세스 종료
echo "🔗 포트 포워딩 프로세스 정리 중..."
GITLAB_PROCESSES=$(pgrep -f "kubectl.*port-forward.*gitlab" 2>/dev/null || true)
if [ -n "$GITLAB_PROCESSES" ]; then
    echo "   종료할 프로세스: $GITLAB_PROCESSES"
    pkill -f "kubectl.*port-forward.*gitlab" 2>/dev/null || true
    echo "   ✅ GitLab 포트 포워딩 프로세스 종료 완료"
else
    echo "   ✅ 실행 중인 GitLab 포트 포워딩 프로세스 없음"
fi

# 기타 DevOps 관련 포트 포워딩 정리
OTHER_PROCESSES=$(pgrep -f "kubectl.*port-forward.*devops" 2>/dev/null || true)
if [ -n "$OTHER_PROCESSES" ]; then
    echo "   종료할 기타 프로세스: $OTHER_PROCESSES"
    pkill -f "kubectl.*port-forward.*devops" 2>/dev/null || true
    echo "   ✅ 기타 DevOps 포트 포워딩 프로세스 종료 완료"
fi

# Kubernetes 리소스 삭제
echo ""
echo "🗑️ Kubernetes 리소스 삭제 중..."

if kubectl get namespace ${NAMESPACE} &> /dev/null; then
    # 매니페스트 파일이 있으면 사용, 없으면 개별 삭제
    if [ -f "gitlab-devops-complete.yml" ]; then
        echo "   📄 매니페스트 파일을 사용하여 삭제 중..."
        kubectl delete -f gitlab-devops-complete.yml --ignore-not-found=true
        echo "   ✅ 매니페스트 기반 리소스 삭제 완료"
    else
        echo "   📦 개별 리소스 삭제 중..."
        
        # Deployment 삭제
        kubectl delete deployment -n ${NAMESPACE} --all --ignore-not-found=true
        echo "   ✅ Deployment 삭제 완료"
        
        # Service 삭제
        kubectl delete service -n ${NAMESPACE} --all --ignore-not-found=true
        echo "   ✅ Service 삭제 완료"
        
        # ConfigMap 삭제
        kubectl delete configmap -n ${NAMESPACE} --all --ignore-not-found=true
        echo "   ✅ ConfigMap 삭제 완료"
        
        # PVC 삭제
        kubectl delete pvc -n ${NAMESPACE} --all --ignore-not-found=true
        echo "   ✅ PVC 삭제 완료"
    fi
    
    # PV 개별 삭제 (네임스페이스에 속하지 않음)
    echo "   🗄️ PersistentVolume 삭제 중..."
    kubectl delete pv gitlab-config-pv gitlab-logs-pv gitlab-data-pv --ignore-not-found=true
    echo "   ✅ PV 삭제 완료"
    
    # 네임스페이스 삭제
    echo "   📁 네임스페이스 삭제 중..."
    kubectl delete namespace ${NAMESPACE} --timeout=60s 2>/dev/null || {
        echo "   ⚠️ 네임스페이스 삭제 타임아웃, 강제 삭제 시도 중..."
        kubectl patch namespace ${NAMESPACE} -p '{"metadata":{"finalizers":[]}}' --type=merge 2>/dev/null || true
        kubectl delete namespace ${NAMESPACE} --force --grace-period=0 2>/dev/null || true
    }
    echo "   ✅ 네임스페이스 삭제 완료"
else
    echo "   ✅ 네임스페이스가 이미 존재하지 않습니다."
fi

# 호스트 데이터 디렉토리 처리
echo ""
echo "💾 호스트 데이터 디렉토리 처리:"
if [ -d "${GITLAB_DATA_DIR}" ]; then
    echo "   현재 디렉토리 크기:"
    du -sh "${GITLAB_DATA_DIR}" 2>/dev/null || echo "   크기 확인 불가"
    
    echo ""
    echo "   디렉토리 내용:"
    ls -la "${GITLAB_DATA_DIR}/" 2>/dev/null || echo "   내용 확인 불가"
    
    echo ""
    read -p "❓ 호스트 데이터 디렉토리도 삭제하시겠습니까? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "   🗑️ 호스트 디렉토리 삭제 중..."
        rm -rf "${GITLAB_DATA_DIR}"
        echo "   ✅ 호스트 디렉토리 삭제 완료"
    else
        echo "   ✅ 호스트 디렉토리 보존됨"
        echo "   📍 수동 삭제: rm -rf ${GITLAB_DATA_DIR}"
    fi
else
    echo "   ✅ 호스트 디렉토리가 존재하지 않습니다."
fi

# 최종 상태 확인
echo ""
echo "📋 정리 후 상태 확인:"

echo "🔍 Kubernetes 리소스:"
if kubectl get namespace ${NAMESPACE} &> /dev/null; then
    echo "   ❌ 네임스페이스 '${NAMESPACE}'가 여전히 존재합니다."
    kubectl get all -n ${NAMESPACE} 2>/dev/null || true
else
    echo "   ✅ 네임스페이스 '${NAMESPACE}' 삭제 확인"
fi

echo ""
echo "🔍 GitLab PV 상태:"
REMAINING_PV=$(kubectl get pv 2>/dev/null | grep -E "(gitlab|devops)" || true)
if [ -n "$REMAINING_PV" ]; then
    echo "   ❌ 남은 GitLab PV:"
    echo "$REMAINING_PV"
else
    echo "   ✅ GitLab PV 모두 삭제 확인"
fi

echo ""
echo "🔍 포트 포워딩 프로세스:"
REMAINING_PROCESSES=$(pgrep -f "kubectl.*port-forward.*(gitlab|devops)" 2>/dev/null || true)
if [ -n "$REMAINING_PROCESSES" ]; then
    echo "   ❌ 남은 프로세스: $REMAINING_PROCESSES"
    echo "   수동 종료: kill $REMAINING_PROCESSES"
else
    echo "   ✅ 모든 관련 프로세스 종료 확인"
fi

echo ""
echo "🔍 호스트 디렉토리:"
if [ -d "${GITLAB_DATA_DIR}" ]; then
    echo "   📁 보존됨: ${GITLAB_DATA_DIR}"
    echo "   크기: $(du -sh "${GITLAB_DATA_DIR}" 2>/dev/null | cut -f1 || echo "확인불가")"
else
    echo "   ✅ 삭제 확인: ${GITLAB_DATA_DIR}"
fi

echo ""
echo "🧹 추가 정리 명령어 (필요시):"
echo "   - 미사용 Docker 이미지: docker image prune -a"
echo "   - 미사용 볼륨: docker volume prune"
echo "   - 미사용 네트워크: docker network prune"
echo "   - Kubernetes 리소스 재확인: kubectl get all --all-namespaces"
echo ""

echo "🎉 DevOps 환경 정리 완료!"
echo ""
echo "💡 다시 배포하려면: ./deploy-devops.sh"