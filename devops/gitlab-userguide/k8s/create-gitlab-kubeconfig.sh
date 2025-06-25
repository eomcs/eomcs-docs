#!/bin/bash
# create-gitlab-kubeconfig.sh - GitLab CI용 kubeconfig 생성

set -e

echo "=== GitLab CI용 kubeconfig 생성 ==="

# 1. 현재 컨텍스트 확인
echo "📋 현재 kubectl 컨텍스트:"
kubectl config current-context

# 2. 현재 설정 추출
echo "📤 kubeconfig 추출 중..."
kubectl config view --raw --context=docker-desktop > gitlab-kubeconfig.yaml

# 3. CI 환경용 서버 URL 수정
echo "🔧 서버 URL 수정 중..."
# 여러 가능한 형태를 모두 변경
sed -i.bak \
  -e 's|https://127.0.0.1:6443|https://host.docker.internal:6443|g' \
  -e 's|https://localhost:6443|https://host.docker.internal:6443|g' \
  -e 's|https://kubernetes.docker.internal:6443|https://host.docker.internal:6443|g' \
  gitlab-kubeconfig.yaml

# 4. 수정된 내용 확인
echo "📄 수정된 kubeconfig 내용:"
echo "----------------------------------------"
cat gitlab-kubeconfig.yaml
echo "----------------------------------------"

# 5. 설정 검증 (선택사항)
echo "🧪 설정 검증 중..."
kubectl --kubeconfig=gitlab-kubeconfig.yaml config view --minify

# 6. Base64 인코딩
echo "🔐 Base64 인코딩 중..."
ENCODED_CONFIG=$(cat gitlab-kubeconfig.yaml | base64 | tr -d '\n')

echo ""
echo "✅ 완료! 다음 값을 GitLab CI/CD Variables에 설정하세요:"
echo ""
echo "Key: KUBE_CONFIG"
echo "Value:"
echo "----------------------------------------"
echo "$ENCODED_CONFIG"
echo "----------------------------------------"
echo ""
echo "📍 GitLab Variables 설정 위치:"
echo "http://localhost:8929/user1/hello-api/-/settings/ci_cd"
echo ""
echo "💾 원본 파일 저장됨: gitlab-kubeconfig.yaml"
echo "💾 백업 파일 저장됨: gitlab-kubeconfig.yaml.bak"