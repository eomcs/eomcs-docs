-- 조인 연습

-- 문제:
--   모든 멤버의 번호와 이름을 출력하라!
--   단 학생의 경우 재직여부도 출력하라!

-- 1) 모든 멤버 데이터 출력하기
select mno, name
from memb;

-- 2) 학생 데이터를 가져와서 연결하기
select mno, name, work
from memb natural join stnt;

-- 3) join ~ using으로 연결하기
select mno, name, work
from memb join stnt using(mno);

-- 4) 고전 문법으로 연결하기
select memb.mno, name, work
from memb, stnt
where memb.mno=stnt.mno;

-- 5) inner join ~ on 연결하기
select memb.mno, name, work
from memb inner join stnt on memb.mno=stnt.mno;

-- 6) inner 생략하기
select memb.mno, name, work
from memb join stnt on memb.mno=stnt.mno;

-- 7) 테이블에 별명 부여하기
select m.mno, name, work
from memb m join stnt s on m.mno=s.mno;

/*
안타깝게도 위의 SQL문은 학생 목록만 출력한다.
왜? 
- memb테이블의 데이터와 stnt 테이블의 데이터를
  연결할 때 mno가 같은 데이터만 연결하여 추출하기 때문이다.
해결책!
- 상대 테이블(stnt)에 연결할 대상(데이터)이 없더라도
  select에서 추출하는 방법 
*/
-- 8) outer join ~ on 으로 연결하기
select m.mno, name, work
from memb m left outer join stnt s on m.mno=s.mno;



/* 여러 테이블의 데이터를 연결하기
    => 다음의 결과가 출력될 수 있도록 수강 신청 데이터를 출력하시오!
    수강신청번호, 강의명, 학생명, 재직여부, 수강신청일, 강의실명, 매니저명, 직위 */

/* 1단계: 수강신청 데이터를 출력 */
select la.lano, la.lno, la.mno, la.rdt
from lect_appl la;

/* 2단계: 수강신청한 학생의 번호 대신 이름을 출력 */
select la.lano, la.lno, m.name, la.rdt
from lect_appl la
     inner join memb m on la.mno=m.mno;

/* 3단계: 수강 신청한 학생의 재직 여부 출력
 * => inner join 에서 inner는 생략 가능
 */
select la.lano, la.lno, m.name, s.work, la.rdt
from lect_appl la
        join memb m on la.mno=m.mno
        join stnt s on la.mno=s.mno;

/* 4단계: 수강신청한 강의 번호 대신 강의명을 출력 */
select la.lano, l.titl, m.name, s.work, la.rdt, l.rno
from lect_appl la
        join memb m on la.mno=m.mno
        join stnt s on la.mno=s.mno
        join lect l on la.lno=l.lno;

/* 5단계: 강의실 이름을 출력한다.
 * => 강의실 번호는 lect 테이블 데이터에 있다.
 * => 강의실 이름은 room 테이블 데이터에 있다.
 */
select la.lano, l.titl, m.name, s.work, la.rdt, r.name, l.mno
from lect_appl la
        join memb m on la.mno=m.mno
        join stnt s on la.mno=s.mno
        join lect l on la.lno=l.lno
        left outer join room r on l.rno=r.rno;

/* 6단계: 매니저 이름을 출력
 * => 매니저 번호는 lect 테이블에 있다.
 * => 매니저 이름은 memb 테이블에 있다.
 */
select
  la.lano,
  l.titl,
  m.name member_name,
  s.work,
  la.rdt,
  r.name room_name,
  m2.name manager_name
from lect_appl la
        join memb m on la.mno=m.mno
        join stnt s on la.mno=s.mno
        join lect l on la.lno=l.lno
        left outer join room r on l.rno=r.rno
        left outer join memb m2 on l.mno=m2.mno;

/* 7단계: 매니저의 직위 출력
 * => 매니저 번호는 lect 테이블 있다.
 * => 매니저 직위는 mgr 테이블에 있다.
 */
select
  la.lano,
  l.titl,
  m.name snm,
  s.work,
  la.rdt,
  r.name rnm,
  m2.name mnm,
  mr.posi
from lect_appl la
        join memb m on la.mno=m.mno
        join stnt s on la.mno=s.mno
        join lect l on la.lno=l.lno
        left outer join room r on l.rno=r.rno
        left outer join memb m2 on l.mno=m2.mno
        left outer join mgr mr on l.mno=mr.mno;










/* */
