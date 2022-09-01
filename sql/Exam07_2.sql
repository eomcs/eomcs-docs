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

select 
  rno, 
  loc, 
  name
from 
  room
order by 
  loc asc, 
  name desc;

select 
  rno, 
  name
from 
  room
order by 
  loc asc, 
  name desc;

-- 실행 순서: from -> where -> select -> order by
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