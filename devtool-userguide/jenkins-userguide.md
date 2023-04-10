# Jenkins 사용법

## Jenkins 설치

### 네트워크 브릿지 생성

젠킨스 도커 컨테이너에서 사용할 브릿지 네트워크를 준비한다.

```
$ docker network ls
$ docker network create jenkins
$ docker network ls
```

### 젠킨스 도커 컨테이너 생성 및 실행

젠킨스 도커 이미지 가져오기

```
$ docker pull jenkins/jenkins:lts-jdk11
$ docker image ls
```

컨테이너 생성 및 실행하기

```
$ docker run --privileged -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure --name jenkins-jdk11 jenkins/jenkins:lts-jdk11
$ docker container ls
```

젠킨스 컨테이너를 재생성 할 때, 기존 젠킨스 볼륨을 제거하기

```
$ docker volume ls
$ docker volume rm jenkins_home
```

### 젠킨스 설정

젠킨스 잠금을 풀기 위해 관리자 암호 찾아서 넣기

```
$ docker logs jenkins-jdk11
```

젠킨스 플러그인 설치

```
"Install suggested plugins" 클릭
```

첫 번째 젠킨스 관리자 등록

```
계정명: jenkins
암호: 1111
암호확인: 1111
이름: jenkins
이메일주소: xxx@xxx.xxx
```

젠킨스 루트 URL 설정

```
http://localhost:8080
```

젠킨스 사용 시작!

### JDK 17 설치

root 사용자로 젠킨스 컨테이너에 접속하기

```
$ docker exec -itu 0 jenkins-jdk11 bash
/# apt-get update
/# apt-get install openjdk-17-jdk -y
```

### 젠킨스에 JDK 17 경로 등록

- Jenkins 관리
  - Global Tool Configuration
    - JDK
      - 'Add JDK' 클릭
        - Name: `openjdk-17`
        - JAVA_HOME: `/usr/lib/jvm/java-17-openjdk-amd64`
    - SAVE 클릭

### github.com의 프로젝트 연동

Dashboard

- 새로운 Item
  - Enter an item name: `myapp`
  - Freestyle project 클릭
  - OK 클릭
- 설정
  - General
    - 설명: `빌드 테스트1`
    - `GitHub project` 체크
      - Project url: `https://github.com/eomjinyoung/bitcamp-myapp.git`
  - 소스 코드 관리
    - `Git` 선택
      - Repository URL: `https://github.com/eomjinyoung/bitcamp-myapp.git`
      - Credentials: `username/token`
      - Branch Specifier: \*/main
  - 빌드 유발
    - `GitHub hook trigger for GITScm polling` 선택
  - Build Steps
    - `Invoke Gradle script` 선택
      - `Use Gradle Wrapper` 선택
        - `Make gradlew executable` 체크
        - Wrappter location: 비워둠
      - Tasks
        - `clean`
        - `build`
        - 입력
  - 저장
- `지금 빌드` 클릭
  - Console Output 확인
  - `docker exec -itu 0 jenkins-jdk11 bash` 접속

### github webhook 연동

- Repository/Settings/Webhooks
  - `Add webook` 클릭
    - Payload URL: `http://젠킨스서버주소:8080/github-webhook/`
    - Content type: `application/json`
    - 저장

## 도커 안에서 도커 사용하기

### DinD(Docker in Docker)

- `# docker run --privileged --name dind -d docker:stable-dind`
- `# docker exec -it dind /bin/ash`
