#!/bin/bash
# cleanup-devops-helm.sh - 로컬 DevOps 환경 정리 스크립트 (Helm 기반)

set -e

NAMESPACE="devops"
RUNNER_NAME="gitlab-runner"
CURRENT_USER=$(whoami)
GITLAB_DATA_DIR="/Users/${CURRENT_USER}/gitlab-devops"

echo "=== 로컬 DevOps 환경 정리 시작 ==="
echo "네임스페이스: ${NAMESPACE}"
echo "데이터 디렉토리: ${GITLAB_DATA_DIR}"
echo ""

# 사용자 확인
read -p "⚠️  모든 GitLab 및 Runner 리소스를 삭제하시겠습니까? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "정리가 취소되었습니다."
    exit 0
fi

echo "🧹 환경 정리 시작..."

# 포트 포워딩 프로세스 종료
echo "📡 포트 포워딩 프로세스 종료 중..."
pkill -f "kubectl.*port-forward.*gitlab" 2>/dev/null || echo "포트 포워딩 프로세스가 없습니다."

# Helm으로 설치된 GitLab Runner 제거
echo "🚀 GitLab Runner (Helm) 제거 중..."
if helm list -n ${NAMESPACE} | grep -q ${RUNNER_NAME}; then
    helm uninstall ${RUNNER_NAME} -n ${NAMESPACE}
    echo "✅ GitLab Runner 제거 완료"
else
    echo "💡 GitLab Runner가 Helm으로 설치되지 않았습니다."
fi

# kubectl로 설치된 기타 리소스 확인 및 제거
echo "🗑️  kubectl 리소스 정리 중..."
if kubectl get namespace ${NAMESPACE} &> /dev/null; then
    echo "현재 네임스페이스의 리소스:"
    kubectl get all -n ${NAMESPACE}
    echo ""
    
    # GitLab 및 기타 리소스 제거
    kubectl delete namespace ${NAMESPACE} --ignore-not-found=true
    echo "✅ 네임스페이스 ${NAMESPACE} 제거 완료"
else
    echo "💡 네임스페이스 ${NAMESPACE}가 존재하지 않습니다."
fi

# PersistentVolume 정리 (수동 설정된 경우)
echo "💾 PersistentVolume 정리 중..."
kubectl delete pv gitlab-config-pv gitlab-logs-pv gitlab-data-pv --ignore-not-found=true
echo "✅ PersistentVolume 정리 완료"

# 데이터 디렉토리 정리 옵션
echo ""
read -p "📁 호스트 데이터 디렉토리도 삭제하시겠습니까? (${GITLAB_DATA_DIR}) (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -d "${GITLAB_DATA_DIR}" ]; then
        echo "🗂️  데이터 디렉토리 삭제 중..."
        rm -rf "${GITLAB_DATA_DIR}"
        echo "✅ 데이터 디렉토리 삭제 완료"
    else
        echo "💡 데이터 디렉토리가 존재하지 않습니다."
    fi
else
    echo "💾 데이터 디렉토리가 보존되었습니다: ${GITLAB_DATA_DIR}"
fi

# Docker 이미지 정리 옵션
echo ""
read -p "🐳 관련 Docker 이미지도 정리하시겠습니까? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Docker 이미지 정리 중..."
    
    # GitLab 관련 이미지 제거
    docker rmi gitlab/gitlab-ce:latest 2>/dev/null || echo "GitLab CE 이미지가 없습니다."
    docker rmi gitlab/gitlab-runner:v17.11.3 2>/dev/null || echo "GitLab Runner 이미지가 없습니다."
    
    # 사용하지 않는 이미지 정리
    docker image prune -f 2>/dev/null || echo "정리할 이미지가 없습니다."
    
    echo "✅ Docker 이미지 정리 완료"
else
    echo "🐳 Docker 이미지가 보존되었습니다."
fi

# Helm 저장소 정리 옵션
echo ""
read -p "📦 GitLab Helm 저장소도 제거하시겠습니까? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    helm repo remove gitlab 2>/dev/null || echo "GitLab 저장소가 없습니다."
    echo "✅ Helm 저장소 정리 완료"
else
    echo "📦 Helm 저장소가 보존되었습니다."
fi

# 최종 상태 확인
echo ""
echo "📋 정리 후 상태 확인:"
echo ""
echo "Kubernetes 네임스페이스:"
kubectl get namespaces | grep ${NAMESPACE} || echo "✅ ${NAMESPACE} 네임스페이스 없음"
echo ""
echo "PersistentVolumes:"
kubectl get pv | grep gitlab || echo "✅ GitLab PV 없음"
echo ""
echo "Helm 릴리스:"
helm list -A | grep gitlab || echo "✅ GitLab Helm 릴리스 없음"
echo ""
echo "호스트 디렉토리:"
if [ -d "${GITLAB_DATA_DIR}" ]; then
    echo "📁 보존됨: ${GITLAB_DATA_DIR}"
    ls -la "${GITLAB_DATA_DIR}/" 2>/dev/null || true
else
    echo "✅ 삭제됨: ${GITLAB_DATA_DIR}"
fi

echo ""
echo "🎉 DevOps 환경 정리 완료!"
echo ""
echo "재설치하려면:"
echo "1. ./deploy-devops-helm.sh  # GitLab 배포"
echo "2. ./install-runner-helm.sh # Runner 설치"
echo ""
echo "문제가 있는 경우:"
echo "- kubectl get all -A  # 전체 리소스 확인"
echo "- docker system prune  # Docker 시스템 정리"
echo "- Docker Desktop 재시작"