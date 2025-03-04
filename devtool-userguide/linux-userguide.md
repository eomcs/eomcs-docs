# 리눅스 사용법

## 리눅스 시스템 구성

- 하드웨어
    - 프로세서(CPU), 주기억장치(RAM), 디스크, 네트워크 포트 등
- 리눅스 커널(kernel)
    - 하드웨어를 관리하고, 하드웨어와 프로그램 사이의 인터페이스 역할 수행.
    - 프로세서나 주기억 장치에 제한없이 접근 가능.
    - 커널 모드에서 동작.
    - 커널만 접근할 수 있는 영역을 '커널 공간(kernel space)'이라 부른다. 
    - 주요 역할
        - 프로세스 관리: 프로세스 생성, 스케줄링, 종료 등
        - 메모리 관리: 가상 메모리, 페이지 테이블 관리, Swap 영역을 통해 메모리 확장 등
        - 파일시스템 관리: 파일 읽기/쓰기/삭제 처리, 디렉토리 관리 등
        - 네트워크 관리: 패킷 전송, IP 주소할당, 방화벽 설정, TCP/IP 스택 제공 등
        - 장치 드라이버: 하드웨어와 사용자 프로그램 사이의 인터페이스, dev 디렉토리를 통해 장치 파일 제공 등
        - 시스템 콜(system call): 사용자 프로세스와의 상호작용. Low-Level API 제공.
            - open(), read(), write(), close(), fork(), exec(), exit(), kill() 등
- 사용자 프로세스(user process)
    - 커널이 관리하는 실행 중인 프로그램이다.
        - 예) 웹서버, 그래픽 사용자 인터페이스, 서버, 쉘 등
    - 메모리 공간의 일부와 안전한 CPU 작업에만 접근 가능.
    - 사용자 모드에서 동작.
    - 프로세스가 접근할 수 있는 주기억 장치의 일부를 '사용자 공간(user space)'이라 부른다.  
- 시스템 라이브러리(system libraries)
    - 시스템 콜을 쉽게 사용할 수 있도록 감싸는 함수(High-Level API)
        - 예) glibc(GNU C Library): printf(), malloc(), fopen() 등
    - 사용자 모드에서 실행
        - 시스템 콜은 커널 모드에서 실행한다.
    - 시스템 콜을 직접 호출하면 복작하고 불편하기 때문에 이를 추상화하여 더 직관적인 형태의 API 제공
        - 단일 시스템 콜 예) fopen() --> open(), fread() --> read(), printf() --> write(), malloc() --> brk() + mmap()
        - 다중 시스템 콜 예) free() --> brk() + munmap(), system() --> fork() + exec() + wait() 
- 시스템 유틸리티(system utilities)
    - 시스템 관리 및 유지보수를 위한 기본 프로그램.
    - 커널과 직접 소통하지 않고, 시스템 라이브러리를 통해 기능 수행.
    - 주요 유틸리티
        - 파일 관리: ls, cp, mv, rm, find
        - 프로세스 관리: ps, top, kill, nice
        - 사용자 관리: whoami, passwd, groupadd, usermod
        - 네트워크 관리: ping, netstat, ifconfig, ip
        - 디스크 관리: df, du, fdisk, mount
- 쉘(shell)
    - 사용자가 명령어를 입력하면 이를 해석하여 커널에 전달하는 역할
    - CLI(command line interface) 환경 제공
    - 종류: zsh(Z Shell), sh(Bourne Shell), bash(Bourne Again Shell), csh(C Shell), ksh(Korn Shell) 등

## 주요 개념
- 배포판
    - 배포판 = 리눅스 OS의 핵심인 커널 + 목적에 따라 다양한 유틸리티, 응용 프로그램
    - distribution 또는 distro 라고 부른다.
        - Debian 계열: .deb, apt|dpkg($ apt install 패키지명)
        - Red Hat 계열: .rpm, yum|dnf|rpm($ dnf install 패키지명)
        - Arch Linux 계열: .pkg|.tar|.zst, pacman($ packman -S 패키지명)
- 커널(kernel)
    - 메모리 관리, 프로세스 스케쥴링, 파일 시스템, 하드웨어 추상화 등 OS의 핵심 기능 제공
- 명령어
    - 리눅스에 작업을 지시하는 간단한 프로그램들
    - `$ 명령어 [옵션] [아규먼트]` 형태로 콘솔에 입력한다.
- 셸(shell)
    - 입력한 명령어를 운영체제에 전달하여 실행하게 하는 프로그램
    - 예) bsh(Bourne shell), ksh(Korn shell), csh(C shell), bash(Bourne-again shell) 등
- 터미널 에뮬레이터
    - 예) KDE(konsole), GNOME(gnome-terminal)
    - 쉘에 접근할 수 있도록 도와주는 프로그램
- 셸 프롬프트
    - 사용자의 입력을 기다리는 상태
    - 보통 `$` 문자를 출력하며 키 입력을 기다리는 위치에 _ 이나 사각형 상자를 출력한다.
- X 윈도우
    - 창, 메뉴, 아이콘, 마우스 등을 지원하는 GUI 시스템
    - 보통 X 윈도우 기반으로 KDE나 GNOME을 올려 사용한다.
- 파일시스템
    - "컴퓨터에서 파일이나 자료를 쉽게 찾고 접근할 수 있도록 보관 또는 조직하는 체계"[한글 위키피디어]
    - 컴퓨터 사용 전에는 종이 문서를 저장하고 검색하는 방식을 가리키는 용어였다.
    - 예) FAT, FAT32, NTFS, ext2, ext3, ZFS, APFS 등
- 슬래시(/)와 디렉토리명, 파일명을 사용하여 그 위치를 표현한다.

## 리눅스 실행 단계

- 1. BIOS/UEFI
    - 하드웨어 초기화 후 부트로더 실행
- 2. 부트로더 실행
    - GRUB(또는 LILO) 실행
    - 커널과 initrd(initial RAM disk) 로드
- 3. 커널 초기화
    - 하드웨어 탐색 및 장치 드라이버 로딩
    - init 및 systemd 실행
- 4. 시스템 초기화
    - systemd 또는 init 서비스 시작
    - 파일시스템 마운트, 네트워크 설정
- 5. 로그인 프롬프트 제공
    - CLI(TTY) 또는 GUI 로그인 화면 표시

## 리눅스 디렉토리 계층 구조 

### 시스템 디렉토리
- 운영체제 파일, 애플리케이션, 문서 등이 들어 있다.
- 시스템 관리자가 접근한다.
- 디렉토리는 보통 `/스코프/카테고리/애플리케이션` 형태로 되어 있다.
- 스코프(scope)
    - 전체 디렉토리의 계층 구조의 목적을 설명한다.
    - `/` :  리눅스 시스템 파일(*root* 라고 읽음)
    - `/usr` : 또 다른 리눅스 시스템 파일
    - `/usr/local` : 소속된 기관이나 개인 컴퓨터에서 생성되는 시스템 파일
    - `/usr/games` : 게임 파일
- 카테고리(category)
    - 디렉토리 내에 존재하는 파일들을 분류한 것
    - 프로그램 관련 카테고리
        - `bin` : 프로그램이 들어 있다.
        - `sbin` : 수퍼 사용자를 위한 프로그램이 들어 있다.
        - `lib` : 프로그램이 사용하는 코드 라이브러리
    - 문서 관련 카테고리
        - `doc` : 문서
        - `info` : 이맥스에서 기본 제공하는 도움말 시스템 문서
        - `man` : man 프로그램이 표시하는 매뉴얼 페이지
        - `share` : 설치 안내 등과 같은 특정 프로그램
    - 설정 관련 카테고리
        - `etc` : 시스템 설정 파일
        - `init.d` : 리눅스 부팅을 위한 설정 파일
        - `rc*.d` : 부팅 모드에 따라 자동으로 시작될 스크립트 파일. 보통 `init.d` 디렉토리에 있는 파일의 링크이다.
    - 프로그래밍 관련 카테고리
        - `include` : 프로그래밍에 필요한 헤더 파일
        - `src` : 프로그램 소스 파일
    - 웹 관련 카테고리
        - `cgi-bin` : 웹 CGI 프로그램과 스크립트
        - `html` : 웹 페이지 관련 파일
        - `public_html` : 개인 홈페이지 관련 파일. 사용자 홈 디렉토리에 있다.
        - `www` : 웹 페이지 관련 파일
    - 디스플레이 관련 카테고리
        - `fonts` : 글꼴
        - `X11` : X 윈도우 시스템 파일
    - 하드웨어 관련 카테고리
        - `dev` : 디스크 및 그 외 하드웨어와 인터페이스를 위한 장치 파일
        - `media` : 디스크에 접근하게 해 주는 디렉토리. 마운트 지점. 
        - `mnt` : 디스크에 접근하게 해 주는 디렉토리. 마운트 지점.
    - 런타임 관련 카테고리
        - `var` : 프로그램들이 런타임 정보를 기록하는 디렉토리
            - 시스템 로깅, 사용자 트래싱, 캐시, 시스템 파일이 생성하고 관리하는 파일을 두는 곳.
        - `lock` : 현재 실행 중인 상태를 알리기 위해 프로그램이 생성한 파일.
        - `log` : 오류, 경고, 정보 메시지 등을 담고 있는 파일
        - `mail` : 수신 메일함
        - `run` : 실행되고 있는 프로세스의 아이디를 담고 있는 PID 파일
        - `spool` : 메일 발신, 작업 출력 등 대기 중이거나 전송 중인 파일
        - `tmp` : 프로그램 또는 사용자가 사용할 임시 저장 파일
        - `proc` : 운영 체제 상태. 현재 실행 중인 프로세스를 보여준다.
- 애플리케이션(application)
    - `/usr/bin/zip` 처럼 스코프와 카테고리 다음에 보통 프로그램들이 놓인다.

### 운영체제 디렉토리
- 커널을 지원하는 파일을 두는 디렉토리
- `/boot` : 시스템 부팅을 위한 파일. 여기에 커널이 있다.
- `/lost+found` : 손상된 파일. 디스크 복구 도구로 고칠 수 있다.
- `/proc` : 현재 실행 중인 프로세스를 파일 형태로 보여 준다. 
    - 용량이 거의 없고 읽기 전용이며 최신 상태를 보여 준다. 
    - 일부 파일은 자세한 정보를 담고 있기도 하다.
    - `/proc/ioports` : 입출력 하드웨어 목록
    - `/proc/cpuinfo` : 컴퓨터 프로세서 관련 정보
    - `/proc/version` : 운영 체제 버전. `uname` 명령은 간단한 이름만 출력한다.
    - `/proc/uptime` : 가장 최근 부팅 후 경과된 시간. 
        - 사람이 이해하기 힘들다. 
        - `uptime` 명령어를 사용하라. 
    - `/proc/nnn` : 아이디가 nnn인 프로세스 정보. nnn은 양의 정수이다.
    - `/proc/self` : 현재 실행 중인 프로세스 정보.
        - `/proc/nnn` 파일에 대한 심볼릭 링크이고 자동으로 업데이트 된다.
        - 확인하는 방법: `ls -l /proc/self` 

### 홈 디렉토리
- 사용자의 개인적인 파일을 두는 디렉토리이다.
- `/home/사용자명` 일반 사용자 홈 디렉토리
- `/root` 수퍼 사용자 디렉토리
- `echo $HOME` 으로 사용자의 홈 디렉토리를 확인할 수 있다.
- `~` 경로는 사용자 홈 디렉토리를 가리킨다.
    - 예) `cd ~/test` 명령어는 사용자 홈 디렉토리에 있는 test 디렉토리로 이동시킨다.


### /usr/share/doc 디렉토리

- 프로그램의 문서가 들어 있는 디렉토리
- 이 디렉토리는 각 프로그램의 문서를 담고 있는 하위 디렉토리를 포함한다.
- 하위 디렉토리의 이름은 프로그램명과 버전으로 명명되어 있다.

```
예1) /usr/share/doc 디렉토리 조회
$ ls /usr/share/doc
합계 1320
drwxr-xr-x 2 root root  4096  6월 22 21:44 acl-2.2.49
drwxr-xr-x 2 root root  4096  6월 22 21:44 acpid-2.0.19
drwxr-xr-x 2 root root  4096  6월 22 21:44 alsa-lib-1.0.22
drwxr-xr-x 2 root root  4096  7월  9 05:38 apr-1.5.2
drwxr-xr-x 2 root root  4096  7월  9 05:38 apr-util-1.5.4
...
```

## 실습 준비 

- 다음 내용은 O'REILLY 출판사의 '리눅스 핵심 레퍼런스'를 요약한 내용이다.
- 실습 예제 파일을 다운로드 하여 홈 디렉토리에 풀고 연습하라.

```
$ cd   <=== 홈디렉토리로 이동하기
$ wget http://linuxpocketguide.com/LPG-stuff.tar.gz   <=== 파일 다운로드
$ tar -xf LPG-stuff.tar.gz   <=== 압축 해제
```


## 파일 시스템 탐색

### `pwd` - 현재 작업 디렉토리를 표시하기

```
[vagrant@host1 ~]$ pwd
/home/vagrant
```

### `ls` - 디렉토리 내용 나열하기

```
[vagrant@host1 ~]$ ls
LPG-stuff.tar.gz  git  linuxpocketguide
```

### `cd` - 디렉토리 변경하기

- 절대 경로명
```
[vagrant@host1 ~]$ cd /usr/bin
[vagrant@host1 bin]$ pwd
/usr/bin
[vagrant@host1 bin]$ ls
..
```

- 사용자 홈 디렉토리로 이동
```
[vagrant@host1 bin]$ cd
[vagrant@host1 ~]$ pwd
/home/vagrant
```

- 상대 경로명
```
[vagrant@host1 ~]$ cd /usr/bin
[vagrant@host1 bin]$ pwd  
/usr/bin
[vagrant@host1 bin]$ cd ..    <--- 상위 폴더로 이동
[vagrant@host1 usr]$ pwd
/usr
[vagrant@host1 usr]$ cd ./bin    <--- 현재 폴더 아래의 bin 으로 이동
[vagrant@host1 bin]$ pwd
/usr/bin
[vagrant@host1 bin]$ cd ..
[vagrant@host1 usr]$ cd bin    <--- ./는 생략 가능
[vagrant@host1 bin]$ pwd
/usr/bin
[vagrant@host1 bin]$ cd ~/git    <--- ~/ 는 사용자 홈 디렉토리를 가리킨다.
[vagrant@host1 git]$ pwd
/home/vagrant/git
[vagrant@host1 git]$ 
```

### --help

- 해당 명령에서 준비한 간단한 도움말을 출력한다.
- 대부분의 명령어는 간단한 도움을 출력하는 이 옵션을 제공한다.

```
예1) ls 명령어의 간단한 도움말 보기
        명령어 --help
$ ls --help
```



### {값1, 값2, ...} 중괄호 확장

- 와일드카드처럼 주어진 값으로 확장된다. 

```
예1) echo file{01,02,03}.txt
$ echo file{-01,-02,-03}.txt
file-01.txt file-02.txt file-03.txt
```


## 시스템 살펴보기

### `ls` - 디렉토리 내용 나열하기

- 현재 작업 디렉토리에 있는 파일과 하위 디렉토리를 나열하기
```
[vagrant@host1 ~]$ cd /usr
[vagrant@host1 usr]$ ls
bin  etc  games  include  lib  lib64  libexec  local  sbin  share  src  tmp
```

- 파일과 디렉토리의 자세한 속성까지 출력하기
```
[vagrant@host1 usr]$ ls -l
total 108
dr-xr-xr-x.  2 root root 24576 Nov 20 12:00 bin
...
drwxr-xr-x.  4 root root    34 Apr 30  2020 src
lrwxrwxrwx.  1 root root    10 Apr 30  2020 tmp -> ../var/tmp
```
- 출력 항목의 의미 
    - 예) `dr-xr-xr-x.  2 root root 24576 Nov 20 12:00 bin`
    - `dr-xr-xr-x` 
        - 디렉토리(d), 파일(-), 링크(l) 구분자
        - 소유자 권한(r-x), 그룹 권한(r-x), 기타 사용자 권한(r-x)
        - 읽기 가능(r), 쓰기 가능(w), 실행 가능(x)
    - `2` : 하드 링크의 수
    - `root` : 파일 소유자의 로그인 ID
    - `root` : 파일 소유자의 그룹명
    - `24576` : 파일 크기(바이트)
    - `Nov 20 12:00` : 마지막 수정일
    - `bin` : 파일 또는 디렉토리 이름
- 한 번에 여러 디렉토리 목록 보기
```
[vagrant@host1 usr]$ ls ~ /usr
/home/vagrant:
LPG-stuff.tar.gz  git  linuxpocketguide

/usr:
bin  etc  games  include  lib  lib64  libexec  local  sbin  share  src  tmp
```

- 자주 사용하는 `ls` 명령어 옵션

| 짧은 옵션 | 긴 옵션 | 설명 |
|---|---|---|
|-a|--all|모든파일보기. 숨김 파일 표시|
|-l| |좀 더 자세한 정보를 출력|
|-s| |파일 크기순으로 출력|
|-t| |파일 수정 시간 순으로 출력|

### * (와일드카드)

- 와일드카드는 명령어를 실행하기 전에 셸에 의해 실제 파일명과 일치하는 형태로 확장된다.
- 즉 명령어에서 와일드카드를 처리하는 것이 아니라 명령어를 실행하기 전에 셸이 먼저 와일드카드를 처리한다.
- 와일드카드
    - `*` : 0개 이상의 문자
    - `?` : 어떤 한 문자
    - `[문자집합]` : 문자집합에 선언된 문자 중에 한 문자
    - `[^문자집합]` 또는 `[!문자집합]`: 문자집합에 없는 어떤 문자 
    - 

```
예1) 현재 디렉토리에서 파일명이 a로 시작하는 목록을 출력하기
$ ls a*

=> 위의 명령은 셸에 의해 다음으로 바뀐 다음에 ls 명령을 실행한다.
$ ls aardvark adamantium apple
``` 

```
예2) 파일 이름이 'file'로 시작하고, 뒤의 한 자는 A 또는 B인 파일
$ ls file[AB]
fileA  fileB
```

### dot file (마침표 파일)

- 마침표로 시작하는 파일은 특정 프로그램에 노출되지 않는다.
- `ls` 명령은 `-a` 옵션을 입력하지 않으면 출력 내용에서 마침표 파일을 제외한다.
- 셸 와일드카드는 마침표로 시작하는 파일을 처리하지 않는다.
- 보통 *숨김 파일(hidden file)* 이라고 부른다.

 

```
예1) dot file도 출력에 포함하기
$ ls
aardvark     fileA               myfile.zip    quadratic.txt  script-if
adamantium   fileB               myfile2       randomlines    script-seq
...

$ ls -a
.             emptyfile           myfile        quadratic.txt  script-seq
..            examplelink         myfile.zip    randomlines    script-until
.hidden_file  fileA               myfile2       reset-lpg      script-while
aardvark      fileB               myfile3       sample.pdf     somefile
adamantium    findfile1           newnames      sample.ps      spacefile
...
```

### `file` - 파일 타입 확인하기

```
[vagrant@host1 ~]$ file LPG-stuff.tar.gz 
LPG-stuff.tar.gz: gzip compressed data, from Unix, last modified: Wed May  4 13:30:49 2016
[vagrant@host1 ~]$ file git
git: directory
```

### `less` - 파일 내용 표시하기

```
[vagrant@host1 ~]$ less /etc/passwd

root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
...
```


## 파일과 디렉토리 조작

### `cp` - 파일 및 디렉토리 복사

### `mv` - 파일 및 디렉토리 이동, 이름 변경

### `mkdir` - 디렉토리 만들기

### `rm` - 파일 및 디렉토리 삭제 

### `ln` - 하드 링크 또는 심볼릭 링크 만들기


## 명령어를 다루는 방법

### `type` - 명령어의 이름이 어떻게 표시되는지 확인

- 명령어가 리눅스 프로그램인지 셸 내장 명령어 인지 알려준다.

```
예1) ls와 who 명령어의 타입을 알아본다.
$ type who
who is /usr/bin/who
$ type cd
cd is a shell builtin
```

### `which` - 실행 프로그램의 위치 표시

### `man` - 명령어의 man 페이지 표시 

- 온라인 매뉴얼 페이지나 해당 프로그램의 manpage를 출력한다.

```
예1) 명령어 사용법 보기
        man 명령어
$ man wc
```

```
예2) 매뉴얼 페이지에서 특정 검색어로 검색하기
        man -k 검색어
$ man -k database | less
```

### `apropos` - 적합한 명령어 리스트 표시 

### `info` - 명령어 정보 표시 

- 하이퍼텍스트 기반 도움말을 출력한다.
- 즉 텍스트 모드 웹 브라우저로 도움말을 보고 링크를 따라 페이지를 이동할 수 있다.
- 사용법
    - h 키 : 도움말
    - q 키 : 종료
    - 스페이스 키 : 다음 페이지
    - 백스페이스 키 : 이전 페이지
    - 탭(tab) : 다음 하이퍼링크로 이동
    - 엔터(enter) : 하이퍼링크가 가리키는 페이지로 이동
  
```
예1) ls 명령어의 도움말을 하이퍼텍스트로 보기
        info 명령어
$ info ls
```

### `whatis` - 명령어에 대한 짧은 설명 표시

### `alias` - 명령어에 별치 붙이기




