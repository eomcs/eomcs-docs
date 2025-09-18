# 데브옵스 & CI/CD(DevOps & Continuous Integration/ Continuous Delivery + Continuous Deployment)

## 1. DevOps란?

- **Development(개발)**과 **Operations(운영)**의 합성어
- 개발팀과 운영팀이 협력해서 빠르게, 안정적으로, 지속적으로 소프트웨어를 제공하기 위한 문화이자 철학
- 목표: 개발과 운영의 사이로 흐르는 **사일로(Silo, 단절)**를 없애고, 자동화와 협업을 통해 효율을 높임

### DevOps의 핵심 요소

- 문화(Culture): 협업, 피드백, 지속적인 개선
- 프로세스(Process): 애자일, 스크럼, 카나리 배포 등
- 도구(Tools): Git, Docker, Kubernetes, Jenkins, Prometheus 등

## 2. CI/CD란?

- DevOps를 실천하기 위한 핵심 기술적 방법론
- CI/CD는 파이프라인 자동화의 두 가지 측면을 합친 개념

### (1) CI: Continuous Integration (지속적 통합)

- 개발자가 코드 변경 사항을 자주(하루에도 여러 번) 중앙 저장소에 통합
- 자동 빌드, 자동 테스트 실행 → 문제를 조기 발견

### (2) CD: Continuous Delivery / Continuous Deployment

- CI 이후 검증된 코드를 자동으로 배포 가능한 상태로 만드는 것(Continuous Delivery)
- 또는 자동으로 실제 서비스 환경에 배포까지 하는 것(Continuous Deployment)
- 사용자에게 빠르게 기능을 전달할 수 있음

### 3. DevOps와 CI/CD의 관계

- DevOps = 문화 + 철학 + 방법론
- CI/CD = DevOps를 실현하는 핵심 기술적 수단

즉,
- DevOps는 **“우리는 협업과 자동화를 통해 소프트웨어를 빠르고 안정적으로 제공하겠다”**라는 큰 그림
- CI/CD는 이를 실행하는 구체적인 도구와 프로세스 (예: GitHub Actions으로 CI 파이프라인, ArgoCD로 CD 자동 배포)

### 4. 비유로 이해하기

- DevOps = 건강한 생활 습관(운동, 식단, 수면 등)
- CI/CD = 그 습관을 실천하는 도구와 방법(헬스장, 요리법, 수면 앱 등)

즉, CI/CD는 DevOps의 핵심 기술적 실천 방식이고, DevOps는 CI/CD를 포함하는 더 넓은 개념(문화 + 프로세스 + 도구)이다.