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


