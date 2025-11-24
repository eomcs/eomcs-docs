# Gradle 프로젝트 설정

실무에서 자주 사용하는 도구들:
| 도구 | 역할 |
| -------------- | -------------------------------- |
| **Spotless** | formatter + lint 통합 관리 |
| **Checkstyle** | 코드 스타일 및 규칙 강제 (이름 규칙, 메서드 길이 등) |
| **PMD** | 불필요한 코드, 사용하지 않는 변수, 안티패턴 탐지 |
| **SpotBugs** | 잠재적 버그 탐지 (NPE 가능성, 잘못된 동기화 등) |

## 1. Java 포맷터 사용하기

왜 필요한가?

- 사람이 스타일을 맞추려고 시간을 쓸 필요가 없음
- 팀원이 달라도 “딱 한 가지” 스타일로 통일됨. 즉, 팀 전체 코드 스타일이 자동으로 강제됨
- 코드 리뷰에서 “포매팅 언쟁”이 사라짐 → 오직 비즈니스 로직만 논의. 즉, “들여쓰기, 중괄호, 라인 길이” 같은 사소한 문제로 리뷰 시간을 낭비하지 않음
- PR에서 변경이 깔끔하게 보임 (불필요한 diff 제거)

### 1.1 Gradle 빌드 도구에 Google Java Format 적용하기

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

### 1.2 Gradle에 Spotless 플러그인 적용

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

### 1.3 Spotless 실행 방법

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

## 2. 정적 분석 도구 사용하기

왜 필요한가?

- 코드 리뷰 전에 자동으로 “문제 있는 부분”을 잡아줌
- 실무에서 발생하는 버그 중 20~30%는 정적 분석으로 예방 가능
- 리팩터링 시 큰 도움 → 안전한 변경을 유도

### 2.1 Checkstyle

Checkstyle은 팀의 코드 스타일 규칙을 자동으로 강제하여
코드 리뷰 부담을 줄이고, 유지보수성을 높이고, 개발자 간 일관성을 만들어주는 도구다.

- 팀/회사/프로젝트에서 코드 스타일을 통일하기 위해
  - 사람마다 코드를 쓰는 스타일은 모두 다르다.
    - 어떤 사람은 if (...) 뒤에 줄바꿈을 함
    - 어떤 사람은 `{` 를 다음 줄에 씀
    - 어떤 사람은 indent 2칸, 어떤 사람은 4칸
  - 팀 코드가 제멋대로가 되고, 전체 코드 품질이 급격히 떨어짐
- 코드 리뷰에서 사소한 스타일 문제를 제거하기 위해
  - “여기 줄 끝에 공백 있어요.”
  - “import 순서 맞춰주세요.”
  - “괄호 정렬이 틀렸어요.”
  - 이런 피곤한 코멘트들이 코드 스타일 문제이다.
  - 이 문제를 Checkstyle이 미리 잡아주면,
    - 코드 리뷰에서는 “비즈니스 로직”에만 집중할 수 있게 된다.
- 빌드 단계에서 규칙 위반을 자동으로 차단하기 위해
  - 규칙 위반이 있으면 빌드 실패 → 잘못된 스타일이 merge 불가
  - PR이 merge되기 전에 자동 필터링이 된다는 의미
- 장기 프로젝트의 코드 품질 유지를 위해
  - 개발자마다 스타일이 달라지면서 유지보수가 어려워진다.
  - 특정 규칙이 안 지켜지는 파일들이 생긴다.
  - 코드 구조가 섞이고 가독성이 떨어진다
- 자동 포매터(google-java-format)로는 부족한 영역을 보완하기 위해
  - 구글 포매터(google-java-format)나 IDE 포매터는 **“코드 모양”**만 신경 쓴다.
  - Checkstyle은 구조적 규칙도 강제할 수 있다:
    - switch 문에 default가 있는지
    - 메서드 길이 제한
    - 클래스 내부 선언 순서(필드 → 생성자 → 메서드)
    - Javadoc 여부
    - 변수/메서드/클래스 이름 패턴
    - 별표 import 금지
    - 빈 블록 방지 등
    - 자동 포매터 + Checkstyle의 조합이 가장 강력하다.
- 인수인계 시에도 코드 품질을 유지할 수 있다
  - 팀원이 바뀌어도:
    - “이 팀의 스타일은 이런 것이고”
    - “이 규칙에 맞춰야 한다”
    - “코드를 작성하면 자동으로 Checkstyle이 감지해준다”
  - 이런 구조라 팀에 새로 들어온 사람도 코드 품질을 자동으로 맞출 수 있음.

#### 2.1.1 Checkstyle 규칙 파일

Checkstyle이 개발자의 코드를 검사할 때 적용할 모든 규칙을 정의한 문서이다.즉, Checkstyle이 “코드를 어떤 기준으로 검사할지” 정의한 XML 형식의 규칙(규약) 설정 파일이다.

Checkstyle이 검사할 “코드 스타일 규칙 목록”:

- 들여쓰기 방식
- 중괄호 위치({})
- 줄 길이 제한(LineLength)
- import 순서
- 변수/메서드/클래스 이름 규칙
- 빈 줄/공백 규칙
- Javadoc 규칙
- switch / for / if 규칙
- 불필요한 공백, 빈 블록 검사
- 클래스 구조(필드-생성자-메서드) 순서

어떤 규칙을 켜고/끄는지 결정:

- `<module name="LineLength">`
- `<module name="MethodName">`
- `<module name="LeftCurly">`
- `<module name="NeedBraces">`
- `<module name="UnusedImports">` 등등…

팀/회사/프로젝트마다 규칙이 다르기 때문에, “Checkstyle 규칙 파일을 팀 규칙 파일”이라고도 부른다.

#### 2.1.2 Checkstyle 규칙 파일 예시

- [Checkstyle 공식 구글 스타일 규칙 파일](https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml)

#### 2.1.3 실무용 Checkstyle 규칙 파일 만들기

구글 스타일 규칙 파일을 편집하여 사용한다.

이유?

- Checkstyle의 구글 스타일 규칙은 너무 엄격하고, 자동 포맷터와 미묘하게 다름
- google-java-format과 충돌하는 규칙이 다수 존재
- 팀마다 코딩 스타일이 다르기 때문에 “맞춤형 규칙 파일”이 필요함
- 네트워크 의존성 회피 (오프라인에서도 동작)
- 규칙 파일을 Git 저장소에 보관할 수 있음

`google-java-format`과 충돌이 발생하는 규칙은 제거:

- LineLength
- CustomImportOrder
- Indentation
- WhitespaceAround
- WhitespaceAfter
- NoLineWrap
- OperatorWrap

교과서스럽고 엄청 엄격해서 경고 폭탄을 맞을 수 있는, 실무에 맞지 않는 규칙은 제거:

- Javadoc을 과하게 강제하는 규칙들
- 라인, 줄바꿈 스타일을 과하게 간섭하는 일부 규칙들
- TODO 형식까지 강제하는 TodoComment 규칙 등

실무에 맞춰 편집한 [checkstyle.xml](checkstyle.xml) 파일 보기

#### 2.1.4 Gradle에 Checkstyle 플러그인 적용하기

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

#### 2.1.5 Checkstyle 실행 방법

- 포매팅 검사:
  ```bash
  ./gradlew checkstyleMain   # 메인 소스 검사
  ./gradlew checkstyleTest   # 테스트 소스 검사
  ```
- 리포트 위치: `build/reports/checkstyle/`

### 2.2 PMD

PMD는 Java 코드에서 다음과 같은 문제를 검출하는 정적 분석 도구다.

- 사용되지 않는 변수 (UnusedLocalVariable)
- 의미 없는 조건
- 복잡도가 너무 높은 메서드
- 빈 catch 블록
- 잘못된 equals/hashCode
- 불필요한 객체 생성
- deprecated API 사용

#### 2.2.1 Gradle에 PMD 플러그인 적용하기

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

#### 2.2.2 PMD 규칙 커스터마이징

- PMD 기본 룰셋은 너무 방대하고 시끄럽다. 실무에 맞게 커스터마이징 필요
- [PMD 공식 사이트](https://pmd.github.io/)에서 룰셋 문서 참고
- 실무에 맞게 편집한 [ruleset.xml](ruleset.xml) 파일 보기

#### 2.2.3 PMD 실행 방법

- PMD 검사 실행:
  ```bash
  ./gradlew pmdMain   # 메인 소스 검사
  ./gradlew pmdTest   # 테스트 소스 검사
  ```
- 리포트 위치: `build/reports/pmd/`

### 2.3 SpotBugs

Java 바이트코드를 분석해서 진짜 버그 가능한 코드를 잡아주는 정적 분석기이다. 컴파일러나 Checkstyle, PMD에서도 잡지 못하는 버그를 잡아준다. 즉, SonarLint/PMD보다 더 깊은 버그 탐지 능력을 갖는 도구다.

- NPE 위험
- 잘못된 equals/hashCode
- 무의미한 조건
- 리소스 누수(Streams, Closeable)
- dead store
- 불변 필드 문제

등을 매우 정확하게 잡는다.

#### 2.3.1 기대효과

“프로덕션 출시 후 사고 방지” 측면에서 매우 중요하다.
특히 다음과 같은 버그를 사전에 제거할 수 있다:

- NPE 기반 장애
- 비정상적인 스레드 경쟁으로 인한 Race Condition
- 잘못된 동기화
- 보안 취약점 가능성
- 해시 기반 자료구조의 오작동

개발 단계에서 SpotBugs를 돌리는 것은 “안전 장치” 같은 역할이다.

#### 2.3.2 Gradle에 SpotBugs 플러그인 적용하기

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

#### 2.3.3 SpotBugs 실행 방법

- SpotBugs 검사 실행:
  ```bash
  ./gradlew spotbugsMain   # 메인 소스 검사
  ./gradlew spotbugsTest   # 테스트 소스 검사
  ```
- 리포트 위치: `build/reports/spotbugs/`

## 3. build.gradle 예시 파일

- [build.gradle 예시 파일 보기](build.gradle.sample)

## 4. CI (GitHub Actions, GitLab CI 등) 파이프라인

```bash
./gradlew clean
./gradlew spotlessCheck
./gradlew check
./gradlew build
```

- spotlessCheck 실패 → 포맷 안 맞는 코드가 있다는 뜻 (개발자가 spotlessApply 해야 함)
- check 실패 → Checkstyle/PMD/SpotBugs/test 중 하나에서 오류
- build → jar/war 생성

### 4.1 역할 정리:

- Spotless: 코드 모양을 자동으로 예쁘게 맞춰주는 포매터
- Checkstyle: 코딩 컨벤션 & 룰 위반 스타일 검사
- PMD: 나쁜 코드 패턴 / 코드 냄새 정적 분석
- SpotBugs: 바이트코드 기반으로 버그 가능성 높은 부분 탐지
- 개발할 때 → spotlessApply로 포맷 맞추고
- 검사/CI 할 때 → spotlessCheck, check (→ 내부적으로 Checkstyle/PMD/SpotBugs 등 실행)
- 최종 결과물 만들 때 → build
