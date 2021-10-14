-- 회원
DROP TABLE IF EXISTS pms_member RESTRICT;

-- 게시판
DROP TABLE IF EXISTS pms_board RESTRICT;

-- 프로젝트
DROP TABLE IF EXISTS pms_project RESTRICT;

-- 프로젝트멤버
DROP TABLE IF EXISTS pms_project_member RESTRICT;

-- 작업
DROP TABLE IF EXISTS pms_task RESTRICT;

-- 좋아요
DROP TABLE IF EXISTS pms_like RESTRICT;

-- 첨부파일
DROP TABLE IF EXISTS pms_board_file RESTRICT;

-- 내관심게시글
DROP TABLE IF EXISTS pms_mylist RESTRICT;

-- 댓글
DROP TABLE IF EXISTS pms_comment RESTRICT;

-- 작업상태
DROP TABLE IF EXISTS pms_task_status RESTRICT;

-- 회원
CREATE TABLE pms_member (
  member_no  INTEGER      NOT NULL COMMENT '회원번호', -- 회원번호
  name       VARCHAR(80)  NOT NULL COMMENT '이름', -- 이름
  email      VARCHAR(50)  NOT NULL COMMENT '이메일', -- 이메일
  password   VARCHAR(100) NOT NULL COMMENT '암호', -- 암호
  photo      VARCHAR(255) NULL     COMMENT '사진', -- 사진
  tel        VARCHAR(30)  NULL     COMMENT '전화', -- 전화
  created_dt DATE         NOT NULL DEFAULT curdate() COMMENT '등록일', -- 등록일
  active     INTEGER      NULL     DEFAULT 1 COMMENT '탈퇴' -- 탈퇴
)
COMMENT '회원';

-- 회원
ALTER TABLE pms_member
  ADD CONSTRAINT PK_pms_member -- 회원 기본키
    PRIMARY KEY (
      member_no -- 회원번호
    );

-- 회원 유니크 인덱스
CREATE UNIQUE INDEX UIX_pms_member
  ON pms_member ( -- 회원
    email ASC -- 이메일
  );

-- 회원 인덱스
CREATE INDEX IX_pms_member
  ON pms_member( -- 회원
    name ASC -- 이름
  );

ALTER TABLE pms_member
  MODIFY COLUMN member_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '회원번호';

-- 게시판
CREATE TABLE pms_board (
  board_no   INTEGER      NOT NULL COMMENT '게시글번호', -- 게시글번호
  title      VARCHAR(255) NOT NULL COMMENT '제목', -- 제목
  content    TEXT         NOT NULL COMMENT '내용', -- 내용
  member_no  INTEGER      NOT NULL COMMENT '회원번호', -- 회원번호
  created_dt DATETIME     NOT NULL DEFAULT now() COMMENT '등록일', -- 등록일
  view_cnt   INTEGER      NULL     DEFAULT 0 COMMENT '조회수' -- 조회수
)
COMMENT '게시판';

-- 게시판
ALTER TABLE pms_board
  ADD CONSTRAINT PK_pms_board -- 게시판 기본키
    PRIMARY KEY (
      board_no -- 게시글번호
    );

ALTER TABLE pms_board
  MODIFY COLUMN board_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '게시글번호';

-- 프로젝트
CREATE TABLE pms_project (
  project_no INTEGER      NOT NULL COMMENT '프로젝트번호', -- 프로젝트번호
  title      VARCHAR(255) NOT NULL COMMENT '제목', -- 제목
  content    TEXT         NOT NULL COMMENT '내용', -- 내용
  start_dt   DATE         NOT NULL COMMENT '시작일', -- 시작일
  end_dt     DATE         NOT NULL COMMENT '종료일', -- 종료일
  member_no  INTEGER      NOT NULL COMMENT '회원번호' -- 회원번호
)
COMMENT '프로젝트';

-- 프로젝트
ALTER TABLE pms_project
  ADD CONSTRAINT PK_pms_project -- 프로젝트 기본키
    PRIMARY KEY (
      project_no -- 프로젝트번호
    );

-- 프로젝트 인덱스
CREATE INDEX IX_pms_project
  ON pms_project( -- 프로젝트
    title ASC -- 제목
  );

ALTER TABLE pms_project
  MODIFY COLUMN project_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '프로젝트번호';

-- 프로젝트멤버
CREATE TABLE pms_project_member (
  project_no INTEGER NOT NULL COMMENT '프로젝트번호', -- 프로젝트번호
  member_no  INTEGER NOT NULL COMMENT '회원번호' -- 회원번호
)
COMMENT '프로젝트멤버';

-- 프로젝트멤버
ALTER TABLE pms_project_member
  ADD CONSTRAINT PK_pms_project_member -- 프로젝트멤버 기본키
    PRIMARY KEY (
      project_no, -- 프로젝트번호
      member_no   -- 회원번호
    );

-- 작업
CREATE TABLE pms_task (
  task_no        INTEGER NOT NULL COMMENT '작업번호', -- 작업번호
  project_no     INTEGER NOT NULL COMMENT '프로젝트번호', -- 프로젝트번호
  member_no      INTEGER NOT NULL COMMENT '회원번호', -- 회원번호
  content        TEXT    NOT NULL COMMENT '내용', -- 내용
  deadline       DATE    NOT NULL COMMENT '마감일', -- 마감일
  task_status_no INTEGER NOT NULL COMMENT '작업상태번호' -- 작업상태번호
)
COMMENT '작업';

-- 작업
ALTER TABLE pms_task
  ADD CONSTRAINT PK_pms_task -- 작업 기본키
    PRIMARY KEY (
      task_no -- 작업번호
    );

ALTER TABLE pms_task
  MODIFY COLUMN task_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '작업번호';

-- 좋아요
CREATE TABLE pms_like (
  member_no INTEGER NOT NULL COMMENT '회원번호', -- 회원번호
  board_no  INTEGER NOT NULL COMMENT '게시글번호' -- 게시글번호
)
COMMENT '좋아요';

-- 좋아요
ALTER TABLE pms_like
  ADD CONSTRAINT PK_pms_like -- 좋아요 기본키
    PRIMARY KEY (
      member_no, -- 회원번호
      board_no   -- 게시글번호
    );

-- 첨부파일
CREATE TABLE pms_board_file (
  board_file_no INTEGER      NOT NULL COMMENT '첨부파일번호', -- 첨부파일번호
  filepath      VARCHAR(255) NOT NULL COMMENT '첨부파일명', -- 첨부파일명
  board_no      INTEGER      NOT NULL COMMENT '게시글번호' -- 게시글번호
)
COMMENT '첨부파일';

-- 첨부파일
ALTER TABLE pms_board_file
  ADD CONSTRAINT PK_pms_board_file -- 첨부파일 기본키
    PRIMARY KEY (
      board_file_no -- 첨부파일번호
    );

ALTER TABLE pms_board_file
  MODIFY COLUMN board_file_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '첨부파일번호';

-- 내관심게시글
CREATE TABLE pms_mylist (
  member_no INTEGER NOT NULL COMMENT '회원번호', -- 회원번호
  board_no  INTEGER NOT NULL COMMENT '게시글번호' -- 게시글번호
)
COMMENT '내관심게시글';

-- 내관심게시글
ALTER TABLE pms_mylist
  ADD CONSTRAINT PK_pms_mylist -- 내관심게시글 기본키
    PRIMARY KEY (
      member_no, -- 회원번호
      board_no   -- 게시글번호
    );

-- 댓글
CREATE TABLE pms_comment (
  comment_no INTEGER  NOT NULL COMMENT '댓글번호', -- 댓글번호
  content    TEXT     NOT NULL COMMENT '내용', -- 내용
  created_dt DATETIME NOT NULL DEFAULT now() COMMENT '작성일', -- 작성일
  member_no  INTEGER  NOT NULL COMMENT '회원번호', -- 회원번호
  board_no   INTEGER  NOT NULL COMMENT '게시글번호' -- 게시글번호
)
COMMENT '댓글';

-- 댓글
ALTER TABLE pms_comment
  ADD CONSTRAINT PK_pms_comment -- 댓글 기본키
    PRIMARY KEY (
      comment_no -- 댓글번호
    );

ALTER TABLE pms_comment
  MODIFY COLUMN comment_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '댓글번호';

-- 작업상태
CREATE TABLE pms_task_status (
  task_status_no INTEGER     NOT NULL COMMENT '작업상태번호', -- 작업상태번호
  title          VARCHAR(80) NOT NULL COMMENT '상태명' -- 상태명
)
COMMENT '작업상태';

-- 작업상태
ALTER TABLE pms_task_status
  ADD CONSTRAINT PK_pms_task_status -- 작업상태 기본키
    PRIMARY KEY (
      task_status_no -- 작업상태번호
    );

-- 작업상태 유니크 인덱스
CREATE UNIQUE INDEX UIX_pms_task_status
  ON pms_task_status ( -- 작업상태
    title ASC -- 상태명
  );

ALTER TABLE pms_task_status
  MODIFY COLUMN task_status_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '작업상태번호';

-- 게시판
ALTER TABLE pms_board
  ADD CONSTRAINT FK_pms_member_TO_pms_board -- 회원 -> 게시판
    FOREIGN KEY (
      member_no -- 회원번호
    )
    REFERENCES pms_member ( -- 회원
      member_no -- 회원번호
    );

-- 프로젝트
ALTER TABLE pms_project
  ADD CONSTRAINT FK_pms_member_TO_pms_project -- 회원 -> 프로젝트
    FOREIGN KEY (
      member_no -- 회원번호
    )
    REFERENCES pms_member ( -- 회원
      member_no -- 회원번호
    );

-- 프로젝트멤버
ALTER TABLE pms_project_member
  ADD CONSTRAINT FK_pms_member_TO_pms_project_member -- 회원 -> 프로젝트멤버
    FOREIGN KEY (
      member_no -- 회원번호
    )
    REFERENCES pms_member ( -- 회원
      member_no -- 회원번호
    );

-- 프로젝트멤버
ALTER TABLE pms_project_member
  ADD CONSTRAINT FK_pms_project_TO_pms_project_member -- 프로젝트 -> 프로젝트멤버
    FOREIGN KEY (
      project_no -- 프로젝트번호
    )
    REFERENCES pms_project ( -- 프로젝트
      project_no -- 프로젝트번호
    );

-- 작업
ALTER TABLE pms_task
  ADD CONSTRAINT FK_pms_project_member_TO_pms_task -- 프로젝트멤버 -> 작업
    FOREIGN KEY (
      project_no, -- 프로젝트번호
      member_no   -- 회원번호
    )
    REFERENCES pms_project_member ( -- 프로젝트멤버
      project_no, -- 프로젝트번호
      member_no   -- 회원번호
    );

-- 작업
ALTER TABLE pms_task
  ADD CONSTRAINT FK_pms_task_status_TO_pms_task -- 작업상태 -> 작업
    FOREIGN KEY (
      task_status_no -- 작업상태번호
    )
    REFERENCES pms_task_status ( -- 작업상태
      task_status_no -- 작업상태번호
    );

-- 좋아요
ALTER TABLE pms_like
  ADD CONSTRAINT FK_pms_member_TO_pms_like -- 회원 -> 좋아요
    FOREIGN KEY (
      member_no -- 회원번호
    )
    REFERENCES pms_member ( -- 회원
      member_no -- 회원번호
    );

-- 좋아요
ALTER TABLE pms_like
  ADD CONSTRAINT FK_pms_board_TO_pms_like -- 게시판 -> 좋아요
    FOREIGN KEY (
      board_no -- 게시글번호
    )
    REFERENCES pms_board ( -- 게시판
      board_no -- 게시글번호
    );

-- 첨부파일
ALTER TABLE pms_board_file
  ADD CONSTRAINT FK_pms_board_TO_pms_board_file -- 게시판 -> 첨부파일
    FOREIGN KEY (
      board_no -- 게시글번호
    )
    REFERENCES pms_board ( -- 게시판
      board_no -- 게시글번호
    );

-- 내관심게시글
ALTER TABLE pms_mylist
  ADD CONSTRAINT FK_pms_member_TO_pms_mylist -- 회원 -> 내관심게시글
    FOREIGN KEY (
      member_no -- 회원번호
    )
    REFERENCES pms_member ( -- 회원
      member_no -- 회원번호
    );

-- 내관심게시글
ALTER TABLE pms_mylist
  ADD CONSTRAINT FK_pms_board_TO_pms_mylist -- 게시판 -> 내관심게시글
    FOREIGN KEY (
      board_no -- 게시글번호
    )
    REFERENCES pms_board ( -- 게시판
      board_no -- 게시글번호
    );

-- 댓글
ALTER TABLE pms_comment
  ADD CONSTRAINT FK_pms_member_TO_pms_comment -- 회원 -> 댓글
    FOREIGN KEY (
      member_no -- 회원번호
    )
    REFERENCES pms_member ( -- 회원
      member_no -- 회원번호
    );

-- 댓글
ALTER TABLE pms_comment
  ADD CONSTRAINT FK_pms_board_TO_pms_comment -- 게시판 -> 댓글
    FOREIGN KEY (
      board_no -- 게시글번호
    )
    REFERENCES pms_board ( -- 게시판
      board_no -- 게시글번호
    );