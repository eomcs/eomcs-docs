# 백엔드/프론트엔드 바이브코딩 실습

## 개발 환경 준비

### 기본 도구 설치

- JDK 25(LTS) 이상 설치
- Gradle (9.3.0) 이상 설치

### Google Antigravity 설치

1. 다운로드: [Google Antigravity 공식 사이트](https://antigravity.google) 에서 운영체제에 맞는 설치 파일을 내려 받아 설치한다.
1. 로그인: 구글 계정으로 로그인 한다. (프리뷰 기간 동안 대부분의 기능 무료 체험)

### 에이전트 브라우저 설정

1. 에이전트 매니저 실행: 상단 메뉴에서 'Open Agent Manager'를 클릭한다.
1. 브라우저 확장 프로그램 설치: 에이전트가 브라우저를 제어할 수 있도록 안내에 따라 Chrome 전용 확장 프로그램을 설치한다.
1. 권한 승인: 에이전트가 브라우저에서 버튼을 클릭하거나 폼을 입력할 수 있도록 'Setup' 버튼을 눌러 권한을 활성화한다.

### 워크스페이스 및 모드 설정

1. 샌드박스 폴더 생성 및 워크스페이스에 연결 
    - 빈 폴더를 하나 만든다. 예) `$USER_HOME/git/exam01`
    - 방법1) `Open Agent Manager` 선택 > `Open Workspace` 선택 > `Open New Workspace` 선택 > `exam01` 폴더 선택
    - 방법2) `Open Folder` 선택 > `exam01` 폴더 선택
1. 작업 모드 선택
    - Planning Mode: 복잡한 기능을 구현할 때 추천. AI가 먼저 계획서를 쓰고 승인을 요청한다.
    - Fast Mode: 단순한 디자인 수정이나 빠른 프로토타이핑에 적합
1. 모델 선택
    - Gemini 3 Pro (High): 
        - 추론 깊이: 최상 (Deep Thinking)
        - 응답 속도: 느림
        - 추천 용도: 아키텍처 설계, 복잡한 로직 구현
    - Gemini 3 Pro (Low): 
        - 추론 깊이: 상 (Balanced)
        - 응답 속도: 보통
        - 추천 용도: 일반적인 코딩 및 기능 추가
    - Gemini 3 Pro (Flash): 
        - 추론 깊이: 중상 (Fast Agent)
        - 응답 속도: 매우 빠름
        - 추천 용도: 이브 코딩, UI/UX 수정, 빠른 반복 테스트
1. 로컬 실행 환경 준비
    - 언어별 도구 설치: 프로젝트 성격에 따라 Node.js(20 버전 이상 추천)나 Python, JDK 등을 미리 설치해 둔다.


## 실습

### 실습 1 - 스프링부트 프로젝트 만들기

#### 프로젝트 명세서 생성하기

```
다음은 스프링부트 기반 웹 애플리케이션 프로젝트를 생성에 대한 내용이다. 
이를 바탕으로 프로젝트 명세서를 작성해줘.

- 프로젝트 설정
    - JDK: JDK 25 이상
    - Language: Java
    - Spring Boot: 4.0.1 이상
    - Build Tool: Gradle 9.3.0 이상, Groovy DSL 사용
    - Dependencies: 없음 (최소 기능 프로젝트)
- 플러그인 
    - 'io.spring.dependency-management': Spring Boot 버전에 맞춰서 플러그인 추가
- Project Metadata
    - Group: com.example
    - Artifact: vibeapp
    - Main Class Name: VibeApp
    - Description: 최소 기능 스프링부트 애플리케이션을 생성하는 프로젝트다.
    - Configuration: YAML 파일 사용    
```

#### 프로젝트 생성하기

```
프로젝트 명세서(PROJECT_SPEC.md)의 내용대로 현재 작업 폴더를 스프링부트 프로젝트 폴더로 구성해줘.
```

#### "Hello, Vibe!" 출력하는 REST API 만들기

```
VibeApp 클래스에 "Hello, Vibe!" 문자열을 반환하는 REST API를 추가해줘.
- 엔드포인트: /api/hello
- HTTP 메서드: GET
- Method name: hello

REST API를 추가하는데 필요한 Starter나 라이브러리가 있다면 빌드 스크립트 파일에 추가해줘.
```

#### 빌드 스크립트 파일 검토하기

```
생성된 빌드 스크립트 파일(build.gradle 또는 build.gradle.kts)을 검토해줘.
```

#### 빌드 및 실행

- 터미널에서 다음 명령어를 실행하여 프로젝트를 빌드하고 실행한다.
    ```zsh
    # 빌드하기
    gradle build

    # 실행하기
    gradle bootRun
    ```
- Agent에서 프로젝트를 빌드하고 실행한다.
    ```text
    프로젝트를 빌드하고 실행해줘.
    ```

#### 현재 프로젝트 상태를 명세서에 저장하기

```
현재 프로젝트 상태를 프로젝트 명세서 파일(PROJECT_SPEC.md)에 저장해줘.
```

#### 프로젝트 명세서 파일로 새 프로젝트 만들기

```
프로젝트 명세서(PROJECT_SPEC.md)의 내용대로 현재 작업 폴더를 스프링부트 프로젝트 폴더로 구성해줘.
```


### 실습 2 - 뷰 템플릿 도입하기

#### Thymeleaf 뷰 템플릿 엔진 추가하기

```
프로젝트에 Thymeleaf 뷰 템플릿 엔진을 추가해줘.
```

#### 간단한 웹 페이지 만들기

```
"/" 경로로 접속하면 "Hello, Vibe!" 메시지를 보여주는 간단한 웹 페이지를 만들어줘.
- 컨트롤러 클래스: HomeController
- 뷰 템플릿 파일: home.html
```

#### 현재 프로젝트 상태를 명세서에 저장하기

```
추가된 내용을 프로젝트 명세서 파일(PROJECT_SPEC.md)에 저장해줘.
```

### 실습 3 - CSS 프레임워크 도입하기

#### Bootstrap 5 CSS 프레임워크 추가하기

```
Thymeleaf 템플릿에 Bootstrap 5 CSS 프레임워크를 적용해줘.
- CDN 방식을 사용해줘.
```

#### 현재 프로젝트 상태를 명세서에 저장하기

```
추가된 내용을 프로젝트 명세서 파일(PROJECT_SPEC.md)에 저장해줘.
```

### 실습 4 - 게시글 CRUD 구현하기 (without DBMS)

#### **게시글 목록 조회** 기능 구현하기

```
"게시글 목록 조회" 기능을 추가해줘.
- 게시글 속성: 
    - 번호: no(Long)
    - 제목: title(String)
    - 내용: content(String)
    - 생성일: createdAt(LocalDateTime)
    - 수정일: updatedAt(LocalDateTime)
    - 조회수: views(Integer)
- 게시글 목록 조회
        - URL: /posts
        - 출력 항목: 번호, 제목, 생성일, 조회수
- 데이터 저장:
    - Java Collection API ArrayList를 사용하여 메모리 기반 저장
    - 예제 데이터 10개 미리 추가
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 엔티티 클래스: Post
- 리포지토리 클래스: PostRepository
- 뷰 템플릿 파일: 
    - 게시물 목록 화면: posts.html
```

#### **게시글 상세 조회** 기능 구현하기

```
"게시글 상세 조회" 기능을 추가해줘.
- 게시글 목록 조회 페이지 변경
    - 각 게시글 제목을 클릭하면 상세 조회 페이지로 이동
- 게시글 상세 조회
    - URL: /posts/{no}
    - 출력 항목: 번호, 제목, 내용, 생성일, 수정일, 조회수
    - 목록 버튼: 클릭하면 게시글 목록으로 페이지 이동
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 엔티티 클래스: Post
- 리포지토리 클래스: PostRepository
- 뷰 템플릿 파일: 
    - 게시물 상세 화면: post_detail.html
```

#### **새 게시글 작성폼** 기능 구현하기

```
"새 게시글 작성폼" 페이지를 추가해줘.
- "새 게시글 작성폼"
    - URL: /posts/new
    - 입력 항목: 제목(필수 입력), 내용(필수 입력)
    - 등록 버튼: 클릭하면 "새 게시글 등록" alert 창만 출력
    - 취소 버튼: 클릭하면 목록 조회 화면으로 이동
    - 컨트롤러 클래스: PostController
    - 뷰 템플릿 파일: 
        - 게시글 작성 화면: post_new_form.html  
- 게시글 목록 페이지 변경
    - 게시글 목록 페이지에 "새 글" 버튼 추가
    - "새 글" 버튼: 클릭하면 "새 게시글 작성폼" 페이지로 이동  
```

#### **새 게시글 등록** 기능 구현하기

```
"새 게시글 등록" 기능을 추가해줘.
- 새 게시글 등록
    - URL: /posts/add
    - 새 게시글 작성폼 페이지의 입력 값을 받아서 저장 처리
    - createdAt: 현재 시각으로 설정
    - updatedAt: null 로 설정
    - views: 0 으로 설정
    - 처리 후 목록 조회 화면으로 이동
- 새 게시글 작성폼 변경
    - 등록 버튼: 클릭하면 "새 게시글 등록"을 요청한다.
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 엔티티 클래스: Post
- 리포지토리 클래스: PostRepository
- 뷰 템플릿 파일: 없음
```

#### **게시글 수정폼** 기능 구현하기

```
"게시글 수정폼" 페이지를 추가해줘.
- "게시글 수정폼"
    - URL: /posts/{no}/edit
    - 출력 항목: 
        - 번호(read-only) 
        - 제목 
        - 내용 
        - 생성일(read-only, YYYY-MM-DD)
        - 수정일(read-only, YYYY-MM-DD, null이면 빈칸으로 표시)
        - 조회수(read-only)
    - 저장 버튼: 클릭하면 alert 창만 출력
    - 취소 버튼: 클릭하면 상세 조회 화면으로 되돌아 간다.
- "게시글 상세 페이지" 변경
    - 수정 버튼 추가
    - 수정 버튼 클릭하면 수정폼으로 페이지 이동
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 엔티티 클래스: Post
- 리포지토리 클래스: PostRepository
- 뷰 템플릿 파일: 
    - 게시글 수정 화면: post_edit_form.html
```

#### **게시글 수정** 기능 구현하기

```
"게시글 수정" 기능을 추가해줘.
- 게시글 수정
    - URL: /posts/{no}/save
    - 게시글 수정폼 페이지에서 보낸 '제목', '내용'을 받아서 변경 처리
    - updatedAt: 현재 시각으로 설정
    - 처리 후 상세 조회 화면으로 이동
- 게시글 수정폼 변경
    - 저장 버튼: 클릭하면 "게시글 수정"을 요청한다.
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 엔티티 클래스: Post
- 리포지토리 클래스: PostRepository
- 뷰 템플릿 파일: 없음
```

#### **게시글 삭제** 기능 구현하기

```
"게시글 삭제" 기능을 추가해줘.
- 게시글 삭제
    - URL: /posts/{no}/delete
    - 삭제 처리 후 목록으로 페이지로 이동
- 게시글 상세 조회 페이지 변경
    - 삭제 버튼 추가
    - 삭제 버튼 클릭하면 "게시글 삭제"를 요청한다.
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 엔티티 클래스: Post
- 리포지토리 클래스: PostRepository
- 뷰 템플릿 파일: 없음
```

#### **게시글 목록 페이징 처리** 기능 구현하기

```
"게시글 목록 페이징 처리" 기능을 추가해줘.
- 게시글 목록 조회 페이지 변경
    - 한 페이지에 5개 게시글씩 출력
    - 페이지 네비게이션 추가
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 리포지토리 클래스: PostRepository
- 엔티티 클래스: Post
- 뷰 템플릿 파일: 
    - 게시물 목록 화면: posts.html
``` 

#### 자바 패키지 구조를 "기능형 구조"로 변경하기

```
현재 자바 패키지 구조를 다음과 같이 "기능형 구조"로 변경해줘.
com.example.vibeapp
├── VibeApp.java
├── home
│   └── HomeController.java
└── post
    ├── Post.java
    ├── PostController.java
    ├── PostRepository.java
    └── PostService.java
```

#### 뷰 템플릿 파일 위치 변경하기

```
뷰 템플릿 파일들을 기능별로 다음과 같이 위치를 변경해줘.
templates/home/
    └── home.html
templates/post/
    ├── post_detail.html
    ├── post_edit_form.html
    ├── post_new_form.html
    └── posts.html
```

#### 리팩토링 하기

```
자바 클래스 파일을 검토해줘. 메서드 이름이 실무의 관례를 따르는지 확인하고, 사용하지 않는 메서드는 제거해줘.
```

#### 현재 프로젝트 상태를 명세서에 저장하기

```
변경 사항이나 프로젝트 상태를 프로젝트 명세서(PROJECT_SPEC.md)에 적용해줘.
```

### 실습 5 - DTO 패턴 적용하기

```
현재 프로젝트에 DTO 패턴을 적용해줘.
현재 상태:
- PostController가 Entity를 직접 받고 반환함
- 입력 검증 없음
- 메모리 기반 PostRepository 사용

요구사항:
- PostCreateDto, PostUpdateDto, PostResponseDTO, PostListDto 생성
- Bean Validation 적용 (제목 필수, 최대 100자)
- Service는 DTO만 입출력
- Entity → DTO 변환은 정적 팩토리 메서드 from() 사용
- DTO → Entity 변환은 DTO 내부의 toEntity() 메서드 사용
```

### 실습 6 - DTO를 record 문법으로 리팩토링하기

```
DTO 클래스를 Java의 record 문법으로 리팩토링해줘.
```

### 실습 7 - DBMS + Mybatis SQL Mapper 도입하기

#### 프로젝트에 H2 데이터베이스와 MyBatis 설정하기

- 프롬프트 작성 방법을 묻는다.
    ```
    프로젝트에 H2 Database와 MyBatis SQL Mapper 설정을 추가하고 싶다.
    예시 프롬프트를 작성해줘.
    ```

- AI가 알려준 예시 프롬프트를 적절하게 수정한다.
    ```
    Spring Boot 프로젝트에 H2 데이터베이스와 MyBatis를 도입해줘.

    요구사항:
    1. build.gradle에 다음 의존성 추가:
        - H2 Database (runtime)
        - MyBatis Spring Boot Starter

    2. application.yml 설정:
        - H2 파일 모드로 설정 (jdbc:h2:file:./data/testdb)
        - H2 Console 활성화 (/h2-console)
            - JakartaWebServlet 등록 포함
        - MyBatis 설정:
            * Mapper XML 위치: classpath:mapper/**/*.xml
            * Type aliases 패키지: com.example.vibeapp.post
            * Camel case 자동 변환 활성화
        - 디버깅 모드 활성화
        - 로깅
            - 스프링부트 autoconfigure 레벨: debug
            - 로그 파일명: ./logs/app.log 

    3. 프로젝트 루트에 .gitignore 업데이트:
    - /data/ 디렉토리 제외
    - *.mv.db, *.trace.db 제외

    현재 Spring Boot 버전은 4.0.1이고, Java 25를 사용 중이야.
    설정 후 정상 동작 여부를 확인할 수 있는 방법도 알려줘.
    ```

#### H2 데이터베이스가 SpringBoot 4.0.1 에서 자동 설정 안되는 문제 해결하기(필요 시)

```
Spring Boot 4.0.1에서 H2 데이터베이스가 자동 설정되지 않는 문제를 해결해줘.

요구사항:
1. 신규 설정 추가: com.example.vibeapp.config 패키지에 H2ConsoleConfig 클래스를 생성해줘.
  - H2 콘솔을 /h2-console 경로에 직접 매핑하는 설정을 포함해야 해.

현재 Spring Boot 4.0.1 버전은 Jakarta EE 네임스페이스를 사용한다. H2ConsoleConfig 클래스를 만들 때 이 점을 유의해줘.
```

#### H2 데이터베이스에 웹 콘솔로 접속하기

- 웹 브라우저에서 `http://localhost:8080/h2-console` 에 접속하여 H2 데이터베이스 웹 콘솔 페이지를 띄운다.
- 로그인 정보:
    - JDBC URL: `jdbc:h2:file:./data/testdb`
    - 사용자 이름: `sa`
    - 비밀번호: (빈칸)
    - Connect 버튼 클릭
    - 로그인이 안 된다면? 
        - 에이전트를 통해 해결!

#### 게시글 테이블 생성하기

```
자바 Post 클래스의 필드 값을 저장할 테이블 생성 SQL문을 작성해줘. 컬럼의 타입은 Post 클래스의 필드 타입에 맞춰줘.
- 테이블명: POSTS
- 컬럼:
    - NO: Pimary key, 자동 증가
    - TITLE: 최대 200자, 필수 입력
    - CONTENT: 10MB까지 입력 가능, 필수 입력
    - CREATED_AT: 기본값은 현재 시각
    - UPDATED_AT: 기본 값은 NULL
    - VIEWS: 기본 값은 0
```

- H2 데이터베이스 웹 콘솔에서 SQL문을 실행하여 POSTS 테이블을 생성한다.
- 스프링부트를 재시작할 때 POSTS 테이블을 자동 생성되게 만들고 싶다면?
    ```
    스프링부트를 재시작할 때 POSTS 테이블이 없으면 자동으로 생성되게 설정해줘.
    ```
    - schema.sql 파일에 POSTS 테이블 생성 SQL문이 추가된 것을 확인하라.
    - application.yml 파일에서 변경된 설정을 확인하라.
    
#### PostRepository를 MyBatis 기반으로 변경하기

```
현재 메모리 기반으로 구현된 PostRepository를 MyBatis SQL Mapper 기반으로 변경해줘.
- Mapper XML 파일 생성
    - 위치: src/main/resources/mapper/post/PostMapper.xml
    - 네임스페이스: com.example.vibeapp.post.PostRepository
    - SQL 매핑: CRUD 및 페이징 처리에 필요한 SQL문 작성
- PostRepository 인터페이스 수정
    - @Mapper 어노테이션 추가
    - 메서드 시그니처는 기존과 동일하게 유지
```

#### 게시글 조회할 때 조회수 증가 기능 구현하기

```
게시글 조회할 때 조회수가 1 증가하는 기능을 추가해줘.
```

### 실습 8 - 트랜잭션 적용하기

#### 게시글 태그 정보를 저장할 테이블 생성

```
게시글의 태그 정보를 저장할 테이블 생성 SQL문을 작성해줘.
- 테이블명: POST_TAGS
- 컬럼:
    - ID: Primary key, 자동 증가
    - POST_NO: 게시글 번호, POSTS 테이블의 NO 컬럼을 참조하는 외래 키
    - TAG_NAME: 태그 이름, 최대 50자, 필수 입력
```

#### 게시글 태그 엔티티 클래스 만들기

```
게시글 태그 정보를 다루는 PostTag 엔티티 클래스를 만들어줘.
- 패키지: com.example.vibeapp.post
- 필드:
    - id(Long): 태그 고유 번호
    - postNo(Long): 게시글 번호
    - tagName(String): 태그 이름
```

#### 게시글 태그 Repository 만들기

```
PostTag 엔티티를 다루는 PostTagRepository 인터페이스를 만들어줘.
- 패키지: com.example.vibeapp.post
- 메서드: 태그 추가, 태그 삭제 기능만 구현.

PostTagRepository의 MyBatis SQL Mapper 파일을 만들어줘.
- Mapper XML 파일:
    - 위치: src/main/resources/mapper/post/PostTagMapper.xml
    - 네임스페이스: com.example.vibeapp.post.PostTagRepository
    - DB 테이블: POST_TAGS 
    - SQL 매핑: 태그 추가, 태그 삭제에 필요한 SQL문 작성

PostTagRepository 인터페이스와 Mybatis Mapper를 연동해줘. 
```

#### 게시글 등록폼과 수정폼에 태그 입력 기능 추가하기

```
게시글 등록폼과 수정폼에 태그를 입력할 수 있는 기능을 추가해줘.
- 입력 방식: 쉼표(,)로 구분된 태그 문자열 입력
- 등록폼:
    - URL: /posts/new
    - 입력 항목에 태그 입력 필드 추가
- 수정폼:
    - URL: /posts/{no}/edit
    - 입력 항목에 태그 입력 필드 추가
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 리포지토리 클래스: PostRepository, PostTagRepository
- 뷰 템플릿 파일: 
    - 게시글 작성 화면: post_new_form.html  
    - 게시글 수정 화면: post_edit_form.html
```

#### 게시글 상세 조회 페이지에 태그 출력 기능 추가하기

```
게시글 상세 조회 페이지에 해당 게시글의 태그를 출력하는 기능을 추가해줘.
- 출력 위치: 게시글 제목 아래
- 컨트롤러 클래스: PostController
- 서비스 클래스: PostService
- 리포지토리 클래스: PostRepository, PostTagRepository
- 뷰 템플릿 파일: 
    - 게시물 상세 화면: post_detail.html
```

#### 트랜잭션 미적용 시 문제점 확인하기

- 게시글을 등록할 때 태그 추가에 실패하는 상황을 시뮬레이션한다.
    - 게시글을 입력 시 3개의 태그를 입력한다.
    - 두 번째 태그는 DB 컬럼의 길이를 초과한 값을 입력한다.
    - 게시글 등록할 때 발생하는 예외를 확인한다.
    - 게시글 목록에서 방금 등록한 게시글이 있는지 확인한다.
    - 게시글 상세 조회에서 태그가 몇 개 저장되었는지 확인한다.

#### 게시글 등록과 태그 등록을 하나의 트랜잭션으로 묶기

```
- 프로젝트의 트랜잭션 기능을 활성화해줘.
- 게시글 등록과 태그 등록을 하나의 트랜잭션으로 묶어줘.
- 게시글 수정과 태그 수정을 하나의 트랜잭션으로 묶어줘.
```

#### 트랜잭션 적용 후 문제점 해결 여부 확인하기

- 게시글 등록할 때 태그 추가에 실패하는 상황을 다시 시뮬레이션한다.
    - 게시글을 입력 시 3개의 태그를 입력한다.
    - 두 번째 태그는 DB 컬럼의 길이를 초과한 값을 입력한다.
    - 게시글 등록할 때 발생하는 예외를 확인한다.
    - 게시글 목록에서 방금 등록한 게시글이 있는지 확인한다.

### 실습 9 - SQL Mapper를 ORM으로 바꾸기

#### MyBatis SQL Mapper에서 JPA ORM으로 전환하는 프롬프트 생생하기

```
현재 프로젝트를 MyBatis(SQL Mapper) 기반 구현에서 "순수 JPA ORM(EntityManager)사용" 방식으로 전환하고 싶다. 코딩 에이전트에게 요청할 프롬프트 예시를 작성해줘.
```

#### 코드 생성하기
```
현재 프로젝트를 MyBatis(SQL Mapper) 기반 구현에서 "순수 JPA ORM(EntityManager)사용" 방식으로 전환해줘.
현재 프로젝트 상태는 프로젝트 명세서(PROJECT_SPEC.md) 파일에 저장되어 있어.

## 작업 목표:
    - MyBatis를 제거하고 순수 JPA(EntityManager)로 전환한다.
    - 주의: Spring Data JPA Repository는 사용하지 말라. EntityManager를 직접 사용해야 한다.

## 작업 요청사항:
1. 의존성 변경해줘. (build.gradle)
    - mybatis는 제거해줘.
2. JPA 설정 (application.yml)
    - 다음 설정을 YAML 형식에 맞춰서 변환하여 추가해줘:
    ```properties
    # JPA/Hibernate 설정
    spring.jpa.hibernate.ddl-auto=validate
    spring.jpa.show-sql=true
    spring.jpa.properties.hibernate.format_sql=true
    ```
3. Entity 클래스 변경
    - DB 테이블: POSTS, POST_TAGS
    - DB 테이블에 맞춰 기존 Post 클래스를 JPA Entity로 변경해줘.
4. Repository 계층 재구현
    - 중요: EntityManager를 직접 사용하여 PostRepository 클래스를 리팩토링해줘.
5. Mybatis 관련 코드 제거
    - Mpper 인터페이스 삭제
    - SQL Mapper XML 삭제
6 src/main/resources/schema.sql은 그대로 둔다.

## 제약사항 및 주의사항
### 반드시 지켜야 할 사항:
1. Spring Data JPA의 JpaRepository 인터페이스는 절대 사용하지 말라.
2. JPQL 사용
   - findAll() 같은 목록 조회는 JPQL로 작성
   - 예: `em.createQuery("SELECT p FROM Post p", Post.class).getResultList()`

3. 트랜잭션 유지
   - @Transactional은 Service 계층에만 유지
   - Respository 계층에는 선언하지 말 것.
   - JPA는 트랜잭션 내에서 동작해야 함

4. 영속성 컨텍스트 활용
   - update() 메서드는 변경 감지(Dirty Checking) 또는 merge() 사용
   - 주석으로 동작 원리 간단히 설명

### 코드 품질 요구사항
- 초급 학습자를 위한 명확하고 읽기 쉬운 코드
- 각 메서드에 JPA 동작 원리 주석 추가 (한 줄 정도)
- 예외 처리는 간단하게 (Optional, orElseThrow 활용)

```

### 실습 10 - Spring Data JPA로 리팩토링하기

```
# 프로젝트 전환 요청: 순수 JPA → Spring Data JPA

## 프로젝트 현재 상태
- EntityManager를 직접 사용하는 PostRepository 클래스 구현 완료
- JPQL로 쿼리 작성
- persist(), find(), createQuery() 등 직접 호출
- 페이징: setFirstResult(), setMaxResults() 사용
- 모든 CRUD 메서드를 수동으로 구현

## 목표
순수 JPA Repository를 Spring Data JPA로 리팩토링한다.
코드 감소와 생산성 향상을 체감하는 것이 핵심이다.

## 작업 요청사항

### 1. 의존성 확인 (build.gradle)
현재 `spring-boot-starter-data-jpa`를 이미 포함하고 있다.
추가할 의존성이 있는지 확인하여 추가해줘.

### 2. 기존 Repository 백업
리팩토링 전 기존 코드를 비교할 수 있도록:
- 현재 Repository 클래스들의 이름 뒤에 접미사 "Old"를 붙여서 별도 파일로 백업
- Before/After 비교를 위해 보존 필수

### 3. 기존 Repository를 Spring Data JPA Repository 로 변경

## 제약사항 및 주의사항

### 반드시 지켜야 할 사항

1. 인터페이스로 작성
   - 기존 Repository 클래스는 interface여야 함
   - @Repository 어노테이션 불필요 (JpaRepository 상속 시 자동)
   - 구현 클래스를 만들지 말라. (Spring Data JPA가 자동 생성)
2. 메서드 이름 규칙 준수
    - findBy + 필드명 + 조건
    - 예: findByTitle, findByTitleContaining, findByTitleAndContent

### 코드 품질 요구사항

- 각 Query Method에 주석으로 동작 설명 추가
- Before/After 비교 가능하도록 기존 코드 보존

```

### 실습 11 - 세션 기반 사용자 인증하기(without Spring Security)

#### 사용자 테이블 생성하기

```
사용자 정보를 저장할 테이블 생성 SQL문을 작성해줘.
- 테이블명: USERS
- 컬럼:
    - NO: Pimary key, 자동 증가
    - NAME: 최대 50자, 필수 입력
    - EMAIL: 최대 50자, 필수 입력, 고유 값
    - PASSWORD: 최대 200자, 필수 입력
    - CREATED_AT: 기본값은 현재 시각
```

#### 회원가입 구현하기

```
USERS 테이블에 맞춰서 회원가입을 처리하는 기능을 추가할 것이다. 적절한 프롬프트를 알려줘.
```

```
# 요청: 회원가입 기능 구현
## 1. 개요
최근 [schema.sql]에 추가된 `USERS` 테이블을 바탕으로 회원가입 기능을 구현해줘. 
기존 프로젝트의 디자인 가이드라인(Glassmorphism, Bootstrap 5)을 엄격히 준수해야 해.

## 2. 작업 상세
### 백엔드 (Java)
1. Entity: `com.example.vibeapp.user.User` 엔티티 클래스 작성 (`@Entity`, `@Table(name="USERS")` 적용)
2. Repository: `UserRepository` 인터페이스 작성 (`Spring Data JPA` 사용)
    - 이메일 중복 확인을 위한 `existsByEmail(String email)` 메서드 포함
3. DTO: 회원가입 요청을 처리할 `UserSignupDto` (Spring Validation 적용: 이름/이메일 필수, 이메일 형식 체크 등)
4. Service: `UserService` 작성
    - 이메일 중복 시 예외 발생 처리
    - 비밀번호 암호화 로직 (현재 단계에서는 단순화를 위해 평문 또는 간단한 해싱 처리 로직만 위치 확보)
5. Controller: `UserController` 작성
    - `GET /signup`: 회원가입 폼 화면 반환
    - `POST /signup`: 회원가입 처리 후 메인 화면(`/`)으로 리다이렉트 (성공 메시지 포함)
### 프론트엔드 (Thymeleaf/CSS)
1. View: `src/main/resources/templates/user/signup.html` 생성
    - 기존 `home.html`의 'Glassmorphism 스타일'과 '애니메이션 효과'를 그대로 적용
    - 이름, 이메일, 비밀번호, 비밀번호 확인 필드 포함
    - Bootstrap 5의 검증 스타일(is-invalid)을 사용해 에러 메시지 표시
## 3. 제약 및 요구사항
- [PROJECT_SPEC.md]의 파일 구조 및 프로젝트 상태 섹션을 업데이트할 것.
- 모든 날짜 처리는 기존 규칙대로 `yyyy-MM-dd` 형식을 고려할 것.
- 패키지 구조는 `com.example.vibeapp.user`를 사용하여 기능별로 분리할 것.
```

#### 로그인 및 로그아웃 기능 구현하기

```
로그인 및 로그아웃 기능을 추가할 것이다. 적절한 프롬프트를 알려줘.
```

```
# 요청: 로그인 기능 구현 (HttpSession 기반)

## 1. 개요
이미 구현된 `USERS` 테이블과 회원가입 기능을 바탕으로 로그인 기능을 구현해줘. 
Spring Security 없이 `HttpSession`을 직접 사용하는 방식으로 진행하며, 기존 디자인 가이드라인(Glassmorphism)을 준수해야 해.

## 2. 작업 상세

### 백엔드 (Java)
1. DTO: `UserLoginDto` (이메일, 비밀번호 필수 검증 포함)
2. Service: [UserService]에 `login` 메서드 추가
    - 이메일로 사용자 조회 후 비밀번호 일치 여부 확인
    - 인증 실패 시 적절한 예외 발생
3. Controller: [UserController]에 로그인 처리 추가
    - `GET /login`: 로그인 폼 화면 반환
    - `POST /login`: 로그인 처리 후 성공 시 `HttpSession`에 사용자 정보 저장 및 `/`으로 리다이렉트
    - `GET /logout`: 세션 만료 처리 및 홈 화면으로 리다이렉트

### 프론트엔드 (Thymeleaf/CSS)
1. View: `src/main/resources/templates/user/login.html` 생성
    - `signup.html`과 동일한 **Glassmorphism 디자인** 적용
    - 이메일, 비밀번호 입력 필드 및 로그인 버튼 포함
2. Navigation/Home: `home.html` 및 공통 레이아웃 반영
    - 세션에 로그인 정보가 있는 경우: "로그아웃", "XX님 환영합니다" 표시
    - 세션에 정보가 없는 경우: "로그인", "회원가입" 링크 표시

## 3. 제약 및 요구사항
- [PROJECT_SPEC.md]의 파일 구조 및 프로젝트 상태 섹션을 업데이트할 것.
- 로그인 성공/실패 시 `RedirectAttributes`를 사용하여 사용자에게 알림 메시지를 전달할 것.
- `src/main/java/com/example/vibeapp/user` 패키지 내에 관련 클래스들을 위치시킬 것.
```

#### 인가 기능 구현하기

```
'인가(authorization)'' 기능을 추가할 것이다. 
- 로그인한 사용자만 게시글 작성할 수 있다.
- 게시글 수정과 삭제는 그 게시글을 작성한 사용자만 할 수 있다.
- 이런 '인가' 기능은 중앙에서 관리한다.
이런 작업을 지시할 적절한 프롬프트를 알려줘.
```

```
현재 프로젝트에 Spring Security 없이 '세션 기반 인가(Authorization)' 기능을 중앙 집중식으로 구현해줘. 구체적인 요구사항은 다음과 같아:

1. 데이터 스키마 수정:
- POSTS 테이블에 작성자를 식별할 수 있는 user_no 컬럼을 추가하고 USERS 테이블에 대한 외래 키(FK)를 설정해줘.
- Post 엔티티와 관련 DTO(PostCreateDto 등)에도 작성자 정보를 반영해줘.

2. 중앙 집중식 인증 체크 (Authentication Interceptor):
- HandlerInterceptor를 구현하여 로그인 여부를 체크하는 기능을 중앙에서 관리해줘.
- 게시글 작성(/posts/new, /posts/add), 수정, 삭제와 같이 로그인이 필요한 경로(PathPatterns)에 대해 인터셉터를 적용하고, 비로그인 사용자는 로그인 페이지로 리다이렉트해줘.

3. 게시글 소유권 확인 로직 (Ownership Check):
- 게시글 수정 및 삭제 시, **'현재 로그인한 유저'**와 **'게시글 작성자'**가 일치하는지 확인하는 로직을 추가해줘.
- 이 기능은 PostService에서 처리하거나 별도의 권한 관리 컴포넌트를 통해 중앙에서 수행될 수 있도록 해줘. 권한이 없는 경우 적절한 예외를 던지고 유저에게 안내 메시지를 보여줘야 해.

4. UI 동적 렌더링:
게시글 상세 페이지(post_detail.html)에서 현재 로그인한 사용자가 게시글의 작성자일 경우에만 '수정' 및 '삭제' 버튼이 보이도록 Thymeleaf 코드를 수정해줘.

5. 문서 업데이트:
변경된 데이터 구조와 인가 정책을 
PROJECT_SPEC.md
에 반영해줘.
```

#### 사용자 비밀번호 암호화하기

```
사용자 비밀번호가 DB에 평문으로 저장되어 있다. 이것을 암호화하여 저장하고 싶다. 로그인할 때도 암호화된 비밀번호와 비교하도록 처리하고 싶다. 암호화는 Spring Security의 BCryptPasswordEncoder를 사용하여 처리한다. 다만, Spring Security를 적용하지는 않는다. 이런 요구사항을 프롬프트로 작성해줘. 
```

```
[목표] 현재 프로젝트의 사용자 비밀번호를 평문 저장 방식에서 BCrypt 암호화 저장 방식으로 리팩토링한다.

[상세 요구사항]

1. 의존성 추가: build.gradle에 BCryptPasswordEncoder를 사용하기 위한  의존성을 추가한다. Spring Security 전체를 추가하지 않고, 암호화 기능만 사용할 수 있도록 한다.
3. Bean 등록: 
WebConfig.java
 또는 별도의 설정 클래스에서 BCryptPasswordEncoder를 @Bean으로 등록한다.
4. 회원가입 로직 수정: UserService.signup()에서 사용자가 입력한 평문 비밀번호를 passwordEncoder.encode()를 사용하여 암호화한 뒤 DB에 저장한다.
5. 로그인 로직 수정: UserService.login()에서 String.equals() 대신 passwordEncoder.matches(rawPassword, encodedPassword)를 사용하여 암호화된 비밀번호와 입력값을 검증한다.
6. 데이터베이스 확인: 
schema.sql
의 users 테이블 password 컬럼 길이가 암호화된 해시값(약 60자 이상)을 충분히 담을 수 있는지 확인한다. (이미 VARCHAR(200)인 경우 유지)
```

### 실습 12 - Spring Security 도입하기

```
현재 프로젝트에 Spring Security를 도입하여 인증 및 인가 기능을 구현하고 싶다.
다음 요구사항을 반영한 프롬프트를 작성해줘.
- 사용자 인증: Spring Security의 인증 매커니즘을 사용하여 로그인 및 로그아웃 기능 구현
- 비밀번호 암호화: BCryptPasswordEncoder를 사용하여 비밀번호 암호화
- 인가(Authorization): 특정 URL 경로에 대한 접근 제어 설정
- 세션 관리: 동시 세션 제어 및 세션 고정 보호 설정
- CSRF 보호: CSRF 공격 방지를 위한 설정 활성화
- 커스텀 로그인 페이지: 기존 로그인 페이지를 Spring Security와 통합 
```

```
# VibeApp Spring Security 통합 구현 요청

## 프로젝트 환경:
PROJECT_SPEC.md 파일에 명시된 현재 프로젝트 상태를 기준으로 작업을 진행해줘.

## 요구사항 상세:

### Spring Security 의존성 추가 및 기본 설정:

- build.gradle에 spring-boot-starter-security 의존성을 추가해줘.
- SecurityConfig 설정을 통해 Security Filter Chain을 구성해줘.

### 사용자 인증 (Authentication):

- Spring Security의 표준 인증 메커니즘을 사용해줘.
- 기존 User 엔티티와 UserRepository를 활용하여 UserDetailsService 및 UserDetails를 구현해줘.
- 사용자 식별값은 email을 사용해줘.
- 로그아웃 기능을 구현하고, 로그아웃 시 세션 무효화 및 홈 화면(/) 리다이렉트를 처리해줘.

### 비밀번호 암호화:

- BCryptPasswordEncoder를 PasswordEncoder 빈으로 등록하여 사용해줘.
- 회원가입 시 비밀번호를 암호화하여 저장하고, 로그인 시 암호화된 비밀번호와 비교하도록 설정해줘.

### 인가 (Authorization):

- 특정 URL 경로에 대한 접근 제어를 설정해줘.
    - 전체 허용: /, /signup, /login, /css/**, /js/**, /images/**, /h2-console/**
    - 인증 필요: /posts/** (게시글 작성, 수정, 삭제, 상세 조회 등 모든 게시글 관련 활동)

### 세션 관리 (Session Management):

- 동시 세션 제어: 사용자당 최대 세션 수를 1개로 제한하고, 기존 세션을 만료시키는 방식을 적용해줘.
- 세션 고정 보호: 로그인 시 세션 ID를 새로 생성하는 migrateSession 설정을 적용해줘.

### CSRF 보호:

- CSRF 공격 방지를 위한 설정을 활성화해줘.
- 개발 편의를 위해 /h2-console/** 경로는 CSRF 검사에서 제외해줘.
- Thymeleaf의 th:action을 사용하여 폼(Form)에서 CSRF 토큰이 자동으로 포함되도록 확인해줘.

### 커스텀 로그인 페이지 통합:

- 기존에 작성된 user/login.html 페이지를 Spring Security의 로그인 페이지로 지정(loginPage("/login"))해줘.
- 로그인 성공 시 /로 리다이렉트되도록 설정해줘.

### 기존 코드 정리 (Legacy Cleanup):

- UserController에서 HttpSession을 직접 관리하던 로그인/로그아웃 로직을 제거해줘.
- 기존의 LoginInterceptor 및 WebConfig 내 인터셉터 등록 코드를 Spring Security 설정으로 대체하며 삭제해줘.
- WebConfig에 선언된 PasswordEncoder 빈을 SecurityConfig로 이동해줘.
- 위 요구사항을 바탕으로 build.gradle, SecurityConfig, UserDetailsService 구현체, 그리고 수정이 필요한 Controller 및 View 파일들을 순서대로 작성해줘.
```

### 실습 13 - SSR 방식에서 CSR 방식으로 전환하기 

```
현재 프로젝트를 SSR(서버 사이드 렌더링) 방식에서 CSR(클라이언트 사이드 렌더링) 방식으로 전환하고 싶다. 다음 요구사항을 반영한 실행 계획을 작성해줘.
- Controller 클래스:
    - @Controller → @RestController 변경
    - ResponseEntity 사용하여 JSON 응답 반환
    - REST API 설계 원칙에 따라 엔드포인트 설계
    - REST API 엔드포인트 예시:
        - 게시글 목록 조회: GET /api/posts
        - 게시글 상세 조회: GET /api/posts/{no}
        - 새 게시글 등록: POST /api/posts
        - 게시글 수정: PATCH /api/posts/{no}
        - 게시글 삭제: DELETE /api/posts/{no}
- 예외 처리: 
    - @RestControllerAdvice 사용하여 전역 예외 처리
    - JSON 형식으로 에러 응답 반환
- 프론트엔드:
    - 기존의 Thymeleaf 뷰 템플릿을 정적 리소스 파일(HTML, CSS, JS)로 변경
    - Fetch API를 사용하여 REST API와 통신
    - Thymeleaf 뷰 템플릿 제거
```

### 실습 14 - 토큰(JWT) 기반 인증 방식으로 전환하기

```
현재 프로젝트의 인증 방식을 세션 기반에서 토큰(JWT) 기반 인증 방식으로 변경하려 한다.
예시 프롬프트를 작성해줘.
```

```
요청: 현재 프로젝트의 세션 기반 인증을 JWT 기반 인증으로 전환해줘

1. 개요 
- 현재 HttpSession을 사용하는 세션 기반 인증 방식을 JWT(JSON Web Token) 기반의 무상태(Stateless) 인증 방식으로 변경하고 싶어. 프론트엔드와 백엔드 모두에 필요한 작업을 수행해줘.

2. 백엔드 요구사항

- 의존성 추가: JWT 구현을 위해 jjwt 라이브러리(또는 최신 Java 25와 호환되는 JWT 라이브러리)를 build.gradle에 추가해줘.
- JWT 유틸리티 클래스 구현: 토큰 생성, 검증, 클레임 추출 기능을 가진 JwtTokenProvider 클래스를 만들어줘. (Secret Key는 환경 설정 파일에서 관리하도록 설정)
- 로그인 API 수정: 
    - 로그인 성공 시 세션을 생성하는 대신 JWT 액세스 토큰을 생성해서 JSON 응답 바디로 반환해줘.
    - 응답 바디 예시: {"accessToken": "...", "tokenType": "Bearer", "userName": "..."}
- SecurityConfig 수정:
    - 세션 정책을 SessionCreationPolicy.STATELESS로 변경해줘.
    - 모든 요청에서 JWT를 검증할 수 있도록 JwtAuthenticationFilter를 커스텀 필터로 등록해줘.
    - 기존의 formLogin 핸들러 대신 JWT 기반의 커스텀 필터나 컨트롤러 로직을 사용하도록 변경해줘.

3. 프론트엔드 요구사항

- 로그인 처리 (login.html): 로그인 성공 시 서버에서 받은 accessToken을 localStorage에 저장하도록 수정해줘.
- 인증 요청 처리: 모든 fetch 요청 시 헤더에 Authorization: Bearer <token>을 포함하도록 공통 로직을 수정해줘.
- 상태 체크 및 로그아웃:
    - index.html에서 인증 상태를 체크할 때 localStorage의 토큰 유무를 확인하고, 로그아웃 시 토큰을 삭제하도록 처리해줘.

4. 기타
- 전환 과정에서 PROJECT_SPEC.md를 최신 상태로 업데이트해줘.
- 기존의 세션 기반 인터셉터나 설정 중 더 이상 필요 없는 코드는 정리해줘.
```

### 실습 15 - Refresh Token 및 인증 고도화하기

```
Refresh Token 기능을 추가하려 한다. 너에게 어떤 것을 알려줘야 하는가? 
```

```
현재 프로젝트에 Refresh Token 기능을 추가하라. 
다음은 기능 구현에 필요한 요구사항이다.

1. 저장소(Persistence) 방식
- RDB: 기존 data/testdb를 활용하여 테이블을 추가한다.

2. Token 형식
- Refresh Token도 JWT 형식이다.

2. Token의 형태 및 만료 시간
- Access Token 만료 시간: 15분
- Refresh Token 만료 시간: 7일

3. API 설계 및 보안 방식
- 전달 방식: Refresh Token을 LoginResponse JSON에 포함한다.
```

```
Refresh Token 기능을 웹페이지에 적용해줘.
```

```
웹 페이지에서 로그아웃을 할 때 Refresh Token도 함께 삭제하도록 수정해줘.
```

### 16. 인증 보안 고도화 및 계정 보호 전략

```
Redis를 활용한 토큰 블랙리스트 기반 무효화 기능을 추가하려 한다.
구현하지는 말고, 너에게 어떤 정보를 알려줘야 하는지 프롬프트 예시를 먼저 작성해줘.
```

```
# 제목: Redis 기반 Access Token 블랙리스트 기능 추가

현재 구현된 JWT 인증 시스템에 Redis를 활용한 블랙리스트 기능을 추가하고 싶어. 로그아웃 시 Access Token을 무효화하는 것이 핵심이야. 다음 정보를 참고해서 작업해 줘.

## 현재 프로젝트 상태

- RDB로 Refresh Token을 관리하고 있다.
- 로그인 인증 흐름:
  1. 로그인
  2. Access Token + Refresh Token 발급
  3. Refresh Token은 DB에 저장
- Access Token 만료 시 흐름:
  1. Access Token 만료
  2. Refresh Token으로 재발급 요청
  3. 기존 RT 삭제 + 새 AT/RT 발급 (Rotation)
  4. 새 RT를 DB에 저장
- 로그아웃 흐름:
  1. 로그아웃
  2. Refresh Token을 DB에서 삭제
  3. 문제점: Access Token은 여전히 유효!

## 1. Redis 환경 구성
- Docker Compose를 사용한 Redis 설정 파일 작성
- 포트: 6379
- 데이터 영속성 설정 포함
- Redis 정상 동작 확인 방법

## 2. Spring Boot 연동
- build.gradle 의존성 추가
- application.yml Redis 설정
- RedisRepository 설정

### 3. 상세 구현 요구사항:

- 로그아웃 로직: /api/logout 호출 시, 현재 요청 헤더의 Access Token을 추출해서 Redis에 저장해 줘.
- TTL 설정: 블랙리스트에 저장될 키의 만료 시간은 해당 토큰의 남은 유효 시간만큼 자동으로 설정되게 해 줘.
- 인증 필터 수정: 
JwtAuthenticationFilter 에서 토큰이 유효하더라도 Redis 블랙리스트에 해당 토큰이 존재하는지 매번 확인하는 로직을 추가해 줘.

### 4. 기타 설정:

- 사용할 Redis 키의 접두사(Prefix) 규칙: (예: blacklist:token:{JWT})
- Redis 연동을 위한 전용 RedisConfig 설정 클래스 작성
- 이 정보를 바탕으로 백엔드(Java 보완) 및 설정 파일(YAML) 수정을 진행해 줘.
```

로그인 및 로그아웃 후, Blacklist에 저장된 토큰 확인하기 
```
redis에 저장된 값을 조회해줘.
```

RTS 적용 및 Relay Attack 탐지 및 차단 로직 구현하기
```
Refresh Token Rotation 적용 여부를 확인하여, 구현이 안되어 있으면 구현해줘. 
또한 재사용 공격(Replay Attack) 탐지 및 자동 차단 로직을 구현해줘.
```

Brute Force 공격 방어 기능 추가하기
```
# Brute Force 공격을 방어하는 기능을 추가해줘.
- Rate Limiting
- 로그인 실패 횟수 제한

# 기능 추가 후 Brute Force 공격에 대한 방어를 테스트해서 확인해줘.
```

Audit 로그 기록 기능 추가하기
```
# 사용자 인증 및 인가 관련 이벤트에 대한 Audit 로그 기록 기능을 추가해줘.
## 기록할 이벤트:
- 로그인 시도 (성공/실패)
- 로그아웃
- 토큰 재발급
- 비밀번호 변경
## 기록 방법
- 로그는 audit.log 로그 파일에 기록되도록 설정해줘.
- 로그 형식은 NDJSON(Newline Delimited JSON) 형식으로 저장해줘.
## 구현 방식
- AOP를 활용하여 로그 기록을 자동으로 처리하도록 구현해줘. 
- @annotation() 패턴을 사용해줘.
```

## 17. OpenAPI로 REST API 문서 자동화하기

```
17단계 "OpenAPI로 REST API 문서 자동화하기"를 현재 프로젝트에 적용하려면, 너에게 어떤 내용을 알려줘야 하는가? 프롬프트 예시를 작성해줘.
```

프롬프트 예시:
```
# 현재 프로젝트(VibeApp)에 springdoc-openapi를 적용해서 OpenAPI 문서를 자동화해줘.

## 적용 범위:
- build.gradle에 springdoc-openapi 의존성 추가 (Spring Boot 4.x 호환 버전)
- SecurityConfig.java에 Swagger UI 및 /v3/api-docs 접근 허용 설정 추가
- JWT Bearer 토큰 인증 설정을 포함한 OpenAPI 전역 설정 클래스 (OpenApiConfig.java) 생성
- PostController, UserController의 모든 엔드포인트에 @Operation, @ApiResponse 어노테이션 추가
- Request/Response DTO(PostCreateDto, PostResponseDTO, LoginRequest, LoginResponse 등)에 @Schema 어노테이션 추가
- 401, 403, 404, 429, 500 공통 에러 응답을 ErrorResponse 기준으로 문서화
application.yml에 Swagger UI 관련 설정 추가

## 제약 조건:

- Spring Boot 4.0.1, JDK 25 환경에 맞는 springdoc-openapi 버전을 사용할 것
- 기존 코드의 비즈니스 로직은 변경하지 말 것
- Swagger UI에서 Bearer 토큰을 입력하여 인증이 필요한 /api/posts/**, /api/user/**, /api/logout API를 직접 테스트할 수 있어야 함
```

git commit: git-message-format.md 파일은 문서 파일 참조
```
# 현재 프로젝트의 작업 내용을 git commit 해줘.

- git commit message 형식: git-message-format.md 파일의 내용을 참조하라.

## 작업 주제
프로젝트(VibeApp)에 springdoc-openapi를 적용해서 OpenAPI 문서 자동화

## 작업 내용:
- build.gradle에 springdoc-openapi 의존성 추가 (Spring Boot 4.x 호환 버전)
- SecurityConfig.java에 Swagger UI 및 /v3/api-docs 접근 허용 설정 추가
- JWT Bearer 토큰 인증 설정을 포함한 OpenAPI 전역 설정 클래스 (OpenApiConfig.java) 생성
- PostController, UserController의 모든 엔드포인트에 @Operation, @ApiResponse 어노테이션 추가
- Request/Response DTO(PostCreateDto, PostResponseDTO, LoginRequest, LoginResponse 등)에 @Schema 어노테이션 추가
- 401, 403, 404, 429, 500 공통 에러 응답을 ErrorResponse 기준으로 문서화
application.yml에 Swagger UI 관련 설정 추가
```

git push:
```
git push 해줘.
```

## 18. Node.js + Express로 프론트엔드 완전 분리하기

### REST API 백엔드 프로젝트

```
현재 프로젝트를 REST API 서버로 전환할 수 있게 다음 작업을 수행해줘. 
- 프론트엔드 관련 코드를 완전히 제거해줘.
- 프론트엔드 서버가 요청할 수 있도록 CORS 설정을 추가해줘.
- 허용할 출처(origin): http://localhost:3000
```

### 프론트엔드 프로젝트

#### AGENTS.md 파일 준비

```
# AI Agent Guide for My REST App

이 파일은 코딩 에이전트가 이 프로젝트의 맥락을 이해하고 일관성 있게 작업을 수행할 수 있도록 돕기 위한 지침서이다.

## 프로젝트 개요
- **목적**: REST API 서버(Spring Boot 기반)에서 제공하는 OpenAPI 명세를 바탕으로 한 현대적인 프론트엔드 웹 서비스 구축.
- **아키텍처**: Node.js + Express (프론트엔드 서버) + 정적 HTML 페이지 기반의 MPA(Multi-Page Application) 구조.

## 작업 완료할 때마다 할 일
- **작업 내용의 정상 동작을 확인(검증)한 후**, 정의된 형식에 맞춰 `git commit` 및 `git push`를 수행한다.
- **Git Commit 메시지 형식**: `./docs/git-message-format.md`를 엄격히 준수한다.

## 에이전트 주의 사항
- **REST API 요청**: 프론트엔드 서버를 통한 프록시가 아닌, 클라이언트(브라우저)에서 REST API 서버(`http://localhost:8080`)로 직접 요청을 보낸다.
```

#### 프롬프트 준비하기
```
코딩 에이전트에게 다음 작업을 단계 별로 수행시킬 수 있도록 여러 개의 작업으로 나누고, 각 작업에 대한 프롬프트를 작성해줘.

# REST API 서버에서 제공하는 OpenAPI 명세를 기반으로 현재 작업 디렉토리를 프론트엔드 프로젝트로 구성해줘.
## 주요 요구사항:
- 서버 아키텍처: Node.js + Express + 정적 HTML 페이지 기반의 MPA(Multi-Page Application) 구조.
- 웹 페이지: HTML5, CSS3 (Vanilla CSS), JavaScript (Vanilla JS, ES6+) 사용.
- REST API 서버: http://localhost:8080 (CORS 허용됨)
- REST API 서버가 제공하는 OpenAPI 명세: http://localhost:8080/v3/api-docs
- AJAX: Fetch API를 사용하여 REST API와 통신하도록 구현해줘. REST API 서버에 직접 요청하여 데이터를 가져오도록 구현해줘.
- REST API 서버 인증 방식: 
  - Type: Bearer Token
  - Token: JWT 토큰
  - Access Token + Refresh Token
  - 토큰 저장: JWT 토큰과 Refresh Token을 localStorage에 저장
- .env 파일을 활용하여 개발 환경과 운영환경에서의 REST API URL을 분리해줘.
```


#### 1단계: 프로젝트 초기 설정 및 환경 구축
**목표:** 프로젝트 구조 초기화 및 서버 설정.

**프롬프트:**
```text
현재 디렉토리를 프론트엔드 애플리케이션을 위한 Node.js 프로젝트로 초기화해줘.
- `package.json`을 생성하고 `express`와 `dotenv`를 설치해.
- `.env` 파일을 생성하고 다음 내용을 포함해:
  REST_API_DEV_URL=http://localhost:8080
  REST_API_PROD_URL=https://api.yourdomain.com
- `public/` 디렉토리의 정적 파일을 서비스하는 `server.js`를 Express로 작성해.
- (중요) 모든 경로를 index.html로 보내지 마. 사용자가 각 html 파일에 직접 접근할 수 있도록 기본 정적 서비스만 구성해.
- 기본 폴더 구조를 생성해: `public/`, `public/js/`, `public/css/`, `public/assets/`.
```

---

#### 2단계: API 클라이언트 및 인증 로직 구현
**목표:** JWT 관리를 포함한 견고한 통신 레이어 구축.

**프롬프트:**
```text
REST API와 통신을 담당할 `public/js/api.js`를 작성해줘.
- `Fetch API`를 사용해.
- 통신 시 `localStorage`에 토큰이 있다면 `Authorization: Bearer <token>` 헤더를 자동으로 추가하는 공통 요청 함수를 구현해.
- `access_token`과 `refresh_token`을 `localStorage`에 저장하고 관리해.
- 401 Unauthorized 에러 시 토큰 갱신 로직 및 실패 시 `login.html`로 이동하는 로직을 포함해.
```

---

#### 3단계: 정적 HTML 템플릿 및 스타일링
**목표:** 주요 기능별 정적 HTML 파일 생성.

**프롬프트:**
```text
애플리케이션의 주요 페이지를 정적 HTML 파일로 구현해줘.
- `public/index.html` (메인/대시보드)
- `public/login.html` (로그인)
- `public/signup.html` (회원가입)
- `public/css/style.css` (프리미엄 디자인 적용)
- 각 HTML 파일은 자바스크립트로 생성하지 않고 직접 작성하며, 필요한 데이터만 JS를 통해 바인딩해.
```

---

#### 4단계: 인증 플로우 구현 (로그인/회원가입)
**목표:** 페이지 이동 기반의 인증 흐름 구현.

**프롬프트:**
```text
로그인 및 회원가입 기능을 구현해줘.
- `login.html`과 `signup.html`의 폼 데이터를 캡처해서 API와 통신해.
- 성공 시 토큰을 저장하고 `location.href = '/index.html'`을 통해 페이지를 이동시켜.
```

---

#### 5단계: OpenAPI 데이터 연동 (기능별 HTML 페이지)
**목표:** OpenAPI 명세 기반의 각 리소스별 전용 HTML 페이지 구현.

**프롬프트:**
```text
OpenAPI 명세를 분석해서 각 리소스(예: 게시글 등)를 위한 전용 정적 HTML 파일을 제작해줘.
- `public/posts.html` (목록), `public/post_detail.html` (상세), `public/post_form.html` (등록/수정)
- JS는 페이지 로드 시 데이터를 가져와서 HTML의 플레이스홀더에 채워넣는 역할만 수행해.
```

---

#### 6단계: 최종 마무리 및 검증
**목표:** 전체 사용자 시나리오 검토 및 에러 처리.
```text
전체 페이지 간의 이동 및 인증 상태 유지를 점검해.
에러 발생 시 사용자에게 알림을 보여주고, 적절한 페이지로 리다이렉트 처리해.
```

## 19. 상태 기반 UI 모델, React로 프론트엔드 리팩토링하기

### AGENTS.md 파일 준비

```
# AI Agent Guide for My REST App

이 파일은 코딩 에이전트가 이 프로젝트의 맥락을 이해하고 일관성 있게 작업을 수행할 수 있도록 돕기 위한 지침서이다.

## 프로젝트 개요
- **목적**: REST API 서버(Spring Boot 기반)에서 제공하는 OpenAPI 명세를 바탕으로 한 현대적인 프론트엔드 웹 서비스 구축.

## 규칙:
- 작업은 현재 디렉토리에서 수행한다.
- 변경/생성/삭제한 파일 목록을 매 단계마다 요약해라.
- 실행해야 하는 커맨드는 정확히 제시하되, 실제 실행 여부는 사용자 환경에 맡긴다.
- 작업을 완료할 때 마다 작업 내용의 정상 동작을 확인(검증)한 후, 정의된 형식에 맞춰 `git commit` 및 `git push`를 수행한다.
- Git Commit 메시지 형식: `./docs/git-message-format.md`를 엄격히 준수한다.
```

### 프론트엔드 프로젝트 생성을 위한 프롬프트 준비하기

```
다음 작업을 여러 단계로 나눠서 진행할 수 있도록 여러 개의 작업 프롬프트를 작성해줘.

# REST API 서버에서 제공하는 기능을 활용하여 프론트엔드 프로젝트를 만들어줘.
## 주요 요구사항:
- 프로젝트 구조
    - 생성 위치: 현재 디렉토리를 프론트엔드 프로젝트로 초기화해줘. (따로 폴더를 만들지 않고, 현재 위치에서 작업)
    - 구현할 화면 목록:
        - 메인 페이지 (공개)
        - 로그인 페이지 (공개)
        - 회원가입 페이지 (공개)
        - 게시글 목록 페이지 (공개)
        - 게시글 상세 페이지 (공개)
        - 게시글 수정 페이지 (인증 필요)
        - 게시글 작성 페이지 (인증 필요)
    - 레이아웃: 상단 내비게이션 바와 하단 푸터가 포함된 기본 레이아웃을 생성해줘.
- 기술 스택
    - 애플리케이션 아키텍처: SPA(Single Page Application) 방식으로 구현해줘.
    - 빌드 도구: Vite latest 버전, react-ts 프로젝트 템플릿 사용
    - 라우팅: React Router DOM 사용
    - HTTP 통신: Fetch API 사용
    - CSS: Tailwind CSS 사용
    - UI 컴포넌트: shadcn/ui 사용
    - 서버 상태관리: useState + useEffect로 직접 구현 (별도 라이브러리 사용 안 함)
    - 클라이언트 상태 관리: React Context API 사용
    - .env 파일을 활용하여 개발 환경과 운영환경에서의 REST API URL을 분리해줘.
- 백엔드 서버 정보
    - REST API 서버 주소: http://localhost:8080
    - REST API 서버가 제공하는 OpenAPI 명세: http://localhost:8080/v3/api-docs
    - REST API 서버 인증 방식: 
        - Type: Bearer Token
        - Token: JWT 토큰
        - Access Token + Refresh Token
        - 토큰 저장 위치: Access Token과 Refresh Token을 localStorage에 저장
    - CORS: 허용됨
```

#### 1단계

```
# 작업 1. OpenAPI 명세 분석

http://localhost:8080/v3/api-docs 에서 OpenAPI 명세를 가져와서 분석해줘.

## 수행 절차
1. HTTP GET 요청으로 http://localhost:8080/v3/api-docs 의 JSON 데이터를 가져와.
2. 가져온 명세를 분석하여 다음 항목을 정리해줘.
   - API 엔드포인트 목록 (경로, HTTP 메서드, 요청/응답 스키마)
   - 인증이 필요한 엔드포인트와 필요하지 않은 엔드포인트 구분
   - 요청/응답에 사용되는 데이터 모델(스키마) 목록
   - 로그인/로그아웃/토큰 재발급 엔드포인트 식별
3. 분석 결과를 api-spec-summary.md 파일로 저장해줘.

## 완료 조건
- api-spec-summary.md 파일이 생성되었는가?
- 엔드포인트 목록이 정리되었는가?
- 인증 관련 엔드포인트가 식별되었는가?
```

#### 2단계

```
# 작업 2. 프로젝트 초기화 및 패키지 설치

현재 디렉토리에 Vite + React + TypeScript 프로젝트를 초기화하고 필요한 패키지를 설치해줘.

## 수행 절차
1. 아래 명령어로 현재 디렉토리에 프로젝트를 초기화해줘.
   npm create vite@latest . -- --template react-ts

2. 아래 패키지를 추가로 설치해줘.
   - react-router-dom (라우팅)
   - tailwindcss, @tailwindcss/vite (CSS)

3. shadcn/ui 를 아래 절차에 따라 설치 및 초기화해줘.
   npx shadcn@latest init

4. Tailwind CSS 설정을 완료해줘.

5. npm run dev 를 실행하여 정상 동작을 확인해줘.

## 완료 조건
- npm run dev 실행 시 오류 없이 브라우저에서 화면이 표시되는가?
- package.json 에 설치한 패키지들이 포함되어 있는가?
```

#### 3단계

```
# 작업 3. 환경 변수 및 API 클라이언트 구현

환경 변수 파일을 구성하고, Fetch API 기반의 HTTP 클라이언트를 구현해줘.

## 수행 절차

### 1. 환경 변수 파일 생성
아래 3개의 파일을 프로젝트 루트에 생성해줘.

[.env.development]
VITE_API_BASE_URL=http://localhost:8080

[.env.production]
VITE_API_BASE_URL=https://api.yourdomain.com

[.env.example]
VITE_API_BASE_URL=http://localhost:8080

.gitignore 에 .env.development, .env.production 이 포함되어 있는지 확인하고 없으면 추가해줘.

### 2. 환경 변수 타입 안전 관리 파일 생성
[src/config/env.ts]
- VITE_API_BASE_URL 을 타입 안전하게 export 해줘.

### 3. 토큰 저장소 유틸리티 생성
[src/utils/tokenStorage.ts]
- localStorage 에 accessToken, refreshToken 을 저장/조회/삭제하는 함수 구현
- getAccessToken(), setAccessToken(), getRefreshToken(), setRefreshToken(), clearTokens() 구현

### 4. Fetch API 래퍼 함수 생성
[src/api/fetchClient.ts]
- 모든 API 요청에 공통으로 사용할 fetch 래퍼 함수 구현
- Authorization: Bearer {accessToken} 헤더 자동 추가
- Content-Type: application/json 기본 설정
- 응답이 401일 경우 Refresh Token으로 Access Token 재발급 후 원래 요청 재시도
- Refresh Token도 만료된 경우 토큰 초기화 후 /login 으로 이동

## 완료 조건
- .env.development, .env.production, .env.example 파일이 생성되었는가?
- fetchClient.ts 가 401 응답 시 토큰 재발급 후 재시도하는가?
- tokenStorage.ts 의 함수들이 올바르게 동작하는가?
```

#### 4단계

```
# 작업 4. TypeScript 타입 정의 및 API 함수 구현

작업 1의 api-spec-summary.md 를 참고하여 TypeScript 타입과 API 함수를 구현해줘.

## 수행 절차

### 1. TypeScript 타입 정의
[src/types/]
- OpenAPI 명세의 스키마를 기반으로 도메인별 타입 파일을 생성해줘.
- 요청 타입(Request)과 응답 타입(Response)을 분리해줘.
  예시: CreatePostRequest, PostResponse
- 필수 필드와 선택 필드를 ? 로 구분해줘.
- 공통 API 응답 타입을 정의해줘.
  예시: ApiResponse<T> { data: T; message: string; status: number; }
- src/types/index.ts 에서 모든 타입을 re-export 해줘.

### 2. API 함수 구현
[src/api/]
- 작업 3에서 만든 fetchClient.ts 를 사용하여 도메인별 API 함수 파일을 생성해줘.
- 인증 관련 API (authApi.ts)
  - login(): Access Token + Refresh Token 응답 처리 후 localStorage 저장
  - logout(): 서버 로그아웃 요청 후 localStorage 토큰 삭제
  - refreshAccessToken(): Refresh Token으로 새 Access Token 발급
  - register(): 회원가입
- 도메인별 API (작업 1의 api-spec-summary.md 기준으로 생성)
  - 함수명: HTTP 메서드 + 리소스명 형태 (예: getPosts, createPost, updatePost, deletePost)
  - async/await 사용
- src/api/index.ts 에서 모든 API 함수를 re-export 해줘.

## 완료 조건
- 모든 타입에 Request/Response 가 분리되어 있는가?
- API 함수가 fetchClient.ts 를 사용하고 있는가?
- npm run build 실행 시 TypeScript 오류가 없는가?
```

#### 5단계

```
# 작업 5. 인증 상태 관리 및 라우팅 구현

React Context API로 인증 상태를 관리하고, React Router DOM으로 SPA 라우팅을 구현해줘.

## 수행 절차

### 1. 인증 Context 구현
[src/context/AuthContext.tsx]
- 전역 인증 상태 관리
- 상태: accessToken, isAuthenticated, isLoading
- 제공할 함수: login(username, password), logout()
- 앱 초기 로드 시 localStorage 에서 토큰을 읽어 인증 상태 초기화

### 2. PrivateRoute 컴포넌트 구현
[src/components/PrivateRoute.tsx]
- 인증되지 않은 사용자가 접근하면 /login 으로 redirect
- 인증 상태 로딩 중에는 로딩 스피너 표시

### 3. 라우팅 구현
[src/App.tsx]
- BrowserRouter 기반 라우팅 구성
- 아래 라우트 구성
  - / → 메인 페이지 (공개)
  - /login → 로그인 페이지 (공개)
  - /register → 회원가입 페이지 (공개)
  - /posts → 게시글 목록 페이지 (공개)
  - /posts/:id → 게시글 상세 페이지 (공개)
  - /posts/new → 게시글 작성 페이지 (PrivateRoute)
  - /posts/:id/edit → 게시글 수정 페이지 (PrivateRoute)
- AuthProvider 로 앱 전체를 감싸줘.

## 완료 조건
- 로그인하지 않은 상태에서 /posts/new 접근 시 /login 으로 이동하는가?
- 로그인 후 인증 상태가 전역으로 공유되는가?
- 모든 라우트가 정상 동작하는가?
```

#### 6단계

```
# 작업 6. 레이아웃 및 공통 컴포넌트 구현

공통 레이아웃과 재사용 가능한 공통 컴포넌트를 구현해줘.

## 수행 절차

### 1. 레이아웃 컴포넌트 구현
[src/components/layout/]
- Layout.tsx: 상단 내비게이션 바와 하단 푸터를 포함한 기본 레이아웃
- Navbar.tsx
  - 로고 및 메인 페이지 링크
  - 게시글 목록 링크
  - 로그인 상태에 따라 로그인/로그아웃 버튼 전환
  - 로그인 상태일 때 게시글 작성 버튼 표시
- Footer.tsx: 기본 푸터

### 2. 공통 컴포넌트 구현
[src/components/common/]
- LoadingSpinner.tsx: 로딩 상태 표시
- ErrorMessage.tsx: 오류 메시지 표시
- ConfirmDialog.tsx: 삭제 등 확인이 필요한 액션에 사용할 다이얼로그

### 3. shadcn/ui 컴포넌트 추가 설치
필요한 shadcn/ui 컴포넌트를 설치해줘.
예시: button, input, card, dialog, form 등

## 완료 조건
- 모든 페이지에 Navbar 와 Footer 가 표시되는가?
- 로그인/로그아웃 상태에 따라 Navbar 의 버튼이 올바르게 전환되는가?
```

#### 7단계

```
# 작업 7. 페이지 구현

각 페이지 컴포넌트를 구현해줘.
작업 4의 API 함수와 작업 5의 AuthContext 를 활용해줘.

## 수행 절차

### 1. 메인 페이지
[src/pages/MainPage.tsx]
- 서비스 소개 및 주요 기능 안내
- 로그인하지 않은 사용자에게 로그인/회원가입 버튼 표시

### 2. 로그인 페이지
[src/pages/LoginPage.tsx]
- 이메일/비밀번호 입력 폼
- AuthContext 의 login() 함수 호출
- 로그인 성공 시 / 로 redirect
- 오류 메시지 표시

### 3. 회원가입 페이지
[src/pages/RegisterPage.tsx]
- 회원가입 폼 (이름, 이메일, 비밀번호 등 OpenAPI 명세 기준)
- 가입 성공 시 /login 으로 redirect
- 오류 메시지 표시

### 4. 게시글 목록 페이지
[src/pages/PostListPage.tsx]
- useState + useEffect 로 게시글 목록 조회
- 로딩 중 LoadingSpinner 표시
- 오류 발생 시 ErrorMessage 표시
- 각 게시글 클릭 시 상세 페이지로 이동
- 로그인 상태일 때 게시글 작성 버튼 표시

### 5. 게시글 상세 페이지
[src/pages/PostDetailPage.tsx]
- useState + useEffect 로 게시글 상세 조회
- 로그인한 작성자에게만 수정/삭제 버튼 표시
- 삭제 시 ConfirmDialog 로 확인 후 처리
- 삭제 성공 시 /posts 로 redirect

### 6. 게시글 작성 페이지 (인증 필요)
[src/pages/PostCreatePage.tsx]
- 게시글 작성 폼 (제목, 내용 등 OpenAPI 명세 기준)
- 작성 성공 시 작성된 게시글 상세 페이지로 redirect

### 7. 게시글 수정 페이지 (인증 필요)
[src/pages/PostEditPage.tsx]
- 기존 게시글 데이터를 불러와 폼에 채워줘.
- 수정 성공 시 해당 게시글 상세 페이지로 redirect

## 완료 조건
- 모든 페이지가 오류 없이 렌더링되는가?
- API 연동이 정상 동작하는가?
- 로그인 상태에 따라 버튼이 올바르게 표시되는가?
- 페이지 이동(redirect)이 올바르게 동작하는가?
```

#### 8단계

```
# 작업 8. 최종 점검 및 정리

프로젝트 전체를 점검하고 최종 정리를 해줘.

## 수행 절차

### 1. 빌드 검증
- npm run build 를 실행하고 TypeScript 오류가 없는지 확인해줘.
- 오류가 있으면 수정해줘.

### 2. 코드 점검
- 모든 API 함수에 타입이 올바르게 지정되어 있는가?
- 환경 변수가 하드코딩 없이 VITE_API_BASE_URL 을 통해 참조되고 있는가?
- localStorage 토큰 처리가 tokenStorage.ts 를 통해서만 이루어지는가?
- PrivateRoute 로 보호해야 할 라우트가 모두 보호되고 있는가?
- 모든 페이지에 레이아웃(Navbar, Footer)이 적용되어 있는가?

### 3. README.md 작성
- 프로젝트 개요
- 기술 스택 목록
- 프로젝트 디렉토리 구조
- 환경 변수 설정 방법 (.env.example 참고)
- 프로젝트 실행 방법 (npm install, npm run dev)
- 빌드 방법 (npm run build)

## 완료 조건
- npm run build 가 오류 없이 완료되는가?
- README.md 가 생성되었는가?
- 최종 디렉토리 구조를 출력해줘.
```

## 20. TanStack Query와 Zustand로 상태 관리 구조 고도화하기

- README.md
    - 프론트엔드 프로젝트에 생성한 파일이다. 
    - 프론트엔드 프로젝트의 정보를 담고 있다. 

### 프롬프트 준비하기
```
README.md 파일은 19단계의 학습목표에 맞춰 생성한 프로젝트 정보다. 이 프로젝트를 20단계의 학습목표에 맞춰 변경할 수 있도록 프롬프트를 작성해줘.
```

```
## 역할
너는 React 프로젝트를 TanStack Query와 Zustand 기반 상태 관리 구조로 리팩토링하는 전문가야.

## 현재 프로젝트 상태
현재 프로젝트는 다음과 같은 구조로 구성되어 있어.
- React 19 + Vite 7 + TypeScript
- useEffect + useState 기반 서버 상태 관리
- React Context(AuthContext)로 인증 상태 관리
- 커스텀 Fetch 클라이언트(401 자동 재시도, 토큰 갱신 포함)
- React Router 7 기반 클라이언트 라우팅
- Tailwind CSS v4 + shadcn/ui

## 리팩토링 목표
아래 두 가지 핵심 목표에 따라 상태 관리 구조를 리팩토링해줘.

### 1. 서버 상태: TanStack Query 도입
- useEffect + useState로 처리하던 모든 서버 상태(게시글 목록, 상세, 사용자 정보 등)를 TanStack Query로 전환해줘.
- Query Key 설계 전략을 수립하고, 계층적 구조(예: ['posts'], ['posts', id], ['user', 'me'])로 정의해줘.
- 게시글 생성/수정/삭제 작업은 useMutation으로 전환하고, 작업 완료 후 관련 Query를 invalidate하여 데이터 동기화 흐름을 구현해줘.
- 게시글 수정은 낙관적 업데이트(Optimistic Update)를 적용해줘. 적용 이유도 주석으로 설명해줘.
- loading, error, success 상태는 TanStack Query가 제공하는 isPending, isError, isSuccess로 처리해줘.

### 2. 전역 UI 상태: Zustand 도입
- 기존 AuthContext를 제거하고 Zustand 스토어로 대체해줘.
- Zustand 스토어에서 관리할 상태는 다음과 같아.
  - 로그인 여부 (isAuthenticated)
  - 사용자 정보 (user: { name, email } 등)
  - AccessToken (메모리 저장 유지)
- RefreshToken은 기존과 동일하게 HttpOnly 쿠키로 유지해줘.
- AccessToken은 Zustand 스토어에서 관리하고, localStorage에는 저장하지 마. 그 이유를 주석으로 설명해줘.

## 디렉토리 구조 변경 가이드
- src/context/ 디렉토리는 제거해줘.
- src/store/ 디렉토리를 추가하고, 아래 파일을 생성해줘.
  - useAuthStore.ts (인증 관련 Zustand 스토어)
- src/hooks/ 디렉토리를 추가하고, 도메인별 TanStack Query 훅을 분리해줘.
  - usePosts.ts (게시글 관련 Query/Mutation)
  - useUser.ts (사용자 정보 관련 Query)

## 패키지 설치
아래 패키지를 추가로 설치해줘.
- @tanstack/react-query
- @tanstack/react-query-devtools
- zustand

## 추가 요구사항
- QueryClientProvider는 main.tsx에서 설정해줘.
- ReactQueryDevtools는 개발 환경에서만 활성화해줘.
- 기존 커스텀 Fetch 클라이언트(401 자동 재시도, 토큰 갱신)는 유지하고, TanStack Query의 queryFn에서 호출하는 방식으로 연결해줘.
- 리팩토링 전후 구조 변화를 README.md에 반영해줘. 특히 상태 관리 전략 섹션을 추가하여 서버 상태와 UI 상태의 책임 분리 기준을 설명해줘.

## 주의사항
- 기존 API 엔드포인트와 커스텀 Fetch 클라이언트 로직은 변경하지 마.
- UI 컴포넌트의 시각적 변경 없이 상태 관리 로직만 리팩토링해줘.
- TypeScript 타입 안전성을 유지해줘.
```

## 21. Next.js로 프론트엔드 아키텍처 고도화하기

### AGENTS.md 파일 준비하기

```
# AI Agent Guide

이 파일은 코딩 에이전트가 이 프로젝트의 맥락을 이해하고 일관성 있게 작업을 수행할 수 있도록 돕기 위한 지침서이다.

## 규칙:
- 실행 전에 반드시 실행 계획을 제시하라.
- 변경/생성/삭제한 파일 목록을 매 단계마다 요약해라.
- 작업을 완료할 때 작업 내용을 정의된 형식에 맞춰 `git commit` 및 `git push` 하라.
- Git Commit 메시지 형식은 `./docs/git-message-format.md`를 따르라.
```

### REST API Endpoint 문서화

```
http://localhost:8080/v3/api-docs에서 제공하는 OpenAPI 명세를 문서화하여 rest-api-docs.md 파일로 저장해줘.
```

```
Next.js 기반 프론트엔드 프로젝트를 생성할 계획이다.
너에게 어떤 정보를 알려줘야 하는지 프롬프트 예시를 작성해줘.
```

### 프로젝트 생성 프롬프트 준비

```
다음 작업을 단계 별로 수행할 수 있도록 분해하여 여러 개의 실행 프롬프트로 작성해줘.

# 프로젝트 개요
- 프로젝트 이름: myapp-frontend-nextjs
- 목적
    - 공유 게시판 서비스의 프론트엔드 구현

# 기술 스택
- 프레임워크: Next.js 16 (App Router)
- 언어: TypeScript 5
- 런타임: Node.js 24 LTS
- 패키지 매니저: pnpm
- 스타일링: Tailwind CSS v4
- UI 컴포넌트 라이브러리: shadcn/ui
- 아이콘: Lucide React
- 서버 데이터 통신: Fetch API (REST API 서버 직접 호출, 인증 불필요 요청만)
- 클라이언트 데이터 통신: Fetch API (REST API 서버 직접 호출)
- 서버 상태 관리: 없음 (다음 단계에서 TanStack Query 도입 예정)
- 클라이언트 상태 관리: React Context API (다음 단계에서 Zustand 도입 예정)
- 린터: ESLint (Next.js 기본 config)
- 포매터: Prettier
- 프로젝트 디렉토리: 현재 디렉토리를 프론트엔드 프로젝트로 초기화 (별도 폴더 생성 안 함)
- 소스 디렉토리: src

# 인증 방식
- Type: Bearer Token (JWT)
- 토큰 구성: Access Token + Refresh Token
- 토큰 저장:
  - Access Token: localStorage 저장
    - 메모리 저장 불가 이유: Next.js API Proxy를 사용하지 않으므로
      서버 컴포넌트와 클라이언트 컴포넌트 간 토큰 공유 수단이 없음
    - XSS 위험 최소화를 위해 토큰 유효기간을 짧게 설정 (백엔드 협의)
  - Refresh Token: HttpOnly Cookie에 저장 (백엔드 서버가 Set-Cookie로 설정)
    - JavaScript 접근 불가
    - REST API 서버 요청 시 credentials: 'include' 옵션으로 자동 전송
- 토큰 갱신:
  - 페이지 새로고침 시: localStorage의 Access Token으로 /api/user/me 호출
    - 401 응답 시: POST {API_BASE_URL}/api/reissue 직접 호출하여 재발급
    - 재발급 성공 시: 새 Access Token을 localStorage에 저장
    - 재발급 실패 시: 토큰 삭제 후 비로그인 상태 유지
  - Access Token 만료(401) 시: POST {API_BASE_URL}/api/reissue 직접 호출 후
    원래 요청 자동 재시도
- 서버 컴포넌트 인증:
  - 서버 컴포넌트는 React Context 접근 불가
  - 인증이 필요한 요청은 Client Component에서만 처리
  - 서버 컴포넌트는 인증 불필요한 공개 API만 직접 호출
    (게시글 목록, 게시글 상세 등)

# REST API 서버
- 서버 주소: `NEXT_PUBLIC_API_BASE_URL` 환경 변수로 관리
  - 개발: http://localhost:8080
  - 운영: https://api.myapp.com
- CORS: 백엔드에서 Next.js 도메인 허용 설정 필요
- credentials: 'include' 옵션으로 Refresh Token Cookie 자동 전송
- OpenAPI 명세 요약: rest-api-spec.md 참고
  타입이나 코드를 생성할 때 이 명세서의 내용을 반영하라.

# 구현 기능
- 메인 페이지 (공개)
- 로그인 페이지 (공개)
- 회원가입 페이지 (공개)
- 게시글 목록 페이지 (공개, Server Component)
- 게시글 상세 페이지 (공개, Server Component)
- 게시글 작성 페이지 (인증 필요, Client Component)
- 게시글 수정 페이지 (인증 필요, Client Component)
- 게시글 삭제 기능 (인증 필요, Client Component)
- 공통
    - 레이아웃 (상단 Navbar + 하단 Footer)
    - 로딩 상태 표시
    - 에러 상태 표시
    - 인증 보호 라우트 구현 (미로그인 시 로그인 페이지로 리다이렉트)
```

### 1단계 - 프로젝트 생성 및 초기 설정

```
다음 명세서에 따라 Next.js 프로젝트를 생성하고 초기 설정을 완료하라.

## 명세서
- 프레임워크: Next.js 16 (App Router)
- 언어: TypeScript 5
- 런타임: Node.js 24 LTS
- 패키지 매니저: pnpm
- 스타일링: Tailwind CSS v4
- 소스 디렉토리: src/
- 린터: ESLint (Next.js 기본 config)
- 포매터: Prettier

## 작업 내용

### 1. 프로젝트 생성
create-next-app@latest . 실행 (현재 디렉토리에 생성, 별도 폴더 생성 안 함)
선택 옵션:
  - TypeScript: Yes
  - ESLint: Yes
  - Tailwind CSS: Yes
  - src/ directory: Yes
  - App Router: Yes
  - Turbopack: Yes
  - import alias: Yes (@/ 로 설정)

### 2. Prettier 설치 및 설정
pnpm add -D prettier eslint-config-prettier 설치

.prettierrc 파일 생성:
  {
    "semi": false,
    "singleQuote": true,
    "tabWidth": 2,
    "trailingComma": "es5",
    "printWidth": 100
  }

.prettierignore 파일 생성:
  node_modules
  .next
  out
  public

eslint.config.mjs(또는 .eslintrc.json)에 prettier 설정 추가:
  extends에 'prettier' 추가 (eslint-config-prettier 적용)

package.json scripts에 추가:
  "format": "prettier --write ."

### 3. shadcn/ui 초기화
pnpm dlx shadcn@latest init 실행

### 4. 필수 shadcn/ui 컴포넌트 설치
button, input, label, card, form, toast 설치

### 5. Lucide React 설치
pnpm add lucide-react

### 6. 환경 변수 파일 생성
.env.local 파일 생성:
  NEXT_PUBLIC_API_BASE_URL=http://localhost:8080

.env.production 파일 생성:
  NEXT_PUBLIC_API_BASE_URL=https://api.myapp.com

.env.local을 .gitignore에 추가 확인

### 7. Boilerplate 정리
- src/app/page.tsx → 빈 홈 페이지 컴포넌트로 교체
- src/app/globals.css → Tailwind 기본 지시어만 남기고 나머지 삭제
- public/ → 기본 이미지 파일 삭제

## 완료 조건
- pnpm dev 실행 시 http://localhost:3000 정상 접속
- pnpm format 실행 시 Prettier 정상 동작
- .env.local 파일 존재
- 홈 화면에 boilerplate 내용 없음
```

### 2단계 - API 클라이언트 구현

```
다음 명세서를 참고하여 REST API 직접 통신 모듈을 구현하라.

## 참고 파일
- rest-api-spec.md: 에러 응답 구조, 공통 응답 형식 확인 후
  타입 정의에 반영하라.

## 명세서
- 서버 주소: NEXT_PUBLIC_API_BASE_URL 환경 변수
- 인증: Bearer Token (Access Token)
- 클라이언트/서버 컴포넌트 모두 REST API 서버에 직접 호출
- Access Token: localStorage에 저장
- 토큰 만료 시: POST /api/reissue 호출하여 재발급 후 요청 재시도

## 생성할 디렉토리 및 파일
src/
├── types/
│   └── api.ts
└── lib/
    └── api.ts

## 작업 내용

### src/types/api.ts
- rest-api-spec.md의 ErrorResponseDto를 참고하여 정의

// ErrorResponseDto
interface ApiError {
  message: string
  status: number
}

### src/lib/api.ts

1. BASE_URL 상수 정의
   const BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL

2. 토큰 관리 함수 (브라우저 전용)
   - getAccessToken(): localStorage에서 토큰 반환
   - setAccessToken(token: string): localStorage에 토큰 저장
   - removeAccessToken(): localStorage에서 토큰 삭제

3. 토큰 재발급 함수
   - reissueToken():
     a. POST {BASE_URL}/api/reissue 호출
        (Refresh Token은 서버가 HttpOnly Cookie로 관리하므로
        credentials: 'include' 옵션 설정)
     b. 성공(200) 시: 새 accessToken을 localStorage에 저장 후 반환
     c. 실패(401) 시: null 반환

4. 기본 fetch 래퍼 함수 apiFetch 구현
   - 요청 헤더: Content-Type: application/json
   - Access Token이 있으면 Authorization: Bearer {token} 헤더 추가
   - credentials: 'include' 설정 (Refresh Token Cookie 자동 전송)
   - 응답이 401이면:
     a. reissueToken() 호출
     b. 재발급 성공 시: 새 토큰으로 원래 요청 재시도
     c. 재발급 실패 시: 토큰 삭제 후 /login 으로 리다이렉트
   - HTTP 에러를 ApiError 타입으로 변환하여 throw

5. 편의 함수 구현
   - get<T>(url: string, token?: string)
   - post<T>(url: string, body: unknown, token?: string)
   - patch<T>(url: string, body: unknown, token?: string)
   - del<T>(url: string, token?: string)

## 주의사항
- 토큰 관리 함수(getAccessToken 등)는 브라우저 환경에서만 동작
  서버 컴포넌트에서는 호출하지 않도록 주석으로 명시
- 서버 컴포넌트는 인증이 불필요한 공개 API만 호출하므로
  token 파라미터 전달이 필요한 경우 Client Component에서만 사용

## 완료 조건
- TypeScript 컴파일 에러 없음
- apiFetch 함수 export 확인
```

### 3단계 - 인증 Context 구현

```
다음 명세서를 참고하여 인증 상태 관리 Context를 구현하라.

## 참고 파일
- rest-api-spec.md: 아래 API의 요청/응답 구조를 확인 후
  타입 정의 및 API 호출 코드에 반영하라.
  - POST /api/login → LoginRequestDto, LoginResponseDto
  - POST /api/logout
  - POST /api/reissue → LoginResponseDto
  - GET /api/user/me → UserResponseDto

## 명세서
- Access Token: localStorage 저장
- Refresh Token: HttpOnly Cookie (서버에서 Set-Cookie로 자동 관리)
- 페이지 새로고침 시: localStorage 토큰으로 /api/user/me 호출하여 복원
- 토큰 만료 시: /api/reissue로 재발급 (api.ts에서 자동 처리)

## 생성할 디렉토리 및 파일
src/
├── types/
│   └── auth.ts
├── context/
│   └── AuthContext.tsx
└── hooks/
    └── useAuth.ts

## 작업 내용

### src/types/auth.ts (신규 생성)
- rest-api-spec.md의 스키마를 참고하여 정의

// LoginRequestDto
interface LoginRequest {
  email: string
  password: string
}

// LoginResponseDto
interface LoginResponse {
  accessToken: string
  tokenType: string
  userName: string
}

// UserResponseDto
interface User {
  no: number
  name: string
  email: string
}

### src/context/AuthContext.tsx
AuthContext 구현:
- state: user(User | null), isLoading(boolean)
- login(email, password):
  1. POST {API_BASE_URL}/api/login 직접 호출
     credentials: 'include' (Refresh Token Cookie 수신)
     요청 타입: LoginRequest
  2. 응답(LoginResponse)의 accessToken을 localStorage에 저장
  3. GET {API_BASE_URL}/api/user/me 호출하여 user 정보 저장
  4. 에러(401): 이메일/비밀번호 불일치 메시지
  5. 에러(403): 계정 잠금 메시지
- logout():
  1. POST {API_BASE_URL}/api/logout 직접 호출
     credentials: 'include' (Refresh Token Cookie 삭제 요청)
  2. localStorage에서 토큰 삭제
  3. user 초기화
- 초기 마운트 시:
  1. localStorage에서 토큰 확인
  2. 토큰 있으면 GET /api/user/me 호출하여 user 복원
  3. 401 응답 시: /api/reissue 호출 (api.ts의 자동 재발급 처리)
  4. 재발급도 실패 시: 토큰 삭제, 비로그인 상태로 유지

### src/hooks/useAuth.ts
- useContext(AuthContext) 래퍼 훅
- Context 외부에서 호출 시 에러 throw

### src/app/layout.tsx 수정
- AuthProvider로 전체 감싸기

## 완료 조건
- TypeScript 컴파일 에러 없음
- pnpm dev 실행 후 에러 없음
- 브라우저 개발자 도구에서 localStorage에 accessToken을 직접 삽입한 후
  페이지 새로고침 시 /api/user/me 호출이 발생하는지 Network 탭으로 확인
```

### 4단계 - 레이아웃 구현

```
다음 명세서를 참고하여 공통 레이아웃 컴포넌트를 구현하라.

## 명세서
- 레이아웃: 상단 Navbar + 하단 Footer
- UI: shadcn/ui, Tailwind CSS v4, Lucide React
- 인증 상태에 따라 Navbar 메뉴 변경

## 생성할 디렉토리 및 파일
src/
└── components/
    └── layout/
        ├── Navbar.tsx
        └── Footer.tsx

## 작업 내용

### src/components/layout/Navbar.tsx
- 'use client' 지시어
- 로고 (클릭 시 / 이동)
- 메뉴: 게시글 목록 (/posts)
- 비로그인 시: 로그인, 회원가입 버튼 표시
- 로그인 시: user.name 표시, 게시글 작성 버튼, 로그아웃 버튼 표시
- useAuth() 훅으로 인증 상태 확인
- 로그아웃 버튼 클릭 시 useAuth().logout() 호출 후 / 로 이동

### src/components/layout/Footer.tsx
- 서비스 이름, 저작권 표시
- Server Component (정적 콘텐츠)

### src/app/layout.tsx 수정
전체 구조:
  AuthProvider
  └─ html > body
       ├─ Navbar
       ├─ main (children)
       └─ Footer

## 완료 조건
- 모든 페이지에서 Navbar, Footer 표시 확인
- 비로그인 상태(기본값)에서 Navbar에 로그인, 회원가입 버튼 표시 확인
- 브라우저 개발자 도구 Console에서 AuthContext의 user 상태를 직접 주입하여
  로그인 상태 시 Navbar에 user.name, 게시글 작성, 로그아웃 버튼 표시 확인
  (실제 로그인/로그아웃 동작 확인은 5단계에서 수행)
```

### 5단계 - 회원가입 / 로그인 페이지 구현

```
다음 명세서를 참고하여 회원가입, 로그인 페이지를 구현하라.

## 참고 파일
- rest-api-spec.md: 아래 API의 요청/응답 구조 및 에러 코드를 확인하라.
  - POST /api/signup → UserSignupDto (성공: 200)
  - POST /api/login → LoginRequestDto, LoginResponseDto
    (실패: 401 이메일/비밀번호 불일치, 403 계정 잠금)

## 명세서
- UI: shadcn/ui (Form, Input, Button, Card)
- 폼 유효성 검사: HTML5 기본 validation 사용
- 인증: useAuth() 훅 사용
- REST API 서버에 직접 호출

## 생성할 디렉토리 및 파일
src/
├── types/
│   └── auth.ts          ← 기존 파일에 타입 추가
└── app/
    ├── (auth)/
    │   ├── login/
    │   │   └── page.tsx
    │   └── register/
    │       └── page.tsx
    └── my/
        └── page.tsx          ← 추가
## 작업 내용

### src/types/auth.ts 수정 (기존 파일에 추가)
// UserSignupDto
interface RegisterRequest {
  name: string
  email: string
  password: string
  passwordConfirm: string
}

### src/app/(auth)/register/page.tsx
- 'use client' 지시어
- 입력 필드: 이름(name), 이메일, 비밀번호, 비밀번호 확인
- 클라이언트 유효성 검사:
  - 이름: 2자 이상
  - 이메일: 이메일 형식
  - 비밀번호: 8자 이상
  - 비밀번호 확인: 비밀번호와 일치 여부
- REST API 직접 호출:
  POST {API_BASE_URL}/api/signup
  요청 타입: RegisterRequest
- 성공(200) 시: /login 으로 이동
- 에러(400) 시: ErrorResponseDto의 message 표시

### src/app/(auth)/login/page.tsx
- 'use client' 지시어
- 입력 필드: 이메일, 비밀번호
- useAuth().login() 호출
  요청 타입: LoginRequest (src/types/auth.ts)
- 성공 시: redirect 쿼리 파라미터 경로 또는 / 로 이동
- 에러(401) 시: "이메일 또는 비밀번호가 올바르지 않습니다." 표시
- 에러(403) 시: "계정이 잠금 상태입니다. 관리자에게 문의하세요." 표시

### src/app/my/page.tsx (사용자 정보 조회)
- 'use client' 지시어
- 마운트 시 accessToken 없으면 /login?redirect=/my 로 리다이렉트
- useAuth()의 user 정보 표시 (이름, 이메일)
- REST API 직접 호출:
  GET {API_BASE_URL}/api/user/me
  헤더: Authorization: Bearer {accessToken}
  응답 타입: User (src/types/auth.ts)
- 표시 항목: 이름, 이메일
- 에러(401) 시: /login 으로 리다이렉트

### src/components/layout/Navbar.tsx 수정
- 로그인 시 표시되는 user.name을 /my 로 이동하는 Link로 변경

## 공통 구현 사항
- 로딩 중 버튼 비활성화 및 로딩 텍스트 표시
- API 에러 메시지 화면에 표시

## 완료 조건
- 회원가입 후 로그인 페이지 이동 확인
- 로그인 성공 후 Navbar에 user.name 표시 확인
- 비밀번호 불일치 시 에러 메시지 표시 확인
- 로그인 실패(401), 계정 잠금(403) 에러 메시지 표시 확인
- 로그인 후 Navbar의 user.name 클릭 시 /my 페이지 이동 확인
- /my 페이지에서 이름, 이메일 표시 확인
- 미로그인 상태에서 /my 접속 시 /login?redirect=/my 로 리다이렉트 확인
```

### 6단계 - 게시글 목록 / 상세 페이지 구현

```
다음 명세서를 참고하여 게시글 목록, 상세 페이지를 구현하라.

## 참고 파일
- rest-api-spec.md: 아래 API의 요청/응답 구조를 확인 후
  타입 정의 및 API 호출 코드에 반영하라.
  - GET /api/posts → PostListResponseDto, PostListDto
    (page: 1부터 시작)
  - GET /api/posts/{no} → PostResponseDto
  - DELETE /api/posts/{no}

## 명세서
- 렌더링: SSR (Server Component, SEO 필요)
- 데이터 패칭: REST API 서버에 직접 호출 (인증 불필요 공개 API)
- 페이지네이션: 쿼리 파라미터 ?page=1 (1부터 시작)
- 수정/삭제 버튼: 인증이 필요하므로 Client Component에서 처리

## 생성할 디렉토리 및 파일
src/
├── types/
│   └── post.ts
├── app/
│   └── posts/
│       ├── page.tsx
│       └── [no]/
│           └── page.tsx
└── components/
    └── post/
        ├── PostActions.tsx    ← 수정/삭제 버튼 통합 Client Component
        └── DeleteButton.tsx   ← 삭제 처리 Client Component

## 작업 내용

### src/types/post.ts (신규 생성)
- rest-api-spec.md의 스키마를 참고하여 정의

// PostListDto
interface PostSummary {
  no: number
  title: string
  createdAt: string
  views: number
  authorName: string
}

// PostListResponseDto
interface PostListResponse {
  posts: PostSummary[]
  currentPage: number
  totalPages: number
}

// PostResponseDto
interface Post {
  no: number
  title: string
  content: string
  createdAt: string
  updatedAt: string
  views: number
  tags: string
  authorName: string
  authorNo: number
}

### src/app/posts/page.tsx (게시글 목록)
- Server Component
- REST API 직접 호출 (인증 불필요):
  GET {API_BASE_URL}/api/posts?page={page}
  page 기본값: 1 (rest-api-spec.md 참고)
  응답 타입: PostListResponse
- 게시글 카드 목록 표시 (제목, 작성자, 작성일, 조회수)
- 각 카드 클릭 시 /posts/{no} 이동
- currentPage, totalPages로 페이지네이션 UI 표시

### src/app/posts/[no]/page.tsx (게시글 상세)
- Server Component
- REST API 직접 호출 (인증 불필요):
  GET {API_BASE_URL}/api/posts/{no}
  응답 타입: Post
- 제목, 내용, 작성자, 작성일, 조회수, 태그 표시
- 에러(404) 시: notFound() 호출
- <PostActions postNo={post.no} authorNo={post.authorNo} /> 렌더링
  (수정/삭제 버튼 표시는 Client Component에서 인증 처리)

### src/components/post/PostActions.tsx
- 'use client' 지시어
- props: postNo(number), authorNo(number)
- useAuth()로 user.no와 authorNo 비교하여 본인 확인
- 본인 아닐 경우 버튼 미표시
- 수정 버튼: /posts/{postNo}/edit 으로 이동 (Next.js Link 또는 useRouter)
- 삭제 버튼: <DeleteButton postNo={postNo} /> 렌더링

### src/components/post/DeleteButton.tsx
- 'use client' 지시어
- props: postNo(number)
- 삭제 확인 다이얼로그 표시
- REST API 직접 호출:
  DELETE {API_BASE_URL}/api/posts/{postNo}
  헤더: Authorization: Bearer {accessToken}
- 성공(200) 시: /posts 로 이동
- 에러(401) 시: /login 으로 리다이렉트
- 에러(403) 시: 권한 없음 메시지 표시
- 에러(404) 시: /posts 로 이동

## 완료 조건
- /posts 게시글 목록 표시 확인
- /posts/{no} 게시글 상세 표시 확인
- 페이지네이션 동작 확인 (1페이지부터 시작)
- 없는 게시글 번호 접속 시 404 페이지 표시 확인
- 본인 게시글에만 수정/삭제 버튼 표시 확인
- 타인 게시글에서 수정/삭제 버튼 미표시 확인
```

### 7단계 - 게시글 작성 / 수정 페이지 구현

```
다음 명세서를 참고하여 게시글 작성, 수정 페이지를 구현하라.

## 참고 파일
- rest-api-spec.md: 아래 API의 요청/응답 구조를 확인 후
  타입 정의 및 API 호출 코드에 반영하라.
  - POST /api/posts → PostCreateDto (성공: 200)
  - PATCH /api/posts/{no} → PostUpdateDto (성공: 200)

## 명세서
- 렌더링: CSR (인증 필요, SEO 불필요)
- 인증: useAuth()로 accessToken 가져와 API 호출 시 사용
- REST API 서버에 직접 호출

## 생성할 디렉토리 및 파일
src/
├── types/
│   └── post.ts          ← 기존 파일에 타입 추가
└── app/
    └── posts/
        ├── new/
        │   └── page.tsx
        └── [no]/
            └── edit/
                └── page.tsx

## 작업 내용

### src/types/post.ts 수정 (기존 파일에 추가)
// PostCreateDto
interface CreatePostRequest {
  title: string
  content: string
  tags: string    // 쉼표로 구분된 해시태그 (예: "Next.js,React")
}

// PostUpdateDto
interface UpdatePostRequest {
  title: string
  content: string
  tags: string
}

### src/app/posts/new/page.tsx (게시글 작성)
- 'use client' 지시어
- 마운트 시 accessToken 없으면 /login 으로 리다이렉트
- 입력 필드: 제목, 내용(textarea), 태그(쉼표로 구분 입력 안내)
- REST API 직접 호출:
  POST {API_BASE_URL}/api/posts
  헤더: Authorization: Bearer {accessToken}
  요청 타입: CreatePostRequest
- 성공(200) 시: /posts 로 이동
- 에러(401) 시: /login 으로 리다이렉트

### src/app/posts/[no]/edit/page.tsx (게시글 수정)
- 'use client' 지시어
- 마운트 시 accessToken 없으면 /login 으로 리다이렉트
- 마운트 시 REST API 직접 호출:
  GET {API_BASE_URL}/api/posts/{no} 로 기존 데이터 로드
- 기존 제목, 내용, 태그를 폼에 채워서 표시
- REST API 직접 호출:
  PATCH {API_BASE_URL}/api/posts/{no}
  헤더: Authorization: Bearer {accessToken}
  요청 타입: UpdatePostRequest
- 성공(200) 시: /posts/{no} 로 이동
- 에러(400) 시: ErrorResponseDto의 message 표시
- 에러(401) 시: /login 으로 리다이렉트
- 에러(403) 시: 권한 없음 메시지 표시
- 에러(404) 시: /posts 로 이동

## 공통 구현 사항
- 로딩 중 버튼 비활성화
- API 에러 메시지 표시
- 취소 버튼: 이전 페이지로 이동

## 완료 조건
- 로그인 후 /posts/new 에서 게시글 작성 후 목록 페이지 이동 확인
- /posts/{no}/edit 에서 기존 데이터 로드 및 수정 확인
- 태그 입력 후 상세 페이지에서 표시 확인
```


### 8단계 - 인증 보호 라우트 구현

```
Next.js Middleware를 사용하여 인증이 필요한 페이지를 보호하라.

## 명세서
- 인증 필요 페이지: /posts/new, /posts/[no]/edit
- 미로그인 시 /login으로 리다이렉트
- 로그인 완료 후 원래 페이지로 복귀

## 주의사항
- Access Token이 localStorage에 저장되므로
  Middleware(서버)에서 직접 확인 불가
- 로그인 시 authStatus 쿠키를 설정하여
  Middleware에서 인증 여부 판단에 사용
- authStatus 쿠키는 인증 상태 표시용이며 보안 토큰이 아님
  (실제 API 인증은 localStorage의 Access Token으로 처리)

## 생성할 파일
src/
└── middleware.ts

## 작업 내용

### src/context/AuthContext.tsx 수정
- login() 성공 시:
  document.cookie = 'authStatus=true; path=/' 설정 (세션 쿠키)
- logout() 시:
  document.cookie = 'authStatus=; path=/; max-age=0' 삭제

### src/middleware.ts
- 보호 경로: /posts/new, /posts/:no/edit
- authStatus 쿠키 존재 여부로 인증 확인
- 미인증 시: /login?redirect={현재경로} 로 리다이렉트
- matcher 설정으로 보호 경로만 Middleware 적용

### src/app/(auth)/login/page.tsx 수정
- 로그인 성공 시 redirect 쿼리 파라미터 경로로 이동
- redirect 없으면 / 로 이동 (기존 동작 유지)

## 완료 조건
- 미로그인 상태에서 /posts/new 접속 시
  /login?redirect=/posts/new 로 리다이렉트 확인
- 로그인 완료 후 /posts/new 로 자동 복귀 확인
- 로그아웃 후 /posts/new 접속 시 다시 리다이렉트 확인
```

### 9단계 - 로딩 / 에러 상태 처리

```
Next.js App Router의 규칙 파일을 활용하여
로딩 및 에러 상태 UI를 구현하라.

## 생성할 파일
src/
└── app/
    ├── loading.tsx
    ├── error.tsx
    ├── not-found.tsx
    └── posts/
        └── loading.tsx    ← 기존 posts/ 디렉토리에 추가

## 작업 내용

### src/app/loading.tsx
- 전체 화면 중앙에 스피너 표시

### src/app/error.tsx
- 'use client' 지시어 (Next.js 요구사항)
- ErrorResponseDto의 message 표시
- "다시 시도" 버튼 (reset() 함수 호출)
- "홈으로" 버튼

### src/app/not-found.tsx
- 404 메시지 표시
- "게시글 목록으로" 버튼 (/posts 이동)
- "홈으로" 버튼

### src/app/posts/loading.tsx
- 게시글 카드 스켈레톤 UI 3개 표시
  (제목, 작성자, 작성일, 조회수 자리 표시)

## 완료 조건
- 존재하지 않는 URL 접속 시 not-found 페이지 표시 확인
- 느린 네트워크 환경에서 로딩 스피너 표시 확인
- /posts/{no} 에서 없는 게시글 번호 접속 시 not-found 표시 확인
```


## 22. Next.js에 TanStack Query와 Zustand 적용하기

### TanStack Query 적용하기

```
기존 코드에 TanStack Query를 적용하려고 한다. 프롬프트를 작성해줘.
단 작업 지시에서 각 단계별 해야할 일만 명시할 때 구체적인 코드를 언급하지 말라. 
이 부분은 코딩 에이전트에서 분석하여 처리할 것이다.
```

```
## 역할
당신은 Next.js + TypeScript 전문 개발자입니다.

## 목표
기존 Next.js 프로젝트에 TanStack Query를 도입하여
Client Component의 데이터 패칭과 상태 관리 구조를 개선합니다.

## 프로젝트 구조 및 주요 파일 현황

**API 호출 레이어** (`src/lib/api.ts`)
- `apiFetch`: 기본 fetch 래퍼 (Authorization 헤더, 401 시 Refresh Token 재발급 내장)
- `get`, `post`, `patch`, `del`: apiFetch 기반 편의 함수

**인증**
- `src/context/AuthContext.tsx`: Context API 기반, AuthProvider로 layout.tsx에 적용
- `src/hooks/useAuth.ts`: useContext 래퍼

**변경 대상 파일 및 현재 패턴**

| 파일 | 현재 패턴 |
|---|---|
| `src/app/my/page.tsx` | useEffect + useState + `get('/api/user/me')` |
| `src/app/posts/new/page.tsx` | handleSubmit 내 `post('/api/posts', formData)` + loading state |
| `src/app/posts/[no]/edit/page.tsx` | useEffect + `get('/api/posts/:no')` 초기 로딩, handleSubmit 내 `patch('/api/posts/:no', formData)` + submitting state |
| `src/components/post/DeleteButton.tsx` | handleDelete 내 `apiFetch('/api/posts/:no', { method: 'DELETE' })` + isDeleting state |

**변경 불가 파일** (Server Component)
- `src/app/posts/page.tsx`
- `src/app/posts/[no]/page.tsx`

## 작업 지시

### 1단계: 패키지 설치
`@tanstack/react-query`와 `@tanstack/react-query-devtools`를 설치합니다.

### 2단계: QueryProvider 생성
`src/providers/QueryProvider.tsx`를 생성합니다.
- App Router 환경에 적합한 방식으로 QueryClient를 생성합니다.
- ReactQueryDevtools는 개발 환경 전용으로 포함합니다.

### 3단계: layout.tsx 수정
기존 AuthProvider 구조를 유지하면서 QueryProvider를 적절한 위치에 추가합니다.

### 4단계: Query Key 상수 정의
`src/lib/queryKeys.ts`를 생성합니다.
- 이 프로젝트에서 사용하는 모든 Query Key를 상수로 정의합니다.
- 대상 리소스: 현재 사용자 정보, 게시글 목록, 게시글 상세

### 5단계: useQuery 적용 — my/page.tsx
- 기존 useEffect + useState 기반 데이터 패칭을 useQuery로 교체합니다.
- 로딩/에러 상태는 useQuery가 제공하는 상태값을 활용합니다.
- 토큰 미존재 시 리다이렉트 처리는 별도로 유지합니다.

### 6단계: useMutation 적용 — posts/new/page.tsx
- 게시글 등록 로직을 useMutation으로 교체합니다.
- 등록 성공 후 관련 캐시를 무효화합니다.
- 기존 loading state를 제거하고 isPending으로 대체합니다.

### 7단계: useMutation 적용 — posts/[no]/edit/page.tsx
- 초기 데이터 로딩(useEffect 기반 get 호출)은 그대로 유지합니다.
- 수정 제출 로직만 useMutation으로 교체합니다.
- 수정 성공 후 목록과 상세 캐시를 모두 무효화합니다.
- 기존 submitting state를 제거하고 isPending으로 대체합니다.
- 현재 코드에 존재하는 `setSubmitting(true)` 중복 호출을 함께 제거합니다.

### 8단계: useMutation 적용 — DeleteButton.tsx
- 삭제 로직을 useMutation으로 교체합니다.
- 삭제 성공 후 게시글 목록 캐시를 무효화합니다.
- 기존 isDeleting state를 제거하고 isPending으로 대체합니다.

## 주의사항
- `posts/page.tsx`, `posts/[no]/page.tsx`는 Server Component이므로 수정하지 않습니다.
- `apiFetch`, `get`, `post`, `patch`는 내부적으로 401 시 Refresh Token 재발급 로직을
  포함하므로 mutationFn 안에서 그대로 사용합니다.
- 기존 toast, router 사용 방식은 유지합니다.
- TypeScript 타입은 `src/types/`의 기존 타입을 그대로 사용합니다.

## 출력 형식
변경된 파일을 파일 경로와 함께 전체 코드로 출력합니다.

신규 생성:
- `src/providers/QueryProvider.tsx`
- `src/lib/queryKeys.ts`

변경:
- `src/app/layout.tsx`
- `src/app/my/page.tsx`
- `src/app/posts/new/page.tsx`
- `src/app/posts/[no]/edit/page.tsx`
- `src/components/post/DeleteButton.tsx`
```

### Zustand 적용하기

```
TanStack Query를 적용하였다. 이제 Zustand를 적용하려 한다. 프롬프트를 작성해줘.
```

```
## 역할
당신은 Next.js + TypeScript 전문 개발자입니다.

## 목표
기존 Next.js 프로젝트에 Zustand를 도입하여
AuthContext 기반 전역 인증 상태를 Zustand로 교체하고
불필요한 Provider 중첩 구조를 제거합니다.

## 프로젝트 구조 및 주요 파일 현황

**현재 인증 구조**
- `src/context/AuthContext.tsx`: Context API 기반, user · isLoading · login · logout 관리
- `src/hooks/useAuth.ts`: useContext 래퍼, AuthProvider 외부 호출 시 에러 발생
- `src/app/layout.tsx`: QueryProvider → AuthProvider 순으로 중첩

**useAuth 사용 컴포넌트**
- `src/components/layout/Navbar.tsx`: user, logout 사용
- `src/components/post/PostActions.tsx`: user 사용
- `src/app/posts/new/page.tsx`: user 사용
- `src/app/posts/[no]/edit/page.tsx`: user 사용
- `src/app/(auth)/login/page.tsx`: user, login 사용
- `src/app/my/page.tsx`: useAuth 참조 (현재 authUser로만 사용)

**TanStack Query 적용 현황**
- `src/providers/QueryProvider.tsx`: QueryClientProvider 설정 완료
- `src/lib/queryKeys.ts`: queryKeys.auth.me() 포함 전체 키 정의 완료
- `src/app/my/page.tsx`: useQuery로 사용자 정보 패칭 중

## 작업 지시

### 1단계: 패키지 설치
`zustand`를 설치합니다.

### 2단계: Zustand 인증 스토어 생성
`src/store/useAuthStore.ts`를 생성합니다.
- 관리할 상태: user, isLoading
- 관리할 액션: restoreSession, login, logout
- 기존 `AuthContext.tsx`의 로직을 그대로 이전합니다.
- `apiFetch`, `setAccessToken`, `removeAccessToken`, `getAccessToken`은 기존 `src/lib/api.ts`의 함수를 사용합니다.
- 서버 인스턴스 공유 문제가 발생하지 않도록 적절한 초기화 방식을 적용합니다.

### 3단계: AuthInitializer 생성
`src/components/AuthInitializer.tsx`를 생성합니다.
- `'use client'` 선언
- 컴포넌트 마운트 시 스토어의 `restoreSession`을 1회 호출합니다.
- UI를 렌더링하지 않고 초기화만 수행합니다.

### 4단계: layout.tsx 수정
- `AuthProvider` 제거, `AuthInitializer`로 교체합니다.
- `AuthProvider` import를 제거합니다.
- Provider 중첩 없이 `AuthInitializer`를 레이아웃 내 적절한 위치에 배치합니다.

### 5단계: useAuth 훅 수정
`src/hooks/useAuth.ts`를 수정합니다.
- useContext 기반 구현을 제거합니다.
- useAuthStore를 그대로 반환하도록 변경합니다.
- 기존 컴포넌트들의 import 경로(`@/hooks/useAuth`) 변경 없이 동작하도록 합니다.

### 6단계: my/page.tsx 수정
- 현재 `useAuth`에서 가져오는 `authUser`는 useQuery의 `user`와 중복됩니다.
- `useAuth` 참조가 실제로 필요한지 검토하고 불필요하면 제거합니다.

### 7단계: AuthContext.tsx 삭제
- 모든 컴포넌트가 `useAuthStore` 또는 수정된 `useAuth`를 통해 동작하는지 확인한 후
  `src/context/AuthContext.tsx`를 삭제합니다.

## 주의사항
- 기존 컴포넌트들의 `useAuth` import 경로는 변경하지 않습니다.
- `user`, `isLoading`, `login`, `logout`의 인터페이스는 기존과 동일하게 유지합니다.
- `login` 함수 내 쿠키 설정 로직과 `logout` 함수 내 쿠키 삭제 로직은 그대로 유지합니다.
- `src/lib/api.ts`는 수정하지 않습니다.

## 출력 형식
변경된 파일을 파일 경로와 함께 전체 코드로 출력합니다.

신규 생성:
- `src/store/useAuthStore.ts`
- `src/components/AuthInitializer.tsx`

변경:
- `src/app/layout.tsx`
- `src/hooks/useAuth.ts`
- `src/app/my/page.tsx`

삭제:
- `src/context/AuthContext.tsx`
```