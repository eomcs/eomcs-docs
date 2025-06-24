#!/bin/bash
# check-user-hostpath.sh - 사용자 홈 디렉토리를 사용한 hostPath 테스트

set -e

# 현재 사용자 정보
CURRENT_USER=$(whoami)
USER_HOME="/Users/${CURRENT_USER}"
GITLAB_BASE_DIR="${USER_HOME}/gitlab-devops"
TEST_DIR="${USER_HOME}/hostpath-test"

echo "=== 사용자 홈 디렉토리 hostPath 테스트 ==="
echo "사용자: ${CURRENT_USER}"
echo "홈 디렉토리: ${USER_HOME}"
echo "GitLab 데이터 디렉토리: ${GITLAB_BASE_DIR}"
echo ""

# 1. 기본 환경 확인
echo "1. 기본 환경 확인:"
echo "   현재 디렉토리: $(pwd)"
echo "   사용자 홈 디렉토리 존재: $([ -d "${USER_HOME}" ] && echo "✅ 예" || echo "❌ 아니오")"
echo "   Docker 실행 상태: $(docker info &>/dev/null && echo "✅ 실행 중" || echo "❌ 중지됨")"
echo "   Kubernetes 연결: $(kubectl cluster-info &>/dev/null && echo "✅ 연결됨" || echo "❌ 연결 안됨")"

# 2. GitLab 데이터 디렉토리 확인
echo ""
echo "2. GitLab 데이터 디렉토리 상태:"
if [ -d "${GITLAB_BASE_DIR}" ]; then
    echo "   ✅ ${GITLAB_BASE_DIR} 존재"
    echo "   디렉토리 구조:"
    ls -la "${GITLAB_BASE_DIR}/" 2>/dev/null | sed 's/^/     /' || echo "     (비어있음)"
else
    echo "   ❌ ${GITLAB_BASE_DIR} 없음"
    echo "   📁 디렉토리 생성 중..."
    mkdir -p "${GITLAB_BASE_DIR}"/{config,logs,data}
    chmod -R 755 "${GITLAB_BASE_DIR}"
    echo "   ✅ 디렉토리 생성 완료"
fi

# 3. Docker 볼륨 마운트 테스트
echo ""
echo "3. Docker 볼륨 마운트 테스트:"

# 테스트 디렉토리 생성
mkdir -p "${TEST_DIR}"

# Docker 컨테이너에서 파일 생성
echo "   📝 Docker → macOS 파일 공유 테스트..."
docker run --rm -v "${TEST_DIR}:/test" alpine sh -c '
    echo "Docker에서 생성한 파일 $(date)" > /test/docker-to-macos.txt
    echo "Docker 컨테이너 ID: $(hostname)" >> /test/docker-to-macos.txt
    ls -la /test/
' 2>/dev/null

# macOS에서 파일 확인
if [ -f "${TEST_DIR}/docker-to-macos.txt" ]; then
    echo "   ✅ Docker → macOS 파일 공유 성공!"
    echo "   📄 파일 내용:"
    cat "${TEST_DIR}/docker-to-macos.txt" | sed 's/^/       /'
else
    echo "   ❌ Docker → macOS 파일 공유 실패"
fi

# macOS에서 파일 생성
echo ""
echo "   📝 macOS → Docker 파일 공유 테스트..."
echo "macOS에서 생성한 파일 $(date)" > "${TEST_DIR}/macos-to-docker.txt"
echo "macOS 사용자: ${CURRENT_USER}" >> "${TEST_DIR}/macos-to-docker.txt"

# Docker에서 파일 읽기
DOCKER_READ_RESULT=$(docker run --rm -v "${TEST_DIR}:/test" alpine cat /test/macos-to-docker.txt 2>/dev/null || echo "파일 읽기 실패")

if [[ "${DOCKER_READ_RESULT}" == *"macOS에서 생성한 파일"* ]]; then
    echo "   ✅ macOS → Docker 파일 공유 성공!"
    echo "   📄 Docker에서 읽은 내용:"
    echo "${DOCKER_READ_RESULT}" | sed 's/^/       /'
else
    echo "   ❌ macOS → Docker 파일 공유 실패"
    echo "   오류: ${DOCKER_READ_RESULT}"
fi

# 4. Kubernetes hostPath 테스트
echo ""
echo "4. Kubernetes hostPath 테스트:"

if kubectl cluster-info &>/dev/null; then
    echo "   ✅ Kubernetes 클러스터 연결됨"
    
    # 기존 테스트 Pod 정리
    kubectl delete pod user-hostpath-test --ignore-not-found=true >/dev/null 2>&1
    
    echo "   📦 테스트 Pod 생성 중..."
    
    # 테스트 Pod 매니페스트 생성 및 적용
    cat << EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: user-hostpath-test
spec:
  containers:
  - name: test
    image: busybox:latest
    command: ['sleep', '600']
    volumeMounts:
    - name: test-volume
      mountPath: /k8s-test
  volumes:
  - name: test-volume
    hostPath:
      path: ${TEST_DIR}
      type: DirectoryOrCreate
  restartPolicy: Never
EOF

    # Pod 실행 대기
    echo "   ⏳ Pod 실행 대기 중..."
    if kubectl wait --for=condition=ready pod/user-hostpath-test --timeout=120s >/dev/null 2>&1; then
        echo "   ✅ 테스트 Pod 실행됨"
        
        # Kubernetes Pod에서 파일 생성
        echo "   📝 Kubernetes → macOS 파일 공유 테스트..."
        kubectl exec user-hostpath-test -- sh -c '
            echo "Kubernetes Pod에서 생성 $(date)" > /k8s-test/k8s-to-macos.txt
            echo "Pod 이름: user-hostpath-test" >> /k8s-test/k8s-to-macos.txt
            echo "Pod 내부 경로: /k8s-test" >> /k8s-test/k8s-to-macos.txt
            ls -la /k8s-test/
        ' 2>/dev/null
        
        # macOS에서 파일 확인
        if [ -f "${TEST_DIR}/k8s-to-macos.txt" ]; then
            echo "   ✅ Kubernetes → macOS 파일 공유 성공!"
            echo "   📄 파일 내용:"
            cat "${TEST_DIR}/k8s-to-macos.txt" | sed 's/^/       /'
        else
            echo "   ❌ Kubernetes → macOS 파일 공유 실패"
        fi
        
        # macOS에서 파일 생성하여 Pod에서 읽기 테스트
        echo ""
        echo "   📝 macOS → Kubernetes 파일 공유 테스트..."
        echo "macOS에서 K8s로 전송 $(date)" > "${TEST_DIR}/macos-to-k8s.txt"
        echo "호스트 경로: ${TEST_DIR}" >> "${TEST_DIR}/macos-to-k8s.txt"
        
        # Pod에서 파일 읽기
        K8S_READ_RESULT=$(kubectl exec user-hostpath-test -- cat /k8s-test/macos-to-k8s.txt 2>/dev/null || echo "파일 읽기 실패")
        
        if [[ "${K8S_READ_RESULT}" == *"macOS에서 K8s로 전송"* ]]; then
            echo "   ✅ macOS → Kubernetes 파일 공유 성공!"
            echo "   📄 Pod에서 읽은 내용:"
            echo "${K8S_READ_RESULT}" | sed 's/^/       /'
        else
            echo "   ❌ macOS → Kubernetes 파일 공유 실패"
            echo "   오류: ${K8S_READ_RESULT}"
        fi
        
        # Pod 내부 디렉토리 구조 확인
        echo ""
        echo "   📁 Pod 내부 디렉토리 구조:"
        kubectl exec user-hostpath-test -- ls -la /k8s-test/ 2>/dev/null | sed 's/^/       /' || echo "       디렉토리 확인 실패"
        
    else
        echo "   ❌ 테스트 Pod 실행 실패"
        kubectl describe pod user-hostpath-test | sed 's/^/       /'
    fi
    
    # 정리
    echo ""
    echo "   🧹 테스트 리소스 정리 중..."
    kubectl delete pod user-hostpath-test --ignore-not-found=true >/dev/null 2>&1
    
else
    echo "   ❌ Kubernetes 클러스터에 연결할 수 없음"
    echo "   Docker Desktop에서 Kubernetes가 활성화되어 있는지 확인하세요."
fi

# 5. 결과 요약 및 GitLab 설정 제안
echo ""
echo "5. 테스트 결과 요약:"

DOCKER_STATUS="❌"
K8S_STATUS="❌"

if [ -f "${TEST_DIR}/docker-to-macos.txt" ] && [ -f "${TEST_DIR}/macos-to-docker.txt" ]; then
    DOCKER_STATUS="✅"
fi

if [ -f "${TEST_DIR}/k8s-to-macos.txt" ] && [ -f "${TEST_DIR}/macos-to-k8s.txt" ]; then
    K8S_STATUS="✅"
fi

echo "   Docker 볼륨 공유: ${DOCKER_STATUS}"
echo "   Kubernetes hostPath: ${K8S_STATUS}"

echo ""
if [[ "${DOCKER_STATUS}" == "✅" ]] && [[ "${K8S_STATUS}" == "✅" ]]; then
    echo "🎉 모든 테스트 통과! GitLab 배포 준비 완료"
    echo ""
    echo "6. GitLab PersistentVolume 설정:"
    echo "   다음 hostPath 설정을 사용하세요:"
    echo ""
    cat << EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: gitlab-config-pv
spec:
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: ${GITLAB_BASE_DIR}/config
  storageClassName: manual
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: gitlab-logs-pv
spec:
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: ${GITLAB_BASE_DIR}/logs
  storageClassName: manual
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: gitlab-data-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: ${GITLAB_BASE_DIR}/data
  storageClassName: manual
EOF
    echo ""
    echo "7. 다음 단계:"
    echo "   - 위 PV 설정으로 gitlab-devops-complete.yml 수정"
    echo "   - ./deploy-devops.sh 실행"
    echo "   - GitLab 데이터: ${GITLAB_BASE_DIR}"
else
    echo "⚠️  일부 테스트 실패 - Docker Desktop 설정 확인 필요"
    echo ""
    echo "6. 문제 해결 방법:"
    echo "   1. Docker Desktop → Settings → Resources → File sharing"
    echo "   2. /Users 디렉토리가 공유되어 있는지 확인"
    echo "   3. Docker Desktop 재시작: killall Docker && open -a Docker"
    echo "   4. 재테스트: ./check-user-hostpath.sh"
fi

# 7. 테스트 파일 정리
echo ""
echo "8. 테스트 파일 정리:"
if [ -d "${TEST_DIR}" ]; then
    rm -rf "${TEST_DIR}"
    echo "   ✅ 임시 테스트 파일 삭제 완료"
else
    echo "   ℹ️  정리할 테스트 파일 없음"
fi

echo ""
echo "🏁 테스트 완료!"