# Docker Desktop for Windows 11 설치 안내서

이 문서는 Windows 11에 Docker Desktop을 설치하는 방법을 안내한다.
**Docker Desktop**은 Docker 컨테이너를 실행하고 관리하는 데 필요한
Docker Engine, Docker CLI, Docker Compose와 그래픽 사용자 인터페이스를 통합하여 제공한다.

Windows 11에서는 일반적으로 **WSL 2(Windows Subsystem for Linux 2)**를 기반으로
Linux 컨테이너를 실행한다. 이 문서에서도 대부분의 개발자에게 적합한
`WSL 2 + 사용자별(per-user) 설치` 방식을 사용한다.

## 1. 설치 전 확인

### 시스템 요구 사항

- Docker가 지원하는 64비트 Windows 11
  - 현재 공식 x86_64 요구 사항은 Windows 11 23H2(빌드 22631) 이상이다.
  - Windows 지원 범위는 바뀔 수 있으므로
    [Docker 공식 설치 문서](https://docs.docker.com/desktop/setup/install/windows-install/)에서
    최신 요구 사항을 확인한다.
- WSL 2.1.5 이상
- 메모리 8GB 이상
- SLAT(Second Level Address Translation)를 지원하는 64비트 프로세서
- BIOS/UEFI에서 하드웨어 가상화 기능 활성화
- 설치 파일과 컨테이너 이미지를 내려받을 수 있는 인터넷 연결

> **Windows 에디션 안내:** Windows 11 Home과 Education에서는 Linux 컨테이너만
> 실행할 수 있다. Windows 컨테이너를 실행하려면 Windows 11 Pro 또는 Enterprise와
> 모든 사용자용(all-users) 설치가 필요하다.

> **라이선스 안내:** 개인 사용, 교육, 비상업 오픈 소스 프로젝트 및
> 일정 규모 미만의 소규모 기업에서는 무료로 사용할 수 있다.
> 대규모 기업이나 정부 기관 등은 유료 구독이 필요할 수 있으므로
> [Docker 구독 정책](https://www.docker.com/pricing/faq/)을 확인해야 한다.

### Windows 버전 확인

1. `Windows + R` 키를 누른다.
2. `winver`를 입력하고 **확인**을 누른다.
3. Windows 버전과 OS 빌드 번호를 확인한다.

또는 PowerShell에서 다음 명령을 실행한다.

```powershell
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
```

Windows 버전이 오래되었다면 **설정 > Windows 업데이트**에서 먼저 업데이트한다.

### CPU 종류 확인

PowerShell에서 다음 명령을 실행한다.

```powershell
$env:PROCESSOR_ARCHITECTURE
```

실행 결과에 맞는 설치 파일을 선택한다.

| 실행 결과 | PC 종류 | 설치 파일 |
| --- | --- | --- |
| `AMD64` | Intel 또는 AMD 64비트 프로세서 | x86_64용 |
| `ARM64` | ARM 기반 Windows PC | Windows Arm용 |

> Windows Arm용 Docker Desktop은 현재 Early Access로 제공될 수 있다.
> 사용 전에 공식 설치 문서에서 지원 상태와 제한 사항을 확인한다.

### 하드웨어 가상화 확인

1. `Ctrl + Shift + Esc`를 눌러 **작업 관리자(Task Manager)**를 연다.
2. **성능(Performance) > CPU**를 선택한다.
3. **가상화(Virtualization)**가 **사용(Enabled)**으로 표시되는지 확인한다.

비활성화되어 있다면 PC를 재시작하여 BIOS/UEFI 설정으로 들어간 뒤
Intel Virtualization Technology(VT-x) 또는 AMD-V/SVM 기능을 활성화한다.
메뉴 이름과 진입 방법은 PC 제조사마다 다르다.

## 2. WSL 2 설치 및 업데이트

Docker Desktop을 설치하기 전에 WSL 상태를 확인한다.
PowerShell 또는 명령 프롬프트를 열고 다음 명령을 실행한다.

```powershell
wsl --version
```

WSL 버전이 출력되고 2.1.5 이상이면 다음 단계로 이동한다.

### WSL이 설치되지 않은 경우

1. 시작 메뉴에서 **PowerShell**을 검색한다.
2. **관리자 권한으로 실행(Run as administrator)**을 선택한다.
3. 다음 명령을 실행한다.

```powershell
wsl --install
```

명령 실행이 끝나면 Windows를 재시작한다. 이 명령은 WSL에 필요한 Windows 기능과
기본 Linux 배포판인 Ubuntu를 함께 설치할 수 있다.

### WSL이 설치되어 있지만 버전이 오래된 경우

관리자 권한 PowerShell에서 다음 명령을 실행한다.

```powershell
wsl --update
wsl --set-default-version 2
```

업데이트 후 다음 명령으로 상태를 다시 확인한다.

```powershell
wsl --version
wsl --status
```

> Docker Desktop 자체는 별도의 Ubuntu 배포판을 요구하지 않는다.
> 다만 Ubuntu 등에서 직접 `docker` 명령을 사용하려면 설치 후
> Docker Desktop의 WSL 통합 기능을 활성화하면 된다.

## 3. Docker Desktop 설치

### 설치 파일 내려받기

1. [Docker Desktop for Windows 설치 페이지](https://docs.docker.com/desktop/setup/install/windows-install/)에 접속한다.
2. PC의 CPU에 맞는 **x86_64** 또는 **Arm** 설치 파일을 선택한다.
3. `Docker Desktop Installer.exe` 파일을 내려받는다.

### 설치 모드 선택

Docker Desktop은 다음 두 가지 모드로 설치할 수 있다.

| 구분 | 사용자별 설치(권장) | 모든 사용자용 설치 |
| --- | --- | --- |
| 대상 | 일반적인 Linux 컨테이너 개발 | 여러 사용자, Hyper-V 또는 Windows 컨테이너 |
| 관리자 권한 | 설치·업데이트 시 불필요 | 설치 시 필요 |
| 기본 설치 경로 | `%LOCALAPPDATA%\Programs\DockerDesktop` | `C:\Program Files\Docker\Docker` |
| 백엔드 | WSL 2 또는 Docker VMM | WSL 2, Hyper-V 또는 Docker VMM |
| Windows 컨테이너 | 지원하지 않음 | 지원함 |

이 안내서에서는 기본값인 **사용자별 설치**를 선택한다.

### 설치 프로그램 실행

1. 내려받은 `Docker Desktop Installer.exe`를 더블 클릭한다.
2. 설치 모드를 묻는 화면에서 **사용자별(per-user) 설치**를 선택한다.
3. 백엔드를 선택하는 구성 화면이 나타나면 **WSL 2**를 선택한다.
   - 시스템에서 사용할 수 있는 백엔드가 하나뿐이면 자동으로 선택될 수 있다.
4. 설치 안내에 따라 진행한다.
5. 설치가 완료되면 **Close**를 선택한다.

Docker Desktop은 설치 직후 자동으로 시작되지 않을 수 있다.

1. 시작 메뉴에서 **Docker Desktop**을 검색하여 실행한다.
2. Docker Subscription Service Agreement를 확인하고 **Accept**를 선택한다.
3. 작업 표시줄 알림 영역의 Docker 고래 아이콘이 실행 완료 상태가 될 때까지 기다린다.

> Docker Hub 로그인은 공개 이미지를 내려받고 기본 기능을 확인하는 데
> 반드시 필요한 것은 아니다.

## 4. 설치 확인

PowerShell 또는 Windows Terminal을 새로 열고 다음 명령을 차례로 실행한다.

### Docker 버전 확인

```powershell
docker --version
docker compose version
```

Docker와 Docker Compose의 버전이 각각 출력되면 명령줄 도구가 정상적으로
설치된 것이다.

### 테스트 컨테이너 실행

```powershell
docker run --rm hello-world
```

처음 실행할 때는 Docker Hub에서 `hello-world` 이미지를 내려받는다.
출력에 `Hello from Docker!`가 나타나면 Docker Engine과 Linux 컨테이너 실행 환경이
정상적으로 동작하는 것이다. `--rm` 옵션은 실행이 끝난 테스트 컨테이너를
자동으로 삭제한다.

다음 명령으로 Docker Engine의 상세 정보도 확인할 수 있다.

```powershell
docker info
```

## 5. WSL 배포판에서 Docker 사용

Ubuntu 등 설치된 WSL 2 배포판의 터미널에서도 `docker` 명령을 사용하려면
WSL 통합 기능을 활성화한다.

1. Docker Desktop에서 **Settings**를 연다.
2. **General**에서 **Use WSL 2 based engine**이 활성화되어 있는지 확인한다.
3. **Resources > WSL Integration**으로 이동한다.
4. Docker를 사용할 Linux 배포판을 활성화한다.
5. **Apply**를 선택한다.

배포판이 WSL 2로 실행되는지는 PowerShell에서 확인할 수 있다.

```powershell
wsl --list --verbose
```

`VERSION`이 `1`인 배포판은 다음 명령으로 WSL 2로 변환한다.

```powershell
wsl --set-version <배포판이름> 2
```

> WSL 배포판 안에 Docker Engine이나 Docker CLI를 별도로 설치하면
> Docker Desktop과 충돌할 수 있다. Docker Desktop의 WSL 통합 기능을 사용한다.

## 6. 기본 설정

Docker Desktop의 **Settings**에서 주요 설정을 변경할 수 있다.

- **General > Start Docker Desktop when you sign in to your computer**
  - Windows 로그인 시 Docker Desktop을 자동으로 시작한다.
- **General > Use WSL 2 based engine**
  - WSL 2 기반 Linux 컨테이너 엔진을 사용한다.
- **Resources > WSL Integration**
  - Docker 명령을 사용할 WSL 2 배포판을 선택한다.
- **Resources > Advanced**
  - Docker 데이터가 저장되는 디스크 위치 등을 설정한다.

설정을 변경하면 Docker Desktop이 재시작될 수 있다.

## 7. 자주 발생하는 문제

### Docker Desktop이 시작되지 않는 경우

WSL과 하드웨어 가상화 상태를 확인한다.

```powershell
wsl --version
wsl --status
wsl --update
```

작업 관리자의 **성능 > CPU**에서 가상화가 활성화되어 있는지도 확인한다.
WSL을 설치하거나 가상화 설정을 변경했다면 Windows를 재시작한다.

### `Cannot connect to the Docker daemon` 오류

Docker Desktop이 실행 중인지 확인하고 고래 아이콘이 실행 완료 상태가 될 때까지
기다린다. 그다음 현재 Docker context를 확인한다.

```powershell
docker context ls
docker context use desktop-linux
```

### `docker` 명령을 찾을 수 없는 경우

Docker Desktop의 초기 실행과 약관 동의를 완료한 뒤 PowerShell 또는 Windows Terminal을
새로 연다. 그래도 명령을 찾지 못하면 Docker Desktop을 재시작하거나 Windows에서
로그아웃한 후 다시 로그인한다.

### WSL 통합 설정에 Linux 배포판이 나타나지 않는 경우

현재 Docker Desktop이 Windows 컨테이너 모드인지 확인한다.
작업 표시줄의 Docker 메뉴에서 **Switch to Linux containers**를 선택한 다음
**Settings > Resources > WSL Integration**을 다시 확인한다.

배포판이 WSL 1로 실행 중이라면 WSL 2로 변환한다.

```powershell
wsl --list --verbose
wsl --set-version <배포판이름> 2
```

### WSL을 재시작해야 하는 경우

WSL이나 Docker 백엔드가 응답하지 않으면 Docker Desktop을 종료한 뒤
다음 명령으로 WSL을 종료하고 Docker Desktop을 다시 실행한다.

```powershell
wsl --shutdown
```

## 참고 자료

- [Docker Desktop for Windows 설치](https://docs.docker.com/desktop/setup/install/windows-install/)
- [Docker Desktop WSL 2 백엔드](https://docs.docker.com/desktop/features/wsl/)
- [Docker Desktop WSL 2 권장 사항](https://docs.docker.com/desktop/features/wsl/best-practices/)
- [Microsoft WSL 설치](https://learn.microsoft.com/windows/wsl/install)
- [Docker Desktop 문제 해결](https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/)
