# 개발 도구 준비

## 보조 편집기 설치

- VisualStudio Code 또는 Atom 등 기본 에디터 설치

## 패키지 관리자 설치

- 리눅스
  - 기존의 apt 사용
- macOS
  - Homebrew 설치 후 사용
- Windows 
  - Scoop 설치 후 사용

## 자바 제품
- Java SE
    - JRE(Java Runtime Environment)
        - 바이트코드를 실행하는 JVM이 있다.
        - 자바에서 기본으로 제공하는 클래스 라이브러리가 있다.
    - Server JRE
        - JRE에서 윈도우 프로그래밍 관련 기능을 제거한다.
        - 대신 서버에 필요한 기능을 추가로 제공한다.
    - JDK(Java Development Kit)
        - JRE + 개발 도구(컴파일러, 디버거, 프로파일러, 자바문서생성기 등)
- Java EE
    - 기업에서 사용할 때 필요한 기술을 제공한다.
    - 분산컴퓨팅 기술(EJB), 웹 기술(Servlet/JSP), 웹서비스, 기타 관리 기술 
- Java ME
    - 임베디드 프로그램을 개발할 때 필요한 기술을 제공한다.

## JDK 설치 
- JDK 종류
  - Oracle JDK
  - OpenJDK
  - GraalVM(OpenJDK + 기타)
- JDK 다운로드 및 설치
- JDK가 설치된 디렉토리 경로를 OS에 JAVA_HOME 이라는 환경변수로 등록한다. 
- OS 환경변수 PATH에 JDK의 실행 파일이 들어 있는 경로를 추가한다.

## VisualStudio Code 설치

## 형상 관리 도구 설치 - git 클라이언트
- https://git-scm.com/ 사이트에서 CLI 버전 다운로드.
- 압축 해제 후 환경 변수 PATH에 $GIT_HOME/bin 등록

## github.com 에서 수업 자료 가져오기
```
$ git clone [깃허브 저장소 URL]
```
- 자바 예제 : https://github.com/eomcs/eomcs-java.git
- 실습 프로젝트 : https://github.com/eomcs/eomcs-java-project.git
- 일반 참고 문서 : https://github.com/eomcs/eomcs-docs.git 

## github.com에 프로그래밍 실습 저장소 준비
  - 회원가입
  - 저장소 생성
  - 로컬에 저장소 복제

## 기본 Java IDE 'Eclipse IDE' 설치  
- eclipse.org 에서 다운로드하여 설치
- 이클립스 실행 할 때 workspace 폴더 선택 
    - 예) /home/사용자홈/eclipse-workspace
- workspace 설정
  - 워크스페이스 폴더 마다 설정해야 한다.
  - 즉 워크스페이스 폴더를 새로 지정하면 설정도 새로 해야 한다.
  - 메뉴 / Windows / Preferences 클릭 
  - 1) General/Apearance/Colors and Fonts
    - Basic/Text Font를 자신의 취향에 맞춰 설정한다.
  - 2) General/Editors/Text Editors
    - Displayed tab width : 2
    - Insert spaces for tabs 체크
      - Remove multiple spaces on backspace/delete
    - Show print margin 체크 
      - print margin column : 100
    - Show white space characters 체크
      - configure visibility 링크 클릭 
        - 스페이스 문자가 삽입된 것을 표시.
        - 엔터키(CR/LF) 입력 표시하지 말 것
        - 투명도(transparency level) : 30
  - 3) General/Workspace
    - Text file encoding을 UTF-8로 설정할 것.
    - New text file line delimiter를 Unix 방식으로 설정할 것.
  - 4) Java/Code Style/Formatter
    - Eclipse java google style 포맷터 다운로드
      - https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
    - Active profile 에서 구글 스타일 포맷터 임포트하기
  - 5) Java/Editor/Save Actions
    - Performed selected action.. 체크
      - Additional actions 체크
        - Configure 버튼 클릭
        - Code Organizing 탭/Correct Indentation 체크
  - 6) Java/Installed JRE
    - JDK 홈 폴더가 등록되어 있지 않았다면 추가한다.
  - 7) Web
    - CSS Files : Encoding을 UTF-8로 설정한다.
    - HTML Files : Encoding을 UTF-8로 설정한다.
    - JSP Files : Encoding을 UTF-8로 설정한다.

## 빌드 도구 설치 - gradle
- https://gradle.org/ 사이트에서 다운로드.
- 압축 해제 후 환경 변수 PATH에 $GRADLE_HOME/bin 등록

## Eclipse로 프로젝트 폴더를 가져오기 
- File / Import... 메뉴 선택
  - General / Existing projects into Workspace 선택 
  - Import Projects 창 
    - Select root directory에서 디렉토리 찾은 후 프로젝트 디렉토리 선택
    - 프로젝트 폴더에 eclipse 용 프로젝트 정보 파일이 있어야만 임포트 할 수 있다.
      - .project 파일
        - 프로젝트 정보를 담은 파일. 
        - 이클립스는 이 파일의 정보를 가지고 프로젝트 및 메뉴를 설정한다.
      - .settings/
        - Eclipse IDE의 플러그인 설정 파일이 들어 있는 폴더
      - .classpath 파일
        - 자바 프로젝트인 경우 존재하는 파일이다.
        - 프로젝트에서 사용할 자바 라이브러리 파일의 경로 정보를 갖고 있다.
- eclipse 정보 파일이 없을 경우
  - Gradle 도구를 이용하여 프로젝트 폴더에 이클립스가 사용할 설정 파일을 만든다.
  - 절차
    - 1) build.gradle 파일의 plugins {} 안에 'eclipse' 플러그인 을 추가한다.
      - 예) id 'eclipse'
    - 2) eclipse 설정 파일을 생성한다.
      - 터미널에서  `gradle eclipse` 실행한다.
      - .settings/, .classpath, .project 등이 생성된다. 

## 서블릿 컨테이너 설치 - Tomcat 
- https://tomcat.apache.org/ 사이트에서 다운로드.
- 압축 해제 후 환경 변수 PATH에 $CATALINA_HOME/bin 등록
- 이클립스에 서블릿 컨테이너 등록
    - Eclipse/preferences/Server/Runtime Environments: 톰캣 서버 등록

## DBMS 설치 - MariaDB
- https://mariadb.org/ 사이트에서 다운로드 및 설치.
- 환경 변수 PATH에 $MARIADB_HOME/bin 폴더 추가.