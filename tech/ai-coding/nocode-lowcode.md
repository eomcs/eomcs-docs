# 1. 노코드 vs 로우코드 vs AI 코딩의 이해

## 1.1 노코드 vs 로우코드 vs AI 코딩의 특징 비교

| 구분           | 노코드 (No-Code)                           | 로우코드 (Low-Code)                       | AI 코딩 (AI-assisted Coding)                         |
| ------------ | --------------------------------------- | ------------------------------------- | -------------------------------------------------- |
| **개념**       | 코딩 없이 UI/드래그앤드롭 방식으로 앱/웹 개발             | 최소한의 코드 + 비주얼 툴로 앱 개발                 | AI가 코드를 생성·보조하며 개발자가 수정/보완                         |
| **대상 사용자**   | 비개발자, 현업 사용자 (업무 자동화·간단 앱 제작)           | 개발자 + 비즈니스 사용자 협업                     | 주로 개발자 (기본 코딩 이해 필요)                               |
| **도구 예시**    | Notion, Airtable, Zapier, Glide, Bubble | OutSystems, Mendix, PowerApps         | GitHub Copilot, Cursor IDE, Claude Code, Replit AI |
| **장점**       | - 빠른 프로토타입 제작<br>- 기술 장벽 낮음             | - 빠른 개발 속도<br>- 복잡한 앱도 가능             | - 자유도 가장 높음<br>- 최신 AI 활용 → 코드 생산성↑                |
| **단점**       | - 확장성/커스터마이징 제한<br>- 복잡한 로직 구현 어려움      | - 플랫폼 종속성(비용, 유지보수)<br>- 여전히 코드 작성 필요 | - 품질·보안 한계<br>- AI 코드 이해/검증 필요                     |
| **대표 활용 사례** | 간단한 설문 앱, 업무 자동화, 데이터 관리                | 기업용 내부 앱, ERP/CRM 보완                  | 웹/앱 개발, API 연동, 디버깅 지원                             |
| **학습 곡선**    | 가장 낮음                                   | 중간                                    | 다소 높음 (코딩 지식 필요)                                   |


## 1.2 노코드(No Code)

### 특징
- 코드 작성 없이 시각적 인터페이스를 통해 애플리케이션을 개발하는 방식
- 비개발자, 현업 사용자 (업무 자동화·간단 앱 제작)
- 빠른 프로토타입 제작,기술 장벽 낮음
- 확장성/커스터마이징 제한, 복잡한 로직 구현 어려움
- 간단한 설문 앱, 업무 자동화, 데이터 관리

### 도구 
- Webflow: 디자이너를 위한 고급 웹사이트 빌더
- Bubble: 가장 강력한 no-code 웹앱 개발 플랫폼
- Zapier: 앱 간 자동화 연결의 대표주자
- Supabase: 개발자 친화적인 Firebase 대안(low-code 특징 포함)
- Typeform: 인터랙티브한 폼 및 설문조사
- Framer: 인터랙티브 프로토타입 및 웹사이트
- Shopify: 온라인 쇼핑몰 구축의 대표 플랫폼
- Airtable: 스프레드시트와 데이터베이스의 결합

### 실습 | 간단한 직원 관리 시스템 만들기

1. Airtable에서 데이터 구조 생성
    ```
    - airtable.com 가입 및 로그인
    - Workspaces > Workspace 선택
    - 'Build on app on your own' 선택
    - Base 이름: 직원 관리
    - 테이블 이름: 직원
        - 이름(Single line text)
        - 부서(Single select): 개발, 마케팅, 영업, 인사
        - 직위(Single line text)
        - 이메일(Email)
        - 시작일(Date)
        - 상태(Single select): 재직, 휴직, 퇴직
        - 프로필 사진(Attachment)
    ```
2. '직원' 테이블에 예제 데이터 넣기
    ```
    프롬프트: '직원' 테이블에 예제 데이터를 10개 추가해줘
    ```
3. 뷰 설정 
    ```
    - Grid View: 전체 직원 목록
    - Gallery View: 프로필 사진 중심 직원카드
    - Calendar View: 입사일 기준 달력
    - Kanban View: 부서별 직원 현황
    ```
4. Zapier를 활용한 업무 자동화: 신규 직원 온보딩
    ```
    - zapier.com 가입 및 로그인
    - Zaps -> Create -> New Zap 클릭
    - Trigger: 새 직원 데이터가 추가될 때 
        - Setup
            - App: Airtable 선택
            - Trigger Event: New Record 선택
            - Account: 계정 연결
        - Contigure
            - Base: '직원 관리' 선택
            - Table: '직원' 선택
        - Test
            - '직원' 테이블의 최신 레코드 3개 확인
    - Action: 환영 이메일 발송
        - Setup
            - App: Gmail 선택
            - Action Event: Send Email 선택
            - Account: 계정 연결
        - Configure
            - To: 신규 직원 이메일 매핑
            - From: 계정 이메일 선택
            - Subject: "환영합니다, {이름}님!"
            - Body: 환영 메시지 작성
        - Test
            - Skip Test
    - Action: HR 채널에 신규 직원 알림
        - Setup
            - App: Slack 선택
            - Action event: Send Channel Message 선택
            - Account: Slack 계정 연결
        - Configure
            - Channel: #채널명 선택
            - Add Zapier app to channel automatically: No 선택
                - 슬랙 채널에 Zapier 앱이 등록되어 있어야 메시지 전송 가능
            - Message Text: 이메일 관련 정보 매핑
                - From, Subject, Snippet 등
            - Send as a bot: Yes 선택
                - No 선택 시: 사용자의 이름으로 메시지 전송
        - Test
            - Skip Test
            - Publish 선택
    ```
5. Airtable의 '직원' 테이블에 새 직원 추가
    - Zapier가 자동으로 이메일 발송 및 슬랙 알림 전송 확인
6. Zapier를 활용한 업무 자동화: 퇴사 처리
    ```
    - airtable.com 에 로그인
    - '직원' 테이블에 '변경일(Last modified time)' 타입의 필드 추가
        - 이 필드가 있어야만 레코드의 변경 상태에 반응하여 Zap이 작동하도록 설정할 수 있음
    ```
    ```
    - zapier.com 가입 및 로그인
    - Zaps -> Create -> New Zap 클릭
    - Trigger: 직원의 레코드가 변경될 때
        - Setup
            - App: Airtable 선택
            - Trigger Event: New or Updated Record 선택
            - Account: 계정 연결
        - Contigure
            - Base: '직원 관리' 선택
            - Table: '직원' 선택
            - Last modified time column: '변경일' 선택
        - Test
            - '직원' 테이블의 최신 레코드 3개 확인
    - Filter: 직원의 '상태' 필드가 '퇴직'으로 변경될 때
        - Setup
            - App: Filter by Zapier 선택
        - Configure & test
            - Field: '상태' 선택
            - Condition: (Text) Exactly matches
            - Value: '퇴직'
    - Action: 퇴사 처리 체크리스트 이메일 발송
        - Setup
            - App: Gmail 선택
            - Action Event: Send Email 선택
            - Account: 계정 연결
        - Configure
            - To: 신규 직원 이메일 매핑
            - From: 계정 이메일 선택
            - Subject: "{이름}님의 퇴사 절차를 안내드립니다."
            - Body: 퇴사 절차 체크리스트 작성
        - Test
            - Skip Test
    - Action: IT팀에 계정 비활성화 요청
        - Setup
            - App: Slack 선택
            - Action event: Send Channel Message 선택
            - Account: Slack 계정 연결
        - Configure
            - Channel: #채널명 선택
            - Add Zapier app to channel automatically: No 선택
                - 슬랙 채널에 Zapier 앱이 등록되어 있어야 메시지 전송 가능
            - Message Text: 퇴사자의 부서, 이름, 직위 명시 
            - Send as a bot: Yes 선택
                - No 선택 시: 사용자의 이름으로 메시지 전송
        - Test
            - Skip Test
    - Action: 퇴사자 명단에 추가
        - Setup
            - App: Google Sheets 선택
            - Action event: Create Spreadsheet Row 선택
            - Account: Google 계정 연결
        - Configure
            - Drive: My Google Drive 선택
            - Spreadsheet: '퇴사자' 선택
            - Worksheet: '2025년' 선택
            - Row: 퇴사자의 이름, 부서, 직위, 이메일, 퇴사일 컬럼
        - Test
            - Skip Test
            - Publish 선택
    ```
7. Airtable의 '직원' 테이블에서 한 직원의 상태를 '퇴사'로 변경
    - Zapier가 실행되는 것을 확인

## 1.3 로우코드(Low Code)

### 특징
- 최소한의 코드 작성으로 애플리케이션을 개발하는 방식
- 개발자 + 비즈니스 사용자 협업
- 빠른 개발 속도, 복잡한 앱도 가능
- 플랫폼 종속성(비용, 유지보수), 일부 코딩 지식 필요 (SQL, JavaScript 등)
- 기업용 내부 앱, ERP/CRM 보완

### 도구 
- OutSystems: 엔터프라이즈급 모바일/웹 앱 개발 플랫폼
- Microsoft Power Platform: Power Apps, Power Automate, Power BI의 통합 생태계
- Salesforce Lightning Platform: 세계 최대 CRM 기반의 커스텀 앱 개발
- Mendix: Siemens 소유의 엔터프라이즈 앱 개발 플랫폼
- Supabase: 개발자 친화적인 Firebase 대안
- Budibase: 웹앱 빌더 (내부 관리 도구, CRM, 대시보드 등 제작)
- Appsmith: 내부용 도구에 최적화된 Low-Code 플랫폼

### 실습 | 직원 CRUD 앱 만들기
- 실습 준비
    ```
    1. appsmith.com 회원 가입 및 무료 시작하기
        - Business plan trial: 15일 무료
    2. 워크스페이스 생성
        - 이름: study
    3. 애플리케이션 만들기
        - [Create New] 클릭
        - Application 선택
        - 이름 변경: (화면 상단) study / Employee App
    ```
- 직원 목록 화면 만들기(Page1)
    ```
    1. 데이터소스 연결하기
        - 왼쪽 사이드바에서 [Datasources 아이콘] 클릭
        - [Bring your data] 클릭
        - Sample Datasources / users 선택
    2. Query 구성하기
        - 오른쪽 상단 [+ New query] 선택 > Datasources: users 선택
        - [Run] 클릭하여 기본 생성된 쿼리 실행
        - 직원 목록 화면에 출력할 컬럼 지정
            - SELECT id, name, email, phone, image FROM public."users" LIMIT 10;
            - [Run] 클릭하여 쿼리 실행
        - 이름 오름차순으로 정렬
            - SELECT id, name, email, phone, image FROM public."users" ORDER BY name ASC LIMIT 10;
            - [Run] 클릭하여 쿼리 실행
        - Query 이름 변경: getUsers
    3. UI 구성하기
        - 왼쪽 상단에서 [UI] 아이콘 클릭
        - [New UI element] 클릭
        - Table 위젯을 화면에 추가 및 크기 조정
        - 오른쪽 속성 창
            - Table data: getUsers 쿼리 선택
            - Columns: id, image, name, email, phone (드래그하여 순서 변경)
    4. 애플리케이션 배포
        - (화면 왼쪽 상단) Deploy 클릭
        - 화면 동작 확인
    5. 직원 목록 화면에서 사진 표시하기
        - Table 위젯 선택
        - 오른쪽 속성 창에서 Columns 설정
            - image 컬럼 > 설정 > Column type: Image 선택
    6. 테이블 위젯 이름 변경
        - 왼쪽 페이지 위젯 목록에서 Table1 선택
        - 설정 > Rename: employeeTable
    7. 페이지 이름 변경
        - 왼쪽 상단 페이지 정보에서 Page1 설정 클릭
        - 이름 변경: Employee List
    8. 페이지 제목 위켓 추가
        - 페이지 UI 편집 화면 > [+ New UI element] > Text 드래그하여 페이지 화면 상단에 추가
        - 속성 창:
            - Content > Text: 직원 목록
            - Style > Font size: XL 선택
        - 위젯 이름 변경: pageTitle
    9. 페이지 이동 처리하기
        - Pagination 속성
            - Show pagination: True
            - Server side pagination: True
        - Query 변경
            - getUsers: SELECT id, name, email, phone, image FROM public."users" ORDER BY name ASC LIMIT {{employeeTable.pageSize}} OFFSET {{(employeeTable.pageNo - 1) * employeeTable.pageSize}};
    ```
- 직원 상세 정보 화면 만들기(Page2)
    ```
    1. 왼쪽 상단 페이지에서 [+]를 클릭하여 새 페이지 추가: New blank page 선택
    2. 페이지 이름 변경: (상단 페이지 정보에서) Employee Details
    3. Query 구성하기
        - 오른쪽 상단 [+ New query] 선택 > Datasources: users 선택
        - Query 이름 변경: getUserById
        - 목록에서 선택한 직원의 id로 상세 정보 조회
            - SELECT * FROM public."users" WHERE id=1;
            - [Run] 클릭하여 쿼리 실행: id가 1번인 직원 정보 확인
    4. UI 구성하기
        - 왼쪽 상단에서 [UI] 아이콘 클릭
        - [New UI element] 클릭
        - JSONForm 위젯을 화면에 추가 및 크기 조정
            - 위젯 이름 변경: employeeForm
        - 오른쪽 속성 창
            - General > Title: 직원 상세 정보
            - Data > Source data: {{getUserById.data[0]}} 입력
            - [Generate form] 클릭
            - 항목 감추기: Latitude, Longitude
            - 날짜 컬럼 포맷 변경
                - Dob 컬럼
                    - Date format: YYYY-MM-DD
                - Created At 컬럼: 
                    - Field Type: Datepicker
                    - Date format: YYYY-MM-DD HH:mm
                - Updated At 컬럼: 
                    - Field Type: Datepicker
                    - Date format: YYYY-MM-DD HH:mm
            - Image 컬럼
                - General Visible: false
        - 사진 출력 위젯 추가
            - UI > Media > Image 드래그하여 Form 왼쪽에 추가
            - 위젯 이름 변경: profileImage
            - Data > Image 속성: {{employeeForm.formData.image}}
    ```
- 목록 페이지와 상세 정보 페이지를 연결하기
    ```
    1. Employee List 페이지: 액션 추가
        - employeeTable 위젯 > name 컬럼 설정
            - Column type: Button 선택
            - onClick 추가
                - Action: Navigate to
                - Type: Page name
                - Choose page: Employee Details
                - Query params
                    - {{{ id: currentRow.id }}}
                - Target: Same window 선택
    2. Employee Details 페이지: Query 변경
        - getUserById: `SELECT * FROM public."users" WHERE id={{appsmith.URL.queryParams.id}};`
    3. Deploy 및 테스트
    ```
- 직원 등록 페이지 만들기
    ```
    1. 왼쪽 상단 페이지에서 [+]를 클릭하여 새 페이지 추가: New blank page 선택
        - 페이지 이름 변경: (상단 페이지 정보에서) Employee Form
    3. Query 구성하기 
        - 오른쪽 상단 [+ New query] 선택 > Datasources: users 선택
        - Query 이름 변경: getUserById
        - 목록에서 선택한 직원의 id로 상세 정보 조회
            - SELECT name, gender, dob, phone, email, image, country FROM public."users" WHERE id=451;
            - [Run] 클릭하여 쿼리 실행: id가 1번인 직원 정보 확인
    4. UI 구성하기
        - 왼쪽 상단에서 [UI] 아이콘 클릭
        - [New UI element] 클릭 
        - 제목 위젯 추가
            - Text 드래그하여 페이지 화면 상단에 추가
            - 속성 창:
                - Content > Text: 직원 등록
                - Style > Font size: XL 선택
            - 위젯 이름 변경: pageTitle
        - 폼 위젯 추가
            - UI > Forms > JSONForm 드래그하여 페이지에 추가
            - 위젯 이름 변경: employeeForm
            - 오른쪽 속성 창:
                - General > Title: 기본 정보
                - Data > Source data: {{getUserById.data[0]}}
                - [Generate form] 클릭
                - 컬럼 정렬: name, email, phone, image, gender, dob, country
                - 컬럼 타입 설정
                    - Name(Text Input, Required)
                    - Email(Email Input, Required)
                    - Phone(Phone Number Input, Required)
                    - Image(Text Input, Required)
                    - Gender(Select)
                        - [{"label": "남자","value": "male"},{"label": "여자","value": "female"}]
                    - Dob(Datepicker)
                        - Date format: YYYY-MM-DD
                    - Country(Text Input)
    ```
- 직원 목록 페이지에서 직원 등록 페이지로 이동하기
    ```
    1. Employee List 페이지: 액션 추가
        - UI > Buttons > Button 드래그하여 페이지에 추가
        - 위젯 이름 변경: addEmployeeButton
        - 속성 창:
            - Label: 직원 등록
            - onClick 추가
                - Action: Navigate to
                - Type: Page name
                - Choose page: Employee Form
                - Target: Same window 선택
    2. Deploy 및 테스트
    ```
- 직원 등록 폼 입력 값 저장하기
    ```
    1. Query 구성하기
        - 오른쪽 상단 [+ New query] 선택 > Datasources: users 선택
        - Query 이름 변경: insertUser
        - 입력폼의 값을 DB에 저장
            - INSERT INTO public."users" (name, gender, dob, phone, email, image, country) VALUES ({{employeeForm.formData.name}}, {{employeeForm.formData.gender}}, {{employeeForm.formData.dob}}, {{employeeForm.formData.phone}}, {{employeeForm.formData.email}}, {{employeeForm.formData.image}}, {{employeeForm.formData.country}});
    2. Employee Form 페이지 > employeeForm: onSubmit 이벤트 추가
        - employeeForm 위젯 선택
        - 오른쪽 속성 창:
            - Events > onSubmit 추가
                - Action: Execute a query 선택 > insertUser 선택
                - Choose API: insertUser
            - Callbacks action 추가: On success 이벤트
                - Action: Navigate to
                - Type: Page name
                - Choose page: Employee List
                - Target: Same window
            - Callbacks action 추가: On failure 이벤트
                - Action: Show alert
                - Message: 입력 실패!
                - Type: Error
    2. Deploy 및 테스트
    ```

## 1.4 AI 코딩(AI-assisted Coding)
- AI가 코드를 생성·보조하며 개발자가 수정/보완하는 방식
- 주로 개발자 (기본 코딩 이해 필요)
- 자유도 가장 높음, 최신 AI 활용 → 코드 생산성↑
- 품질·보안 한계, AI 코드 이해/검증 필요
- 웹/앱 개발, API 연동, 디버깅 지원
- 도구:
    - IDE 통합 코드 어시스턴트: 
        - GitHub Copilot: 가장 널리 사용되는 AI 코드 완성 도구, OpenAI Codex 기반
        - Amazon CodeWhisperer: AWS 서비스와 잘 통합되는 무료 코드 어시스턴트
    - 대화형 AI 코딩 어시스턴트:
        - ChatGPT: 코드 설명, 디버깅, 알고리즘 구현에 널리 활용
        - Claude: 긴 코드 분석 및 복잡한 프로그래밍 문제 해결에 강함
        - Google Bard/Gemini: 구글의 AI 어시스턴트, 코딩 지원 포함
        - Perplexity: 코딩 관련 정보 검색 및 코드 생성
    - 전문 AI 코딩 플랫폼
        - Cursor: AI 우선으로 설계된 코드 에디터, GPT-4 통합
        - Replit: AI 기반 협업 코딩 환경
        - Claude Code CLI: 커맨드 라인 인터페이스 기반의 코드 작성 및 수정 지원

