# 바이브 코딩 프로젝트 설정

AI 에이전트가 코드를 자동으로 실행·수정·설치·빌드·테스트하는 환경을 안전하고 재현 가능하게 만들기 위해서 도커 컨테이너를 사용합니다. 이 문서에서는 바이브 코딩 프로젝트 설정 방법을 안내합니다.

## 1. 바이브 코딩을 도커 컨테이너에서 실행하는 이유

### 1.1 AI 에이전트가 하는 일

- 패키지 설치 (apt, npm, pip 등)
- 파일 생성/삭제
- 프로그램 실행 (java, node)
- 시스템 명령 실행 (rm -rf, curl, chmod) 등

예를 들어, AI가 다음과 같은 지시를 할 수 있다.

```
apt install some-package
npm install some-library
pip install some-library
wget .../install.sh | bash
rm -rf /some/important/directory
```

### 1.2 AI 에이전트를 호스트 OS에서 실행할 때 (문제점)

- **시스템이 손상**되거나 **중요한 데이터가 삭제**될 위험이 있다.
- **불필요한 소프트웨어가 설치**되거나, 기존에 설치된 **소프트웨어와 충돌이 발생**하거나 **PATH가 오염**될 수 있다.
- **개발자마다 다른 환경**으로 인해 동일한 코드를 실행해도 다른 결과가 나올 수 있다.

### 1.3 AI 에이전트를 컨테이너에서 실행할 때 (이점)

- AI 에이전트의 실행 권한을 격리하여 **호스트 OS를 보호**할 수 있다.
- 호스트 머신에 불필요한 소프트웨어 설치 없이 필요한 모든 도구와 라이브러리를 컨테이너 내부에 격리하여 설치할 수 있습니다. 즉, **호스트의 환경 오염을 방지**한다.
- 팀 전체가 **동일한 개발 환경**을 사용함으로써, **재현성을 100% 확보**할 수 있다. 즉, 컨테이너 이미지를 통해 동일한 개발 환경을 여러 머신에서 재현할 수 있습니다.
- 도커파일과 설정 파일을 통해 **개발 환경 구성을 코드로 관리**할 수 있습니다.

| 이유                           | 설명                                       |
| ------------------------------ | ------------------------------------------ |
| 🔒 보안/격리                   | AI의 명령이 Host OS에 영향을 주지 않음     |
| 🧼 시스템 오염 방지            | 패키지 설치/삭제를 Host에 남기지 않음      |
| 🧪 실험 환경 리셋 가능         | 컨테이너 삭제 → 원상복구                   |
| 👥 환경 통일                   | 팀에서 모두 같은 환경 사용                 |
| 🧩 복합 아키텍처 관리          | DB/백엔드/프론트/Redis 등을 compose로 묶기 |
| 🐧 AI-friendly 환경(Linux CLI) | AI 에이전트가 명령 실행하기 좋은 환경      |
| 🧠 책임 분리(IDE vs Agent)     | Host는 IDE, 컨테이너는 AI 실행 환경        |

### 1.4 Host OS와 Docker 컨테이너의 역할 분담

**Host OS에서는:**

- VSCode/IntelliJ로 코드 편집
- docker 컨테이너 실행
- 웹 애플리케이션: 브라우저로 결과 확인

**Docker Container에서는:**

- AI Agent가 명령 실행
- 빌드/실행/테스트
- 패키지 설치
- 파일 조작

## 2. 개발 환경 구축

### 2.1 Docker Desktop 설치

Docker Desktop을 설치하여 바이브 코딩 개발 환경을 컨테이너에서 실행할 수 있도록 준비한다. Docker가 설치되어 있지 않다면 [Docker 공식 사이트](https://www.docker.com/products/docker-desktop/)에서 설치 방법을 참고한다.

### 2.2 Dockerfile 작성

[Dockerfile 예시](./Dockerfile)를 참고하여 프로젝트에 맞는 Dockerfile을 작성한다. 이 파일은 도커 컨테이너에 AI 에이전트가 사용할 개발 환경을 정의한다.

### 2.3 Docker Compose 작성

[Docker Compose 예시](./docker-compose.yml)를 참고하여 `docker-compose.yml` 파일을 작성한다.

### 2.4 컨테이너 이미지 빌드 및 실행

프로젝트 루트에서:

```bash
# 처음 시작: 이미지 빌드 + 컨테이너 생성/실행
docker compose up -d

# 단순 재시작 (코드 변경 X)
docker compose restart

# Dockerfile/설정 변경 후: 재빌드 + 컨테이너 생성/실행
docker compose up -d --build

# 컨테이너 쉘 접속
docker exec -it vibe-dev bash

```

Docker Compose로 생성한 컨테이너 삭제:

```bash
# 컨테이너, 네트워크 삭제. 볼륨은 유지
docker compose down

# 이미지까지 삭제
docker compose down --rmi all

# 볼륨까지 모두 삭제
docker compose down --volumes

# 컨테이너 + 네트워크 + 이미지 + 볼륨 모두 삭제
docker compose down --rmi all --volumes
```

## 3. 바이브 코딩

### 3.1 Claude 사용

컨테이너 쉘에서 `claude` 명령어로 바이브 코딩을 시작한다. 예:

```bash
claude
# 로그인 링크를 복사하여 호스트 OS의 브라우저에서 열기
# 웹페이지의 key를 복사하여 터미널에 붙여넣기
```

### 3.2 OpenAI Codex CLI 사용

호스트 OS에서 codex 인증을 먼저 수행한다:

```bash
npm install -g @openai/codex
codex login
# 로그인을 수행하면 ~/.codex/ 디렉토리에 인증 토큰이 저장된다.
```

그 다음 컨테이너 쉘에서 `codex` 명령어로 OpenAI Codex CLI를 사용할 수 있다. 예:

```bash
codex
```

### 3.3 Gemini CLI 사용

호스트 OS에서 gemini 인증을 먼저 수행한다:

```bash
npm install -g @google/gemini-cli
gemini
# 로그인을 수행하면 ~/.gemini/ 디렉토리에 인증 토큰이 저장된다.
```

그 다음 컨테이너 쉘에서 `gemini` 명령어로 Gemini CLI를 사용할 수 있다. 예:

```bash
gemini
```
