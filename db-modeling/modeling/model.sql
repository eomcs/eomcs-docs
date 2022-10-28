-- 수강신청
DROP TABLE IF EXISTS stud_cours_appl RESTRICT;

-- 강사
DROP TABLE IF EXISTS tchr RESTRICT;

-- 학생
DROP TABLE IF EXISTS stud RESTRICT;

-- 주소
DROP TABLE IF EXISTS addr RESTRICT;

-- 교육과정
DROP TABLE IF EXISTS cours RESTRICT;

-- 강의실
DROP TABLE IF EXISTS clas RESTRICT;

-- 강의실사진
DROP TABLE IF EXISTS clas_phot RESTRICT;

-- 매니저
DROP TABLE IF EXISTS mgr RESTRICT;

-- 지점
DROP TABLE IF EXISTS loc RESTRICT;

-- 과목
DROP TABLE IF EXISTS subj RESTRICT;

-- 강사교육과정배정
DROP TABLE IF EXISTS tchr_cours RESTRICT;

-- 강사강의과목
DROP TABLE IF EXISTS tchr_subj RESTRICT;

-- 교육과정과목
DROP TABLE IF EXISTS cours_subj RESTRICT;

-- 사용자
DROP TABLE IF EXISTS user RESTRICT;

-- 학력
DROP TABLE IF EXISTS grade RESTRICT;

-- 결제유형
DROP TABLE IF EXISTS pay_type RESTRICT;

-- 신청결과
DROP TABLE IF EXISTS app_stat RESTRICT;

-- 수강신청
CREATE TABLE stud_cours_appl (
  stud_cours_appl_id INTEGER  NOT NULL COMMENT '수강신청번호', -- 수강신청번호
  stud_id            INTEGER  NOT NULL COMMENT '학생번호', -- 학생번호
  cours_id           INTEGER  NOT NULL COMMENT '교육과정번호', -- 교육과정번호
  rdt                DATETIME NOT NULL COMMENT '신청일', -- 신청일
  app_stat_id        INTEGER  NULL     COMMENT '신청결과번호', -- 신청결과번호
  pay_type_id        INTEGER  NULL     COMMENT '결제유형번호', -- 결제유형번호
  pay_stat           BOOLEAN  NULL     COMMENT '결제상태', -- 결제상태
  pay_dt             DATETIME NULL     COMMENT '결제일' -- 결제일
)
COMMENT '수강신청';

-- 수강신청
ALTER TABLE stud_cours_appl
  ADD CONSTRAINT PK_stud_cours_appl -- 수강신청 기본키
    PRIMARY KEY (
      stud_cours_appl_id -- 수강신청번호
    );

ALTER TABLE stud_cours_appl
  MODIFY COLUMN stud_cours_appl_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '수강신청번호';

-- 강사
CREATE TABLE tchr (
  tchr_id   INTEGER      NOT NULL COMMENT '강사번호', -- 강사번호
  lst_grade VARCHAR(80)  NOT NULL COMMENT '최종학력', -- 최종학력
  schl      VARCHAR(80)  NOT NULL COMMENT '학교', -- 학교
  major     VARCHAR(80)  NOT NULL COMMENT '전공', -- 전공
  hp        VARCHAR(255) NULL     COMMENT '홈페이지' -- 홈페이지
)
COMMENT '강사';

-- 강사
ALTER TABLE tchr
  ADD CONSTRAINT PK_tchr -- 강사 기본키
    PRIMARY KEY (
      tchr_id -- 강사번호
    );

-- 학생
CREATE TABLE stud (
  stud_id  INTEGER     NOT NULL COMMENT '학생번호', -- 학생번호
  work     BOOLEAN     NOT NULL COMMENT '재직중', -- 재직중
  grade_id INTEGER     NOT NULL COMMENT '최종학력번호', -- 최종학력번호
  bank     VARCHAR(80) NULL     COMMENT '은행명', -- 은행명
  acc      VARCHAR(30) NULL     COMMENT '계좌번호', -- 계좌번호
  major    VARCHAR(80) NULL     COMMENT '전공' -- 전공
)
COMMENT '학생';

-- 학생
ALTER TABLE stud
  ADD CONSTRAINT PK_stud -- 학생 기본키
    PRIMARY KEY (
      stud_id -- 학생번호
    );

-- 주소
CREATE TABLE addr (
  addr_id  INTEGER      NOT NULL COMMENT '주소번호', -- 주소번호
  pst_no   CHAR(5)      NOT NULL COMMENT '우편번호', -- 우편번호
  bas_addr VARCHAR(255) NOT NULL COMMENT '기본주소' -- 기본주소
)
COMMENT '주소';

-- 주소
ALTER TABLE addr
  ADD CONSTRAINT PK_addr -- 주소 기본키
    PRIMARY KEY (
      addr_id -- 주소번호
    );

ALTER TABLE addr
  MODIFY COLUMN addr_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '주소번호';

-- 교육과정
CREATE TABLE cours (
  cours_id INTEGER      NOT NULL COMMENT '교육과정번호', -- 교육과정번호
  sdt      DATETIME     NOT NULL COMMENT '시작일', -- 시작일
  edt      DATETIME     NOT NULL COMMENT '종료일', -- 종료일
  tot_hr   INTEGER      NOT NULL COMMENT '총강의시간', -- 총강의시간
  day_hr   INTEGER      NOT NULL COMMENT '일강의시간', -- 일강의시간
  pric     INTEGER      NOT NULL COMMENT '수강료', -- 수강료
  qty      INTEGER      NOT NULL COMMENT '모집인원', -- 모집인원
  titl     VARCHAR(255) NOT NULL COMMENT '교육과정명', -- 교육과정명
  cont     TEXT         NOT NULL COMMENT '설명', -- 설명
  clas_id  INTEGER      NULL     COMMENT '강의실번호', -- 강의실번호
  mgr_id   INTEGER      NULL     COMMENT '매니저번호' -- 매니저번호
)
COMMENT '교육과정';

-- 교육과정
ALTER TABLE cours
  ADD CONSTRAINT PK_cours -- 교육과정 기본키
    PRIMARY KEY (
      cours_id -- 교육과정번호
    );

-- 교육과정 인덱스
CREATE INDEX IX_cours
  ON cours( -- 교육과정
    titl ASC -- 교육과정명
  );

ALTER TABLE cours
  MODIFY COLUMN cours_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '교육과정번호';

-- 강의실
CREATE TABLE clas (
  clas_id INTEGER     NOT NULL COMMENT '강의실번호', -- 강의실번호
  qty     INTEGER     NOT NULL COMMENT '최대수용인원', -- 최대수용인원
  loc_id  INTEGER     NOT NULL COMMENT '지점번호', -- 지점번호
  name    VARCHAR(80) NOT NULL COMMENT '교실명' -- 교실명
)
COMMENT '강의실';

-- 강의실
ALTER TABLE clas
  ADD CONSTRAINT PK_clas -- 강의실 기본키
    PRIMARY KEY (
      clas_id -- 강의실번호
    );

-- 강의실 유니크 인덱스
CREATE UNIQUE INDEX UIX_clas
  ON clas ( -- 강의실
    loc_id ASC, -- 지점번호
    name ASC    -- 교실명
  );

ALTER TABLE clas
  MODIFY COLUMN clas_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '강의실번호';

-- 강의실사진
CREATE TABLE clas_phot (
  clas_phot_id INTEGER      NOT NULL COMMENT '강의실사진번호', -- 강의실사진번호
  clas_id      INTEGER      NOT NULL COMMENT '강의실번호', -- 강의실번호
  file_path    VARCHAR(255) NOT NULL COMMENT '교실사진' -- 교실사진
)
COMMENT '강의실사진';

-- 강의실사진
ALTER TABLE clas_phot
  ADD CONSTRAINT PK_clas_phot -- 강의실사진 기본키
    PRIMARY KEY (
      clas_phot_id -- 강의실사진번호
    );

ALTER TABLE clas_phot
  MODIFY COLUMN clas_phot_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '강의실사진번호';

-- 매니저
CREATE TABLE mgr (
  mgr_id INTEGER     NOT NULL COMMENT '매니저번호', -- 매니저번호
  pos    VARCHAR(80) NOT NULL COMMENT '직위', -- 직위
  fax    VARCHAR(30) NULL     COMMENT '팩스' -- 팩스
)
COMMENT '매니저';

-- 매니저
ALTER TABLE mgr
  ADD CONSTRAINT PK_mgr -- 매니저 기본키
    PRIMARY KEY (
      mgr_id -- 매니저번호
    );

-- 지점
CREATE TABLE loc (
  loc_id INTEGER     NOT NULL COMMENT '지점번호', -- 지점번호
  name   VARCHAR(80) NOT NULL COMMENT '지점명' -- 지점명
)
COMMENT '지점';

-- 지점
ALTER TABLE loc
  ADD CONSTRAINT PK_loc -- 지점 기본키
    PRIMARY KEY (
      loc_id -- 지점번호
    );

-- 지점 유니크 인덱스
CREATE UNIQUE INDEX UIX_loc
  ON loc ( -- 지점
    name ASC -- 지점명
  );

ALTER TABLE loc
  MODIFY COLUMN loc_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '지점번호';

-- 과목
CREATE TABLE subj (
  subj_id INTEGER      NOT NULL COMMENT '과목번호', -- 과목번호
  titl    VARCHAR(255) NOT NULL COMMENT '과목명' -- 과목명
)
COMMENT '과목';

-- 과목
ALTER TABLE subj
  ADD CONSTRAINT PK_subj -- 과목 기본키
    PRIMARY KEY (
      subj_id -- 과목번호
    );

-- 과목 유니크 인덱스
CREATE UNIQUE INDEX UIX_subj
  ON subj ( -- 과목
    titl ASC -- 과목명
  );

ALTER TABLE subj
  MODIFY COLUMN subj_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '과목번호';

-- 강사교육과정배정
CREATE TABLE tchr_cours (
  cours_id INTEGER NOT NULL COMMENT '교육과정번호', -- 교육과정번호
  tchr_id  INTEGER NOT NULL COMMENT '강사번호' -- 강사번호
)
COMMENT '강사교육과정배정';

-- 강사교육과정배정
ALTER TABLE tchr_cours
  ADD CONSTRAINT PK_tchr_cours -- 강사교육과정배정 기본키
    PRIMARY KEY (
      cours_id, -- 교육과정번호
      tchr_id   -- 강사번호
    );

-- 강사강의과목
CREATE TABLE tchr_subj (
  subj_id INTEGER NOT NULL COMMENT '과목번호', -- 과목번호
  tchr_id INTEGER NOT NULL COMMENT '강사번호' -- 강사번호
)
COMMENT '강사강의과목';

-- 강사강의과목
ALTER TABLE tchr_subj
  ADD CONSTRAINT PK_tchr_subj -- 강사강의과목 기본키
    PRIMARY KEY (
      subj_id, -- 과목번호
      tchr_id  -- 강사번호
    );

-- 교육과정과목
CREATE TABLE cours_subj (
  cours_id INTEGER NOT NULL COMMENT '교육과정번호', -- 교육과정번호
  subj_id  INTEGER NOT NULL COMMENT '과목번호' -- 과목번호
)
COMMENT '교육과정과목';

-- 교육과정과목
ALTER TABLE cours_subj
  ADD CONSTRAINT PK_cours_subj -- 교육과정과목 기본키
    PRIMARY KEY (
      cours_id, -- 교육과정번호
      subj_id   -- 과목번호
    );

-- 사용자
CREATE TABLE user (
  user_id  INTEGER      NOT NULL COMMENT '사용자번호', -- 사용자번호
  name     VARCHAR(80)  NOT NULL COMMENT '이름', -- 이름
  email    VARCHAR(40)  NOT NULL COMMENT '이메일', -- 이메일
  pwd      VARCHAR(100) NOT NULL COMMENT '암호', -- 암호
  tel      VARCHAR(30)  NULL     COMMENT '전화', -- 전화
  phot     VARCHAR(255) NULL     COMMENT '사진', -- 사진
  addr_id  INTEGER      NULL     COMMENT '주소번호', -- 주소번호
  det_addr VARCHAR(255) NULL     COMMENT '상세주소' -- 상세주소
)
COMMENT '사용자';

-- 사용자
ALTER TABLE user
  ADD CONSTRAINT PK_user -- 사용자 기본키
    PRIMARY KEY (
      user_id -- 사용자번호
    );

-- 사용자 유니크 인덱스
CREATE UNIQUE INDEX UIX_user
  ON user ( -- 사용자
    email ASC -- 이메일
  );

-- 사용자 인덱스
CREATE INDEX IX_user
  ON user( -- 사용자
    name ASC -- 이름
  );

ALTER TABLE user
  MODIFY COLUMN user_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '사용자번호';

-- 학력
CREATE TABLE grade (
  grade_id INTEGER     NOT NULL COMMENT '학력번호', -- 학력번호
  titl     VARCHAR(80) NOT NULL COMMENT '학력명' -- 학력명
)
COMMENT '학력';

-- 학력
ALTER TABLE grade
  ADD CONSTRAINT PK_grade -- 학력 기본키
    PRIMARY KEY (
      grade_id -- 학력번호
    );

-- 학력 유니크 인덱스
CREATE UNIQUE INDEX UIX_grade
  ON grade ( -- 학력
    titl ASC -- 학력명
  );

ALTER TABLE grade
  MODIFY COLUMN grade_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '학력번호';

-- 결제유형
CREATE TABLE pay_type (
  pay_type_id INTEGER     NOT NULL COMMENT '결제유형번호', -- 결제유형번호
  type_nm     VARCHAR(80) NULL     COMMENT '결제유형명' -- 결제유형명
)
COMMENT '결제유형';

-- 결제유형
ALTER TABLE pay_type
  ADD CONSTRAINT PK_pay_type -- 결제유형 기본키
    PRIMARY KEY (
      pay_type_id -- 결제유형번호
    );

-- 결제유형 유니크 인덱스
CREATE UNIQUE INDEX UIX_pay_type
  ON pay_type ( -- 결제유형
    type_nm ASC -- 결제유형명
  );

ALTER TABLE pay_type
  MODIFY COLUMN pay_type_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '결제유형번호';

-- 신청결과
CREATE TABLE app_stat (
  app_stat_id INTEGER     NOT NULL COMMENT '신청결과번호', -- 신청결과번호
  stat_nm     VARCHAR(80) NULL     COMMENT '상태' -- 상태
)
COMMENT '신청결과';

-- 신청결과
ALTER TABLE app_stat
  ADD CONSTRAINT PK_app_stat -- 신청결과 기본키
    PRIMARY KEY (
      app_stat_id -- 신청결과번호
    );

-- 신청결과 유니크 인덱스
CREATE UNIQUE INDEX UIX_app_stat
  ON app_stat ( -- 신청결과
    stat_nm ASC -- 상태
  );

ALTER TABLE app_stat
  MODIFY COLUMN app_stat_id INTEGER NOT NULL AUTO_INCREMENT COMMENT '신청결과번호';

-- 수강신청
ALTER TABLE stud_cours_appl
  ADD CONSTRAINT FK_stud_TO_stud_cours_appl -- 학생 -> 수강신청
    FOREIGN KEY (
      stud_id -- 학생번호
    )
    REFERENCES stud ( -- 학생
      stud_id -- 학생번호
    );

-- 수강신청
ALTER TABLE stud_cours_appl
  ADD CONSTRAINT FK_cours_TO_stud_cours_appl -- 교육과정 -> 수강신청
    FOREIGN KEY (
      cours_id -- 교육과정번호
    )
    REFERENCES cours ( -- 교육과정
      cours_id -- 교육과정번호
    );

-- 수강신청
ALTER TABLE stud_cours_appl
  ADD CONSTRAINT FK_pay_type_TO_stud_cours_appl -- 결제유형 -> 수강신청
    FOREIGN KEY (
      pay_type_id -- 결제유형번호
    )
    REFERENCES pay_type ( -- 결제유형
      pay_type_id -- 결제유형번호
    );

-- 수강신청
ALTER TABLE stud_cours_appl
  ADD CONSTRAINT FK_app_stat_TO_stud_cours_appl -- 신청결과 -> 수강신청
    FOREIGN KEY (
      app_stat_id -- 신청결과번호
    )
    REFERENCES app_stat ( -- 신청결과
      app_stat_id -- 신청결과번호
    );

-- 강사
ALTER TABLE tchr
  ADD CONSTRAINT FK_user_TO_tchr -- 사용자 -> 강사
    FOREIGN KEY (
      tchr_id -- 강사번호
    )
    REFERENCES user ( -- 사용자
      user_id -- 사용자번호
    );

-- 학생
ALTER TABLE stud
  ADD CONSTRAINT FK_user_TO_stud -- 사용자 -> 학생
    FOREIGN KEY (
      stud_id -- 학생번호
    )
    REFERENCES user ( -- 사용자
      user_id -- 사용자번호
    );

-- 학생
ALTER TABLE stud
  ADD CONSTRAINT FK_grade_TO_stud -- 학력 -> 학생
    FOREIGN KEY (
      grade_id -- 최종학력번호
    )
    REFERENCES grade ( -- 학력
      grade_id -- 학력번호
    );

-- 교육과정
ALTER TABLE cours
  ADD CONSTRAINT FK_clas_TO_cours -- 강의실 -> 교육과정
    FOREIGN KEY (
      clas_id -- 강의실번호
    )
    REFERENCES clas ( -- 강의실
      clas_id -- 강의실번호
    );

-- 교육과정
ALTER TABLE cours
  ADD CONSTRAINT FK_mgr_TO_cours -- 매니저 -> 교육과정
    FOREIGN KEY (
      mgr_id -- 매니저번호
    )
    REFERENCES mgr ( -- 매니저
      mgr_id -- 매니저번호
    );

-- 강의실
ALTER TABLE clas
  ADD CONSTRAINT FK_loc_TO_clas -- 지점 -> 강의실
    FOREIGN KEY (
      loc_id -- 지점번호
    )
    REFERENCES loc ( -- 지점
      loc_id -- 지점번호
    );

-- 강의실사진
ALTER TABLE clas_phot
  ADD CONSTRAINT FK_clas_TO_clas_phot -- 강의실 -> 강의실사진
    FOREIGN KEY (
      clas_id -- 강의실번호
    )
    REFERENCES clas ( -- 강의실
      clas_id -- 강의실번호
    );

-- 매니저
ALTER TABLE mgr
  ADD CONSTRAINT FK_user_TO_mgr -- 사용자 -> 매니저
    FOREIGN KEY (
      mgr_id -- 매니저번호
    )
    REFERENCES user ( -- 사용자
      user_id -- 사용자번호
    );

-- 강사교육과정배정
ALTER TABLE tchr_cours
  ADD CONSTRAINT FK_cours_TO_tchr_cours -- 교육과정 -> 강사교육과정배정
    FOREIGN KEY (
      cours_id -- 교육과정번호
    )
    REFERENCES cours ( -- 교육과정
      cours_id -- 교육과정번호
    );

-- 강사교육과정배정
ALTER TABLE tchr_cours
  ADD CONSTRAINT FK_tchr_TO_tchr_cours -- 강사 -> 강사교육과정배정
    FOREIGN KEY (
      tchr_id -- 강사번호
    )
    REFERENCES tchr ( -- 강사
      tchr_id -- 강사번호
    );

-- 강사강의과목
ALTER TABLE tchr_subj
  ADD CONSTRAINT FK_tchr_TO_tchr_subj -- 강사 -> 강사강의과목
    FOREIGN KEY (
      tchr_id -- 강사번호
    )
    REFERENCES tchr ( -- 강사
      tchr_id -- 강사번호
    );

-- 강사강의과목
ALTER TABLE tchr_subj
  ADD CONSTRAINT FK_subj_TO_tchr_subj -- 과목 -> 강사강의과목
    FOREIGN KEY (
      subj_id -- 과목번호
    )
    REFERENCES subj ( -- 과목
      subj_id -- 과목번호
    );

-- 교육과정과목
ALTER TABLE cours_subj
  ADD CONSTRAINT FK_cours_TO_cours_subj -- 교육과정 -> 교육과정과목
    FOREIGN KEY (
      cours_id -- 교육과정번호
    )
    REFERENCES cours ( -- 교육과정
      cours_id -- 교육과정번호
    );

-- 교육과정과목
ALTER TABLE cours_subj
  ADD CONSTRAINT FK_subj_TO_cours_subj -- 과목 -> 교육과정과목
    FOREIGN KEY (
      subj_id -- 과목번호
    )
    REFERENCES subj ( -- 과목
      subj_id -- 과목번호
    );

-- 사용자
ALTER TABLE user
  ADD CONSTRAINT FK_addr_TO_user -- 주소 -> 사용자
    FOREIGN KEY (
      addr_id -- 주소번호
    )
    REFERENCES addr ( -- 주소
      addr_id -- 주소번호
    );