-- 조인 연습
-- 문제:
--   다음의 결과가 출력될 수 있도록 수강 신청 데이터를 출력하시오!
--   수강신청번호, 강의명, 학생명, 재직여부, 수강신청일, 강의실명, 매니저명, 직위


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
