# 데브옵스 프로젝트 실습

## GitLab 설정

### 쿠버네티스 설정 정보 준비(root 사용자)

- 로컬에서 kubeconfig Base64 인코딩

```bash
# macOS, Linux
cat ~/.kube/config | base64 -w 0

# Windows 11
[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((Get-Content -Path "$env:USERPROFILE\.kube\config" -Raw)))

# 또는(macOS, Linux)
kubectl config view --raw --flatten | \
  sed 's|127.0.0.1:6443|kubernetes.docker.internal:6443|g' | \
  base64 -w 0
```

- GitLab root 사용자의 관리자 페이지
  - Settings => CI/CD => Variables 페이지 => 변수 추가
    - Key: KUBE_CONFIG
    - Value: 위에서 생성한 Base64 문자열
    - Type: Variable
    - Environment scope: *
    - Protect variable: ☐ (체크하지 않음)
    - Mask variable: ☐ (체크하지 않음 - 너무 길어서 불가능)
    - Expand variable reference: ☐ (체크하지 않음)

### 프로젝트 생성(일반 사용자)

- `새로 만들기` (왼쪽 상단 `+` 아이콘)
  - **빈 프로젝트 생성** 
    - 프로젝트 이름: 예) `hello-api`
    - 기타 설정


## 프로젝트 설정

### 로컬로 깃 저장소 복사하기 

```bash
git clone http://localhost:8929/<사용자아이디>/hello-api
```

### `.gitlab-ci.yml` 파일 생성

- CI/CD 파이프라인의 단계와 각 단계(stage)에서 실행할 작업(job) 및 스크립트를 정의하는 파일이다.
  - 예) 변수 및 job 간의 의존성 정의, job을 실행시키는 방법 및 때를 지정
- 프로젝트루트/`.gitlab-ci.yml`
  - [백엔드](./backend/.gitlab-ci.yml)
  - [프론트엔드](./frontend/.gitlab-ci.yml)

### 도커 이미지 생성 파일

- 프로젝트루트/`Dockerfile`
  - [백엔드](./backend/Dockerfile)
  - [백엔드](./frontend/Dockerfile)

### 쿠버네티스 배포 설정 파일

- 프로젝트루트/`k8s-deployment.yml`
  - [백엔드](./backend/k8s-deployment.yml)
  - [프론트엔드](./frontend/k8s-deployment.yml)

### next.js 설정 파일

- 프로젝트루트/`next.config.mjs`
  - [프론트엔드](./frontend/next.config.mjs)

#### 일반 빌드 vs Standalone 빌드 비교

| 구분          | 일반 빌드           | Standalone 빌드   |
|---------------|---------------------|-------------------|
| 실행 방법     | `npm start`         | `node server.js`  |
| 의존성        | 전체 node_modules   | 최소한의 의존성만 |
| 이미지 크기   | 800MB ~ 1.5GB       | 200MB ~ 400MB     | 
| 시작시간      | 느림(npm 오버헤드)  | 빠른(직접 실행)   |
| Docker 최적화 | 부분적              | 완전 최적화       |

## 프로젝트 빌드 및 배포

- 프로젝트 변경 사항을 깃 저장소로 보내기
  ```bash
  git add .
  git commit -m "커밋 메시지"
  git push # gitlab 서버에 보내기
  ```
- 인증 관련 오류가 발생할 때
  - SSH 키 생성:
    ```bash
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```
  - 공개 키를 GitLab에 추가:
    - GitLab → User Settings → SSH Keys
    - ~/.ssh/id_rsa.pub 내용 복사하여 추가
  - Remote URL 변경:
    ```bash
    git remote set-url origin git@localhost:user1/hello-api.git
    ```

- 프로젝트 빌드 및 배포 과정 확인하기
  - **프로젝트** 메뉴 => **프로젝트 둘러보기** => 목록에서 프로젝트 선택
    - **빌드** 메뉴 => **파이프라인** 메뉴 => 목록에서 작업 중인 파이프라인 확인  