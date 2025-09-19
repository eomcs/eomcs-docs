# 백엔드 프로젝트

## 프로젝트 설정

### 스프링부트 설정 파일을 개발과 운영으로 분리

- application.properties 파일 분리
  - application-dev.properties (개발)
  - application-prod.properties (운영)
- 실행 방법
  - 환경변수를 통해 설정
    - 예) `$ export SPRING_PROFILES_ACTIVE=dev`
    - 예) `$ gradle bootRun`
    - 예) `$ java -jar hello-api.jar`
  - JVM 아규먼트: `-Dspring.profiles.active=dev`
    - 예) `$ java -Dspring.profiles.active=prod -jar hello-api.jar`
  - 프로그램 아규먼트: `--spring.profiles.active=dev`
    - 예) `$ java -jar hello-api.jar --spring.profiles.active=prod`
    - 예) `$ gradle bootRun --args='--spring.profiles.active=dev'`
  - IntelliJ : 환경변수를 통해 설정한다.
    - bootRun -> 구성 -> 편집: spring.profiles.active=dev

### 서버 포트 번호 설정

- 실행 방법
  - 환경변수를 통해 설정할 수 있다.
    - 예) `$ export $SERVER_PORT=9090`
    - 예) `$ gradle bootRun`
    - 예) `$ java -jar hello-api.jar`
  - JVM 아규먼트: `-Dserver.port=9090`
    - 예) `$ java -Dserver.port=9090 -jar hello-api.jar`
  - 프로그램 아규먼트: `--server.port=9090`
    - 예) `$ java -jar hello-api.jar --server.port=9090`
    - 예) `$ gradle bootRun --args='--server.port=9090'`

### .env 파일에 환경 변수 설정한 후 application.properties 에 적용하기

- `.env` 파일에 환경 변수를 등록한다.

```properties
...
NCP_ENDPOINT=https://k...
NCP_REGIONNAME=kr-s...
NCP_ACCESSKEY=8...
NCP_SECRETKEY=ma...
NCP_BUCKETNAME=b...

# JDBC
JDBC_URL=jdbc:mysql://db-...
JDBC_USERNAME=st...
JDBC_PASSWORD=b...
JDBC_DRIVER=co...
```

- `application.properties` 파일에서 사용하기

```properties
...
server.port=${SERVER_PORT:9090}
...
spring.datasource.driver-class-name=${JDBC_DRIVER}
spring.datasource.url=${JDBC_URL}
spring.datasource.username=${JDBC_USERNAME}
spring.datasource.password=${JDBC_PASSWORD}

# Naver Cloud Platform
ncp.end-point=${NCP_ENDPOINT}
ncp.region-name=${NCP_REGIONNAME}
ncp.access-key=${NCP_ACCESSKEY}
ncp.secret-key=${NCP_SECRETKEY}
ncp.bucket-name=${NCP_BUCKETNAME}
...
```

- `app/build.gradle` 에서 `.env` 로딩하기

```gradle
...
// .env 파일 로딩 함수
def loadEnvIntoBootRunEnvironment(String path = ".env") {
    def envFile = rootProject.file(path)
    if (!envFile.exists()) {
        println ".env file not found: $path"
        return [:]
    }

    def envVars = [:]
    envFile.eachLine { line ->
        line = line.trim()
        if (!line || line.startsWith("#")) return

        def (key, value) = line.split("=", 2)
        key = key.trim()
        value = value.trim().replaceAll('^"|"$', '') // 양쪽 큰따옴표 제거
        envVars[key] = value
    }
    return envVars
}

bootRun {
    // .env 파일에서 환경 변수 읽어와 설정
    environment loadEnvIntoBootRunEnvironment()

    // 필요 시 인코딩 설정
    jvmArgs = ["-Dfile.encoding=UTF-8"]
}
...
```

## 빌드 및 실행

### Gradle 로 실행

```bash
./gradlew bootRun --args='--spring.profiles.active=dev --server.port=9090'
```

### Java 로 직접 실행

```bash
./gradlew bootJar
export $(grep -v '^#' .env | xargs) # .env 파일에 등록된 환경변수를 OS에 등록하기
java -jar ./app/build/libs/hello-api.jar --spring.profiles.active=dev --server.port=9090
```
