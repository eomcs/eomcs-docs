# 스프링부트 바이브코딩

## 1. 스프링부트 프로젝트 만들기

학습 목표:
- 스프링부트 프로젝트의 “정체성”을 이해한다.
- 스프링부트 프로젝트 구조를 설명할 수 있다.
- 최소 기능 웹 애플리케이션을 실행할 수 있다.
- 바이브코딩 기반 개발 흐름을 경험한다.

## 2. 뷰 템플릿 도입하기

학습 목표:
- 웹 애플리케이션에서 템플릿 엔진의 필요성을 설명할 수 있다.
- Thymeleaf 템플릿 엔진을 설정하고 기본적인 사용법을 적용할 수 있다.
- MVC 패턴에서 Controller와 View를 연결할 수 있다.
- 바이브코딩을 활용하여 뷰 계층을 효율적으로 구축하는 개발 흐름을 경험한다.

## 3. CSS 프레임워크 도입하기

학습 목표:
- CSS 프레임워크의 필요성을 설명하고, 순수 CSS와의 차이를 구분할 수 있다.
- Bootstrap 5를 CDN 또는 로컬 방식으로 프로젝트에 적용할 수 있다. 
- Bootstrap 컴포넌트와 Thymeleaf를 결합하여 동적 UI를 구현할 수 있다. 
- 바이브코딩을 활용하여 Bootstrap 기반 UI를 생성하고 커스터마이징 할 수 있다.

## 4. 게시글 CRUD 구현하기 (without DBMS)

학습 목표:
- 웹 애플리케이션에서 CRUD(Create, Read, Update, Delete)의 개념과 역할을 설명할 수 있다.
- Java Collection API를 사용하여 게시글 데이터를 관리할 수 있다.
- 게시글 등록 / 조회 / 수정 / 삭제 기능을 서버 렌더링 기반으로 구현할 수 있다.
- Controller, Service, Repository 계층의 역할 분리를 이해하고 적용할 수 있다.
- Thymeleaf와 Bootstrap을 활용하여 CRUD 화면을 구성할 수 있다.
- 바이브코딩을 활용해 CRUD 기능을 구현하고, 생성된 코드를 분석·개선할 수 있다.

## 5. DTO 패턴 적용하기

학습 목표:
- DTO의 역할과 Entity와의 분리 필요성을 설명할 수 있다.
- 요청(Request)과 응답(Response) DTO를 설계하고 유효성 검증을 적용할 수 있다.
- DTO ↔ Entity 간 변환 방법을 이해하고 적절한 위치에서 구현할 수 있다.
- Controller ↔ Service 계층 사이에서 DTO 기반 데이터 전달 구조를 구현할 수 있다.
- 바이브코딩을 활용하여 기존 코드를 DTO 패턴으로 리팩토링할 수 있다.

## 6. DTO를 record 문법으로 리팩토링 하기

학습 목표:
- Java record 문법의 목적과 특징을 설명할 수 있다. 
- class 기반 DTO와 record 기반 DTO의 차이를 비교할 수 있다. 
- Response DTO를 record로 변환하고, 불변성의 장점을 설명할 수 있다. 
- record에서 Bean Validation과 Compact Constructor를 활용할 수 있다.
- record의 제약사항을 이해하고 DTO 종류별 적절한 선택을 할 수 있다. 
- 바이브코딩을 활용하여 DTO를 record로 리팩토링하고 개선할 수 있다.

## 7. DBMS + Mybatis SQL Mapper 도입하기

학습 목표:
- H2 데이터베이스와 MyBatis를 스프링부트에 연동하고 기본 설정을 구성할 수 있다. 
- 게시글 Entity 기준으로 테이블 DDL과 CRUD SQL을 직접 작성할 수 있다. 
- MyBatis XML Mapper를 사용하여 SQL을 실행하고 결과를 매핑할 수 있다. 
- Repository 구현체를 Collection 기반에서 MyBatis 기반으로 교체할 수 있다. 
- 데이터 저장소 변경 후에도 Controller와 DTO 계층이 영향받지 않음을 확인할 수 있다. 
- 바이브코딩을 활용하여 SQL과 Mapper를 작성하고 실행 흐름을 분석할 수 있다.

## 8. 트랜잭션 적용하기

학습 목표:
- 트랜잭션 없이 여러 SQL을 실행할 때 발생하는 데이터 불일치 문제를 경험하고 설명할 수 있다. 
- 트랜잭션의 개념과 ACID 특성을 이해하고 설명할 수 있다. 
- 스프링의 선언적 트랜잭션 관리 방식과 @Transactional 동작 원리를 설명할 수 있다. 
- @Transactional을 적용하여 여러 SQL 작업을 하나의 원자적 단위로 묶을 수 있다. 
- 예외 발생 시 커밋/롤백 결정 규칙을 이해하고 필요시 커스터마이징할 수 있다. 
- readOnly 속성과 트랜잭션 전파 속성의 기본 개념을 이해한다. 
- 바이브코딩을 활용하여 트랜잭션 적용 코드를 작성하고 실행 결과를 검증할 수 있다.

## 9. SQL Mapper를 ORM으로 바꾸기

학습 목표:
- SQL 중심 개발 방식의 한계를 경험하고 ORM 도입 필요성을 설명할 수 있다. 
- ORM의 개념과 JPA 표준 스펙의 역할을 이해하고 설명할 수 있다.
- JPA 엔티티를 정의하고 핵심 구성 요소(Entity, EntityManager, 영속성 컨텍스트)의 역할과 객체-테이블 매핑을 설정할 수 있다.
- 엔티티의 생명주기(비영속, 영속, 준영속, 삭제)를 이해하고 각 상태별 동작을 설명할 수 있다.
- EntityManager를 직접 사용하여 Repository를 구현하고 기본 CRUD 기능을 수행할 수 있다.
- 변경 감지(Dirty Checking)와 flush 발생 시점의 동작 원리를 이해하고, JPA에서 트랜잭션 관리가 필수적인 이유를 설명할 수 있다. 
- JPQL을 사용하여 엔티티 기반 조회 쿼리를 작성할 수 있다. 
- 바이브코딩을 활용하여 순수 JPA 기반 Repository를 구현하고, 반복 코드 패턴을 인식하여 Spring Data JPA의 필요성을 설명할 수 있다.

## 10. Spring Data JPA로 리팩토링하기

학습 목표:
- Spring Data JPA의 역할과 등장 배경을 설명할 수 있다. 
- Repository 추상화와 인터페이스 기반 프로그래밍을 이해하고, 기존 EntityManager 기반 Repository를 Spring Data JPA로 리팩토링할 수 있다. 
- JpaRepository 인터페이스를 활용하여 기본 CRUD 기능을 구현할 수 있다. 
- Query Method와 @Query를 활용하여 다양한 조회 쿼리를 작성할 수 있다. 
- Pageable과 Sort를 사용하여 페이징과 정렬 기능을 구현할 수 있다. 
- SQL 중심 사고에서 도메인(엔티티) 중심 설계로 전환하고, 비즈니스 로직을 엔티티에 배치할 수 있다. 
- 트랜잭션과 Spring Data JPA의 연계 방식을 이해한다. 
- 바이브코딩으로 점진적 리팩토링을 경험하고, Spring Data JPA의 장점과 한계를 설명할 수 있다.

## 11. 세션 기반 사용자 인증하기(without Spring Security)

학습 목표:
- 인증(Authentication)과 인가(Authorization)의 차이를 설명하고, HTTP 무상태성으로 인한 세션 필요성과 쿠키-세션 관계를 이해한다. 
- 세션 기반 로그인 처리 흐름(로그인 → 세션 생성 → 인증 → 로그아웃)을 단계별로 설명할 수 있다.
- HttpSession을 이용해 로그인 상태를 저장·조회·삭제하고, 사용자 정보를 세션에 안전하게 저장할 수 있다. 
- 비밀번호를 암호화하여 저장하고 검증하는 방법을 구현할 수 있다. 
- Interceptor(또는 Filter)를 활용하여 로그인 여부에 따른 접근 제어를 중앙화할 수 있다. 
- 세션 기반 인증의 한계(확장성, 메모리)와 주요 보안 이슈 (세션 하이재킹, CSRF)를 설명할 수 있다.
- Spring Security 도입 이전 단계로서 수동 세션 인증을 구현하며, 표준 프레임워크의 필요성을 이해한다.
- 바이브코딩을 통해 로그인/로그아웃 및 인증 흐름을 구현하고, 요청-응답-세션 상태 변화를 디버깅으로 확인한다.

## 12. Spring Security 도입하기

학습 목표:
- Spring Security의 역할과 수동 구현 대비 도입 효과를 설명할 수 있다. 
- Spring Security의 FilterChain 아키텍처와 주요 필터들(인증, 인가, CSRF 등)의 역할을 이해한다. 
- Spring Security 기본 설정 시 자동 적용되는 보안 기능 (폼 로그인, CSRF 보호, 세션 관리)을 확인하고 설명할 수 있다. 
- Interceptor를 통한 세션 기반 인증과 Spring Security FilterChain 기반 인증 흐름을 비교하고 차이점을 설명할 수 있다. 
- UserDetails와 UserDetailsService를 구현하여 사용자 인증 로직을 Spring Security에 통합하고, 비밀번호 자동 검증을 이해한다. 
- SecurityFilterChain을 설정하여 URL 기반 접근 제어(Authorization)와 로그인/로그아웃 흐름을 구성할 수 있다. 
- CSRF 보호의 필요성을 이해하고, Thymeleaf 폼에서 CSRF 토큰이 자동 적용되는 것을 확인할 수 있다. 
- 바이브코딩을 통해 기존 세션 인증 코드(Interceptor, 수동 검증)를 Spring Security 기반으로 리팩토링하고, 코드 감소 및 보안 강화 효과를 확인한다.

## 13. SSR 방식에서 CSR 방식으로 전환하기

학습 목표:
- 서버 사이드 렌더링(Thymeleaf)과 클라이언트 사이드 렌더링(JavaScript)의 차이와 장단점을 설명할 수 있다.
- REST API 설계 원칙(리소스 중심, HTTP 메서드, 상태 코드)을 이해하고 올바르게 적용할 수 있다.
- @RestController와 ResponseEntity를 활용하여 JSON 기반 REST API를 구현할 수 있다.
- @RestControllerAdvice를 사용하여 API 예외를 JSON 에러 응답으로 처리할 수 있다.
- 클라이언트(JavaScript)에서 Fetch API를 사용하여 REST API를 호출하고 동적으로 화면을 렌더링할 수 있다.
- 단일 서버 내에서 API와 정적 파일을 함께 제공하는 구조를 이해하고, 완전 분리 구조(Backend 서버 + Frontend 서버)와의 차이를 설명할 수 있다.
- CSR 환경에서 세션 쿠키 방식의 한계를 이해하고, API 인증에 적합한 토큰 기반 방식의 필요성을 설명할 수 있다.
- 바이브코딩을 통해 기존 Thymeleaf 기반 MVC 구조를 REST API + JavaScript 구조로 리팩토링한다.

## 14. 토큰(JWT) 기반 인증 방식으로 전환하기

학습 목표:
- 세션 기반 인증과 토큰 기반 인증의 차이를 이해하고, CSR 환경에서 JWT 도입이 필요한 이유를 설명할 수 있다.
- JWT의 구조와 서명 기반 무결성 검증 원리를 설명할 수 있다.
- 로그인 시 JWT를 생성˙발급하는 인증 흐름을 단계별로 설명할 수 있다.
- 클라이언트에서 JWT를 저장하고 전송하는 방법을 구현할 수 있다.
- JWT 기반 인증을 위해 Spring Security를 설정할 수 있다.
- JWT 기반 인증에서 세션 관리 정책의 변화와 CSRF 처리 방식의 차이를 설명할 수 있다.
- CSRF, 세션 고정, 서버 확장성 관점에서 JWT 기반 인증의 장점을 설명할 수 있다.
- JWT 기반 인증의 한계와 보안 고려사항을 이해한다.
- 바이브코딩을 통해 기존 세션 기반 인증 구조를 JWT 기반 인증 구조로 점진적으로 리팩토링하고 테스트할 수 있다.

## 15. Refresh Token 기반 인증 확장하기

학습 목표:
- Access Token과 Refresh Token의 역할 분리 구조를 이해하고 설명할 수 있다.
- JWT 단독 인증 방식의 한계를 이해하고, Refresh Token이 필요한 이유를 설명할 수 있다.
- 로그인 시 Access Token과 Refresh Token을 함께 발급하는 인증 흐름을 설계하고 구현할 수 있다.
- Refresh Token을 활용한 토큰 재발급(Reissue) API를 구현할 수 있다.
- Refresh Token을 데이터베이스에 안전하게 저장·관리하는 기본 구조를 구현할 수 있다.
- 로그아웃 시 Refresh Token을 삭제하는 기본 흐름을 구현할 수 있다.
- Access Token 만료 시 자동 재인증(Silent Refresh) 처리 흐름을 클라이언트에서 구현할 수 있다.
- Refresh Token 만료 시 재로그인 처리 흐름을 구현할 수 있다.
- Access Token과 Refresh Token의 적절한 만료 시간 설정 전략을 이해한다.
- 바이브코딩을 통해 기존 JWT 단독 인증 구조를 Refresh Token 기반 인증 구조로 리팩토링하고, 정상 흐름을 테스트할 수 있다.

## 16. 인증 보안 고도화 및 계정 보호 전략

학습 목표:
- Refresh Token 기반 인증 환경에서 발생 가능한 보안 위협 시나리오(토큰 탈취, 재사용 공격, Brute Force 등)를 설명할 수 있다.
- Redis를 활용한 중앙 인증 상태 관리 구조를 설계하고, 토큰 블랙리스트 기반 무효화를 구현할 수 있다.
- Refresh Token Rotation(RTR) 전략을 이해하고 구현할 수 있으며, 재사용 공격(Replay Attack) 탐지 및 자동 차단 로직을 구현할 수 있다.
- 토큰 무효화(Token Revocation) 구조를 설계하고, 다중 기기 동시 로그인 제한 및 강제 로그아웃 정책을 구현할 수 있다.
- Rate Limiting과 로그인 실패 횟수 제한을 구현하여 Brute Force 공격을 방어할 수 있다.
- 보안 로그 및 인증 이력 관리 구조를 이해하고, 감사(Audit) 로그를 설계·구현할 수 있다.
- 인증 시스템 운영 관점에서 성능·보안·사용자 경험 간의 균형 전략을 설명할 수 있다.
- 바이브코딩을 통해 인증 시스템을 실제 서비스 운영 수준으로 고도화하고, 다양한 공격 시나리오를 테스트할 수 있다.

## 17. OpenAPI로 REST API 문서 자동화하기

학습 목표:
- OpenAPI Specification의 개념과 API 문서 자동화의 필요성을 설명할 수 있다.
- Spring Boot + Spring Security 프로젝트에 springdoc-openapi를 적용하고 기본 설정을 구성할 수 있다.
- Request/Response DTO와 Validation 제약 조건이 OpenAPI 스키마에 자동 반영되는 원리를 이해하고, 실제 스펙과 일치하는지 검증할 수 있다.
- @Operation, @ApiResponse, @Schema, @Parameter 등을 활용하여 API 문서를 명확하고 일관되게 보강할 수 있다.
- 공통 응답 구조와 예외 응답(401, 403, 404, 500 등)을 일관되게 문서화하여 프론트엔드와의 협업 품질을 향상시킬 수 있다.
- 생성된 OpenAPI 문서를 검토하여 누락된 엔드포인트, 잘못된 상태 코드, 스키마 불일치 등을 점검할 수 있다.
- OpenAPI 스펙을 기반으로 프론트엔드 분리 또는 외부 연동을 위한 계약 기반 개발(API First 사고방식)을 설명할 수 있다.
- 바이브코딩을 활용하여 기존 REST API 프로젝트를 점진적으로 OpenAPI 기반 문서화 구조로 리팩토링할 수 있다.

## 18. Node.js + Express로 프론트엔드 완전 분리하기

학습 목표:
- 프론트엔드 완전 분리 구조(API 서버 + 프론트엔드 서버)의 개념과 장단점을 설명할 수 있다.
- 포트 분리 실행 환경을 기준으로 API 서버와 프론트엔드 서버의 독립 배포 구조를 설명할 수 있다.
- 기존 Spring Boot 프로젝트에서 뷰 관련 책임을 제거하고 순수 REST API 서버로 재정의할 수 있다.
- CORS(Cross-Origin Resource Sharing)의 동작 원리를 이해하고, Spring Security에서 안전하게 CORS 정책을 설정할 수 있다.
- Cross-Origin 환경에서 JWT 기반 인증 흐름(Authorization 헤더 전송 방식)을 이해하고, 완전 분리 구조에 적합한 이유를 설명할 수 있다.
- Cross-Origin 환경에서 Refresh Token 기반 재발급 흐름이 기존과 어떻게 달라지는지 설명하고, 클라이언트 인증 처리 로직의 동작 여부를 검증하여 필요한 부분을 조정할 수 있다.
- Node.js와 Express를 사용하여 프론트엔드 정적 파일 서버를 구축하고 독립 실행할 수 있다.
- OpenAPI 명세(/v3/api-docs)를 기반으로 API First 개발 흐름으로 Express 프론트엔드 프로젝트를 새로 구축할 수 있다.
- .env 파일이나 환경 변수를 활용하여 개발 및 운영 환경에 따른 API 서버 URL 분리 전략을 구현할 수 있다.
- 바이브코딩을 활용하여 기존 통합 구조를 완전 분리 구조로 점진적으로 리팩토링하고, CORS 및 인증 이슈를 해결할 수 있다.

## 19. Next.js로 프론트엔드 아키텍처 고도화하기

학습 목표
- React 기반 프레임워크로서 Next.js의 역할과 기존 Express 정적 서버 방식과의 차이를 설명할 수 있다.
- Next.js에서 제공하는 렌더링 전략(SSR, SSG, CSR, RSC)의 개념을 구분하고, 각 전략의 적용 기준을 설명할 수 있다.
- Next.js App Router 구조(app 디렉터리 기반)의 폴더 구조와 라우팅 방식을 이해하고 설계할 수 있다.
- Layout, Template, Loading, Error 파일의 역할을 이해하고 계층적 UI 구조를 구성할 수 있다.
- Server Component와 Client Component(RSC 포함)의 차이를 이해하고, 적절한 경계 설정 전략을 설계할 수 있다.
- TypeScript를 기반으로 Next.js 프로젝트를 구성하고, API 응답 타입 및 컴포넌트 Props를 타입 안전하게 정의할 수 있다.
- Tailwind CSS를 활용하여 유틸리티 클래스 기반 스타일링을 적용하고, shadcn/ui 컴포넌트를 프로젝트에 통합하여 일관된 UI를 구성할 수 있다.
- 기존 Spring Boot REST API(OpenAPI 기반)를 연동하여 Server Component 및 Client Component 환경에서 데이터 패칭 구조를 구현할 수 있다.
- TanStack Query를 활용하여 클라이언트 사이드 서버 상태(캐싱, 로딩, 에러 처리)를 관리하고, 서버 컴포넌트 데이터 패칭과의 역할 분리 기준을 설명할 수 있다.
- Zustand를 활용하여 클라이언트 전역 UI 상태를 관리하고, TanStack Query와의 책임 분리 기준을 설명할 수 있다.
- 기존 JWT + Refresh Token 기반 인증 구조를 Next.js 환경에 맞게 재구성하고, 401 발생 시 자동 재발급 흐름을 구현할 수 있다.
- 환경 변수(.env) 및 빌드 환경 분리를 통해 개발/운영 API 서버 URL 전략을 설계할 수 있다.
- API Route(Route Handler)를 활용하여 BFF(Backend For Frontend) 구조의 기본 개념을 이해하고, CORS 문제를 구조적으로 해결하는 전략을 설명할 수 있다.
- Next.js의 자동 코드 스플리팅, Image/Font 최적화, dynamic import를 활용하여 성능 개선 전략을 설명하고 적용할 수 있다.
- 바이브코딩을 활용하여 기존 Express 기반 프론트엔드 프로젝트를 Next.js 기반 구조로 점진적으로 마이그레이션하고, 구조적 차이를 분석할 수 있다.


