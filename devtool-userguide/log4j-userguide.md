# Log4j 사용법

## 프로젝트에 라이브러리 추가하기

- mvnrepository.com 에서 log4j 검색
- log4j 1.2.x 버전을 build.gradle에 추가
- 'gradle eclipse' 실행
- 프로젝트 리프래시

## 설정 파일 등록

- 루트 자바 패키지에 설정 파일 추가 : src/main/resources/log4j.properties

## log4j.properties 내용

### 루트 로거(기본 로깅 도구)를 설정

```
log4j.rootLogger=로깅레벨, 출력담당자1, 출력담당자2, 출력담당자3 ...
예)
log4j.rootLogger=ERROR, aaa, bbb, ccc, ...
```

#### 로깅 레벨

로깅 레벨은 다음 여섯 개 중 하나를 지정할 수 있다.

- FATAL : 애플리케이션을 중지해야 할 심각한 오류를 의미
- ERROR : 오류가 발생했지만, 애플리케이션을 계속 실행할 수 있는 상태를 의미
- WARN : 잠재적인 위험을 안고 있는 상태를 의미
- INFO : 애플리케이션의 진행 정보를 의미. 프로그램을 실행시키는 시스템 운영자를 위해 출력할 때 주로 사용한다.
- DEBUG : 애플리케이션의 내부 실행 상태를 의미. 프로그래밍 할 때 필요한 정보를 출력할 때 주로 사용한다.
- TRACE : DEBUG 보다 더 자세한 상태를 의미

루트 로거에 로깅 레벨을 지정하면 그 하위 로거들에 모두 적용된다.
하위 로거에 루트 로거의 레벨 대신 다른 레벨을 지정할 수 있다.

```
rootLogger = ERROR
  +-- com.eomcs.lms.dao = DEBUG
  |
  +-- com.eomcs.lms.handler (지정하지 않으면 루트 로거에 지정된 레벨을 사용한다)
```

#### 출력담당자(Appender)

한 개 이상이 출력 담당자를 지정할 수 있다.
담당자 이름은 마음대로 작성한다. 
이 담당자 이름으로 출력 방법을 자세하게 정의한다. 

 
### 출력 담당자(Appender) 설정하기

#### 출력 방법 지정

출력할 도구를 지정한다. 예를 들면, 파일이나 콘솔, 네트워크 등을 지정할 수 있다.

```
log4j.appender.출력담당자명=패키지명을 포함한 클래스명
예)
log4j.appender.aaa=org.apache.log4j.ConsoleAppender  <-- 콘솔 창으로 출력
log4j.appender.aaa=org.apache.log4j.FileAppender  <-- 파일로 출력
log4j.appender.aaa=org.apache.log4j.net.SocketAppender  <-- 원격 서버로 출력
```

#### 출력 형식 관리자 지정

출력할 때의 문자열 형식을 관리할 객체를 설정한다.

```
log4j.appender.출력담당자명.layout=패키지명을 포함한 클래스명
예)
log4j.appender.aaa.layout=org.apache.log4j.SimpleLayout (한 줄의 간단한 문자열 출력)
log4j.appender.aaa.layout=org.apache.log4j.HTMLLayout (HTML 테이블 형식으로 출력)
log4j.appender.aaa.layout=org.apache.log4j.PatternLayout (지정된 패턴 명령에 따라 출력)
log4j.appender.aaa.layout=org.apache.log4j.XMLLayout (XML 태그로 출력)
```

#### 출력 형식 지정

출력 문자열의 형식을 설정한다.

```
log4j.appender.출력담당자명.layout.ConversionPattern=패턴 명령
예)
log4j.appender.aaa.layout.ConversionPattern=%5p [%t] - %m%n
```

패턴 명령 

- %자릿수p : 등급(예: FATAL/ERROR/WARN/...)을 출력하고 싶을 때 사용한다.
- %t : 스레드 이름(예: main)을 출력하고 싶을 때 사용한다.
- %m : 로그 메시지를 출력하고 싶을 때 사용한다.
- %n : 줄 바꿀 때 사용한다.

### 하위 로거 설정

특정 이름의 로거나 특정 자바 패키지(또는 클래스)에 대해 출력 레벨을 설정할 수 있다.

```
log4j.logger.로거이름=레벨
log4j.logger.자바 패키지 이름=레벨
예)
log4j.logger.okok=DEBUG
log4j.logger.com.eomcs.lms.dao=DEBUG
log4j.logger.com.eomcs.lms.dao.BoardDao=DEBUG

```








