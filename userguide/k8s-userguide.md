# 쿠버네티스 사용법

## 설치

### kubectl 바이너리 설치

1. 최신 릴리즈 다운로드

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

2. 다운로드 받은 파일 검증

```bash
# 체크섬 파일 다운로드
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# 다운로드 파일의 체크섬과 비교
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```

3. kubectl 설치

```bash
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

4. 버전 확인

```bash
kubectl version --client

# 설치된 버전의 상세 내용 확인
kubectl version --client --output=yaml
```
