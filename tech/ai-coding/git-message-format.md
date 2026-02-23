# Git Commit Message 형식

## 기본 형식 (Conventional Commits)

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Type 종류 차트

| type       | 사용 상황                          | 예시                                      |
|------------|-----------------------------------|------------------------------------------|
| `feat`     | 새로운 기능 추가                    | feat(auth): JWT 기반 로그인 구현           |
| `fix`      | 버그 수정                          | fix(post): 게시글 조회 시 NPE 수정         |
| `refactor` | 기능 변경 없는 코드 개선            | refactor(user): UserService 메서드 분리   |
| `docs`     | 문서 수정 (README, OpenAPI 등)     | docs(api): OpenAPI 어노테이션 추가         |
| `chore`    | 빌드 설정, 의존성 변경              | chore(build): springdoc 의존성 추가       |
| `test`     | 테스트 코드 추가/수정               | test(post): PostService 단위 테스트 추가  |
| `style`    | 포맷, 세미콜론 등 스타일만 변경      | style(global): 코드 인덴트 정리           |
| `perf`     | 성능 개선                          | perf(post): 게시글 목록 쿼리 최적화        |
| `ci`       | CI/CD 파이프라인 설정 변경          | ci(github): Actions 빌드 워크플로우 추가  |
| `revert`   | 이전 커밋 되돌리기                  | revert: feat(auth): Refresh Token 도입   |

## 각 단계별 커밋 예시 모음

```
# 1단계
feat(init): 스프링부트 프로젝트 초기 구성

# 4단계
feat(post): 게시글 CRUD 기능 구현 (Collection 기반)

# 9~10단계
refactor(post): MyBatis → Spring Data JPA 리팩토링

# 14단계
feat(auth): JWT 기반 인증 구조 도입

# 15단계
feat(auth): Refresh Token 발급 및 재발급(Reissue) API 구현

# 16단계
feat(security): Redis 기반 토큰 블랙리스트 및 Rate Limiting 적용

# 17단계
feat(docs): OpenAPI(springdoc) 기반 REST API 문서 자동화 적용
```

## 핵심 원칙 3가지

- subject는 명령문, 50자 이내 — "추가했다"가 아니라 "추가" 또는 "적용"으로 마무리한다.
- body는 what/why 중심 — how(어떻게)는 코드가 설명하므로, 무엇을 왜 변경했는지를 쓴다.
- scope는 변경된 도메인 기준 — post, auth, security, docs, config 등 실제 패키지 구조와 맞추면 일관성이 생긴다.
