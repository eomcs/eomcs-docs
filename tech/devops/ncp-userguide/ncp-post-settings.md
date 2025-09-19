# NCP 기본 설정 후 작업

## Container Registry 생성

- 프로젝트를 빌드할 때 생성하는 도커 이미지를 저장할 저장소이다
- 테라폼으로 생성할 수 없기 때문에 콘솔 웹 화면에서 직접 작업해야 한다.
- 작업
  - services> Containers> Container Registry > 레지스트리 생성
  - 레지스트리 이름 : k8s-edu-(내가원하는영문자or숫자)
  - 버킷 : `docker-image-xxx` 로 시작하는 위에서 만든 버킷 선택
  - ‘생성’ 버튼 클릭

### 로그인 테스트

```bash
$ sudo docker login k8s-edu-camp71.kr.ncr.ntruss.com
Username: Access Key ID
Password: Secret Key
```

## 작업 호스트 준비

### 도커 설치

- 스크립트 다운로드

```bash
$ sudo apt-get update
$ sudo apt-get install curl
$ curl https://get.docker.com > docker-install.sh
$ chmod 755 docker-install.sh
```

- 도커 설치

```bash
$ sudo ./docker-install.sh
```

### kubectl 바이너리 설치

- 최신 릴리즈 다운로드

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

- 다운로드 받은 파일 검증

```bash
# 체크섬 파일 다운로드
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# 다운로드 파일의 체크섬과 비교
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```

- kubectl 설치

```bash
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

- 버전 확인

```bash
kubectl version --client

# 설치된 버전의 상세 내용 확인
kubectl version --client --output=yaml
```

### ncp-iam-autthenticator 설치

- 설치파일 다운로드

```bash
cd ~
curl -o ncp-iam-authenticator https://kr.object.ncloudstorage.com/nks-download/ncp-iam-authenticator/v1.0.0/linux/amd64/ncp-iam-authenticator
```

- 바이너리 실행 권한 추가

```bash
chmod +x ./ncp-iam-authenticator
```

- $HOME/bin/ncp-iam-authenticator를 생성하고 $PATH에 추가

```bash
mkdir -p $HOME/bin && cp ./ncp-iam-authenticator $HOME/bin/ncp-iam-authenticator && export PATH=$PATH:$HOME/bin
```

- Shell Profile에 PATH를 추가 후 명령어가 잘 작동하는지 확인

```bash
$ nano .bash_profile
# .bashrc 파일이 존재하면 실행
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# 사용자 bin 디렉토리를 PATH에 추가
export PATH="$PATH:$HOME/bin"
```

```bash
source ~/.bash_profile # 현재 쉘에 변경사항 적용
ncp-iam-authenticator help # PATH에 잘 설정되었는지 확인
```

- 사용자 환경 홈 디렉터리의 .ncloud 폴더에 configure 파일 생성

```bash
$ mkdir .ncloud
$ nano ~/.ncloud/configure
[DEFAULT]
ncloud_access_key_id = <사용자의 Access key>
ncloud_secret_access_key = <사용자의 Secret key>
ncloud_api_url = https://ncloud.apigw.ntruss.com
```

- ncp-iam-authenticator create-kubeconfig 명령을 사용하여 kubeconfig를 생성
  `clusterUuid`는 Kubernetes Service / clusters 화면에서 확인한다.

```bash
# kubeconfig.yml 파일을 생성할 때 당장 사용해야 하기 때문에 임시 설정할 필요가 있다.
$ export NCLOUD_ACCESS_KEY=<사용자의 Access key>
$ export NCLOUD_SECRET_KEY=<사용자의 Secret key>
$ export NCLOUD_API_GW=https://ncloud.apigw.ntruss.com
$ ncp-iam-authenticator create-kubeconfig --region KR --clusterUuid <cluster-uuid> > kubeconfig.yml
```

- Kubeconfig 파일이 생성되면 kubectl 명령어를 테스트

```bash
kubectl get namespaces --kubeconfig kubeconfig.yml
```

- Kubeconfig 파일이 지정이 번거로울 경우, 아래와 같이 bash_profile 에 alias로 명시

```bash
echo "alias kubectl2='kubectl --kubeconfig=\$HOME/kubeconfig.yml'" >> ~/.bashrc
source ~/.bashrc
kubectl2 get namespaces
```

### K8S에 Container Registry 저장소의 접근키 등록

```bash
kubectl2 create secret docker-registry regcred \
--docker-server=<private-registry-end-point> \
--docker-username=<access-key-id> \
--docker-password=<secret-key> \
--docker-email=<your-email>

kubectl2 get secret
```

### Helm 설치

```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
helm version
```

### NGINX Ingress Controller 설치

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --kubeconfig ~/kubeconfig.yml
```

- 이전에 설치한 것 삭제하기

```bash
helm uninstall ingress-nginx --namespace ingress-nginx --kubeconfig ~/kubeconfig.yml
```

- 설치 확인

```bash
kubectl2 get pods -n ingress-nginx
```

- 외부 IP 확인

```bash
kubectl2 get svc -n ingress-nginx
```

### Cert-Manager 설치

```bash
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  --kubeconfig ~/kubeconfig.yml
```

- 설치 확인

```bash
kubectl2 get pods -n cert-manager
```

- 삭제

```bash
helm uninstall cert-manager --namespace cert-manager --kubeconfig ~/kubeconfig.yml
kubectl2 delete crd certificaterequests.cert-manager.io \
  certificates.cert-manager.io \
  challenges.acme.cert-manager.io \
  clusterissuers.cert-manager.io \
  issuers.cert-manager.io \
  orders.acme.cert-manager.io \
  --kubeconfig ~/kubeconfig.yml
kubectl2 get crd --kubeconfig ~/kubeconfig.yml | grep cert-manager
```

### Let's Encrypt ClusterIssuer 생성

- production 환경용 k8s Manifest 파일
  - [ncp-cluster-issuer-prod.yml](./ncp-cluster-issuer-prod.yml)
- 적용
  - `kubectl2 apply -f cluster-issuer-prod.yml`
