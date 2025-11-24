# Gradle 사용법

## 빌드 도구의 역할 이해

- 프롬프트
  ```text
  빌드 도구에 대해 간단히 설명해줘.
  ```

## Ant vs Maven vs Gradle 비교

- 프롬프트:
  ```text
  Ant 빌드 도구가 있었는데 Maven이 등장하였다. 그 이후에 Gradle이 등장하였다. 새로운 도구가 등장했다는 것은 이전 도구의 단점을 극복하기 위함일 것이다. 이 부분을 비교하여 설명해줘.
  ```

## Gradle 빌드 도구 설치

- [Gradle 다운로드](https://gradle.org/install/)
- Gradle 설치 후 환경 변수 설정
  - `GRADLE_HOME` 변수 설정: Gradle 설치 경로를 지정
  - `PATH` 변수에 `%GRADLE_HOME%\bin` 추가
- Gradle 설치 확인
  ```bash
  gradle -v
  ```

## gradle init

gradle 관련 폴더와 설정파일을 자동으로 생성한다.

- Gradle 프로젝트 생성

  ```bash
  $ gradle init
  Starting a Gradle Daemon (subsequent builds will be faster)

  Select type of build to generate:
    1: Application
    2: Library
    3: Gradle plugin
    4: Basic (build structure only)
  Enter selection (default: Application) [1..4] 1

  Select implementation language:
    1: Java
    2: Kotlin
    3: Groovy
    4: Scala
    5: C++
    6: Swift
  Enter selection (default: Java) [1..6] 1

  Enter target Java version (min: 7, default: 21):

  Project name (default: lab03): myapp

  Select application structure:
    1: Single application project
    2: Application and library project
  Enter selection (default: Single application project) [1..2] 1

  Select build script DSL:
    1: Kotlin
    2: Groovy
  Enter selection (default: Kotlin) [1..2] 2

  Select test framework:
    1: JUnit 4
    2: TestNG
    3: Spock
    4: JUnit Jupiter
  Enter selection (default: JUnit Jupiter) [1..4]

  Generate build using new APIs and behavior (some features may change in the next minor release)? (default: no) [yes, no]
  ```

- Gradle 로 생성한 디렉토리 구조
  ```bash
  $ tree
  .
  ├── app
  │   ├── build.gradle
  │   └── src
  │       ├── main
  │       │   ├── java
  │       │   │   └── org
  │       │   │       └── example
  │       │   │           └── App.java
  │       │   └── resources
  │       └── test
  │           ├── java
  │           │   └── org
  │           │       └── example
  │           │           └── AppTest.java
  │           └── resources
  ├── gradle
  │   ├── libs.versions.toml
  │   └── wrapper
  │       ├── gradle-wrapper.jar
  │       └── gradle-wrapper.properties
  ├── gradle.properties
  ├── gradlew
  ├── gradlew.bat
  └── settings.gradle
  ```
  - .gradle 폴더
    - gradle을 실행할 때 사용하는 관련 파일들을 모아둔 폴더이다.
  - gradle 폴더
    - gradle 실행 파일을 둔 폴더이다.
  - build.gradle
    - gradle 설정 파일
  - gradlew(unix/linux 용), gradlew.bat(windows 용)
    - 사용자 PC에 gradle을 자동으로 다운로드 받아 설치하고 실행한다.
    - 즉 사용자 PC에 gradle이 설치되어 있지 않아도 실행할 수 있다.
  - settings.gradle
    - gradle 실행할 때 참조하는 정보가 들어 있다.
- 프롬프트
  ```text
  다음은 Gradle로 생성한 자바 애플리케이션 프로젝트의 디렉토리 구조다. 각 디렉토리와 파일의 역할을 설명해줘.
  (tree 명령어로 출력한 디렉토리 구조를 붙여넣기)
  ```

### gradle init --type [프로젝트타입]

지정한 유형에 맞춰 프로젝트 폴더 및 기본 파일들을 자동으로 생성한다.

## Gradle 빌드 도구 사용법

- Gradle Wrapper 사용
  - Gradle Wrapper는 프로젝트에 포함된 `gradlew` 스크립트와 `gradle/wrapper/gradle-wrapper.jar` 파일로 구성됩니다.
  - Gradle Wrapper를 사용하면 다음과 같은 장점이 있습니다:
    - 개발자가 Gradle을 별도로 설치할 필요가 없습니다.
    - Gradle Wrapper를 사용하여 빌드를 실행하면, Gradle 버전이 자동으로 다운로드되고 설정됩니다.
    - 프로젝트에 포함된 Gradle 버전을 사용하므로, 개발 환경에 따라 Gradle 버전이 달라지는 문제를 방지할 수 있습니다.
    - 즉 모든 팀원이 빌드 환경을 일관되게 유지할 수 있습니다.
- Gradle Wrapper 생성:
  ```bash
  gradle wrapper --gradle-version 8.14.3
  ```
- Gradle 을 사용하여 수행할 수 있는 작업 목록 확인:

  ```bash
  ./gradlew tasks

  # gradle로 사용할 수 있는 모든 작업을 출력한다.
  ./gradlew tasks --all
  ```

- 자바 소스 코드 컴파일:
  ```bash
  ./gradlew compileJava
  ```
- 자바 리소스 파일 처리:
  ```bash
  ./gradlew processResources
  ```
- 자바 애플리케이션 컴파일 및 리소스 처리 = `compileJava` + `processResources`:
  ```bash
  ./gradlew classes
  ```
- 단위 테스트 소스 파일 컴파일:
  ```bash
  ./gradlew compileTestJava
  ```
- 단위 테스트 리소스 파일 처리:
  ```bash
  ./gradlew processTestResources
  ```
- 자바 애플리케이션 실행:
  ```bash
  # 단순 실행
  ./gradlew run
  # 디버그 모드로 실행
  ./gradlew run --debug
  # 실행 계획만 확인
  ./gradlew run --dry-run
  # 실행 시 콘솔 출력 상세 모드
  ./gradlew run --console=verbose
  # 실행 시 콘솔 출력 상세 모드 + 정보 출력
  ./gradlew run --info --console=verbose
  # Gradle 실행 로그를 최소화하여 출력. 즉 애플리케이션 출력에 집중
  ./gradlew run --quiet
  # Gradle 실행 로그를 최소화하여 출력. 색상 빼고 단순 텍스트로 출력
  ./gradlew run --quiet --console=plain
  ```
- 테스트 실행:
  ```bash
  ./gradlew test
  ```
- JAR 파일(app.jar) 생성:
  ```bash
  ./gradlew jar --console=plain
  ```
- 전체 빌드 실행:
  ```bash
  ./gradlew build --console=plain
  ```

## Gradle 플러그인

gradle로 실행할 수 있는 작업들을 모아둔 라이브러리이다.

플러그인을 추가하는 방법: build.gradle 파일에 다음 설정을 추가한다.

```
방법1:
apply plugin: '플러그인명'

방법2:
plugins {
    id '플러그인명'
}
```

### 'java' 플러그인

```
> gradle compileJava
```

- build/classes/java/main 폴더를 생성한다.
- src/main/java 폴더의 모든 자바 소스 파일을 컴파일하여 위에서 생성한 폴더에 넣는다.

```
> gradle clean
```

- build 폴더를 제거한다.

```
> gradle processResources
```

- build/resources/main 폴더를 생성한다.
- src/main/resources 폴더의 모든 파일을 복사하여 위의 폴더에 넣는다.

```
> gradle classes
```

- compileJava + processResources 작업 수행

```
> gradle compileTestJava
```

- classes 작업을 먼저 수행
- build/classes/java/test 폴더를 생성한다.
- src/test/java 폴더의 모든 자바 소스 파일을 컴파일하여 위에서 생성한 폴더에 넣는다.

```
> gradle processTestResources
```

- build/resources/test 폴더를 생성한다.
- src/test/resources 폴더의 모든 파일을 복사하여 위의 폴더에 넣는다.

```
> gradle testClasses
```

- compileTestJava + processTestResources 작업을 수행

```
> gradle test
```

- testClasses 작업을 수행
- build/classes/test 폴더에 있는 테스트 관련 클래스를 모두 실행한다.

```
> gradle jar
```

- classes 작업 수행
- build/libs 폴더 생성
- 자바 클래스 파일과 기타 자원 파일을 .jar 파일에 묶는다. 그리고 위의 폴더로 복사한다.

### 'application' 플러그인

자바 프로그램을 실행할 수 있는 작업이 들어 있다.

```
gradle run
```

- classes 작업을 먼저 수행한다.
- mainClassName에 지정된 자바 클래스를 실행한다.

### 'eclipse' 플러그인

이클립스 IDE 관련 설정 파일을 다루는 작업들이 들어 있다.

```
> gradle eclipseClasspath
```

- .classpath 파일 생성

```
> gradle eclipseProject
```

- .project 파일 생성

```
> gradle eclipseJdt
```

- JDT(Java Developement Tool)관련 설정 파일 및 폴더 생성
- .settings 폴더 및 파일 생성

```
> gradle eclipse
```

- eclipseClasspath + eclipseProject + eclipseJdt 작업 수행

```
> gradle cleanEclipseClasspath
```

- .classpath 파일 삭제

```
> gradle cleanEclipseProject
```

- .project 파일 삭제

```
> gradle cleanEclipseJdt
```

- .settings 폴더의 파일 삭제

```
> gradle cleanEclipse
```

- cleanEclipseClasspath + cleanEclipseProject + cleanEclipseJdt 작업 수행
