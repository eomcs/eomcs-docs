# VirtualBox 사용 안내

## 준비

### Windows 11

`VirtualBox`와 `Hyper-V` 계열 가상화 기술**이 동일한 하드웨어 가상화 기능(Intel VT-x, AMD-V)을 놓고 경쟁하기 때문에 VirtualBox를 사용할 때는 **다음 Windows 기능을 꺼야 충돌이 발생하지 않고 성능 향상을 꾀할 수 있다.**

**꺼야할 Windows 기능:**

- Hyper-V
- Linux용 Windows 하위 시스템(WSL2)
- 가상 머신 플랫폼(Virtual Machine Platform)
- Windows Hypervisor Platform
- Windows Sandbox
- Device Guard / Credential Guard

**Hyper-V 활성화 전/후 구동 원리:**

```bash
# 활성화 전

VirtualBox
    ↓
VT-x / AMD-V
    ↓
CPU
```

```bash
# Hyper-V 활성화 후

VirtualBox
    ↓
Hyper-V
    ↓
VT-x / AMD-V
    ↓
CPU
```

- VirtualBox가 CPU를 직접 제어하지 못하고 Hyper-V 위에서 동작하게 된다.
- 성능 저하
  - CPU 가상화 오버헤드 증가
  - I/O 성능 저하
  - 부팅 속도 저하
- 64비트 게스트 OS 실행 불가
  - 실제로 BIOS는 활성화되어 있는데 Hyper-V가 먼저 점유한 경우에 발생
  - 예:
    - `VT-x is not available`
    - `AMD-V is disabled`
- VM이 아예 실행되지 않음
  - `Raw-mode is unavailable courtesy of Hyper-V`
  - `VT-x is being used by another hypervisor`

**Linux용 Windows 하위 시스템(WSL2)을 끄는 이유:**


*WSL1 구동 원리:*

```
Windows Kernel
    ↓
Linux 호환 계층
```

- Hyper-V 사용 안 함

*WSL2 구동 원리:*

```
Hyper-V
    ↓
Linux Kernel
```

- WSL2가 설치되면 Hyper-V 관련 기능이 활성화


**가상 머신 플랫폼(Virtual Machine Platform)을 끄는 이유:**

이 기능은 사실상 WSL2를 위한 Hyper-V 구성 요소이다.

```
Windows
  └─ Virtual Machine Platform
          ↓
       Hyper-V
          ↓
        WSL2
```

- VirtualBox 성능을 최대로 사용하려면 끄는 것이 좋다

**Docker Desktop을 사용할 때:**

```
Docker Desktop
    ↓
WSL2
    ↓
Hyper-V
```

- 기본적으로 Hyper-V 또는 WSL2를 사용한다.
- Docker Desktop 와 VirtualBox의 성능을 동시에 만족시키기 어렵다.

## 설치

https://www.virtualbox.org/ 사이트에서 다운로드 후 설치