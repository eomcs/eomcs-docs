# Docker Desktop for macOS 설치 안내서

이 문서는 macOS에 Docker Desktop을 설치하는 방법을 안내한다. **Docker Desktop**은 Docker 컨테이너를 실행하고 관리하는 데 필요한 Docker Engine, Docker CLI, Docker Compose와 그래픽 사용자 인터페이스를 통합하여 제공한다.

## 1. 설치 전 확인

### 시스템 요구 사항

- Docker가 지원하는 macOS 버전
  - Docker는 현재 macOS 메이저 버전과 이전 두 개 메이저 버전을 지원한다.
  - 지원 범위는 새 macOS가 출시될 때 바뀔 수 있으므로
    [Docker 공식 설치 문서](https://docs.docker.com/desktop/setup/install/mac-install/)에서
    현재 지원 버전을 확인한다.
- 메모리 4GB 이상
- 설치 파일을 내려받을 수 있는 인터넷 연결
- 권장 설정을 적용하려면 관리자 암호가 필요할 수 있다.

> **라이선스 안내:** 개인 사용, 교육, 비상업 오픈 소스 프로젝트 및
> 일정 규모 미만의 소규모 기업에서는 무료로 사용할 수 있다.
> 대규모 기업이나 정부 기관 등은 유료 구독이 필요할 수 있으므로
> [Docker 구독 정책](https://www.docker.com/pricing/faq/)을 확인해야 한다.

### Mac 프로세서 확인

Apple 메뉴에서 **이 Mac에 관하여(About This Mac)**를 열고
**칩(Chip)** 또는 **프로세서(Processor)** 항목을 확인한다.

터미널에서는 다음 명령으로도 확인할 수 있다.

```bash
uname -m
```

실행 결과에 맞는 설치 파일을 선택한다.

| 실행 결과 | Mac 종류 | 설치 파일 |
| --- | --- | --- |
| `arm64` | Apple silicon(M1, M2, M3, M4 등) | Apple silicon용 |
| `x86_64` | Intel 프로세서 | Intel용 |

Apple silicon Mac에서는 Rosetta 2가 필수는 아니지만,
일부 AMD64용 명령줄 도구를 사용할 때 필요할 수 있다.
필요한 경우 다음 명령으로 설치한다.

```bash
softwareupdate --install-rosetta
```

## 2. Docker Desktop 설치

### 설치 파일 내려받기

1. [Docker Desktop for Mac 설치 페이지](https://docs.docker.com/desktop/setup/install/mac-install/)에 접속한다.
2. Mac의 프로세서에 맞는 **Apple silicon** 또는 **Intel chip** 설치 파일을 선택하여 다운로드 한다.

> 설치 또는 업데이트 전에는 터미널, Visual Studio Code 등
> 백그라운드에서 Docker를 사용할 수 있는 프로그램을 종료하는 것이 좋다.

### 애플리케이션 설치

1. 내려받은 `Docker.dmg` 파일을 더블 클릭한다.
2. 설치 창에서 Docker 아이콘을 **Applications** 폴더로 끌어다 놓는다.
3. 복사가 끝나면 Finder에서 **응용 프로그램(Applications)** 폴더를 연다.
4. `Docker.app`을 더블 클릭한다.
5. macOS가 실행 여부를 물으면 **열기(Open)**를 선택한다.
6. Docker Subscription Service Agreement를 확인하고 **Accept**를 선택한다.
7. 초기 설정 화면에서 다음 중 하나를 선택한다.
   - **Use recommended settings**: 일반 사용자에게 권장한다. 필요한 시스템 설정을
     Docker Desktop이 구성하며 관리자 암호를 요구할 수 있다.
   - **Use advanced settings**: Docker CLI 설치 위치, 기본 Docker 소켓,
     1024 미만 포트 사용 권한 등을 직접 설정한다.
8. **Finish**를 선택한다. 필요한 경우 macOS 관리자 암호를 입력한다.
9. 설치가 완료되면, 메뉴 막대에 Docker 고래 아이콘이 표시된다.
10. 아이콘의 상태가 **Docker Desktop is running**이 될 때까지 기다린다.

> Docker Desktop은 기본적으로 `/Applications/Docker.app`에 설치된다.
> Docker Hub 계정 로그인은 공개 이미지를 내려받고 기본 기능을 확인하는 데
> 반드시 필요한 것은 아니다.

## 3. 설치 확인

터미널을 새로 열고 다음 명령을 차례로 실행한다.

### Docker 버전 확인

```bash
docker --version
docker compose version
```

Docker와 Docker Compose의 버전이 각각 출력되면 명령줄 도구가 정상적으로
설치된 것이다.

### 테스트 컨테이너 실행

```bash
docker run --rm hello-world
```

처음 실행할 때는 Docker Hub에서 `hello-world` 이미지를 내려받는다.
출력에 `Hello from Docker!`가 나타나면 Docker Engine과 컨테이너 실행 환경이
정상적으로 동작하는 것이다. `--rm` 옵션은 실행이 끝난 테스트 컨테이너를
자동으로 삭제한다.

다음 명령으로 Docker Engine의 상세 정보도 확인할 수 있다.

```bash
docker info
```

## 4. 기본 설정

메뉴 막대의 Docker 아이콘에서 **Settings**를 열어 설정을 변경할 수 있다.

- **General > Start Docker Desktop when you sign in to your computer**
  - macOS 로그인 시 Docker Desktop을 자동으로 시작한다.
- **Resources**
  - Docker 가상 머신에 할당할 CPU, 메모리 및 디스크 사용량을 조절한다.
- **Resources > File sharing**
  - 컨테이너와 공유할 호스트 디렉터리를 관리한다.
- **Advanced**
  - Docker CLI 설치 위치, 기본 Docker 소켓 및 privileged port 매핑을 설정한다.

설정을 변경한 뒤 Docker Desktop이 재시작될 수 있다.

## 5. 자주 발생하는 문제

### `Cannot connect to the Docker daemon` 오류

Docker Desktop이 실행 중인지 확인한다. 응용 프로그램 폴더에서 Docker를 실행한 뒤
메뉴 막대의 Docker 아이콘이 실행 완료 상태가 될 때까지 기다린다.

현재 Docker context도 확인한다.

```bash
docker context ls
docker context use desktop-linux
```

### `docker: command not found` 오류

Docker Desktop을 한 번 실행해 초기 설정을 완료한 다음 터미널을 새로 연다.
고급 설정에서 CLI 도구를 사용자 디렉터리(`$HOME/.docker/bin`)에 설치했다면
다음 내용을 `~/.zshrc`에 추가하고 터미널을 다시 연다.

```bash
export PATH="$PATH:$HOME/.docker/bin"
```

### 이미지 플랫폼이 맞지 않는다는 경고

Apple silicon Mac에서 `linux/amd64` 전용 이미지를 실행하면 플랫폼 경고가
표시되거나 실행되지 않을 수 있다. 이미지가 `linux/arm64`를 지원하는지 먼저
확인한다. AMD64 이미지가 꼭 필요하면 다음과 같이 플랫폼을 지정할 수 있지만,
에뮬레이션 때문에 성능이 저하될 수 있다.

```bash
docker run --platform linux/amd64 이미지이름
```

### 관리자 권한 없이 CLI를 설치한 경우

CLI 도구 위치를 `$HOME/.docker/bin`으로 선택하면 관리자 권한 없이 설치할 수 있지만,
위에서 설명한 것처럼 해당 디렉터리를 `PATH`에 추가해야 한다.
기본 소켓(`/var/run/docker.sock`)을 사용하는 일부 외부 도구는 Docker Desktop의
**Settings > Advanced > Allow the default Docker socket to be used** 설정이 필요할 수 있다.

## 참고 자료

- [Docker Desktop for Mac 설치](https://docs.docker.com/desktop/setup/install/mac-install/)
- [macOS 권한 요구 사항](https://docs.docker.com/desktop/setup/install/mac-permission-requirements/)
- [Docker Desktop 설정](https://docs.docker.com/desktop/settings-and-maintenance/settings/)
- [Docker 시작하기](https://docs.docker.com/get-started/)
