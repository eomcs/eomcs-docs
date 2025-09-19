/* order by */

/* 기본 인덱스 컬럼을 기준으로 정렬한다.*/
select rno, loc, name
from room;

/* 이름의 오름 차순(ascending)으로 정렬하기 */
select rno, loc, name
from room
order by name asc;

/* asc는 생략 가능하다. */
select rno, loc, name
from room
order by name;

/* 이름의 내림 차순(desceding)으로 정렬하기 */
select rno, loc, name
from room
order by name desc;

/* 이름은 오름차순, 지점명도 오름차순으로 정렬하기*/
select rno, loc, name
from room
order by name asc, loc asc;

/* 이름은 오름차순, 지점명은 내림차순으로 정렬하기*/
select rno, loc, name
from room
order by name asc, loc desc;

/* 지점명은 오름차순으로, 이름은 오름차순  정렬하기*/
select rno, loc, name
from room
order by loc asc, name asc;

-- order by 에서 컬럼을 지정할 때 select 절에 선택된 컬럼이 아니더라도 지정할 수 있다.
-- 즉 select 절에 있는 컬럼 또는 테이블 컬럼을 지정할 수 있다.
select rno, name, concat(loc,'-',name) as name2
from room
order by loc asc, name2 asc;

-- 실행 순서: from -> where -> select -> order by
-- 1) from 또는 join : 테이블의 전체 데이터 또는 조인 데이터 
-- 2) where : 조건에 따라 결과로 뽑을 데이터를 selection 한다.
-- 3) group by : 조건에 따라 뽑은 데이터를 특정 컬럼을 기준으로 데이터를 묶는다.
-- 4) having : 그룹으로 묶은 데이터를 조건에 따라 선별한다.
-- 5) select : 최종 결과로 뽑을 컬럼을 표시(projection)한다. 표현식으로 계산한 컬럼도 포함시킨다.
-- 6) order by : select 절에서 추가한 임의 컬럼이나 테이블 컬럼을 기준으로 정렬한다.
-- 7) limit : 결과 데이터에서 지정한 범위의 데이터를 선택한다.
-- 8) 결과 추출: 7번을 수행한 결과 데이터에서 5번에 표시된 컬럼만 추출한다.
select 
  concat(name,'-',loc) as class_name
from 
  room
where 
  loc <> '강남'
order by 
  class_name; -- select 절에 있는 컬럼 또는 테이블 컬럼

select 
  concat(name,'-',loc) as class_name
from 
  room
where 
  loc <> '강남'
order by 
  loc desc; -- select 절에 있는 컬럼 또는 테이블 컬럼