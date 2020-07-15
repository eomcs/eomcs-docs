# Git 브랜치 사용법

## 커밋 정보

Git에서 commit을 수행하면 다음의 절차에 따라 커밋 정보를 저장한다.

- `git add` 실행
  - **Blob** 생성
    - Git 저장소에 저장되는 파일이다.
    - 각 파일은 SHA-1 해시 알고르즘으로 계산된 40바이트 크기의 고유의 체크섬(checksum) 값을 가진다.
  - Staging Area에 Blob의 체크섬을 기록한다.
- `git commit` 실행
  - 트리 객체 생성
    - 디렉토리와 파일의 구조 정보가 들어 있다.
    - 파일 정보는 Blob의 체크섬이다. 
    - 각 트리를 구분하기 위한 SHA-1 해시로 생성한 체크섬을 가진다.
  - 커밋 객체 생성
    - 작성자, 커미터, 커밋 메시지 등 메타 정보가 들어 있다.
    - 트리 객체를 가리키는 정보가 들어 있다.
    - 각 커밋을 식별하기 위한 SHA-1 해시로 생성한 체크섬을 가진다.
    - 이전 커밋을 가리키기 위해 이전 커밋의 체크섬이 들어 있다.
- 객체들 간의 관계
  - [커밋 객체]----> [트리 객체]----> [Blob 객체들]     

## 브랜치

- Git의 브랜치는 커밋 사이를 이동할 때 사용하는 포인터 같은 것이다.
- 커밋의 체크섬을 이용하여 여러 커밋들 중에서 한 커밋을 가리킨다.
- 즉 새 브랜치를 만드는 것은 단순히 41바이트(40바이트 체크섬 + 1바이트 줄 바꿈 문자)의 파일을 하나 만드는 것에 불과하다. 따라서 브랜치를 여러 개 만들어도 전혀 상관없다. 
- Git은 브랜치를 만들어 작업하고 나중에 merge 하는 것을 권장한다.
- 하루에 수십 번씩 해도 괜찮다고 제안하고 있다. 

### master 브랜치

- `git init`를 통해 Git 저장소를 만들 때 'master'라는 이름으로 기본 브랜치를 생성한다.
- master 브랜치로 작업하는 동안에는 항상 가장 마지막 커밋을 가리킨다.

### HEAD

- 현재 작업 중인 로컬 브랜치를 가리키는 특수한 포인터이다.

### 토픽 브랜치 

- 어떤 한가지 주제나 작업을 위해 만든 짧은 호흡의 브랜치이다. 

### 트래킹 브랜치 = upstream 브랜치

- 원격 브랜치를 체크아웃 하여 만든 로컬 브랜치이다.
- 트래킹 브랜치에서 `git pull` 을 실행하면 이 로컬 브랜치와 연결된 원격 브랜치에서 데이터를 받아 로컬 브랜치로 자동 merge 한다. 

## 브랜치 명령

### git branch

- 브랜치를 관리한다.

```
예1) b1 이라는 이름으로 브랜치를 새로 만들기
        git branch [새 브랜치 이름]
    - 새로 만든 브랜치도 지금 작업하고 있는 커밋을 가리킨다.
    - HEAD 포인터는 브랜치 생성과 상관없이 기존의 브랜치를 계속 가리킨다.
$ git branch b1
$ git log --oneline                   <=== 커밋 정보를 한 줄 씩 출력한다.
f559e21 (HEAD -> master, b1) v0.3
5896279 v0.2
8dd76bf v0.1
5d8d97b (origin/master, origin/HEAD) Initial commit 
```

```
예2) 브랜치 목록을 조회하기 
        git branch
    - 아무런 옵션 없이 실행하면 브랜치의 목록을 출력한다.
$ git branch
  b1
* master      <=== 현재 작업하는 브랜치에 * 가 붙는다.
```

```
예3) 브랜치들 중에서 merge 한 브랜치를 조회하기
$ git branch --merged
```

```
예4) 브랜치들 중에서 merge 하지 않은 브랜치를 조회하기
$ git branch --no-merged
```

```
예5) 브랜치 삭제하기
$ git branch -d b1    <=== merge 되지 않은 브랜치는 삭제되지 않는다.
error: The branch 'b1' is not fully merged.    
If you are sure you want to delete it, run 'git branch -D b1'.

$ git branch -D b1    <=== -D 옵션으로 merge 되지 않은 브랜치를 강제 삭제하라.
Deleted branch b1 (was 519ee27).
```



### git checkout [브랜치 이름]

- HEAD?
  - 작업 디렉토리에 로딩한 브랜치를 가리킨다.
- 작업 디렉토리에 커밋 파일을 교체하기
  - HEAD 포인터가 다른 브랜치를 가리키게 한다.
  - HEAD 포인터가 가리키는 브랜치가 바뀌면, 
    작업 디렉토리도 그 브랜치의 커밋 정보에 따라 바뀐다.
- 명령?
  - git checkout 브랜치명
```
예1) HEAD 포인터를 b1 브랜치로 옮긴다.
$ git checkout b1
$ git log --oneline                   <=== 로그 정보를 확인해 보라.
f559e21 (HEAD -> b1, master) v0.3     <=== HEAD는 b1을 가리키고 있다. 
5896279 v0.2
8dd76bf v0.1
5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예2) test04.txt를 만들어 b1 브랜치에 추가하기
    test04.txt 파일을 만들었다고 가정하자!
$ git add test04.txt
$ git commit -m 'v0.4'
$ git log --oneline
9cf510e (HEAD -> b1) v0.4    <=== b1은 새로 커밋한 스냅샷을 가리킨다. HEAD는 현재 작업 브랜치인 b1을 가리킨다.
f559e21 (master) v0.3        <=== master가 가리키는 스냅샷은 변경되지 않는다. 
5896279 v0.2
8dd76bf v0.1
5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예3) test05.txt를 만들어 b1 브랜치에 추가하기
    test05.txt 파일을 만들었다고 가정하자!
$ git add test05.txt
$ git commit -m 'v0.5'
$ git log --oneline
34fda9c (HEAD -> b1) v0.5    <=== b1은 새로 커밋한 스냅샷을 가리킨다. HEAD는 현재 작업 브랜치인 b1을 가리킨다.
9cf510e v0.4    
f559e21 (master) v0.3        <=== master가 가리키는 스냅샷은 변경되지 않는다. 
5896279 v0.2
8dd76bf v0.1
5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예4) 작업할 브랜치를 b1에서 다시 master로 교체하기
    브랜치를 교체한 후 작업 디렉토리를 확인해 보면, 다시 master가 가리키는 스냅샷으로 돌아 온 것을 확인할 수 있다.
$ git checkout master
$ git log --oneline
f559e21 (HEAD -> master) v0.3    <=== 전체 스냅샷 중에서 master 브랜치와 연결된 스냅샷만 화면에 출력된다.
5896279 v0.2
8dd76bf v0.1
5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예5) test06.txt를 만들어 master 브랜치에 추가하고 커밋 내력 확인하기
    test06.txt 파일을 만들었다고 가정하자!
$ git add test06.txt
$ git commit -m 'v0.6'
$ git log --oneline
6f4725e (HEAD -> master) v0.6
f559e21 v0.3
5896279 v0.2
8dd76bf v0.1
5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예6) 현재 HEAD가 가리키는 브랜치의 역사 뿐만 아니라 다른 브랜치의 역사까지 출력하기
$ git log --oneline --graph --all
* 6f4725e (HEAD -> master) v0.6
| * 34fda9c (b1) v0.5
| * 9cf510e v0.4
|/  
* f559e21 v0.3
* 5896279 v0.2
* 8dd76bf v0.1
* 5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예7) 체크아웃 할 때 자동으로 새 브랜치를 만들기
    'git branch' + 'git checkout' = git checkout -b [새 브랜치 이름] 
$ git checkout -b b2
$ git log --oneline --all --graph
* 6f4725e (HEAD -> b2, master) v0.6
| * 34fda9c (b1) v0.5
| * 9cf510e v0.4
|/  
* f559e21 v0.3
* 5896279 v0.2
* 8dd76bf v0.1
* 5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예8) 새로 만든 b2 브랜치에 test07.txt 파일을 추가하고 커밋하기
$ git add test07.txt
$ git commit -m 'v0.7'
$ git log --oneline --all --graph
* 33c8c8d (HEAD -> b2) v0.7
* 6f4725e (master) v0.6
| * 34fda9c (b1) v0.5
| * 9cf510e v0.4
|/  
* f559e21 v0.3
* 5896279 v0.2
* 8dd76bf v0.1
* 5d8d97b (origin/master, origin/HEAD) Initial commit
```

### git merge [브랜치 이름]

- 현재 브랜치의 커밋에 다른 브랜치의 커밋 내용을 합친다.

```
예1) 합치려는 브랜치가 현 브랜치 보다 Upstream(이후 버전)일 경우,
    별도의 merge 과정이 필요없고, 해당 브랜치의 최신 버전의 커밋으로 이동한다.
    이런 merge 방식을 'fast forward'라 부른다.
$ git checkout master
$ git merge b2
$ git log --oneline --all --graph
* 33c8c8d (HEAD -> master, b2) v0.7   <=== master가 b2가 가리키는 커밋으로 이동한다.
* 6f4725e v0.6
| * 34fda9c (b1) v0.5
| * 9cf510e v0.4
|/  
* f559e21 v0.3
* 5896279 v0.2
* 8dd76bf v0.1
* 5d8d97b (origin/master, origin/HEAD) Initial commit
```

```
예2) 더 이상 필요없는 b2 브랜치를 삭제하기
$ git branch -d b2
$ git log --oneline --all --graph
* 33c8c8d (HEAD -> master) v0.7
* 6f4725e v0.6
| * 34fda9c (b1) v0.5
| * 9cf510e v0.4
|/  
* f559e21 v0.3
* 5896279 v0.2
* 8dd76bf v0.1
* 5d8d97b (origin/master, origin/HEAD) Initial commit
[~/git/git-test]$ 
```

```
예3) master 브랜치에 b1 브랜치 커밋 내용을 합치기
$ git checkout master     <=== 현재 브랜치가 master가 아니라면 이 명령을 수행한다.
$ git merge b1
$ git log --oneline --all --graph
*   58489d3 (HEAD -> master) v0.8    <=== master 브랜치에 b1 브랜치를 합친 새 커밋이 생성된다.
|\  
| * 34fda9c (b1) v0.5
| * 9cf510e v0.4
* | 33c8c8d v0.7
* | 6f4725e v0.6
|/  
* f559e21 v0.3
* 5896279 v0.2
* 8dd76bf v0.1
* 5d8d97b (origin/master, origin/HEAD) Initial commit

더 이상 필요없는 b1 브랜치를 삭제하기
$ git branch -d b1
[~/git/git-test]$ git log --oneline --all --graph
*   58489d3 (HEAD -> master) v0.8
|\  
| * 34fda9c v0.5
| * 9cf510e v0.4
* | 33c8c8d v0.7
* | 6f4725e v0.6
|/  
* f559e21 v0.3
* 5896279 v0.2
* 8dd76bf v0.1
* 5d8d97b (origin/master, origin/HEAD) Initial commit
```

### git rebase [브랜치명]

- 지정한 브랜치에 현재 브랜치의 변경 내력을 순서대로 합친다. 
- 작업 원리
    - 두 브랜치가 갈라지기 전인 공통 커밋으로 이동한다.
    - 공통 커밋 부터 현재 브랜치까지의 diff(변경 사항)를 차례로 만들어 임시 보관해 둔다.
    - 현재 브랜치가 지정한 브랜치를 가리키게 한다.
    - 임시 보관된 diff(변경 사항)을 차례로 적용한다.
- 특징
    - merge 보다 좀 더 깔끔한 history를 만든다.
    - history가 선형이다.
    - 모든 작업이 순서대로 진행된 것 처럼 보인다.
    - 보통 원격 브랜치에 커밋을 깔금하게 적용하고 싶을 때 사용한다.
    - rebase 브랜치의 변경 사항을 다른 브랜치에 순서대로 적용하면서 합친다.
    - merge는 두 브랜치의 최종 결과만을 가지고 합친다. 
- merge vs rebase
    - 로컬 저장소에서 브랜치를 정리할 때 rebase를 사용한다.
    - push로 공개한 커밋에 대해서는 rebase를 하지 말라!
    - 되도록 merge를 사용하여 역사를 기록하고 후세에 남겨 교훈이 되게 하라.

```
예1) b1 브랜치를 master 브랜치에 합치기 

현재 브랜치 내력을 조회한다.
$ git log --oneline --graph --all
* f9e2727 (HEAD -> master) C1

b1 브랜치를 만든다.
$ git branch b1
$ git log --oneline --graph --all
* f9e2727 (HEAD -> b1, master) C1

파일을 변경한 후 커밋한다.
$ git add .
$ git commit -m 'C2'
$ git log --oneline --graph --all
* 0ebbfb2 (HEAD -> b1) C2
* f9e2727 (master) C1

master 브랜치로 옮긴 후 파일을 변경한 후 커밋한다.
$ git checkout master
$ git add .
$ git commit -m 'C3'
$ git log --oneline --graph --all
* 1df28eb (HEAD -> master) C3
| * 0ebbfb2 (b1) C2
|/  
* f9e2727 C1

b1 브랜치로 옮긴 후 master 브랜치를 b1 브랜치쪽으로 rebase 한다.
$ git checkout b1
$ git rebase master
$ git log --oneline --graph --all
* 211448b (HEAD -> b1) C2
* 1df28eb (master) C3
* f9e2727 C1

master를 'fast-forward'로 merge 한다.
$ git checkout master
$ git merge b1
$ git log --oneline --graph --all
* 211448b (HEAD -> master, b1) C2
* 1df28eb C3
* f9e2727 C1
```

```
브랜치 history가 다음과 같다면,

C1 --- C2 --- C3   master
        \
         C4 --- C5 --- C6    b1
          \
           C7 --- C8 --- C9    b2

예2) b2 브랜치를 master 브랜치와 연결하기
        git rebase -onto [기준브랜치] [토픽 브랜치1] [토픽 브랜치2]
    - '-onto' 옵션을 사용하면 b2 브랜치로 체크아웃 할 필요없다.
    - '토픽 브랜치1'과 '토픽 브랜치2'의 공통 커밋 이후부터 '토픽 브랜치2'까지의 모든 변경 사항을 patch로 만들어서 '기준 브랜치'에 적용한다.
$ git rebase -onto master b1 b2

위 명령을 수행한 후 브랜치의 history
C1 --- C2 --- C3   master
        \      \
         \      C7' --- C8' --- C9'    b2
          \
           C4 --- C5 --- C6    b1

b2를 master에 합쳤으면 master에 대해 'fast-forward'를 수행한다.
$ git checkout master
$ git merge b2

위 명령을 수행한 후 브랜치의 history
C1 --- C2 --- C3 --- C7' --- C8' --- C9' master, b2
        \      
         C4 --- C5 --- C6    b1
```

```
예3) 위의 상황에서 b1 브랜치를 master에 합치기
        git rebase [기준 브랜치] [토픽 브랜치]
$ git rebase master b1

위 명령을 수행한 후 브랜치의 history
C1 --- C2 --- C3 --- C7' --- C8' --- C9' --- C4' --- C5' --- C6'
                                      |                       |
                                    master, b2               b1

b1을 master에 합쳤으면 master에 대해 'fast-forward'를 수행한다.
$ git checkout master
$ git merge b1
$ git branch -d b1    <=== 필요없는 b1 브랜치 삭제
$ git branch -d b2    <=== 필요없는 b2 브랜치 삭제

C1 --- C2 --- C3 --- C7' --- C8' --- C9' --- C4' --- C5' --- C6' 
                                                              |
                                                            master
```

## 원격 브랜치 

- 원격 브랜치는 원격 저장소에 있는 브랜치를 가리키는 레퍼런스(포인터) 이다.
- 원격 브랜치를 가리키는 형식
    - (remote)/(branch)
    - 예) origin/master
- 'git clone' 명령을 수행하면 원격 저장소를 가리키는 이름으로 'origin'이 자동 부여된다.

### git clone -o [원격저장소이름]

- '-o' 옵션을 이용하여 원격 저장소 이름을 지정하면 'origin' 대신 지정한 이름이 부여된다.

```
예1) 원격 저장소의 이름을 'orgin' 대신 'ohora'라 짓기
$ git clone -o ohora https://github.com/eomjinyoung/git-test
$ git remote
ohora
```

### git ls-remote

- 원격 레퍼런스(Refs)를 조회한다.

```
예1) 원격 저장소의 레퍼런스를 모두 출력하기
        git ls-remote [원격 저장소 이름]
$ git ls-remote    <=== 원격 저장소 이름을 생략하면 전체 출력
From https://github.com/eomjinyoung/git-test.git
9babde9de3ff3f9c979a8da0c9d65e008a13af31	HEAD
9babde9de3ff3f9c979a8da0c9d65e008a13af31	refs/heads/master

$ git ls-remote origin    <=== origin에 대한 것만 출력
9babde9de3ff3f9c979a8da0c9d65e008a13af31	HEAD
9babde9de3ff3f9c979a8da0c9d65e008a13af31	refs/heads/master
```

### git remote show [원격 저장소 이름]

- 원격 저장소에 대한 모든 브랜치와 정보를 조회한다.

```
예1) 원격 저장소의 브랜치 정보를 출력하기
        git remote show [원격 저장소 이름]
$ git remote show origin
* remote origin
  Fetch URL: https://github.com/eomjinyoung/git-test.git
  Push  URL: https://github.com/eomjinyoung/git-test.git
  HEAD branch: master
  Remote branch:
    master tracked
  Local branch configured for 'git pull':
    master merges with remote master
  Local ref configured for 'git push':
    master pushes to master (local out of date)
```

### git fetch [원격 저장소 이름]

- 원격 저장소가 로컬 저장소에 없는 정보를 가지고 있다면 모두 가져온다.
- 그리고 origin/master 포인터를 최신 커밋으로 이동시킨다.

```
현재 로컬 저장소의 브랜치 및 커밋 역사가 다음과 같다고 가정하자.
C1 --- C2 --- C3 --- C4 --- C5 --- C6 --- X1 --- X2
                                    |             |
                              origin/master     master

현재 원격 저장소의 브랜치 및 커밋 역사가 다음과 같다고 가정하자.
C1 --- C2 --- C3 --- C4 --- C5 --- C6 --- Y1 --- Y2
                                                  |
                                                master

예1) 원격 저장소의 내용을 로컬 저장소로 가져온다.
$ git fetch origin
$ git log --oneline --graph --all
* 9babde9 (origin/master, origin/HEAD) Y2
* 440c0c1 Y1
| * 82efd10 (HEAD -> master) X2
| * 4039833 X1
|/  
* b4dec77 C6
* 66d6384 C5
* 401d39d C4
* 4859dd1 C3
* 241b657 C2
* 046ea07 C1

즉 다음 그래프와 같이 커밋이 구성된다.
C1 --- C2 --- C3 --- C4 --- C5 --- C6 --- X1 --- X2 
                                     \            |
                                      \     HEAD -> master
                                       Y1 --- Y2
                                               |
                                         origin/master

예2) 원격에서 가져온 정보를 로컬 저장소에 merge하기 
$ git merge 9babde9
$ git log --oneline --graph --all
*   f5d2046 (HEAD -> master) X3
|\  
| * 9babde9 (origin/master, origin/HEAD) Y2
| * 440c0c1 Y1
* | 82efd10 X2
* | 4039833 X1
|/  
* b4dec77 C6
* 66d6384 C5
* 401d39d C4
* 4859dd1 C3
* 241b657 C2
* 046ea07 C1

즉 다음 그래프와 같이 커밋이 구성된다.
C1 --- C2 --- C3 --- C4 --- C5 --- C6 --- X1 --- X2 --- X3    HEAD -> master
                                    \                 /
                                     --- Y1 --- Y2 ---
                                                 |
                                           origin/master
```

```
예3) 원격 저장소의 정보를 가져와서 로컬 저장소와 합치기
        git pull = git fetch + get merge
    - 'git pull' 명령을 사용하면 더 간단히 처리할 수 있다.
$ git pull
```

```
예4) 모든 원격 저장소에서 데이터를 받아오기
$ git fetch --all
```

### git push

- 로컬 저장소의 정보를 원격 저장소에 올린다.
- 로컬에서 생성한 브랜치를 원격 저장소에 올릴 수 있다.
- 원격 저장소의 브랜치를 삭제할 수 있다.

```
예1) push를 사용하여 로컬 저장소의 정보를 원격 저장소에 올리기
$ git push    <=== master를 origin/master로 올린다.
$ git log --oneline --graph --all
*   f5d2046 (HEAD -> master, origin/master, origin/HEAD) X3
|\  
| * 9babde9 Y2
| * 440c0c1 Y1
* | 82efd10 X2
* | 4039833 X1
|/  
* b4dec77 C6
```

```
예2) 로컬 저장소에 있는 'b1' 브랜치를 원격 저장소에 올리기 
        git push [원격 저장소 이름] [로컬 브랜치 이름]
    - 로컬 브랜치 이름과 같은 원격 브랜치가 없으면 새로 만든다.
    - 로컬 브랜치 정보를 원격 브랜치에 올린다.
$ git push origin b1
```

```
예3) 로컬 저장소에 있는 'b1' 브랜치를 원격 저장소의 'other' 브랜치로 올리기
        git push [원격 저장소 이름] [로컬 브랜치 이름]:[원격 브랜치 이름]
    - 로컬 브랜치 이름과 원격 브랜치 이름을 다를 때 유용하다.
$ git push origin b1:other
```

```
예3) 원격 저장소의 'b1' 브랜치를 삭제하기
        git push [원격 저장소 이름] --delete [브랜치 이름]
$ git push origin --delete b1
```

### git checkout -b [로컬 브랜치] [원격 저장소]/[원격 브랜치]

- 원격 저장소의 브랜치를 받아서 로컬 브랜치를 만든다.
  
```
예1) 원격 저장소의 origin/other 브랜치를 체그아웃 하여 other2 로컬 브랜치 만들기
$ git checkout -b other2 origin/other
Branch 'other2' set up to track remote branch 'other' from 'origin'.
Switched to a new branch 'other2'
```

```
예2) 원격 저장소의 origin/other 브랜치를 체크아웃 하여 같은 이름으로 로컬 브랜치 만들기
    - 같은 이름으로 만들 때는 --track 옵션을 사용한다.
$ git checkout --track origin/other
```

### git branch -vv

- 트래킹 브랜치의 설정 정보를 조회한다.
- 출력 결과
    - ahead n : 로컬 브랜치가 커밋을 n 개 앞서 있다. 즉 로컬 브랜치에 커밋이 2개 더 있다는 의미.
    - behind n : 원격 브랜치에서 로컬 브랜치로 merge 하지 않은 커밋이 n 개 있다는 의미.

```
$ git branch -vv
  b1     c2be10d [origin/b1] v1.3
* b2     664dbb5 v3.1
  master 09fb339 [origin/master: ahead 2] v3.0   <=== 로컬 브랜치가 커밋을 2개 앞서 있다는 의미
  other  ed485e2 [origin/other] v1.2
  other2 ed485e2 [origin/other] v1.2
```
