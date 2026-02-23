# AI 코딩 에이전트를 활용한 코드 리뷰 전문가 교육 과정

> **커리큘럼 (80시간 / 10일)**

---

## 1. 과정 개요

AI 코딩 에이전트를 활용한 코드 리뷰 전문가 교육 과정은 클린 코드, 리팩토링, TDD의 핵심 이론과 실습을 기반으로, AI 코딩 에이전트를 활용한 코드 리뷰 자동화 및 품질 개선 역량을 키우는 실무 중심 과정입니다.

### 1.1 교육 목표

- 클린 코드 원칙에 기반한 객관적 코드 품질 기준 확립
- 리팩토링 기법을 통한 기존 코드의 구조적 개선 역량 확보
- TDD 방법론과 JUnit 5 기반 테스트 설계 능력 습득
- AI 코딩 에이전트를 활용한 코드 리뷰 자동화 시스템 구축 및 운영

### 1.2 교재

- 로버트 C 마틴, 『Clean Code』
- 마틴 파울러, 『Refactoring: Improving the Design of Existing Code』
- 켄트 벡, 『Test-Driven Development by Example』
- 『JUnit in Action』 (3rd Edition)

### 1.3 수강 대상 및 사전 요구사항

본 과정은 실무 개발 경험이 있는 개발자를 대상으로 하며, 다음의 사전 역량이 필요합니다.

- Java 프로그래밍 및 Spring Boot 기반 개발 경험 (1년 이상 권장)
- Git / GitHub 사용 능력 (Branch, PR, Merge 워크플로우 이해)
- CI/CD 기본 개념 이해 (GitHub Actions 기초 수준)
- IDE 사용 능력 (IntelliJ IDEA 또는 VS Code)

### 1.4 사용 AI 도구

본 과정에서 활용하는 AI 코딩 에이전트는 다음과 같으며, Day 1에서 환경 설정을 완료합니다.

- **Claude Code** | **Gemini Code Assist** | **ChatGPT Codex** : CLI 기반 에이전틱 코딩 및 코드 리뷰
- **Cursor IDE** | **VS Code** | **Google Antigravity** : IDE 통합 AI 코드 어시스턴트
- **GitHub Copilot** : 코드 자동 완성 및 제안

---

## 2. 전체 구성 개요

| 구분 | 기간 | 시간 | 주요 내용 |
|------|------|------|-----------|
| **클린 코드** | 1~2일차 | 16시간 | 코드 품질 기준 확립 + AI 도구 환경 설정 |
| **리팩토링** | 3~5일차 | 24시간 | 구조 개선 역량 강화 + 실전 리팩토링 실습 |
| **TDD** | 6~8일차 | 24시간 | 테스트 기반 설계 + JUnit 5 + Spring Boot 테스트 |
| **AI 코드리뷰** | 9~10일차 | 16시간 | AI 활용 실무 적용 + 통합 프로젝트 |

### 2.1 평가 체계

학습 효과를 추적하기 위해 중간 체크포인트와 최종 평가를 운영합니다.

| 시점 | 평가 항목 | 내용 |
|------|-----------|------|
| Day 2 마무리 | 코드 리뷰 체크리스트 | 클린 코드 기준 기반 리뷰 체크리스트 작성 및 적용 |
| Day 5 마무리 | 리팩토링 결과물 | 레거시 코드 리팩토링 전후 비교 보고서 제출 |
| Day 8 마무리 | 테스트 커버리지 | TDD 기반 서비스 구현 + 테스트 커버리지 보고서 |
| Day 10 | 최종 평가 | 통합 프로젝트 발표 + 품질 개선 수치 비교 |

---

## 3. 일자별 상세 커리큘럼

---

### Day 1 (8h) — 클린 코드 핵심 원칙과 가독성 + AI 도구 환경 설정

#### 참고 자료

- 로버트 C 마틴, 『Clean Code』 — 1장: 깨끗한 코드 / 2장: 의미 있는 이름 / 3장: 함수 / 4장: 주석

#### 학습 목표

- "좋은 코드"의 객관적 기준 이해
- 읽기 쉬운 코드 작성 능력 확보
- 주석을 최소화하는 자기 문서화(Self-Documenting) 코드 작성
- AI 코딩 에이전트 환경 설정 및 기초 활용 경험

#### 교육 내용

**오전 — 클린 코드 이론 (4h)**

- 클린 코드의 3대 요소: 가독성·의도·유지보수성
- 의미 있는 변수/메서드 이름 설계 원칙
- 함수 크기와 책임 최소화 전략
- 함수 분해 전략 (Extract Method 도입)
- 주석을 대체하는 자기 문서화 코드 작성법
- [실습] 더러운 코드 → Clean Code 스타일로 개선

**오후 — AI 코딩 에이전트 소개 및 환경 설정 (4h)**

- AI 코딩 에이전트 개요
- [실습] 각 도구 설치 및 환경 구성: Google Antigravity
- AI와 함께 Clean Code 원칙 적용하기
- [실습] 더러운 코드 → Clean Code 스타일로 개선 (AI 에이전트 활용)
- [실습] 네이밍 개선 (AI 에이전트 활용)

---

### Day 2 (8h) — 클린 코드 구조·예외·클래스 설계

#### 참고 자료

- 로버트 C 마틴, 『Clean Code』 — 5장: 형식 맞추기 / 6장: 객체와 자료구조 / 7장: 오류 처리 / 10장: 클래스

#### 학습 목표

- 유지보수 가능한 구조 설계 능력 확보
- 코드 리뷰 기준 수립 및 체크리스트 작성
- 클린 코드와 리팩토링의 관계 이해 (브릿지 세션)

#### 교육 내용

**오전 — 구조와 설계 (4h)**

- 객체 vs 자료구조: 언제 무엇을 사용할 것인가
- 오류 처리 원칙: Checked vs Unchecked Exception 전략
- 클래스 책임 분리와 SRP (Single Responsibility Principle)
- 응집도/결합도 이해와 측정

**오후 — 리뷰 기준 수립 (4h)**

- [실습] God Class 분해
- [실습] 오류 구조 개선
- [실습] 코드 리뷰 체크리스트 작성 및 상호 리뷰
- 브릿지 세션: "클린 코드는 작성 시점의 품질, 리팩토링은 기존 코드의 품질 개선"

**✅ 체크포인트 1:** 클린 코드 기준 기반 코드 리뷰 체크리스트 작성 및 상호 리뷰 적용

---

### Day 3 (8h) — 리팩토링 개론 & 코드 스멜

#### 참고 자료

- 마틴 파울러, 『Refactoring』 — 1장: 리팩토링 소개 / 2장: 리팩토링의 원리 / 3장: 코드 속의 나쁜 냄새

#### 학습 목표

- "언제 고쳐야 하는가"를 판단하는 능력 확보
- 코드 스멜 유형을 분류하고 개선 우선순위 판단

#### 교육 내용

**오전 — 리팩토링 이론 (4h)**

- 리팩토링 정의와 목적
- 리팩토링 vs 기능 개발: 두 개의 모자(Two Hats) 원칙
- 테스트 기반 리팩토링 원칙
- 코드 스멜 22가지 유형 분석

**오후 — 코드 스멜 탐색 실습 (4h)**

- [실습] 레거시 코드에서 코드 스멜 탐색
- [실습] AI 에이전트를 활용한 코드 스멜 자동 탐지 및 수동 탐지와 비교
- [실습] 개선 후보 선정 및 우선순위 평가

---

### Day 4 (8h) — 리팩토링 핵심 기법 (1) — 기본 리팩토링 & 캡슐화

#### 참고 자료

- 마틴 파울러, 『Refactoring』 — 6장: 기본적인 리팩토링 / 7장: 캡슐화 / 8장: 기능 이동

#### 학습 목표

- 기본 리팩토링 기법 습득 및 실무 적용 능력 확보
- 캡슐화와 기능 이동을 통한 구조 개선

#### 교육 내용

**오전 — 기본 리팩토링 기법 (4h)**

- Extract Method / Extract Variable / Inline Method
- Rename Variable / Rename Method
- Introduce Parameter Object / Preserve Whole Object
- IDE 리팩토링 기능 활용 (IntelliJ 리팩토링 단축키)
- [실습] 레거시 코드 대상 기본 리팩토링 적용

**오후 — 캡슐화 & 기능 이동 (4h)**

- Encapsulate Record / Encapsulate Collection
- Move Method / Move Field
- Replace Temp with Query
- [실습] 단계별 리팩토링 (IDE + AI 에이전트 병행 활용)
- [실습] 테스트 유지 리팩토링 (테스트가 깨지지 않는 리팩토링)

---

### Day 5 (8h) — 리팩토링 핵심 기법 (2) — 조건부 로직 & 상속 & API 리팩토링

#### 참고 자료

- 마틴 파울러, 『Refactoring』 — 9장: 데이터 조직화 / 10장: 조건부 로직 간소화 / 11장: API 리팩토링 / 12장: 상속 다루기

#### 학습 목표

- 조건부 로직 간소화 및 상속 구조 개선 습득
- 종합 리팩토링 프로젝트를 통한 실무 적용 능력 검증

#### 교육 내용

**오전 — 고급 리팩토링 기법 (4h)**

- Replace Conditional with Polymorphism
- Decompose Conditional / Consolidate Conditional
- Replace Type Code with Subclasses / Strategy Pattern 전환
- Pull Up Method / Push Down Method / Extract Superclass
- Separate Query from Modifier / Replace Constructor with Factory Method

**오후 — 종합 리팩토링 프로젝트 (4h)**

- [실습] 레거시 코드 종합 리팩토링 (Day 3~5 기법 종합 적용)
- [실습] AI 에이전트를 활용한 리팩토링 제안 및 검증
- [실습] 리팩토링 전후 비교 보고서 작성

**✅ 체크포인트 2:** 레거시 코드 리팩토링 전후 비교 보고서 제출

---

### Day 6 (8h) — TDD 기본 철학 & JUnit 5 기초

#### 참고 자료

- 켄트 벡, 『TDD by Example』 — Part I: Money Example
- 『JUnit in Action』 (3rd) — Part I: JUnit 기초 (1~5장)

#### 학습 목표

- TDD 기본 철학과 Red-Green-Refactor 사이클 체화
- 무엇을/어디까지 테스트할지 판단하는 기준 확보
- JUnit 5의 구조와 핵심 API 숙지
- JUnit 5 테스트 작성 기본기 확보

#### 교육 내용

**오전 — TDD 철학과 Money Example (4h)**

- TDD란 무엇인가: 테스트 먼저 작성하는 이유
- Red-Green-Refactor 사이클
- [실습] Money Example 따라하기: 테스트 주도 설계 체험
- [참고] xUnit Example (『TDD by Example』 — Part II)
- 테스트 범위 결정 프레임
    - Unit vs Integration vs E2E의 책임
    - Test Pyramid (권장 비율/의도)
    - Test Trophy (프론트/서비스 관점 확장)
    - What NOT to test: 구현 세부사항, 프레임워크 내부, 중복 검증

**오후 — JUnit 5 기초 (4h)**

- JUnit 5 아키텍처: Platform / Jupiter / Vintage
- JUnit 4 → JUnit 5 전환 핵심 포인트
- 핵심 어노테이션: @Test, @BeforeEach, @AfterEach, @DisplayName
- Assertions 및 Assumptions API
- 테스트 라이프사이클 이해
- [실습] JUnit 5 테스트 클래스 구조 설계 (명명, 배치, 구성 전략)
- [실습] PrimeFactor KATA를 JUnit 5로 TDD 구현

---

### Day 7 (8h) — 테스트 전략 & Mock 적용

#### 참고 자료

- 켄트 벡, 『TDD by Example』 — 리팩토링 중심 사례
- 『JUnit in Action』 (3rd) — Part II: 다양한 테스트 전략 (6~9장)

#### 학습 목표

- 다양한 테스트 전략 이해 (Stub, Mock, Fake)
- Mockito 기반 분리 테스트 설계 능력 확보
- 테스트 품질(Test Quality) 개념 습득
- Flaky Test 원인 파악 및 예방 전략 습득

#### 교육 내용

**오전 — 테스트 전략 이론 (4h)**

- Test Double 개념: Dummy, Stub, Spy, Mock, Fake
- Stub을 이용한 분리 테스트
- Mock 객체와 행위 검증
- Test Quality: 무엇이 좋은 테스트인가
- Flaky Test (불안정 테스트) 원인과 예방 (시간/환경/랜덤/외부 의존)

**오후 — Mockito 실습 (4h)**

- Mockito 기본: @Mock, @InjectMocks, when/thenReturn, verify
- Mockito 심화: ArgumentCaptor, BDD 스타일 (given/willReturn)
- [실습] Baseball KATA TDD
- [실습] 문자열 유사도 서비스 TDD
- [실습] 테스트 품질 평가

---

### Day 8 (8h) — Spring Boot 테스트 & TDD 실전 적용

#### 참고 자료

- 『JUnit in Action』 (3rd) — 선별: Spring Boot 테스트 관련 장 중심 (Part III~V에서 핵심 선별)
- 켄트 벡, 『TDD by Example』 — TDD 철학 최종 응용

#### 학습 목표

- Spring Boot 테스트 어노테이션 및 전략 습득
- TDD 기반 서비스 개발 실전 적용
- 테스트 커버리지 측정 및 관리

#### 교육 내용

**오전 — Spring Boot 테스트 (4h)**

- @SpringBootTest: 통합 테스트 설계
- @WebMvcTest: 컨트롤러 레이어 테스트
- @DataJpaTest: 리포지토리 레이어 테스트
- TestRestTemplate / MockMvc 활용 REST API 테스트

**오후 — TDD 실전 프로젝트 (4h)**

- [실습] Restaurant Booking 서비스 TDD 구현
- [실습] Spring Boot 연동 테스트
- [실습] 테스트 커버리지 측정 및 보고서 작성

**✅ 체크포인트 3:** TDD 기반 서비스 구현 + 테스트 커버리지 보고서 제출

---

### Day 9 (8h) — AI 코드리뷰 설계 & 자동화 시스템 구축

#### 학습 목표

- AI에게 "좋은 코드 기준"을 재사용 가능한 템플릿으로 주입
- PR 단위 AI 리뷰 자동 실행 환경 구축
- AI 리뷰의 한계 인식 및 인간 검증 체계 설계

#### 교육 내용

**오전 — AI 코드리뷰 설계(프롬프트/루브릭) + 검증 체계 (4h)**

- AI 코드리뷰 구조 이해: LLM 기반 코드 분석 구조
- 정적 분석 vs AI 분석 비교: SonarQube 등 정적 분석 도구와 AI 리뷰의 커버 영역
- LLM API 선택 및 비용 구조 안내 (Claude API, OpenAI API, Gemini API 등)
- 리뷰 프롬프트 패턴: 역할기반 / 기준명시형 / 체크리스트 / 단계적분석
- 리뷰 산출물 표준화: Summary / Risk / Must-fix / Suggestion / Test Impact
- AI 검증 체계
    - False Positive(오탐) / False Negative(미탐) 유형
    - "AI가 확신해도 틀릴 수 있는 영역" 분류 (예: 도메인 규칙, 숨은 요구사항)
    - 인간 검증 체크:
        - 변경 범위 파악 → 리스크 높은 영역 우선 확인 → 테스트/리팩토링 영향 확인
    - 신뢰도 레벨링: High / Medium / Low (근거 요구)
- [실습] 개인별 리뷰 프롬프트 제작 및 동일 코드 대상 비교 실험

**오후 — AI 코드리뷰 자동화 시스템 구축 (4h)**

- AI 코드리뷰 워크플로우: 커밋 → PR → AI 분석 → 리뷰 리포트 → 인간 검증 → 병합
- [실습] GitHub Actions 연동 AI 리뷰 봇 구성 (사전 제공 템플릿 기반)
    - PR 코멘트 자동 생성
    - 리뷰 요약 리포트 출력
- [실습] 동일 PR에 대해
    - AI 리뷰 2종 (프롬프트 A/B) 생성
    - 오탐/미탐을 팀이 직접 분류 (근거 첨부)
    - 최종 "Human 결정" 작성 (승인/반려 사유)
- "Merge Gate" 정책 설계:
    - Must-fix 존재 시 차단
    - 테스트 실패/커버리지 하락 시 차단 (선택)
- 리뷰 정책 설계: AI 1차 필터링 + Human 2차 검증
- [실습] 리뷰 품질 평가표 작성

---

### Day 10 (8h) — 통합 프로젝트 & 코드 리뷰 전문가 실습 + KPI 명확화

#### 학습 목표

- AI + 인간 협업 기반 전문가급 리뷰 수행
- 10일간 학습 내용 종합 적용 및 실무 적용 가능 수준 도달
- 개선 작업을 수치(지표)로 증명
- 조직 적용 가능한 리뷰 운영 모델 도출

#### 교육 내용

**오전 — 통합 프로젝트 수행 (5h)**

- 입력: 레거시 서비스 코드 + PR 단위 변경 시나리오
- 수행 절차:
    1. AI 자동 리뷰 실행
    2. 문제 분류 (클린코드/리팩토링/테스트/설계)
    3. 개선 설계 (핵심 모듈 중심으로 범위 제한)
    4. 리팩토링 + 테스트 보강
    5. 재리뷰 (AI + Human)

**오후 — KPI 기반 발표 + 운영 모델 정리 (3h)**

- 품질 개선 수치 비교 (전/후 코드 품질 지표, 사전 제공 KPI 대시보드 템플릿 활용)
    - 테스트: Line/Branch Coverage, 실패 테스트 수, Flaky 발생 여부
    - 복잡도: Cyclomatic Complexity (핵심 모듈), 중복률 (Duplication)
    - 코드 품질: Lint/정적분석 경고 수, Code Smell 카운트 (도구 기반 가능)
    - 리뷰 생산성: 리뷰 리드타임 (PR 오픈→머지), Must-fix 개수
- "AI 리뷰 성능 지표"
    - 오탐률 (리뷰 중 실제 불필요 판정 비율)
    - 미탐 사례 (휴먼이 발견했는데 AI가 놓친 항목)
- 팀별 리뷰 결과 발표
    - 최종 PR (개선 코드)
    - 테스트 리포트 (전/후)
    - 리팩토링 전/후 요약
    - AI 리뷰 vs Human 리뷰 비교표 (오탐/미탐 포함)
    - KPI 대시보드 1페이지 (표 형태)

**✅ 최종 평가:** 통합 프로젝트 발표 + KPI 기반 품질 개선 수치 비교

---

