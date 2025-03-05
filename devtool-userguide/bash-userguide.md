# Bash Shell User Guide

## 개요

### 쉘(shell)이란?

- 운영체제에서 사용자와 커널 간의 인터페이스 역할을 하는 프로그램
- 사용자가 입력한 명령을 해석하여 커널에게 전달하고 그 실행 결과를 출력
- 명령어를 직접 입력하는 CLI(Command Line Interface) 환경 제공
- 배치 작업 및 자동화를 위한 스크립트(.sh 파일) 실행 기능 지원 

### 주요 쉘

- Bash(Bourne Again Shell): 기본 리눅스 쉘, sh 호환, 빠르고 가볍다, `/bin/bash`
- Sh(Bourne Shell): 오래된 유닉스 계열 기본 쉘, 빠르고 가볍다, `/bin/sh`
- Zsh(Z Shell): Bash와 호환, 자동완성 및 추천, 플러그인 기능 지원, `/bin/zsh`
- Ksh(Korn Shell): Bash 보다 성능이 뛰어나며 스크립트 작성에 강점, `/bin/ksh`
- Fish(Friendly Interactive Shell): 사용하기 쉬운 GUI 스타일과 자동 완성 기능 제공, `/usr/bin/fish` 

### Bash 쉘

- sh 호환 쉘이다. ksh, csh 의 유용한 기능을 통합하였다.
- IEEE POSIX P1003.2/ISO 9945.2 쉘 및 도구 표준을 따른다.


### 용어 정의

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
    - 모두 동인한 프로세시 그룹에 속한다.
- job control
    - 사용자가 프로세스 실행을 중지(일시 중단)하고 다시 시작(재개)할 수 있는 메커니즘이다.
- metacharacter
    - 따옴표 없이(unquoted) 단어를 구분하는 문자이다.
    - `newline`, `space`, `tab`, `|`, `&`, `;`, `(`, `)` , `<`, `>`
- name
    - 문자, 숫자, 밑줄(_)로 구성된 단어이다. 문자나 밑줄로 시작한다.
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
    - ***단어(word)*** 또는 ***연산자(operator)***
- word
    - 쉘에서 한 단위로 취급하는 문자열이다. 
    - 단어는 따옴표 없는 metacharacter를 포함할 수 없다.


## 기본 구성 요소


### 쉘 구문(Shell Syntax)

쉘 스크립트 파일, -c 옵션 또는 터미널에서 명령을 읽으면 다음의 절차에 따라 처리한다.

1. 주석 무시 - 입력이 주석의 시작을 나타내면, 주석 기호(`#`)와 그 줄의 나머지 부분을 무시한다.
    ```bash
    echo "Hello" # 이 부분은 주석이므로 무시됨
    ```

2. 단어와 연산자 구분(tokenizing) - 따옴표 규칙에 따르며, metacharacter를 기준으로 입력을 **단어(words)**와 **연산자(operators)**로 나눈다. 이렇게 구분된 것을 **토큰(token)** 이라고 한다.
    ```bash
    cat "hello world.txt" # "Hello World.txt"는 한 개의 단어로 인식한다.
    cat hello world.txt # hello와 world.txt는 각각 개별 단어로 인식한다.
    ls -l /home # ls 와 /home 은 단어가 되고, -l 은 연산자가 된다.
    ```

3. 명령어 해석 - 이렇게 나눈 토큰(token)을 명령이나 기타 구조로 분석한다.

4. 특수 의미 제거 및 확장 - 일부 단어나 문자열의 특별한 의미를 제거하고, 필요한 경우 확장(expansion) 작업을 수행한다.
    ```bash
    echo *  # 특별한 의미로 사용(확장)
    ```
    와일드카드(*) 문자는 '작업 디렉토리의 모든 파일과 디렉토리'로 의미를 확장한다. 예) `echo a.txt b.txt c.gif dir1 dir2`

    ```bash
    echo \*  # 특별한 의미 제거
    ```
    이스케이프 문자를 통해 '와일드카드의 의미를 제거'하고 단순 문자로 취급한다.

    ```bash
    cat hello\ world.txt # 특별한 의미 제거
    ```
    \ 뒤에 오는 공백을 metacharacter로 간주하지 않고 단순 공백 문자로 간주한다. 즉 'hello world.txt' 파일명이다.


5. 입출력 리디렉션 - 필요에 따라 입력과 출력을 리디렉션 한다.

6. 명령 실행 - 지정된 명령을 실행하고, 명령어의 종료 상태를 기다린다.

7. 종료 상태 저장 - 종료 상태를 추가 검사나 작업에 사용할 수 있도록 한다.


#### 인용(Quoting)

특정 문자나 단어의 특수 의미를 제거하는 데 사용된다.

- 특수 문자에 대한 특수 처리를 비활성화
- 예약어가 예약어로 인식되는 것을 방지
- 매개 변수 확장을 방지

1. 이스케이프 문자

    `\` 다음에 오는 문자의 특수 의미를 제거하고 문자 그대로 해석한다. 예를 들어, 공백(space)이나 메타문자(*, ?, $, " 등)와 같이 특별한 의미가 있는 문자를 일반 문자로 취급한다.
    
    ```bash
    cat hello\ world.txt
    ````
    `hello world.txt` 이라는 파일명을 의미한다.

    ```bash
    cat Hello\
    Python\
    Wworld
    ````
    `\` 다음에 오는 `newline`은 무시된다. 즉 `cat helloPythonWorld` 와 같다.

    ```bash
    cat \$HOME
    ````
    `\` 다음에 오는 `$`는 단순 문자로 취급된다.

2. 작은 따옴표

    작은 따옴표 안의 문자는 그대로 유지된다. 메타 문자도 단순 문자로 취급한다.
    
    ```bash
    name="홍길동"
    echo 'Hello $name'  # 출력: Hello $name
    echo "Hello $name"  # 출력: Hello 홍길동
    ````
    
    ```bash
    echo 'Hello\
    World'

    # 출력 결과
    Hello\
    World
    ````
    `\` 도 단순 문자로 취급된다.


3. 큰 따옴표

    작은 따옴표와 달리 큰 따옴표 내부에서는 **변수 확장**, **명령어 치환**, **이스케이프**, **히스토리 확장**이 동작할 수 있다. 또한 일부 메타 문자도 해석된다.

    - 변수 확장 예)
    ```bash
    name="홍길동"
    echo "Hello $name"  # 출력: Hello 홍길동
    ``` 

    - 명령어 치환 예)
    ```bash
    echo 'Today is `date`' # Today is `date`
    echo "Today is `date`"  # Today is Wed Mar  5 08:08:52 UTC 2025
    ``` 

    - 히스토리 확장 예) 
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

4. ANSI-C 인용
5. 로케일별 번역

#### 주석(Comments)


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

### ``', ", `, $()`` (따옴표)

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


