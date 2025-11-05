# 바이브 코딩으로 백엔드 개발하기

## 1교시. DB 컨테이너 생성 및 테이블 준비

- Docker Compose를 이용한 MySQL 컨테이너 생성 및 삭제
    ```
    # 생성
    docker compose -f docker-compose-postgres.yml up -d

    # 컨테이너 중지 및 삭제
    docker compose -f docker-compose-postgres.yml down

    # 볼륨까지 함께 삭제 (데이터도 완전히 삭제됨)
    docker compose -f docker-compose-postgres.yml down -v

    # 직접 컨테이너 중지
    docker stop postgres-14

    # 직접 컨테이너 삭제
    docker rm postgres-14

    # 직접 한 번에 중지 + 삭제
    docker rm -f postgres-14
    ```
- 컨테이너 확인
    ```
    docker ps
    ```
- PostgreSQL 클라이언트 접속
    ```
    docker exec -it postgres-14 psql -U postgres -d mydb
    ```
- 테이블 생성
    ```
    # SQL 파일을 컨테이너로 복사
    docker cp lms-ddl.sql postgres-14:/tmp/lms-ddl.sql

    # SQL 파일 실행
    docker exec -it postgres-14 psql -U postgres -d mydb -f /tmp/lms-ddl.sql
    ```
- 테이블 생성 확인
    ```
    # 현재 스키마의 모든 테이블 보기
    \dt

    # 테이블과 상세 정보 (크기, 설명 등) 보기
    \dt+
    
    # 모든 스키마의 테이블 보기
    \dt *.*
    
    # 특정 테이블의 구조(컬럼, 타입 등) 보기
    \d table_name
    
    # 특정 테이블의 상세 구조 보기
    \d+ table_name
    ```
- 예제 데이터 입력
    ```
    # 1. psql 접속 상태에서 실행
    \i /tmp/lms-data.sql
    
    # Docker 컨테이너 외부 파일을 실행하는 경우
    # 만약 /tmp/lms-data.sql 파일이 호스트에 있다면:
    # 호스트의 파일을 컨테이너로 복사
    docker cp lms-data.sql postgres-14:/tmp/lms-data.sql

    # 그 다음 실행
    docker exec -it postgres-14 psql -U postgres -d mydb -f /tmp/lms-data.sql
    ```

## 2교시. Product Requirements Document 문서 준비

- PRD(Product Requirements Document) 문서 준비
    ```
    프롬프트:
    Vibe Coding으로 백엔드 애플리케이션을 개발할 것이다.
    최소한의 필수 항목만 갖춘 product requirements document 템플릿을 작성해줘.
    형식은 markdown 파일로 만들어줘.
    ```
- PRD 문서 커스터마이징
    - 프로젝트 정보 설정
    - API 명세서 설정
    - 기술 스택 설정
- PRD 문서를 기반으로 프로젝트 생성
    ```
    PRD.md 문서를 바탕으로 백엔드 프로젝트를 생성해줘.
    ```
- Spring Boot 실행 및 테스트
    ```
    gradle bootRun
    curl http://localhost:8080/hello
    ```


###