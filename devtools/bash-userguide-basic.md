# Bash Shell User Guide - 기초편

## 1 개요

### 1.1 쉘(shell)이란?

- 운영체제에서 사용자와 커널 간의 인터페이스 역할을 하는 프로그램
- 사용자가 입력한 명령을 해석하여 커널에게 전달하고 그 실행 결과를 출력
- 명령어를 직접 입력하는 CLI(Command Line Interface) 환경 제공
- 배치 작업 및 자동화를 위한 스크립트(.sh 파일) 실행 기능 지원

### 1.2 Bash 쉘

- sh 호환 쉘이다. ksh, csh 의 유용한 기능을 통합하였다.
- IEEE POSIX P1003.2/ISO 9945.2 쉘 및 도구 표준을 따른다.

#### 1.2.1 주요 쉘

- Bash(Bourne Again Shell)
  - 기본 리눅스 쉘, sh 호환, 빠르고 가볍다, `/bin/bash`
- Sh(Bourne Shell)
  - 오래된 유닉스 계열 기본 쉘, 빠르고 가볍다, `/bin/sh`
- Zsh(Z Shell)
  - Bash와 호환, 자동완성 및 추천, 플러그인 기능 지원, `/bin/zsh`
- Ksh(Korn Shell)
  - Bash 보다 성능이 뛰어나며 스크립트 작성에 강점, `/bin/ksh`
- Fish(Friendly Interactive Shell)
  - 사용하기 쉬운 GUI 스타일과 자동 완성 기능 제공, `/usr/bin/fish`

### 1.2 용어 정의

- POSIX
  - 유닉스 계열 운영체제의 표준 인터페이스를 정의한 규격이다.
  - IEEE(미국 전기전자학회)에서 제정하였으며, 공식 명칭은 **IEEE 1003** 이다.
    - POSIX.1: 시스템 API 및 C 라이브러리 표준
    - POSIX.2: 쉘과 유틸리티(명령어) 표준
    - POSIX.3: 보안 및 네트워크 기능
    - POSIX.4: 실시간(Real-time) 시스템 지원
  - Bash는 POSIX.1(부분지원), POSIX.2(지원) 표준을 따르며 추가 기능 제공한다.
- blank
  - `space`, `tab` 문자
- builtin
  - 쉘 자체에서 제공하는 명령이다.
  - 외부의 실행 프로그램이 아니다.
    - 예) `$ which pwd` 명령으로 확인해 보라.
- control operator
  - 제어 기능을 수행하는 토큰이다.
  - `newline`, `||`, `&&`, `&`, `;`, `;;`, `;&`, `;;&`, `|`, `|&`, `(`, `)`
- exit status
  - 명령이 호출자에게 리턴하는 8비트(0 ~ 255) 값이다.
- field
  - 쉘 확장 중 하나의 결과인 텍스트 단위이다. 확장 후 명령을 실행할 때 결과 필드는 명령 이름과 아규먼트로 사용된다.
- filename
  - 파일을 식별하는 데 사용되는 문자열이다.
- job
  - 파이프라인을 구성하는 프로세스 집합과 이 파이프라인에서 파생되는 프로세스들이다.
  - 모두 동인한 프로세스 그룹에 속한다.
- job control
  - 사용자가 프로세스 실행을 중지(일시 중단)하고 다시 시작(재개)할 수 있는 메커니즘이다.
- metacharacter
  - 따옴표로 묶이지 않은(unquoted) 상태일 떄 word를 분리하는 역할을 수행하는 문자이다.
  - `newline`, `space`, `tab`, `|`, `&`, `;`, `(`, `)` , `<`, `>`
    - `space`, `tab`: 단어 사이를 구분할 때 사용.
    - `newline`: 명령어의 끝을 의미.
    - `|`(파이프): 왼쪽 명령어의 출력을 오른쪽 명령의 입력으로 연결.
    - `&`(앰퍼샌드): 명령어를 백그라운드로 실행.
    - `;`(세미콜린): 명령어들을 순서대로 실행.
    - `(`, `)`: 명령어 그룹을 만들 때 사용.
    - `<`, `>`(리다이렉션): 파일 입출력 방향을 바꿀 때 사용.
- name
  - 문자, 숫자, 밑줄(\_)로 구성된 단어이다. 문자나 밑줄로 시작한다.
  - 변수나 함수 이름으로 사용된다. 식별자(identifier)라고도 한다.
- operator
  - 제어 연산자(control operator)와 리다이렉션 연산자(redirection operator) 이다.
  - 연산자는 따옴표 없이 최소한 한 개의 metacharacter를 포함한다.
- process group
  - 같은 프로세스 ID를 가지는 관련 프로세스들의 컬렉션이다.
- process group ID
  - 생명주기 동안 프로세스 그룹을 대표하는 식별자이다.
- reserved word
  - 쉘에서 특별한 의미를 가지는 단어이다. 예) `for`, `while`
- return status
  - exit status 와 같은 용어이다.
- signal
  - 커널이 시스템 이벤트를 프로세스에게 전달하는 메커니즘이다.
- special builtin
  - POSIX 표준에서 특수 명령어로 분류된 쉘 내장 명령어이다.
- token
  - 쉘에서 단일 단위로 간주되는 문자열이다.
  - 즉 쉘에 명령어 줄을 해석할 때 분리하는 최소 단위이다.
  - **_단어(word)_** 또는 **_연산자(operator)_**
- word
  - 쉘에서 한 단위로 취급하는 문자열이다.
  - 즉 token 중에서 명령어나 아규먼트, 변수로 사용될 수 있는 문자열이다.
  - 단어는 따옴표 없는 metacharacter를 포함할 수 없다.
  ```arduino
  bash 입력: echo "Hello" > output.txt
  토큰:
    |-- word: echo
    |-- word: "Hello"
    |-- operator: >
    |-- word: output.txt
  ```

## 2 쉘 문법(Shell Syntax)

### 2.1 쉘 명령 실행 방식

- 쉘 스크립트 파일을 실행

```bash
$ bash test.sh
```

- `-c` 옵션으로 스크립트 코드를 문자열로 전달하여 실행

```bash
$ bash -c 'echo Hello; echo World!'
```

- 터미널에 명령어를 입력하여 실행

```bash
$ echo Hello; echo World!
```

### 2.2 명령어 실행 절차

1. 입력 받기
   - 파일: `.sh` 같은 쉘 스크립트 파일
   - 문자열: `-c` 옵션으로 전달된 명령문
     - 예) `bash -c "echo hello"`
   - 터미널: 사용자가 직접 터미널에 입력한 명령문
     - 예) `$ echo hello`
2. word 와 operator 로 나누기 + alias 확장
   - 따옴표 규칙(quoting rules)을 따른다.
   - metacharacter를 기준으로 token을 분리한다.
     - `뉴라인`, `공백`, `탭`, `|`, `&`, `;`, `(`, `)`, `<`, `>` 은 토큰을 분리하는 경계가 된다.
   - **별명 확장(alias expansion)** 을 수행한다.
     - 토큰이 미리 정의된 문장에 붙인 별명이라면, 별명을 해당 문장으로 바꾼다.
3. 토큰을 단순 명령어(simple) 또는 복합 명령어(compount command)로 구조화
4. 셸 확장(shell expansion)
   - 파라미터 확장: `$HOME`, `$USER` 와 같은 변수를 실제 값으로 치환한다.
   - 명령어 치환: `$(command)` 또는 `command`를 실제 명령 실행 결과로 치환한다.
   - 산술 확장: `$((expression))` 산술 계산 결과를 치환한다.
   - 파일명 확장(globbing): `*.txt` 같은 패턴을 실제 파일 리스트로 치환한다.
5. 리다이렉션 처리
   - `>`: 출력 리다이렉션
   - `<`: 입력 리다이렉션
   - `2>`: 오류 출력 리다이엑션
6. 명령 실행
   - 내부 명령(builtin)인지 외부 프로그램인지 구분해서 실행한다.
7. 종료 코드 수집
   - 명령이 끝날 때까지 기다린다. 끝나면 exit status(종료 코드)를 가져온다.
   - exit status 0: 정상 종료
   - exit status 0 이외의 값: 오류 발생
   - 단, 백그라운드로 실행(`&`)하는 경우에는 기다리지 않고 다음 작업으로 넘어간다.

예) `echo "Hello" > file.txt`

- 입력 읽기
  - 명령어를 읽는다.
- word/operator 분리
  - `echo`, `"Hello"`, `>`, `file.txt` 로 나눈다.
- 구문 분석
  - 명령어 구조 = 단순 명령 + 출력 리다이렉션
- 셸 확장
  - 확장 없음
- 리다이렉션 처리
  - file.txt 파일을 쓰기 모드로 연다.
  - 표준 출력을 이 파일로 연결한다.
- 명령 실행
  - `echo "Hello"` 명령을 실행한다.
  - `"Hello"` 문자열을 표준 출력으로 보낸다.
  - 즉 file.txt에 쓴다.
- 종료 상태 처리
  - 성공 여부(exit code)를 기록한다.

### 2.3 인용(Quoting)

특정 문자나 단어에 부여된 의미를 제거하는 데 사용된다.

- 특정 문자나 단어에 부여된 특수 기능을 비활성화
- 예약어로 인식되는 것을 방지
- 매개 변수 확장을 방지

크게 3종류의 인용이 있다.

- Escape Character
- Single Quotes
- Double Quotes
- ANSI-C Quoting
- Locale-Specific Translation

#### 2.3.1 이스케이프 문자

`\` 다음에 오는 문자는 일반 문자로 취급한다. 예를 들어, **공백(space)** 이나 **메타문자**(`*`, `?`, `$`, `"` 등)와 같이 특별한 의미가 있는 문자를 일반 문자로 취급한다.

```bash
cat hello\ world.txt
```

`hello world.txt` 이라는 파일명을 의미한다.

```bash
echo Hello\
Python\
Wworld
```

`\` 다음에 오는 `newline`은 라인 연결자로 간주한다. 즉 `echo helloPythonWorld` 와 같다.

```bash
echo \$HOME
```

`\` 다음에 오는 `$`는 단순 문자로 취급된다.

#### 2.3.2 작은 따옴표(`''`)

작은 따옴표 안의 문자는 일반 문자로 취급된다. 즉 메타 문자도 단순 문자로 취급한다.

```bash
name="홍길동"
echo 'Hello $name'  # 출력: Hello $name
echo "Hello $name"  # 출력: Hello 홍길동
```

```bash
echo 'Hello\
World'

# 출력 결과
Hello\
World
```

`\` 도 단순 문자로 취급한다.

#### 2.3.3 큰 따옴표(`""`)

큰 따옴표 내부의 문자들은 **변수 확장**, **명령어 치환**, **이스케이프**, **히스토리 확장** 이 적용된다. 또한 일부 메타 문자도 해석된다.

- 변수 확장

```bash
name="홍길동"
echo "Hello $name"  # 출력: Hello 홍길동
```

- 명령어 치환

```bash
echo 'Today is `date`' # Today is `date`
echo "Today is `date`"  # Today is Wed Mar  5 08:08:52 UTC 2025
```

- 히스토리 확장

```bash
pwd
whoami
ls
echo "마지막 두 번째 명령: !-2" # 명령문 확장: echo "====> whoami"
echo '마지막 두 번째 명령: !-2' # 명령문 확장 안함
```

- 이스케이프 예)

```bash
name="홍길동"
echo "Hello $name"  # 출력: Hello 홍길동
echo "Hello \$name" # 출력: Hello $name

echo "Today is `date`" # Today is Wed Mar  5 08:08:52 UTC 2025
echo "Today is \`date\`" # Today is `date`

echo "File path: \C:\Users" # \C 나 \U 는 특별한 의미가 없으므로 그냥 출력

echo "She said, \"Hello\"" # She said, "Hello"
```

#### 2.3.4 ANSI-C 인용

`$'문자열'` 형식의 문자열을 **ANSI-C quoting** 이라 부른다. 문자열 안에 이스케이프 문자(`\`)가 있을 경우 ANSI C 표준에 따라 변환한다.

```bash
echo 'Hello\nWorld'
echo 'Hello\tWorld'
echo 'Hello\\World'
echo $'I\'m happy'
echo $'\x41\x42\x43'
echo $'\a'

# 출력 결과
Hello
World
Hello	World
Hello\World
I'm happy
ABC
(벨소리 출력)
```

- `\a` : 벨소리 출력
- `\b` : backspace
- `\f` : form feed
- `\n` : newline
- `\r` : carriage return
- `\t` : horizontal tab
- `\v` : vertical tab
- `\\` : backslash
- `\'` : single quote
- `\"` : double quote
- `\?` : question mark
- `\nnn` : 8진수 ASCII 문자코드(8비트)
- `\xHH` : 16진수 ASCII 문자코드(8비트)
- `\uHHHH` : 16진수 유니코드(16비트)
- `\UHHHHHHHH` : 16진수 유니코드(32비트)
- `\cx` : control + 제어문자
  - `\cA` : Ctrl+A (0x01), 터미널에서 줄의 맨 앞으로 이동
  - `\cB` : Ctrl+B (0x02), 커서를 왼쪽으로 이동
  - `\cC` : Ctrl+C (0x03), 실행 중인 프로세스 중단 (Interrupt)
  - `\cD` : Ctrl+D (0x04), 입력 종료 (EOF)
  - `\cG` : Ctrl+G (0x07), 경고음 (Bell)
  - `\cH` : Ctrl+H (0x08), 백스페이스 (\b)
  - `\cJ` : Ctrl+J (0x0A), 줄 바꿈 (\n)
  - `\cM` : Ctrl+M (0x0D), 캐리지 리턴 (\r)

#### 2.3.5 로케일별 번역

`$"문자열"` 형식으로 문자열을 작성하면 현재 로케일 설정에 따라 번역이 수행될 수 있다.
이 기능은 GNU gettext 시스템을 사용하여 문자열을 변환한다. 주로 다국어 지원을 위한 스크립트에 활용된다.

- 쉘 스크립트 작성(`test.sh`)

```bash
#!/bin/bash

# gettext를 못찾으면, gettext.sh 스크립트를 찾아서 포함시킨다.
# 찾기 명령: $ find /usr -name gettext.sh
# 포함 문장: source /usr/local/bin/gettext.sh

export TEXTDOMAIN=myapp
export TEXTDOMAINDIR=./locale

USER="Alice"

echo "Current Locale: $LANG"
echo $"Hello, $USER!"  # echo $(eval_gettext "Hello, \$USER!")
```

- gettext 템플릿 파일(`myapp.pot`) 생성(쉘스크립트 파일에서 추출)

```bash
# bash --dump-po-strings 스크립트이름 > 도메인.pot
$ bash --dump-po-strings test.sh > myapp.pot
```

- 템플릿 파일을 복사하여 국제화를 지원할 언어 파일(`fr.po`) 생성

```bash
$ cp myapp.pot fr.po
```

- 언어 파일(`fr.po`) 작성

```bash
msgid "Hello, $USER!"
msgstr "Bonjour, $USER!"
```

- gettext 도구에서 사용할 수 있도록 MO 파일로(`fr.mo`) 변환

```bash
# msgfmt 명령이 없다고 오류가 발생한다면,
# - gettext 패키지 설치
$ sudo apt update && apt install -y gettext

# 실행
$ msgfmt -o fr.mo fr.po
```

- MO 파일을 TEXTDOMAINDIR 변수가 가리키는 폴더에 설치

```bash
$ cp fr.mo ./locale/fr/LC_MESSAGES/myapp.mo
```

- 로케일을 프랑스어로 설정 후 실행

```bash
# 로케일이 생성되지 않아 번역이 적용되지 않는 문제가 발생한다면,
# - 로케일 패키지 설치
$ apt update && apt install -y locales

# - 로케일 생성
$ locale-gen fr_FR.UTF-8

# 실행
$ export LANG=fr_FR.UTF-8

# test.sh 파일에 실행 권한 부여
$ chmod +x test.sh

# test.sh 실행
$ ./test.sh
```

#### 2.3.6 로케일(locale)

일반적으로 `language_territory.codeset` 형식으로 표현한다.

- 언어(language): ISO 639-1
  - 한국어(ko), 영어(en), 프랑스어(fr), 독일어(de), 일본어(ja), 중국어(zh) 등
- 지역(territory): ISO 3166-1
  - 한국(KR), 미국(US), 프랑스어(FR), 독일어(DE), 일본어(JP), 중국어(CN), 영국(GB) 등
- 문자집합(codeset): 문자집합
  - UTF-8, EUC-KR 등

로케일 값과 변수

- `LC_ALL`: 전역 로케일 설정 값. 우선 순위가 가장 높다.
- `LANG`: 전역 로케일 설정 값. 다른 값이 설정되어 있지 않을 때 사용됨. 우선 순위가 가장 낮다.
- `LC_MESSAGES`: 메시지를 표시하는 기준이 되는 로케일 설정 값.
- `LC_CTYPE`: 문자 분류, 글자 수, 대소문자 구분이 되는 로케일 설정 값.
- `LC_NUMERIC`: 숫자와 관련된 기준이 되는 로케일 설정 값.
- `LC_MONETARY`: 통화나 금액과 관련된 숫자의 기준이 되는 로케일 설정 값.
- `LC_TIME`: 날짜, 시간과 관련된 로케일 설정 값.
- `LC_COLLATE`: 문자열의 정렬 순서를 결정하는 로케일 설정 값.

시스템 로케일 정보 확인하기

```bash
$ locale # 현재 시스템에 설정된 로케일 정보
$ locale -a # 현재 시스템에서 사용 가능한 모든 로케일
```

로케일 생성하기

```bash
# 생성 가능한 로케일 목록 확인
$ cat /usr/share/i18n/SUPPORTED
...
ko_KR.UTF-8 UTF-8
ko_KR.EUC-KR EUC-KR
...

# 로케일 생성 방법1)
$ sudo localedef -f UTF-8 -i ko_KR ko_KR.UTF-8

# 로케일 생성 방법2)
$ sudo locale-gen ko_KR.UTF-8 # 내부적으로 localedef 명령을 실행한다. 결국 위의 명령과 동일하다.

# 한국어 패키지 설치
$ sudo apt-get install -y language-pack-ko
```

로케일 설정하기

```bash
# 현재 터미널에만 적용하기
$ export LC_ALL=ko_KR.UTF-8
$ export LANG=ko_KR.UTF-8

# 도커 컨테이너를 재시작할 때마다 다시 설정하지 않으려면,
# 방법1) 전체 사용자에게 적용하기
$ echo "LANG=ko_KR.UTF-8" >> /etc/default/locale
$ echo "LC_ALL=ko_KR.UTF-8" >> /etc/default/locale

# 방법2) 현재 로그인 한 사용자에게만 적용하기
$ echo 'export LANG=ko_KR.UTF-8' >> ~/.bashrc
$ echo 'export LC_ALL=ko_KR.UTF-8' >> ~/.bashrc
$ source ~/.bashrc
```

## 3 쉘 명령(Shell Commands)

쉘 명령은 단순 구조의 명령어과 복합 구조의 명령어로 구분할 수 있다.

- 단순 구조의 쉘 명령(Simple Shell Command)
  - 하나의 명령과 아규먼트들로 구성된다.
  - 공백으로 나뉜다.
- 복합 구조의 쉘 명령(Compount/Complex Shell Command)
  - 단순 구조의 명령들을 파이브라인으로 연결한 것.
  - 반복문이나 조건문으로 구성된 명령들.
  - 여러 개의 명령을 그룹으로 묶은 것.

### 3.1 예약어(Reserved Words)

예약어는 쉘에서 특별한 의미로 사용되는 단어다.

- 복합 쉘 명령의 시작과 끝에 사용한다.
- 따옴표로 감싸지 않아야 한다.
- 명령어 줄에서 첫 번째 단어여야 한다.

```bash
if	then	elif	else	fi	time
for	in	until	while	do	done
case	esac	coproc	select	function
{	}	[[	]]	!
```

- `in`
  - `select` 나 `case`, `for` 명령의 세 번째 단어로 등장할 때 예약어로 인식된다.
- `do`
  - `for` 명령의 세 번째 또는 다섯 번째 단어로 등장할 때 예약어로 인식된다.

### 3.2 간단한 명령(Simple Commands)

가장 기본적인 형태의 명령이다.

- 공백(space, tab)으로 구분된 일련의 단어들의 조합이다.
- 첫 단어는 실행할 명령이고, 나머지는 해당 명령의 아규먼트다.
- 쉘의 제어 연산자가 나오면 종료된다.

```bash
# command_name arg1 arg2 ... argN

# 예1)
echo "Hello, World!"

# echo : 명령
# ""Hello, World!" : 아규먼트

# 예2)
ls -l /home/user

# ls : 명령
# -l : 옵션
# /home/user : 아규먼트
```

#### 3.2.1 명령어를 종료시키는 제어 연산자

- `;`: 여러 명령을 순차적으로 실행 (command1; command2)
- `&` : 명령을 백그라운드에서 실행 (command &)
- `&&` : 앞의 명령이 성공하면 다음 명령 실행 (command1 && command2)
- `||` : 앞의 명령이 실패하면 다음 명령 실행 (command1 || command2)
- \`: backtick

#### 3.2.2. 리턴 상태(return status) = 종료 상태(exit status)

- 값의 범위
  - waitpid 시스템 콜 또는 이와 동등한 함수에서 리턴한 값이다.
  - 0 ~ 255 사이의 정수 값이다. 125 이상의 값은 특별한 용도로 사용된다.
- 성공과 실패 기준
  - 0이면 성공, 0이 아니면 실패이다.
  - 실패 원인을 구분할 수 있도록 다양한 0이 아닌 값이 사용된다.
- 특별한 값
  - 128 + n : 프로세스가 치명적인 Signal n 에 의해 종료된 경우
  - 127 : 실행할 명령을 찾을 수 없는 경우
  - 126 : 명령어는 존재하지만 실행할 수 없는 경우
  - 2 : 잘못된 옵션이나 아규먼트로 인해 Bash built-in 명령이 실패한 경우
- 확장 및 리디렉션 오류
  - 명령 실행 중 확장(expansion)이나 리디렉션(redirection) 오류가 발생하면 0 보다 큰 값을 리턴한다.

### 3.3 파이프라인(Pipelines)

여러 개의 명령을 제어 연산자 `|` 또는 `|&` 로 연결하여 실행하는 방식이다. 이 과정에서 앞 명령어의 출력은 다음 명령의 입력으로 전달된다.

#### 3.3.1 `|` 파이프 연산자

- 앞 명령의 **출력(`stdout`)** 이 다음 명령의 **입력(`stdin`)** 으로 전달된다.
- 연결된 모든 명령이 순차적으로 실행되며, 마지막 명령의 출력이 최종 결과다.
- 쉘은 파이프에 포함된 모든 명령이 종료될 때까지 기다린다.
- 마지막 명령의 종료 상태를 반환한다.

```bash
$ ls /etc | grep conf | sort -r
```

1. `ls /etc` : `/etc` 폴더에 있는 파일 목록 출력
2. `grep conf` : `conf` 를 포함하는 파일을 필터링
3. `sort -r` : 파일명을 역순으로 정렬

#### 3.3.2 `|&` 파이프 연산자

- `|&` : 앞 명령의 **출력(`stdout`) + 오류(`stderr`)** 가 다음 명령의 입력(`stdin`)으로 전달된다.
- `2>&1 |`의 단축 표현이다.
  - `stdout`: 정상적인 출력(1)
  - `stderr`: 오류 메시지 출력(2)
  - `>`: stdout을 파일로 리디렉션(덮어쓰기)
  - `>>`: stdout을 파일로 리디렉션(덧붙이기)
  - `2>`: stderr를 파일로 리디렉션(덮어쓰기)
  - `2>>`: stderr를 파일로 리디렉션(덧붙이기)
  - `2>&1`: stderr를 stdout으로 합침(리디렉션 조합용)
  - `&>`: stdout + stderr를 같은 파일로 리디렉션(`2>&1 >`) 축약형

```bash
$ ls /okok | tee log.txt # ls의 실행 오류는 tee에 전달되지 않는다.
$ cat log.txt # log.txt는 빈 파일이다.

$ ls /okok |& tee log.txt # ls의 실행 오류는 tee에 전달된다.
$ cat log.txt # log.txt에 오류 내용이 들어 있다.
```

#### 3.3.3 실행 시간 측정

- 쉘 예약어 `time` 을 사용하면 명령어 또는 전체 파이프라인 실행 시간을 측정할 수 있다.

```bash
$ time find /usr -name "gettext.sh"

real	0m0.017s # 전체 실행 시간
user	0m0.007s # 사용자 모드에서 소모된 시간
sys	    0m0.011s # 커널 모드에서 소모된 시간
```

#### 3.3.4 실행 방식

- 파이프라인의 각 명령은 서브쉘(Subshell)에서 실행된다.

```bash
$ name='Gildong Hong'
$ read name
James Kim
$ echo $name
James Kim

$ name='Gildong Hong'
$ echo "James Kim" | read name # 각 명령은 별도의 서브쉘에서 실행한다. 부모쉘에는 영향을 미치지 않는다.
$ echo $name
Gildong Hong
```

- `shopt -s lastpipe` 옵션을 설정하면 파이프라인의 마지막 명령은 현재 쉘에서 실행된다. 단, 인터렉티브 모드(터미널에서 직접 실행)에서는 적용되지 않는다.

```bash
 #!/bin/bash
shopt -s lastpipe
name='Gildong Hong'
echo "James Kim" | read name
echo $name
```

#### 3.3.5 `pipefail` 옵션

- 기본적으로 파이프라인의 종료 상태(exit status)는 마지막 명령의 종료 상태이다.

```bash
$ false | true
$ echo $? # 0, 마지막 명령의 값(true)이 종료 상태로 리턴된다.
```

- 파이프라인에서 가장 마지막에 실패한 명령어의 종료 상태를 리턴 받기. 모든 명령이 성공하면 0을 리턴한다.

```bash
$ set -o pipefail
$ false | true
$ echo $?
```

- 파이프라인 앞에 `!` 를 붙이면 종료 상태의 논리적 반대값을 반환한다.

```bash
$ ! false
$ echo $?
```

### 3.4 명령 목록(Lists of Commands)

여러 개의 **파이프라인(`|`나 `|&`로 연결된 명령어들)** 을 `&&`, `||`, `;`, `&` 으로 연결하여 순차적 또는 조건적으로 실행하는 구조.

#### 3.4.1 연산자 우선순위

1. `&&`, `||` (같은 우선 순위)
2. `;`, `&` (같은 우선 순위, 1번 보다 낮음)

#### 3.4.2 `&&` (AND 연산)

- 앞 명령이 성공(0 리턴)하면 다음 명령을 실행한다.
- 앞 명령이 실패(0이 아닌 값 리턴)하면 다음 명령은 실행되지 않는다.

```bash
# 성공할 경우 현재 폴더를 test로 바꾼다.
$ mkdir test && cd test

# 성공할 경우 삭제 메시지를 출력한다.
$ rm test.txt && echo "File deleted"
```

#### 3.4.3 `||` (OR 연산)

- 앞 명령이 실패(0이 아닌 값 리턴)하면 다음 명령을 실행한다.
- 앞 명령이 성공(0 리턴)하면 뒤의 명령은 실행되지 않는다.

```bash
# 파일 삭제가 실패할 경우 메시지를 출력한다.
$ rm test.txt || echo "File not found"
```

#### 3.4.4 `&&` + `||`

- 우선 순위가 같기 때문에 왼쪽에서 오른쪽으로 연산을 수행(Left Associativity)한다.

```bash
$ false && echo "Success" || echo "Failure"
```

- `&&`와 `||`로 연결된 명령문의 종료 상태는 마지막 명령문의 종료 상태 값이다.

```bash
$ false && true || echo "Failed" && echo $?
```

1. `false` 실행 : 1 리턴
1. `&&` 연산에 의해 `true` 실행 안함
1. `||` 연산에 의해 `echo "Failed"` 실행
1. `echo "Failed"`의 리턴 값(0; 성공)을 출력

#### 3.4.5 `;` (순차 실행)

- `;` 을 사용하여 명령을 순차적으로 실행시킬 수 있다.
- 앞 명령 결과에 상관없이 다음 명령이 순차적으로 실행된다.

```bash
$ echo "Hello"; echo "World"
```

- `;` 연산자로 연결된 명령문의 종료 상태는 마지막 명령문의 종료 상태 값이다.

```bash
$ true; false; true
$ echo $?
```

#### 3.4.6 `&` (백그라운드 실행)

- 명령문 뒤에 `&` 를 붙이면, 별도의 서브쉘에서 백그라운드로 실행시키고 다음 명령문로 바로 넘어간다.
- 입력이 필요한 경우 /dev/null 을 입력으로 사용한다.

```bash
$ sleep 5 # 5초 동안 실행을 중단한 후 다음 명령으로 넘어 간다.
$ echo "Hello!"

$ sleep 5 & echo "Hello!" # sleep 5 명령문은 별도의 서브쉘에서 실행시키고, 즉시 echo 명령문을 처리한다.
```

### 3.5 복합 명령(Compound Commands)

여러 개의 명령문을 반복, 조건, 그룹화 등의 문법을 사용하여 실행 흐름을 제어할 수 있다.

- 복합 명령은 항상 특정 예약어 또는 제어 연산자로 시작하고, 그에 대응하는 예약어 또는 제어 연산자로 끝난다.
  - `if ~ then ~ fi`
  - `for ~ in ~ do ~ done`
  - `while ~ do ~ done`
  - `{ ... ; }`, `( ... )`
- 복합 명령에 입출력 리디렉션(`>`, `<`, `>>`)이 붙으면, 복합 명령 모두에 적용된다.
  ```bash
  # 다음 두 개의 echo 명령 모두 output.txt로 출력된다.
  {
      echo "Hello"
      echo "World"
  } > output.txt
  ```
- 복합 명령 안에 있는 명령 목록(command list) 는 일반적으로 줄바꿈으로 구분된다. `;` 대신 줄바꿈을 사용할 수 있다.

  ```bash
  x=100
  if [ "$x" -gt 0 ]; then
    echo "양수"
  fi

  x=-100
  if [ "$x" -gt 0 ]  # ; 대신 newline 사용 가능
  then
    echo "양수"
  fi
  ```

- 복합 명령의 유형
  - 반복문: `for`, `while`, `until`
  - 조건문: `if`, `case`
  - 그룹화: `{}`, `()`,
  - 복합조건: `[[ 조건 ]]`,
  - 수식평가: `(( 수식 ))`

#### 3.5.1 반복문(Looping Constructs)

- 반복적인 작업을 수행할 때 사용한다.
- 즉 특정 조건이 충족될 때까지 동일한 코드 블록을 여러 번 실행시키는 문법이다.
- `;`은 줄바꿈(newline)으로 대체할 수 있다.
  ```bash
  while true; do echo hi; done
  ```
  위 문장은 다음 문장과 같다.
  ```bash
  while true
  do
      echo hi
  done
  ```

##### until 반복문

조건이 거짓(exit status != 0)인 동안 실행.

```bash
until test-commands; do consequent-commands; done
```

1. `test-commands`: 조건을 검사하는 명령
1. `consequent-commands`: `test-commands`가 실패(exit status != 0)하면 실행한다.
1. 즉 `test-command`가 성공(exit status = 0) 할 때까지 반복한다.
1. 리턴 상태는 마지막 명령의 종료 상태이다.
1. 아무런 명령도 실행하지 않았다면, 0을 리턴한다.

```bash
# count가 5보다 커질 때까지 반복
count=1
until [ $count -gt 5 ]; do
    echo "Count: $count"
    ((count++))
done
echo "return status: $?"
```

##### while 반복문

조건이 참(exit status = 0)인 동안 실행.

```bash
while test-commands; do consequent-commands; done
```

1. `test-commands`: 조건을 검사하는 명령
1. `consequent-commands`: `test-commands`가 성공(exit status = 0)하면 실행한다.
1. 즉 `test-commands`가 실패(exit status != 0) 할 때까지 반복한다.
1. 리턴 상태는 마지막 명령의 종료 상태이다.
1. 아무런 명령도 실행하지 않았다면, 0을 리턴한다.

```bash
# count가 5 이하인 동안 반복
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
done
echo "return status: $?"
```

##### for 반복문

리스트 또는 특정 범위의 값을 반복하여 실행.

```bash
for name [ [in [words …] ] ; ] do commands; done
```

1. `name`: 리스트의 각 요소를 담는 변수
1. `words`: 리스트(공백으로 구분된 여러 값, 파일 목록 등)
1. `commands`: 리스트의 각 값에 대해 실행할 명령
1. `words`에 포함된 값들을 하나씩 가져와서 `name`에 저장하고, `commands`를 실행한다.
1. `words`에 더 이상 값이 없을 때 반복을 종료한다.
1. 리턴 상태는 마지막 명령의 종료 상태이다.
1. 아무런 명령도 실행하지 않았다면, 0을 리턴한다.

```bash
for i in 1 2 3; do
    echo "Number: $i"
done

for fruit in apple banana cherry; do
    echo "Fruit: $fruit"
done
```

##### `in` 없는 `for` 반복문

위치 파라미터(`$@`, positional parameter)를 사용.

- `for-test.sh` 스크립트 파일

```bash
#!/bin/bash
for fruit; do # $@ 에서 파라미터를 한 개씩 꺼낸다.
    echo "Fruit: $fruit"
done
```

- 스크립트 파일 실행

```bash
$ for-test.sh apple banana cherry
```

##### C 언어 스타일의 `for` 반복문

C 언어의 `for` 문과 유사하게 동작한다.

```bash
for ((expr1; expr2; expr3)) ; do commands; done
```

1. `expr1`: 초기화 산술 표현식(반복 시작 전 한 번 실행)
1. `expr2`: 반복 조건 산술 표현식(non-zero 이면 계속 반복, zero 이면 종료)
1. 표현식의 실행 결과
   - non-zero이면 return status는 0이고,
   - zero 이면 return status는 1이다.
1. `expr3`: 반복 실행 후 수행할 산술 표현식
1. `expr1/2/3` 은 산술 표현식이어야 한다. 표현식을 생략하면 결과 값이 1로 간주 된다.
1. 리턴 상태는 마지막 명령의 종료 상태이다.
1. 아무런 명령도 실행하지 않았다면, 0을 리턴한다.

```bash
for ((i = 1; i <= 5; i++)) ; do
    echo "Number: $i"
done
for ((i = 1; 100 >> i; i++)) ; do
    result=$((100 >> i))
    echo "Number: $result"
done
```

##### `break`

현재 실행 중인 반복문을 즉시 종료한다.

```bash
i=1
for (( ; ; )) do
  if [ $i -gt 5 ]; then
    break
  fi
  echo "Number: $i"
  ((i++))
done
```

##### `continue`

다음 반복으로 건너 뛰기

```bash
for ((i = 1; i <= 10; i++)) ; do
    if (( i % 2 != 0 )); then
        continue
    fi
    echo "Number: $i"
done

for i in 1 2 3 4 5; do
  if [ $i -eq 3 ]; then
    continue
  fi
  echo "Number: $i"
done
```

#### 3.5.2 조건문(Conditional Constructs)

조건에 따라 실행할 문장을 지정하는 문법이다.

##### `if` 조건문

```bash
if test-commands; then # test-commands 조건을 검사한다.
    consequent-commands;  # test-commands의 exit status = 0 일 때 실행한다.
[elif more-test-commands; then
    more-consequents;] # more-test-commands의 exit status = 0 일 때 실행
[else
    alternate-consequents;] # if 와 elif 모두 exit status = 1 일 때 실행
fi
```

1. `test-commands` 를 실행하고 exist status가 `0`(성공)이면 then 블록을 실행한다.
1. `0` 이 아니라면, 각 `elif` 블록을 순서대로 검사한다.
1. 모든 `if` 및 `elif` 조건이 실패하면, `else` 블록을 실행한다.
1. 리턴 상태는 마지막으로 실행한 명령의 종료 상태이다.
1. 아무런 명령도 실행하지 않았다면, 0을 리턴한다.

```bash
if ls /home; then
  echo "파일 및 디렉터리 목록을 성공적으로 가져왔습니다." # ls 명령의 return status가 0일 때
else
  echo "파일 및 디렉터리를 찾을 수 없습니다." # ls 명령의 return status가 non-zero일 때
fi
```

```bash
num=10
if [ $num -gt 5 ]; then
  echo "num은 5보다 큽니다."
elif [ $num -eq 5 ]; then
  echo "num은 5입니다."
else
  echo "num은 5보다 작습니다."
fi
```

##### `case` 조건문

- 값의 패턴으로 여러 조건을 검사할 때 사용
- `if-elif-else` 문 보다 가독성이 좋다.

```bash
case word in
    pattern1) command-list1 ;;
    pattern2) command-list2 ;;
    *) default-command-list ;;
esac
```

1. `word` : 비교할 문자열/변수/값
1. `pattern` : `word`와 비교할 패턴(\*, ?, [] 등 사용 가능)
1. `command-list` : 패턴이 일치할 때 실행할 명령어 목록
1. `;;` : 해당 블록을 실행한 후, case 문 종료
1. `;&` : 해당 블록을 실행한 후, 다음 블록의 명령도 실행
1. `;;&` : 해당 블록을 실행한 후, 다음 블록의 패턴들도 검사
1. `*)` : 기본 패턴(일치하는 패턴이 없을 경우 실행)
1. `|` : 여러 패턴을 묶을 경우

```bash
read -p '동물 이름?' animal
case $animal in
    horse | dog | cat)
        echo "다리 4개";;
    man | kangaroo)
        echo "다리 2개";;
    *)
        echo "다리 갯수 모름";;
esac
```

###### `;;` 사용법

첫 번째로 찾은 패턴을 실행한 후 case 문 종료

```bash
VAR=apple
case $VAR in
  apple) echo "This is an apple." ;;
  banana) echo "This is a banana." ;;
  *) echo "Unknown fruit." ;;
esac
```

###### `;&` 사용법

첫 번째로 찾은 패턴을 실행한 후 다음 패턴의 명령도 실행

```bash
VAR=apple
case $VAR in
  apple) echo "This is an apple." ;&
  banana) echo "This is a banana." ;;
  *) echo "Unknown fruit." ;;
esac
```

###### `;;&` 사용법

첫 번째로 찾은 패턴을 실행한 후 나머지 패턴도 검사하고 실행

```bash
VAR=apple
case $VAR in
  apple) echo "This is an apple." ;;&
  banana) echo "This is a banana." ;;
  *) echo "Unknown fruit." ;;
esac
```

###### `word`의 확장

패턴을 비교하기 전에 word 확장을 먼저 수행

- 틸드 확장(`~`)
- 변수 확장(`$VAR`)
- 명령어 치환(`$(command)`)
- 산술 확장(`$((expression))`)
- 인용 제거(`"text"` --> `text`)

```bash
VAR=""
read -p '입력>' VAR
case $VAR in
  "$HOME") echo "Home directory matched." ;;
  "$(whoami)") echo "User matched." ;;
  *) echo "No match." ;;
esac
```

##### `select` 문

- 숫자가 부여된 메뉴 목록을 자동 생성하고, 사용자가 메뉴를 선택할 수 있는 프롬프트 자동 생성
- `for` 반복문과 유사

```bash
select name [in word1 word2 ...]; do
    commands
done
```

1. `name` : 사용자가 선택한 값을 저장하는 변수
1. `word1 word2 ...` : 선택할 메뉴 목록
1. `commands` : 선택 후 실행될 명령
1. `PS3` : 사용자에게 표시될 프롬프트 문자열(기본 값: #?)
1. `REPLY` : 사용자가 입력한 값이 저장되는 변수(숫자 입력)
1. 실행 절차
   - `in` 뒤에 있는 단어 목록에 번호를 붙여 메뉴 목록으로 출력됨
   - `PS3` 프롬프트가 표시되고 사용자 입력을 기다림
   - 사용자가 번호를 입력하면 해당 값이 `name` 변수에 저장됨
   - `commands` 블록이 실행됨
   - `break` 또는 **EOF(Ctrl + D)** 입력 시 루프 종료

```bash
PS3="번호? "
select name in apple banana cherry; do
    echo "$REPLY 번 $name 을 선택하였습니다."
    break
done
```

##### `((expression))` : 산술 평가문(arithmetic evaluation)

- 정수형 산술 표현식을 평가하고 그 결과에 따라 exit status를 설정한다.
- C 스타일의 산술 계산을 수행한다.
  - 사칙 연산자: `+`, `-`, `*`, `/`, `%` (나머지)
  - 비교 연산자: `==`, `!=`, `<`, `<=`, `>`, `>=`
  - 논리 연산자: `&&`, `||`, `!`
  - 비트 연산자: `&`, `|`, `^`, `<<`, `>>`
- 변수 확장, 명령 치환 등 대부분의 확장이 적용된다.
- `if` 문 등과 함께 조건문에서 활용한다.

```bash
(( expression ))
```

1. `expression` : C 스타일의 산술 연산 실행
1. non-zero 또는 참 : return status 0(성공)
1. zero 또는 거짓 : return status 1(실패)

```bash
# 참/거짓의 return status 확인
(( 5 > 3 ))
echo $?

(( 5 < 3 ))
echo $?
```

```bash
# 변수 사용
x=10
y=5
(( x + y )) # 15는 0이 아님 --> 참 --> exit status = 0
echo $?
```

```bash
# 변수 사용
x=10
y=-10
(( x + y )) # 계산 결과는 0 --> 거짓 --> exit status = 1
echo $?
```

```bash
read x
(( x == 10 )) # exit status: true --> 1, false --> 0
echo $?
```

```bash
read x
(( x == 'aaa' )) # 실행 오류: 문자열 비교는 안된다. 정수 연산만 가능!
echo $?
```

```bash
# if 문
x=10
if (( x > 5 )); then
    echo "x is greater than 5"
fi
```

```bash
# 증감 연산자
x=5
(( y = x++ ))
echo $x $y

x=5
(( y = --x ))
echo $x $y
```

```bash
# 논리 연산
x=5
y=10

(( x < 10 && y > 5 ))  # 참 (0 반환)
echo $?

(( x > 10 || y < 5 ))  # 거짓 (1 반환)
echo $?
```

##### `[[ expression ]]` 문

- 조건식(conditional expression) 실행
- if, while 등의 조건문에서 많이 사용
- `test` 또는 `[ expression ]` 보다 강력한 기능 제공
- 확장 처리
  - 틸드 확장(`~`)
  - 변수 확장(`$var`)
  - 산술 확장(`$(( ... ))`)
  - 명령어 치환(`$(...)`)
  - 프로세스 치환(`<(...)`)
  - 따옴표 제거
  - 단어 분리(word splitting) 및 파일 이름 확장(globbing)은 수행하지 않음.

```bash
[[ expression ]]
```

1. `expression` : 조건식
1. return status :
   - 참이면, 0
   - 거짓이면, 1

###### 문자열 비교(문자열, `-z`, `-n`, `==`, `=`, `!=`, `<`, `>`)

```bash
# 문자열
#   빈문자열이 아닌 경우: true = return status 0
#   빈문자열: false = return status 1
# -n 문자열
#   문자열의 길이가 1이상: true = return status 0
#   문자열의 길이가 0: false = return status 1
#   그냥 문자열을 쓰는 것 보다 의미가 더 명확함.

name=""; [[ $name ]]; echo $?
name=""; [[ -n $name ]]; echo $?

name="abc"; [[ $name ]]; echo $?
name="abc"; [[ -n $name ]]; echo $?

# -z
#   빈 문자열인지 검사
#   zero: true = return status 0
#   non-zero: false = return status 1
name=""; [[ -z $name ]]; echo $?
name="abc"; [[ -z $name ]]; echo $?

# 문자열 비교
name="Alice"; [[ $name == "Alice" ]]; echo $?
name="Alice"; [[ $name = "Alice" ]]; echo $? # == 과 같다.
name="Alice"; [[ $name == A* ]]; echo $? # 패턴 매칭

# 문자열 정렬 순서 비교
[[ "apple" < "banana" ]]; echo $? # 0: 성공
[[ "apple" > "banana" ]]; echo $? # 1: 실패
[[ "apple" < "apple" || "apple" == "apple" ]]; echo $? # <= 연산자 사용 불가!
[[ "apple" > "apple" || "apple" == "apple" ]]; echo $? # >= 연산자 사용 불가!

# [[ ... ]] vs (( ... ))
[[ 15 > 3 ]]; echo $? # 문자열로 간주하고 비교
(( 15 > 3 )); echo $? # 숫자로 간주하고 비교
```

###### 정규 표현식 매칭(`=~`)

```bash
word="hello123"; [[ $word =~ ^hello[0-9]+$ ]]; echo $?
word="hello123"; [[ $word =~ ^hello ]]; echo $? # 0: 성공
word="hello123"; [[ $word =~ hello$ ]]; echo $? # 1: 실패
word="hello123"; [[ $word =~ +hello ]]; echo $? # 2: 정규식 문법 오류
```

1. `=~` : POSIX 정규표현식(ERE, Extended Reqular Expression) 비교 연산자
1. 시작(`^`), 끝(`$`)을 의미
1. 정규식이 잘못되면 return status 2 반환

###### 변수 상태 검사

```bash
name1="Kim"

# 변수에 값이 설정되어 있는지 검사
[[ -v name0 ]]; echo $? # 1
[[ -v name1 ]]; echo $? # 0

# 이름 참조(name reference) 변수인지 검사
declare -n name2=name1 # name2는 name1 변수를 참조한다.
[[ -R name1 ]]; echo $? # 1
[[ -R name2 ]]; echo $? # 0
echo $name2

declare -n name3=name4 # name3는 name4 변수를 참조한다.
[[ -R name3 ]]; echo $? # 0
name4="Park"
echo $name3
```

###### 파일 상태 검사

```bash
file="test.sh"; [[ -f $file ]]; echo $?
```

- `-e` : 파일이 존재하는지 확인. 예) `[[ -e file.txt ]]`
- `-d` : 디렉터리인지 확인. 예) `[[ -d mydir ]]`
- `-f` : 일반 파일인지 확인. 예) `[[ -f file.txt ]]`
- `-L` : 심볼릭 링크인지 확인. 예) `[[ -L link.txt ]]`
- `-h` : 심볼릭 링크인지 확인 (-L과 동일). 예) `[[ -h link.txt ]]`
- `-r` : 읽기 권한이 있는지 확인. 예) `[[ -r file.txt ]]`
- `-w` : 쓰기 권한이 있는지 확인. 예) `[[ -w file.txt ]]`
- `-x` : 실행 권한이 있는지 확인. 예) `[[ -x script.sh ]]`
- `-s` : 파일 크기가 0보다 큰지 확인. 예) `[[ -s file.txt ]]`
- `-b` : 블록 디바이스 파일인지 확인. 예) `[[ -b /dev/sda ]]`
- `-c` : 문자 디바이스 파일인지 확인. 예) `[[ -c /dev/tty ]]`
- `-p` : 명명된 파이프(FIFO)인지 확인. 예) `[[ -p pipefile ]]`
- `-S` : 소켓 파일인지 확인. 예) `[[ -S /var/run/docker.sock ]]`
- file1 `-nt` file2 : file1이 file2보다 새로운 파일인지 확인. 예) `[[ file1 -nt file2 ]]`
- file1 `-ot` file2 : file1이 file2보다 오래된 파일인지 확인. 예) `[[ file1 -ot file2 ]]`
- file1 `-ef` file2 : file1과 file2가 같은 파일인지 (하드링크) 확인. 예) `[[ file1 -ef file2 ]]`

###### 논리 연산(`&&`, `||`)

```bash
[[ -f "test.sh" && -r "test.sh" ]]; echo $?
[[ -f "test1.sh" || -f "test2.sh" ]]; echo $?
[[ -f "test1.sh" || -f "test.sh" ]]; echo $?
```

###### `( expression )`, `! expression`

- `( expression )` : 연산자 우선 순위를 변경한다.
- `! expression` : false --> true, true --> false

```bash
result=$(( 4 + 3 * 5 )); echo $result # 19
result=$(( (4 + 3) * 5 )); echo $result # 35
(( 100 < 200 )); echo $? # true: return status 0
(( ! (100 < 200) )); echo $? # false: return status 1
[[ ! -f "en.mo" && (-f "ko.mo" || -f "fr.mo") ]]; echo $?
```

#### 3.5.3 명령어 그룹화(Grouping Commands)

##### `( list )` : 서브쉘에서 실행

```bash
( command1; command2; command3 )
```

1. 소괄호로 감싼 명령 목록은 서브쉘에서 실행된다.
1. 변수의 변경이 부모쉘에 영향을 미치지 않는다.
1. 그룹화된 모든 명령의 출력을 한 번에 리디렉션 할 수 있다.

```bash
# 변수의 값 변경
VAR="Hello"
( VAR="World"; echo "서브쉘: $VAR" )
echo "부모쉘: $VAR"
```

```bash
# 모든 명령의 출력을 리디렉션하기
( echo "첫 번째 줄"; echo "두 번째 줄" ) > output.txt
cat output.txt
```

##### `{ list; }` : 현재쉘에서 실행

```bash
{ command1; command2; command3; }
```

1. 중괄호로 감싼 명령 목록은 현재 쉘에서 실행된다.
1. 서브쉘이 생성되지 않기 때문에 부모쉘의 변수가 변경된다.
1. 리디렉션은 전체 명령의 출력을 하나의 스트림으로 다룬다.
1. 마지막 명령은 반드시 세미콜론(`;`) 또는 줄바꿈(new line)으로 끝나야 한다.

```bash
# 변수의 값 변경
VAR="Hello"
{ VAR="World"; echo "중괄호 안 : $VAR"; } # 마지막 명령도 ; 을 붙이거나 newline 이어야 한다.
echo "중괄호 밖: $VAR"
```

```bash
# 모든 명령의 출력을 리디렉션하기
{ echo "첫 번째 줄"; echo "두 번째 줄"; } > output.txt
cat output.txt
```

### 3.6 코프로세스(Coprocesses)

- 백그라운드에서 실행되는 서브쉘 프로세스이다.
- 비동기(asynchronous) 실행: `&` 연산자로 실행하는 백그라운드 프로세스와 유사하게 실행된다.
- 양방향 파이프(two-way pipe) 생성: 실행 쉘과 코프로세스 간에 입출력 파이프가 자동 연결된다.
- 표준 입/출력 파일 디스크립터(FD)를 제공한다.
  - `NAME[0]` : 코프로세스의 표준 출력(`stdout`)
  - `NAME[1]` : 코프로세스의 표준 입력(`stdin`)
  - `NAME_PID` : 코프로세스의 프로세스 ID(PID)

```bash
coproc [NAME] command [redirections]
coproc NAME { command; }
coproc NAME compound-command
coproc compound-command
coproc simple-command
```

1. `coproc` : 백그라운드에서 프로세스 실행시키는 명령
1. `NAME` : 코프로세스의 이름 설정(기본값: COPROC)
1. `command` : 실행할 명령(단순 명령 또는 복합 명령)
1. `redirections` : 입출력 리디렉션 설정

#### 기본 사용법

```bash
coproc bc
echo "3 + 5" >&"${COPROC[1]}"
read result <&"${COPROC[0]}"
echo "결과: $result"
```

1. `coproc bc`: 계산기 프로그램(bc)를 코프로세스로 실행한다.
1. `echo "3 + 5" >&"${COPROC[1]}"`: echo 출력 결과인 "3 + 5"를 계산기의 stdin 으로 보낸다.
1. `read result <&"${COPROC[0]}"`: 코프로세스 출력을 입력으로 읽는다.
1. `echo "결과: $result"`: result 변수의 값을 출력한다.

#### 코프로세스 이름 지정

```bash
coproc MATH_PROCESS { bc -l; } # 코프로세스 이름: MATH_PROCESS
echo "10 / 2" >&"${MATH_PROCESS[1]}"
read output <&"${MATH_PROCESS[0]}"
echo "결과: $output"
```

#### `wait` 사용법

백그라운드에서 실행 중인 프로세스가 종료될 때까지 대기하는 명령

- 특정 백그라운드 프로세스의 종료를 기다릴 때 사용
- 백그라운드 프로세스의 exit status를 리턴
- wait 뒤에 프로세스 ID 지정하면, 해당 프로세스를 기다림
- wait 뒤에 프로세스 ID 생략하면, 모든 백그라운드 프로젝스 기다림

```bash
coproc MYPROC { sleep 5; echo "끝!"; }
echo "코프로세스 PID: $MYPROC_PID" # 코프로세스 ID: 이름_PID
wait "$MYPROC_PID"
echo "코프로세스 종료됨!"
```

#### `()` 서브쉘 vs `coproc` 차이점

- 실행방식
  - `()` : 독립적인 서브쉘
  - `coproc` : 백그라운드 실행(비동기)
- 프로세스 ID
  - `()` : `$!`
  - `coproc` : `$NAME_PID`
- 입력/출력
  - `()` : 일반적인 리디렉션 사용
  - `coproc` : 양방향 파이프 자동 생성
- 부모쉘과 통신
  - `()` : >& 를 사용하여 명시적인 연결 필요
  - `coproc` : `NAME[0]`, `NAME[1]` 로 자동 연결

### GNU 병렬(GNU Parallel)

- bash 자체 기능은 아니다.
- 명령어들을 병렬로 실행할 수 있게 도와주는 외부 도구이다.
- 대량의 작업을 효율적으로 처리할 때 매우 유용하다.
- 사용 예:
  - 동일한 명령을 다양한 아규먼트와 함께 여러 번 실행하고 싶을 때.
  - 여러 파일, 사용자, 호스트에 대해 같은 작업을 병렬로 실행하고 싶을 때.
  - xargs 보다 더 유연하게 병렬 처리를 하고 싶을 때.
  - for 반복문을 사용하지 않고, 여러 작업을 동시에 실행시킬 수 있다.

#### 기본 문법

```bash
parallel command ::: arg1 arg2 arg3 ...
```

1. `command`: 실행할 명령어
2. `:::` 뒤에 나오는 인자들을 각각 병령 실행에 사용한다.

```bash
parallel gzip ::: file1.txt file2.txt file3.txt
```

- `gzip file1.txt`, `gzip file2.txt`, `gzip file3.txt` 를 병렬로 동시에 실행한다.

#### 표준 입력을 통해 아규먼트 받기

```bash
cat file_list.txt | parallel gzip
```

- `file_list.txt` 의 각 줄을 받아서 `gzip` 명령어로 병렬 처리한다.

#### 자리 표시자(`{}`) 사용

```bash
parallel "convert {} {.}.jpg" ::: *.png
```

1. `{}`: 현재 아규먼트 (예: `image.png`)
1. `{.}`: 확장자를 제외한 파일명 (예: `image`)
1. 실행 결과: `convert image.png image.jpg`

## 4 쉘 함수(Shell Functions)

- 쉘 함수는 여러 명령어를 하나의 이름으로 묶어서 필요할 때마다 호출할 수 있게 만든 문법 구조이다.
- 마치 명령어처럼 사용할 수 있으며, **새로운 프로세스를 생성하지 않고 현재 쉘 컨텍스트에서 실행** 된다.
  - 외부 명령은 보통 서브 프로세스를 생성하여 실행한다.

### 4.1 함수 정의와 호출

- 문법 1

```bash
fname () compound-command [ redirections ]
```

- 문법 2

```bash
# 방법 2
function fname [()] compound-command [ redirections ]
```

1. `fname`: 함수 이름이다.
1. `()`: 괄호는 생략 가능.
1. `compound-command`: 보통 `{ ... }` 형태의 명령 블록이며, 여러 명령어를 그룹화 한다.
1. `function`: 선택 사항이다. 단 이를 사용할 경우 `()`를 생략할 수 있다.
1. `{ ... }` 작성 형식:
   - `{` + `공백` 또는 `개행(newline)` + 명령어
   - `;` 또는 `개행(newline)` + `}`

- 예

```bash
hello1() {
    echo 'hello1(): Hello, world!'
}

# 한 줄로 작성한다면,
hello2() { echo 'hello2(): Hello, world!'; }

# () 괄호를 생략한 경우,
function hello3 { echo 'hello3(): Hello, world!'; }

# () 괄호를 생략하지 않은 경우,
function hello4() { echo 'hello4(): Hello, world!'; }

# 함수 호출
hello1
hello2
hello3
hello4
```

### 4.2 아규먼트(arguments)와 파라미터(Positional Parameter)

```bash
f1() {
    echo "아규먼트 개수: $#"
    echo "아규먼트 값: $1 $2 $3"
    echo "스크립트 이름: $0"
    echo "함수 이름: ${FUNCNAME[0]}"
}
f1 aaa bbb ccc
```

- 아규먼트
  - 함수를 호출할 때 넘겨주는 값.
  - 예) `aaa` `bbb` `ccc`
- 파라미터
  - 아규먼트를 받는 변수.
  - 아규먼트 순서대로 1부터 번호가 부여된다.
  - 예) `$1` `$2` `$3`
  - 파라미터 값을 설정하거나 제거할 때는 bash 내장 명령인 `set`과 `shift`가 사용된다.
- `$#`: 함수에 전달된 아규먼트 개수
- `$0`: 스크립트 파일명
  - 쉘에서 직접 실행할 때는 **쉘 이름** 이다.
- `FUNCNAME[0]`: 현재 실행 중인 함수 이름

#### `$@`: 전체 아규먼트 목록

```bash
f1() {
    echo "아규먼트 값: $1 $2 $3"
    echo "\$@: $@"
}
f1 aaa bbb ccc
```

### 4.3 로컬 변수

- `local` 키워드를 붙이지 않고 선언한 변수는 글로벌 공유된다.
- `local` 키워드를 사용하여 변수를 선언하면 **함수 지역 변수** 가 된다.
- 지역 변수는 상위 scope 변수를 가린다.
- 지역 변수는 메서드 호출 스택을 따라 내려가며 하위 함수에게 전달된다.

```bash
x=100
y=200

f1() {
    local x=111 # 로컬 변수
    y=222 # 글로벌 변수

    echo "f1(): x=$x, y=$y"
}

f1
echo "main: x=$x, y=$y"
```

#### 로컬 변수와 함수 호출 체인

- 로컬 변수는 함수 호출 체인을 따라 전달된다.

```bash
f1() {
    local x='local'
    f2
}

f2() {
    echo "f2(): x=$x"
}

x='global'
f1 'Hello'
echo "x=$x"
```

### 4.4 리턴 값: `return`

```bash
check_even() {
    if (( $1 % 2 == 0 )); then
        return 0 # success
    else
        return 1 # failure
    fi
}
check_even 120 && echo '짝수' || echo '홀수'
check_even 99 && echo '짝수' || echo '홀수'
```

- `return` 문이 없을 경우, 마지막 명령의 종료 상태가 리턴된다.

```bash
f1() {
    echo 'Hello' # 정상 실행: 0 리턴
}
f1 && echo 'Yes' || echo 'No'
```

### 4.5 함수 이름: `FUNCNAME`

- bash 에서 함수 호출 스택 정보를 담고 있는 배열 변수이다.
- 함수를 실행할 때 자동으로 설정된다.
- 함수의 호출자를 추적할 때 사용된다.
  - `FUNCNAME[0]`: 현재 실행 중인 함수 이름
  - `FUNCNAME[1]`: 현재 함수를 호출한 함수 이름
  - `FUNCNAME[2]`: 호출자의 호출자 ...
  - 마지막 이름: 쉘을 의미하는 `main`

```bash
f1() {
    echo "f1(): ${FUNCNAME[0]}, ${FUNCNAME[1]}, ${FUNCNAME[2]}"
    f2
}

f2() {
    echo "f2(): ${FUNCNAME[0]}, ${FUNCNAME[1]}, ${FUNCNAME[2]}"
}

echo "main: ${FUNCNAME[0]}, ${FUNCNAME[1]}, ${FUNCNAME[2]}"
f1
```

### 4.6 함수 제거 및 조회

- 함수 제거: `unset -f 함수이름`

```bash
f1() { echo 'Hello!'; }
f1
unset -f f1
f1
```

- 함수 조회: `declare -f`, `declare -F`

```bash
f1() { echo 'f1()'; }
f2() { echo 'f2()'; }
f3() { echo 'f3()'; }
f4() { echo 'f4()'; }

# 함수 정의 전체
declare -f

# 함수 이름만
declare -F
```

### 4.7 `export`: 자식 쉘에게 함수 정의 전파

- 기본은 함수를 정의한 현재 쉘에서만 호출할 수 있다.

```bash
f1() { echo 'Hello!'; }
f1
bash -c f1 # 자식 쉘은 f1 함수를 모른다.

# bash : 새로운 서브 쉘을 실행한다.
# -c : 다음 문자열을 명령어로 실행하라는 의미
# f1 : 실행할 명령어 문자열
```

- 자식 쉘에서도 호출할 수 있게 하려면, `export` 키워드로 공개 설정 해야 한다.

```bash
f2() { echo 'World!'; }
f2
export -f f2 # 자식 쉘에서도 사용할 수 있도록 공개한다.
bash -c f2

# export -f : 함수 정의를 환경 변수 형태로 자식 쉘에게 전달하도록 설정.
```

## 5. 쉘 파라미터(Shell Parameters)

- 파라미터는 값을 저장하는 엔티티이다.
  - 엔티티? **이름으로 식별할 수 있는 독립적인 객체** 를 의미한다.
- 파라미터에 이름을 부여한 것이 **변수** 이다.

### 5.1 변수

#### 5.1.1 변수 선언

```bash
name=value

# 값을 생략하면 빈문자열("")이 할당된다.
```

```bash
# 예:
myvar=100
path=
greeting="Hello, world"
```

#### 5.1.2 값 저장

- 변수에 값을 저장할 때 다음의 경우, 확장을 먼저 수행한다.

```bash
# 틸드(~) 확장
home_dir=~      # /home/user
echo $home_dir
```

```bash
# $변수 또는 ${변수} 확장
name='홍길동'
echo "$name 님, 안녕하세요."
echo "${name} 님, 안녕하세요."
```

```bash
# $변수 vs ${변수}
name='홍길동'
echo "$name123, ${name}123"  # 변수와 그 다음에 오는 텍스트를 명확히 구분할 수 있다.

arr=(apple banana tomato)
echo "$arr[0]"
echo "${arr[0]}"  # 어디까지가 변수인지 명확히 지정할 수 있다.
```

```bash
# 명령어 치환
today1=$(date)   # 명령어 결과가 들어간다.
echo $today1
today2=`date`   # 명령어 결과가 들어간다.
echo $today2
```

```bash
# 산술 확장
a=100
b=27
result=$(( a / b )) # 정수 산술 연산을 수행한다.
echo $result
```

```bash
# 따옴표 제거(quote removal): 변수 확장 마지막 단계에서 따옴표 제거가 수행된다.
name="홍길동"
# 큰 따옴표를 제거하고 따옴표 안의 문자열만 name 변수에 저장한다.

message="$name 님, 안녕하세요."
# $name 자리에 홍길동 값을 넣는다.
# 큰 따옴표를 제거(quote removal)하고 남은 문자열을 message 변수에 저장한다.

echo $message
```

```bash
# 단어 분할을 수행하지 않는다.
title="Hello World"  # title 변수에 Hello World 문자열이 그대로 저장된다.

echo $title
# 이 문장에서 변수 확장이 발생한다.
#   --> echo Hello World
# 즉 echo 에 아규먼트를 2개 전달하게 된다.

echo "$title"
# 이렇게 하면 1개의 아규먼트를 전달하게 된다.
#   --> echo "Hello World"
# 실행 결과는 같아 보이지만, 내부 구동은 다르다.

# 차이점을 확인해 보자.
printf '<%s>\n' $title  # 공백 기준으로 쪼개진다.
echo '---------'
printf '<%s>\n' "$title"  # 단일 문자열 그대로 출력된다.
```

```bash
# 파일명 확장(globbing)을 수행하지 않는다.
myvar="*.sh" # 변수에 값을 저장할 때는 파일 확장을 수행하지 않는다.

echo "$myvar"  # myvar 변수 값 그대로 출력
echo '----------'
echo $myvar # 따옴표로 감싸지 않으면 이 문장에서 파일 확장을 수행한다.
```

#### 5.1.3 속성(attribute)과 `declare`

- `declare` 명령을 이용하여 변수에 속성을 부여할 수 있다.
- 주요 옵션
  - `-i`: 정수(integer) 변수로 선언 – 산술 평가가 자동 적용됨
  - `-r`: 읽기 전용 변수로 설정 (readonly)
  - `-a`: 일반 배열(array)로 선언
  - `-A`: 연관 배열(associative array)로 선언
  - `-x`: 환경 변수로 export
  - `-n`: nameref (참조 변수) 선언
  - `-f`: 함수 정의를 표시
  - `-F`: 함수 이름만 표시 (파일/라인 정보 포함 가능)
  - `-p`: 변수의 현재 상태 출력

```bash
declare -i num=30       # 정수 속성
declare -r pi=3.14      # 읽기 전용
declare -a arr=(aaa bbb ccc)  # 배열
```

```bash
num=100 # 단순 문자열로 취급한다.
echo $num # 100
num=200+30 # 단순 문자열로 취급한다. 수식으로 다루지 않는다.
echo $num # 200+30
num=$((200+30)) # 수식으로 다루려면 산술 확장 $((...))을 사용해야 한다.
echo $num

echo '--------------'

declare -i num2=100 # 정수형 변수로 선언한다.
echo $num2
num2=200+30 # 수식을 계산한다. 산술 확장을 사용하지 않아도 된다.
echo $num2

num=hello # 문자열을 저장한다.
num2=hello # 정수형 변수는 숫자 값이 아닌 경우 0을 저장한다.
echo $num $num2
```

#### 5.1.4 += 연산자 : 값 추가

```bash
# 기존 문자열에 덧붙임
str='hello'
str+=' world'
echo $str
```

```bash
# 산술 연산
declare -i num=100
num+=20
echo $num
```

```bash
# 배열 변수
arr=(100 200)
arr+=(300 400 500)
echo ${arr[0]} ${arr[1]} ${arr[2]} ${arr[3]} ${arr[4]}
```

#### 5.1.5 `nameref`: 간접 참조 변수

- 다른 변수의 이름을 저장한 후 그 변수처럼 사용

```bash
declare -n ref=score
ref=100
echo $score
```

- 함수에 변수 이름을 전달하기

```bash
f1() {
    declare -n v=$1
    v='hello'
}
msg=''
f1 msg
echo $msg
```

- `for` 반복문에서 nameref 사용하기

```bash
kor=100
eng=90
math=80

for subject in kor eng math; do
    declare -n ref=$subject
    echo "$ref"
done
```

- nameref 제거하기

```bash
name=홍길동
declare -n ref=name
echo "ref=$ref, name=$name"

unset -n ref # 참조 변수 제거
echo "ref=$ref, name=$name"
```

```bash
name=임꺽정
declare -n ref=name
echo "ref=$ref, name=$name"

unset ref # 참조 변수가 가리키는 변수를 제거
echo "ref=$ref, name=$name"
```

### 5.2 위치 파라미터(Positional Parameters)

bash 스크립트나 함수에 넘겨진 아규먼트를 표현하는 숫자로 된 변수이다.

- `$1`, `$2`, `$3`, ..., `$9` 등이 대표적인 위치 파라미터이다.
- `$0`는 예외로, 스크립트 이름 또는 명령어 이름을 의미한다.

#### 5.2.1 스크립트 아규먼트

```bash
#!/bin/bash
echo "스크립트 이름: $0"
echo "첫 번째 아규먼트: $1"
echo "두 번째 아규먼트: $2"
```

```bash
$ ./exam.sh aaa bbb
```

- 숫자가 2자리 이상일 경우 반드시 중괄호 {} 를 사용해야 한다.

```bash
#!/bin/bash
echo "스크립트 이름: $0"
echo "\$1: $1"
echo "\$2: $2"
echo "\$10: $10"  # $1 값에 0이라는 문자열을 붙인 것으로 인식한다.
echo "\${10}: ${10}" # 10번 아규먼트를 가리킨다.
echo "\${11}: ${11}"
```

```bash
$ ./exam.sh 1a 2a 3a 4a 5a 6a 7a 8a 9a 10a 11a 12a
```

### 5.3 특수 파라미터(Special Parameters)

## 6. 쉘 확장(Shell Expansions)

## 7. 리디렉션(Redirections)

## 8. 명령 실행(Executing Commands)

## 9. 쉘 스크립트(Shell Scripts)

### 셸 변수

- 값을 가진 변수를 정의할 수 있다.
- 보통 변수명은 대문자로 정의한다.

```
예1) MYVAR 이라는 변수를 만들고 100을 저장하기
$ MYVAR=100
$ echo $MYVAR
100
```

```
예2) 셸에 미리 정의되어 있는 변수 보기
$ echo $HOME   <=== 사용자 홈 디렉토리
/home/ec2-user
$ echo $LOGNAME   <=== 로그인명
ec2-user
$ echo $PATH   <=== 셸이 명령어를 찾을 때 뒤져보는 디렉토리. 콜론으로 디렉토리 구분한다.
/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/aws/bin: ...
$ echo $PWD   <=== 현재 작업 디렉토리
/home/ec2-user/linuxpocketguide
$ echo $SHELL   <=== 사용하는 셸의 경로
/bin/bash
$ echo $USER   <=== 로그인명
ec2-user
```

```
예3) 다른 프로그램이 사용할 수 있도록 변수를 공개하기
$ export MYVAR=200   <=== 공개된 셸 변수를 '환경변수' 라고 부른다.
```

### printevn

- 셸의 환경변수를 출력한다.

```
예1) 셸의 전체 환경변수를 출력하기
$ printenv
VERIFY_TOKEN=abcde12345
LESS_TERMCAP_mb=
HOSTNAME=ip-172-31-16-175
LESS_TERMCAP_md=
LESS_TERMCAP_me=
TERM=xterm-256color
SHELL=/bin/bash
HISTSIZE=1000
...
```

```
예2) 셸의 특정 환경변수 출력하기
$ printenv JAVA_HOME
/usr/lib/jvm/java
```

### $PATH (환경변수)

- 셸이 프로그램을 찾기 위해 뒤지는 디렉토리의 정보를 저장한 변수이다.
- 변수의 값을 영구적으로 저장하고 싶다면, `~/.bash_profile` 파일에 등록해야 한다.

```
예1) PATH 환경 변수에 디렉토리 설정하기
$ export PATH=/usr/sbin
$ who
-bash: who: command not found   <=== /usr/sbin 디렉토리에서 못 찾아서 실행 오류!
$ PATH=$PATH:/usr/bin   <=== 기존 값에서 디렉토리 추가하기
$ who
ec2-user pts/0        2018-09-03 11:19 (49.170.162.242)   <=== 정상적으로 실행!
```

```
예2) .bash_profile 을 변경한 후 바로 적용하기
$ . $HOME/.bash_profile
```

### alias

- 긴 명령어에 별명을 붙인다.
- `~/.bash_aliases` 또는 `~/.bashrc`파일에 별명을 등록하면 영구적으로 사용할 수 있다.

```
예1) 'ls -al' 명령에 대해 'la' 별명을 붙이기
$ alias la='ls -al'
$ la
합계 3960
drwx------ 12 ec2-user ec2-user    4096  9월  2 13:25 .
drwxr-xr-x  3 root     root        4096  7월  9 05:25 ..
-rw-------  1 ec2-user ec2-user   21544  9월  3 12:33 .bash_history
-rw-r--r--  1 ec2-user ec2-user      18  8월 30  2017 .bash_logout
...
```

```
예2) 모든 별명을 출력하기
$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
...
```

### <, >>, >>, 2> (입출력 리다이렉션)

- 표준 입력/출력/오류를 파일로 보낼 수 있다.
- 파일의 내용을 프로그램으로 전달할 수 있다.

```
예1) 파일의 내용을 명령어로 보내기
$ 명령어 < 파일
```

```
예2) 명령어의 실행 결과를 파일로 출력하기
$ 명령어 > 파일
```

```
예3) 명령어의 실행 결과를 기존 파일에 덧 붙이기
$ 명령어 >> 파일
```

```
예4) 명령어의 표준 출력은 화면으로 출력하고 표준 오류는 파일로 출력하기
$ 명령어 2> 오류파일
```

```
예5) 명령어의 표준 출력과 표준 오류를 분리하여 각각의 파일로 출력하기
$ 명령어 > 표준출력파일 2> 오류출력파일
```

### | (파이프)

- 어떤 명령어의 표준 출력을 다른 명령어의 표준 입력으로 보낸다.

```
예1) 현재 실행 중인 프로세스의 이름 목록을 정렬하여 출력하기
$ ps -eo %c | sort
COMMAND
acpid
agetty
amazon-ssm-agen
ata_sff
...
=> ps를 통해 현재 실행 중인 프로세스의 이름 목록을 만든다.
=> 파이프(|)를 이용해 sort로 목록을 보낸다.
=> sort는 이를 정렬하여 출력한다.
```

### `<(명령어)` 프로세스 대체(substitution)

- 출력을 파일로 변환한다.

```
예1) <() 명령어 사용 전
$ cd jpegexample   <=== 예제 파일이 있는 디렉토리로 이동
$ ls *.jpg | cut -d. -f1 > /tmp/jpegs
$ ls *.txt | cut -d. -f1 > /tmp/texts
$ diff /tmp/jpegs /tmp/texts  <=== 두 개 파일을 비교

==> ls *.jpg
    확장자가 .jpg 인 파일을 모두 출력한다.
==> cut -d. -f1
    -d. : .을 기준으로 문자열을 분리한다.
    -f1 : 분리된 항목에서 첫 번째 항목을 선택한다.
==> > /tmp/jpegs
    실행 결과를 /tmp 폴더에 jpegs라는 이름으로 저장한다.
```

```
예2) <() 명령어 사용 후
$ diff <(ls *.jpg | cut -d. -f1) <(ls *.txt | cut -d. -f1)
```

### `;, &&, ||` (명령어 결합)

- 여러 개의 명령어를 결합하여 실행한다.

```
예1) 명령어를 순서대로 실행하기
$ 명령어1; 명령어2; 명령어3
```

```
예2) 명령어를 순서대로 실행하되, 그 중 하나가 실패하면 다음 명령을 실행하지 않는다.
$ 명령어1 && 명령어2 && 명령어3
```

```
예3) 명령어를 순서대로 실행하되, 그 중 하나가 성공하면 다음 명령을 실행하지 않는다.
$ 명령어1 || 명령어2 || 명령어3
```

### `` ', ", `, $() `` (따옴표)

- '(작은 따옴표) : 파일명에 공백을 포함하고 있을 때 사용한다.
- "(큰 따옴표) : 작은 따옴표와 같다. 단 변수의 값을 처리한다.
- `` ` ``(역 따옴표;backtick) : 쉘 명령어를 실행한 후 그 결과를 출력으로 바꾼다.
- $() : 역 따옴표와 같다.

```
예1) 변수의 값을 출력하기
$ V1=100   <=== 주의! 연산자와 피연산자 사이에 공백이 있으면 안된다.

$ echo 'V1의 값은 $V1입니다.'
V1의 값은 $V1입니다.   <=== 작은 따옴표는 변수의 값을 출력하지 못한다.

$ echo "V1의 값은 $V1입니다."
V1의 값은 100입니다.   <=== 큰 따옴표는 변수의 값을 처리하여 출력한다.
```

```
예2) 현재 년도 출력하기
$ date +%Y
2018

$ echo 올해는 `date +%Y`년 입니다.
올해는 2018년 입니다.   <=== 역 따옴표는 셸 명령어를 인식하고 실행한다. 그 결과를 출력한다.

$ echo 올해는 $(date +%Y)년 입니다.
올해는 2018년 입니다.   <=== $()는 역 따옴표와 같다.
```

### 이스케이핑

- 셸에서 특별한 의미를 가지는 문자를 일반 문자로 변환한다.

```
예1) * 문자 출력하기
$ echo a*
aardvark adamantium apple   <=== a 문자로 시작하는 파일명을 출력한다.

$ echo a\*
a*
```

```
예2) $ 문자 출력하기
$ echo $HOME
/home/ec2-user
$ echo \$HOME
$HOME
```

### 명령어 히스토리

- 셸 히스토리를 다룰 수 있다.
- 문법
  - `history` 현재까지 실행한 명령어 내력을 출력
  - `history 5` 최근에 실행한 5 개의 명령만 출력
  - `history -c` 히스토리 삭제
  - `!!` 이전 명령어 재실행
  - `!$` 이전 명령어의 마지막 파라미터
  - `!*` 이전 명령의 전체 파라미터

### 탭으로 파일명 완성

- 파일명을 입력할 때 탭 키를 누르면 자동으로 그 파일명을 완성한다.
- 만약 여러 개가 있다면 셸은 '삐'하고 소리를 낸다.
- 한 번 더 탭 키를 누르면 파일 목록을 출력한다.

```
예1) 문자 'o'로 시작하는 파일명 조회하기
$ ls o<탭><탭>
oldfile1      oldfile2      oldfile3      oldnames      one.pdf       original_who

```
