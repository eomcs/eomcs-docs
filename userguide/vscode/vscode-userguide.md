# VSCode 사용법

## 1. 플러그인 설치

1.1 Extension Pack for Java(Microsoft) 설치

- Language support for Java ™ for Visual Studio Code
- Debugger for Java
- Test Runner for Java
- Maven for Java
- Gradle for Java
- Project Manager for Java

## 2. Java 포맷터 사용하기

왜 필요한가?

- 사람이 스타일을 맞추려고 시간을 쓸 필요가 없음
- 팀원이 달라도 “딱 한 가지” 스타일로 통일됨. 즉, 팀 전체 코드 스타일이 자동으로 강제됨
- 코드 리뷰에서 “포매팅 언쟁”이 사라짐 → 오직 비즈니스 로직만 논의. 즉, “들여쓰기, 중괄호, 라인 길이” 같은 사소한 문제로 리뷰 시간을 낭비하지 않음
- PR에서 변경이 깔끔하게 보임 (불필요한 diff 제거)

### 2.1 IDE에 Google Java Format 적용하기

- [Google Java Format 사이트 참조](https://github.com/google/google-java-format)
  - [google-java-format-for-vs-code 확장 설치](https://marketplace.visualstudio.com/items?itemName=JoseVSeb.google-java-format-for-vs-code)
- `settings.json` 파일에 다음 설정 추가:

  ```json
  {
    // 저장할 때 포매팅 적용
    "editor.formatOnSave": true,

    // 100자 이상 넘어가는 라인에 가이드라인 표시
    "editor.rulers": [100],

    // VSCode Java 확장팩의 Built-in Formatter 비활성
    "java.format.enabled": false,

    // Google Java Format 확장팩을 기본 포매터로 설정
    "[java]": {
      "editor.defaultFormatter": "josevseb.google-java-format-for-vs-code"
    },

    // 저장할 때 import 문 정리
    "editor.codeActionsOnSave": {
      "source.organizeImports": "explicit"
    }
  }
  ```

### 2.2 Gradle 빌드 도구에 Google Java Format 적용하기

코드 포매팅을 자동화하고, 팀 전체에 강제하며, CI에서 검사해주는 최고의 포매팅 방법이다.

IDE 플러그인을 사용하는 경우의 문제점:

- google-java-format 플러그인을 IDE에 설치하는 것만으로는 강제력이 없다.
- 개발자가 “format on save"를 꺼버리면 규칙이 깨진다.
- IDE마다 포매팅 결과도 달라진다.

빌드 도구에 적용하는 이유:

- google-java-format을 자동으로 적용하고 강제할 수 있다
- 빌드 도구 수준에서 포맷팅을 강제할 수 있다.
  ```bash
  # Spotless 명령어 예시
  ./gradlew spotlessCheck   # 포매팅이 올바른지 검사
  ./gradlew spotlessApply   # 자동으로 포맷 수정
  ```
  - 이렇게 하면 팀원 모두가 동일한 formatter를 사용하게 된다.
- CI에서 코드 스타일을 강제해서, 스타일이 깨진 코드는 merge 자체를 막을 수 있다.
  ```bash
  # GitHub Actions, GitLab CI, Jenkins 등에서 다음을 수행:
  ./gradlew spotlessCheck
  ```
  - 실패하면 PR merge 불가
  - “포매팅은 자동 검사”
  - 개발자는 오직 로직에만 집중
  - 팀 코드 품질이 강제로 일정 수준 유지됨.
- IDE에 의존하지 않는 포매팅 환경 구축할 수 있다.
  - Gradle/Maven에서 일관성 보장
  - 개발자가 어떤 IDE 사용해도 동일한 결과
  - CI에서도 동일하게 동작
  - 즉, 100% IDE 불문 통일 포매팅 체계를 만들 수 있다.
- 포매팅뿐 아니라 린팅(정적 코드 규칙)도 함께 관리할 수 있다.
  - License header 체크
  - 파일 끝 개행 존재 여부
  - import 순서
  - whitespace 규칙
  - Kotlin/Go/SQL/Markdown 등 여러 언어 지원
  - 여러 도구를 따로 설치할 필요 없이, 하나의 플러그인으로 통합 관리된다.

#### 2.2.1 Gradle에 Spotless 플러그인 적용

```groovy
plugins {
  // Kotlin DSL(build.gradle.kts)에서 쓰는 스타일과도 호환되는 문법으로 작성
  id("com.diffplug.spotless") version "8.1.0"
}

// Spotless 플러그인은 설치만 하면 아무 일도 하지 않는다.
// 어떤 포매터를 사용할지 지정해야 한다.
spotless {
  java {
    // google-java-format을 사용하도록 지정
    googleJavaFormat()

    // 선택 사항:
    // import 순서 규칙을 지정할 수 있다.
    // importOrder()
  }
}
```

#### 2.2.4 Spotless 실행 방법

- 포매팅 검사:
  ```bash
  ./gradlew spotlessCheck
  ```
  - 포매팅이 올바르면 성공
  - 포매팅이 틀리면 실패 → CI에서 사용 가능
- 포매팅 자동 수정:
  ```bash
  ./gradlew spotlessApply
  ```

## 3. 정적 분석 도구 사용하기

왜 필요한가?

- 코드 리뷰 전에 자동으로 “문제 있는 부분”을 잡아줌
- 실무에서 발생하는 버그 중 20~30%는 정적 분석으로 예방 가능
- 리팩터링 시 큰 도움 → 안전한 변경을 유도

실무에서 자주 사용하는 도구들:
| 도구 | 역할 |
| -------------- | -------------------------------- |
| **Checkstyle** | 코드 스타일 및 규칙 강제 (이름 규칙, 메서드 길이 등) |
| **PMD** | 불필요한 코드, 사용하지 않는 변수, 안티패턴 탐지 |
| **SpotBugs** | 잠재적 버그 탐지 (NPE 가능성, 잘못된 동기화 등) |
| **Spotless** | formatter + lint 통합 관리 |

### 3.1 Checkstyle

#### 3.1.1 IDE에 적용하기

- [Checkstyle for VSCode 확장 설치](https://marketplace.visualstudio.com/items?itemName=shengchen.vscode-checkstyle)
  - Checkstyle 규칙 위반을 실시간으로 표시 → 실무에서 가장 자주 쓰는 VSCode Java lint 확장
- Checkstyle 설정 파일 지정
  - [Checkstyle 설정 파일 다운로드](https://raw.githubusercontent.com/checkstyle/checkstyle/master/src/main/resources/google_checks.xml)
    - 프로젝트 루트에 `checkstyle.xml` 파일명으로 저장
  - `checkstyle.xml` 파일에 대해 컨텍스트 메뉴에서 "Set as Checkstyle Configuration File" 선택
  - 또는 직접 `.vscode/settings.json` 파일에 다음 설정 추가:
    ```json
    {
      "checkstyle.configurationFile": "${workspaceFolder}/checkstyle.xml"
    }
    ```
- Checkstyle 버전 설정
  - VSCode 명령 팔레트 > "Checkstyle: Set the Checkstyle Version" 선택
    - JRE 17+ 경우: `11.x` 이상 선택
    - JRE 11+ 경우: `10.x` 선택
    - JRE 8+ 경우: `7.x`, `8.x`, `9.x` 선택
  - 또는 직접 `.vscode/settings.json` 파일에 다음 설정 추가:
    ```json
    {
      "java.checkstyle.version": "12.1.2"
    }
    ```

#### 3.1.2 Checkstyle 규칙 커스터마이징

- 이유?
  - Checkstyle의 구글 스타일 규칙은 너무 엄격하고, 자동 포맷터와 미묘하게 다름
  - google-java-format과 충돌하는 규칙이 다수 존재
  - 팀마다 코딩 스타일이 다르기 때문에 “맞춤형 규칙 파일”이 필요함
  - 네트워크 의존성 회피 (오프라인에서도 동작)
  - 규칙 파일을 Git 저장소에 보관할 수 있음
- `google-java-format`과 충돌이 발생하는 규칙은 제거
  - LineLength
  - CustomImportOrder
  - Indentation
  - WhitespaceAround
  - WhitespaceAfter
  - NoLineWrap
  - OperatorWrap
- 교과서스럽고 엄청 엄격해서 경고 폭탄을 맞을 수 있는, 실무에 맞지 않는 규칙은 제거
  - Javadoc을 과하게 강제하는 규칙들
  - 라인, 줄바꿈 스타일을 과하게 간섭하는 일부 규칙들
  - TODO 형식까지 강제하는 TodoComment 규칙 등
- 실무에 맞춰 편집한 [checkstyle.xml](checkstyle.xml) 파일 보기

#### 3.1.3 Gradle에 Checkstyle 플러그인 적용하기

- `build.gradle` 파일에 다음 내용 추가:
  ```groovy
  plugins {
    id 'checkstyle'
  }
  checkstyle {
    toolVersion = '12.1.2'  // Checkstyle 버전 지정
    configFile = file("${rootProject.projectDir}/config/checkstyle/checkstyle.xml")  // 규칙 파일 경로 지정
  }
  tasks.withType(Checkstyle) {
    reports {
      xml.required = false
      html.required = true  // HTML 리포트 생성
    }
  }
  ```

#### 3.1.4 Checkstyle 실행 방법

- 포매팅 검사:
  ```bash
  ./gradlew checkstyleMain   # 메인 소스 검사
  ./gradlew checkstyleTest   # 테스트 소스 검사
  ```
- 리포트 위치: `build/reports/checkstyle/`

### 3.2 SonarLint

- “코드를 이해하면서 버그/보안/냄새를 찾는 정적 분석기”
  - 사용은 하는데 의미 없는 조건, 항상 true/false인 if
  - NPE 가능성 높은 코드 패턴
  - 잘못된 equals/hashCode 구현
  - 잠재적 resource leak (스트림/파일 닫지 않음 등)
  - 보안 취약점 패턴 (하드코딩 비밀번호, 취약한 API 호출 등)
  - 복잡도 과도한 메서드, 중복 코드
- Checkstyle vs SonarLint
  - Checkstyle: 코드 스타일/모양/네이밍 경찰
  - SonarLint: 코드 품질/버그 사냥꾼
  - 둘 다 사용하면 시너지 효과 극대화 가능

#### 3.2.1 IDE에 적용하기

- [SonarLint for VSCode 확장 설치](https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode)
  - SonarQube/SonarCloud와 연동 가능
  - 실시간으로 코드 품질 문제 표시하는 IDE 전용 정적 분석기
  - 다양한 언어 지원 (Java, JavaScript, Python 등)
  - 실무에서 널리 사용되는 정적 분석 도구
  - 설치 후 별도 설정 없이 바로 사용 가능
- `settings.json` 파일에 다음 설정 추가:

  ```json
  {
    "sonarlint.analyzerProperties": {
      "sonar.java.source": "21" // 프로젝트 JDK 버전에 맞추기
    },

    // 너무 시끄러운 규칙 일부 비활성화 (원하는 경우)
    "sonarlint.rules": {
      "java:S106": { "level": "off" }, // System.out.println 사용 금지 규칙 끄기
      "java:S125": { "level": "off" } // 주석 안에 코드가 있어도 경고 끄기
    }
  }
  ```

### 3.3 PMD

PMD는 Java 코드에서 다음과 같은 문제를 검출하는 정적 분석 도구다.

- 사용되지 않는 변수 (UnusedLocalVariable)
- 의미 없는 조건
- 복잡도가 너무 높은 메서드
- 빈 catch 블록
- 잘못된 equals/hashCode
- 불필요한 객체 생성
- deprecated API 사용

#### 3.3.1 Gradle에 PMD 플러그인 적용하기

- `build.gradle` 파일에 다음 내용 추가:

  ```groovy
  plugins {
    id 'pmd'
  }
  pmd {
    consoleOutput = true    // 콘솔에 결과 표시
    toolVersion = "7.16.0"  // 원하는 PMD 최신 버전
    ignoreFailures = false  // 실패 시 빌드 실패 (true: 경고만 표시)

    // 실무에서는 기본 룰셋을 비활성화하고 커스컴 룰셋을 사용하는 것이 일반적이다.
    ruleSets = []           // 기본 룰셋 비활성화
    ruleSetFiles = files("${rootProject.projectDir}/config/pmd/ruleset.xml") // 커스텀 룰
  }

  tasks.withType(Pmd) {
    reports {
      xml.required = false
      html.required = true  // HTML 리포트 생성
    }
  }
  ```

#### 3.3.2 PMD 규칙 커스터마이징

- PMD 기본 룰셋은 너무 방대하고 시끄럽다. 실무에 맞게 커스터마이징 필요
- [PMD 공식 사이트](https://pmd.github.io/)에서 룰셋 문서 참고
- 실무에 맞게 편집한 [ruleset.xml](ruleset.xml) 파일 보기

#### 3.3.3 PMD 실행 방법

- PMD 검사 실행:
  ```bash
  ./gradlew pmdMain   # 메인 소스 검사
  ./gradlew pmdTest   # 테스트 소스 검사
  ```
- 리포트 위치: `build/reports/pmd/`

### 3.4 SpotBugs

Java 바이트코드를 분석해서 진짜 버그 가능한 코드를 잡아주는 정적 분석기이다. 컴파일러나 Checkstyle, PMD에서도 잡지 못하는 버그를 잡아준다. 즉, SonarLint/PMD보다 더 깊은 버그 탐지 능력을 갖는 도구다.

- NPE 위험
- 잘못된 equals/hashCode
- 무의미한 조건
- 리소스 누수(Streams, Closeable)
- dead store
- 불변 필드 문제

등을 매우 정확하게 잡는다.

#### 3.4.1 기대효과

“프로덕션 출시 후 사고 방지” 측면에서 매우 중요하다.
특히 다음과 같은 버그를 사전에 제거할 수 있다:

- NPE 기반 장애
- 비정상적인 스레드 경쟁으로 인한 Race Condition
- 잘못된 동기화
- 보안 취약점 가능성
- 해시 기반 자료구조의 오작동

개발 단계에서 SpotBugs를 돌리는 것은 “안전 장치” 같은 역할이다.

#### 3.4.2 Gradle에 SpotBugs 플러그인 적용하기

- `build.gradle` 파일에 다음 내용 추가:

  ```groovy
  plugins {
    id("com.github.spotbugs") version "6.4.5"
  }
  import com.github.spotbugs.snom.Effort
  import com.github.spotbugs.snom.Confidence
  spotbugs {
    // toolVersion = '4.9.8'  // SpotBugs 엔진 버전. 지정하지 않으면 플러그인에서 자동 선택
    ignoreFailures = false  // 실패 시 빌드 실패 (true: 경고만 표시)
    effort = Effort.valueOf("MAX")  // 분석 노력 수준 (min, default, max)
    reportLevel = Confidence.valueOf("MEDIUM")  // 보고서 수준 (high, default, low)
  }

  tasks.withType(com.github.spotbugs.snom.SpotBugsTask).configureEach {
    reports {
      xml.required = false
      html.required = true    // HTML 리포트 생성
    }
  }
  ```

- 보안 분석 플러그인(FindSecBugs) 추가 (선택 사항)
  ```groovy
  dependencies {
    spotbugsPlugins("com.h3xstream.findsecbugs:findsecbugs-plugin:1.14.0")
  }
  ```
  - 다음 취약점도 자동 분석된다:
    - SQL Injection
    - XXE
    - Command Injection
    - Hard-coded credentials
    - HTTP→HTTPS downgrade
    - 파일 경로 조작 공격
  - 보안 강화에는 사실상 필수 플러그인이다.

#### 3.4.3 SpotBugs 실행 방법

- SpotBugs 검사 실행:
  ```bash
  ./gradlew spotbugsMain   # 메인 소스 검사
  ./gradlew spotbugsTest   # 테스트 소스 검사
  ```
- 리포트 위치: `build/reports/spotbugs/`

## 4. build.gradle 예시 파일

- [build.gradle 예시 파일 보기](build.gradle)

## 5. CI (GitHub Actions, GitLab CI 등) 파이프라인

```bash
./gradlew clean
./gradlew spotlessCheck
./gradlew check
./gradlew build
```

- spotlessCheck 실패 → 포맷 안 맞는 코드가 있다는 뜻 (개발자가 spotlessApply 해야 함)
- check 실패 → Checkstyle/PMD/SpotBugs/test 중 하나에서 오류
- build → jar/war 생성

### 5.1 역할 정리:

- Spotless: 코드 모양을 자동으로 예쁘게 맞춰주는 포매터
- Checkstyle: 코딩 컨벤션 & 룰 위반 스타일 검사
- PMD: 나쁜 코드 패턴 / 코드 냄새 정적 분석
- SpotBugs: 바이트코드 기반으로 버그 가능성 높은 부분 탐지
- 개발할 때 → spotlessApply로 포맷 맞추고
- 검사/CI 할 때 → spotlessCheck, check (→ 내부적으로 Checkstyle/PMD/SpotBugs 등 실행)
- 최종 결과물 만들 때 → build

## 6. 단축키

### 6.1 auto indent

- Windows : Shift + Alt + F
- macOS : Shift + Option + F
- Ubuntu : Ctrl + Shift + I
