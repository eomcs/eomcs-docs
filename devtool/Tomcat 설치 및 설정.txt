# 톰캣 설치 및 설정

## 톰캣 서버 설치

- tomcat.apache.org 사이트에서 zip 파일을 내려 받는다.
- 특정 폴더에 압축을 푼다.
- 설치형이 아니다.
- Java로 만들었기 때문에 JRE 또는 JDK가 설치되어 있어야 한다.

## 톰캣 서버 설정

### 서버 포트 번호 변경

- $TOMCAT_HOME/conf/server.xml 변경
  - Connector 태그의 port 값을 8080에서 원하는 값으로 변경한다.
  - 예) Connector port="9999"...
  
## tomcat 관리자 아이디 등록하기

- $TOMCAT_HOME/conf/tomcat-users.xml 파일에 role 및 user 추가

```
  <role rolename="tomcat"/>
  <role rolename="manager-gui"/>
  <role rolename="admin-gui"/>

  <user username="tomcat" password="1111" roles="tomcat,manager-gui,admin-gui"/>
```

- $TOMCAT_HOME/conf/Catalina/localhost 폴더에 manager.xml 파일 추가하고 다음과 같이 작성한다.

```
<?xml version="1.0" encoding="UTF-8"?>
<Context privileged="true" antiResourceLocking="false"
         docBase="${catalina.home}/webapps/manager">
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="^.*$" />
</Context>

```

## 톰캣 서버 실행

- $TOMCAT_HOME/bin/startup.bat 실행(Windows)
- $TOMCAT_HOME/bin/startup.sh 실행(Unix/Linux)