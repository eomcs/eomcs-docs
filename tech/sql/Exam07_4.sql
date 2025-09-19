/* union 과 union all */

/* select 결과 합치기
   union : 중복 값 자동 제거*/
select distinct bank from stnt
union
select distinct bank from tcher;

/* union all: 중복 값 제거 안함*/
select distinct bank from stnt
union all
select distinct bank from tcher;

/* 차집합
   mysql 은 차집합 문법을 지원하지 않는다.
   따라서 다음과 기존의 SQL 문법을 사용해서 처리해야 한다.
*/
select distinct bank
from stnt
where not bank in (select distinct bank from tcher);

/* 교집합
   mysql 은 교집합 문법을 지원하지 않는다.
   따라서 다음과 기존의 SQL 문법을 사용해서 처리해야 한다.
*/
select distinct bank
from stnt
where bank in (select distinct bank from tcher);







/* */
