/* 데이터를 특정 컬럼을 기준으로 그룹으로 묶어 질의하기
=> group by ~ having ~
*/

/* 각 지점별 강의실 수 구하기*/
-- 1단계: 강의실 목록 구하기
select 
    r.rno,
    r.loc,
    r.name
from 
    room r;

-- 2단계: 지점정보를 저장한 컬럼을 기준으로 그룹으로 묶는다.
select 
    r.rno, -- 그룹으로 묶인 경우 그 그룹의 첫 번째 데이터 값만 출력한다.
    r.loc,
    r.name -- 그룹으로 묶인 경우 그 그룹의 첫 번째 데이터 값만 출력한다.
from 
    room r
group by 
    r.loc;

-- 3단계: group by를 통해 데이터를 그룹으로 묶은 경우 
--        개별 항목의 값을 나타내는 컬럼의 값은 의미가 없기 때문에 제거한다.
select 
    r.loc
from 
    room r
group by 
    r.loc;

-- 4단계: 그룹으로 묶은 경우 그룹 관련 함수를 사용할 수 있다.
select 
    r.loc,
    count(*) as cnt
from
    room r
group by    
    r.loc;

-- 5단계: group by의 결과에서 최종 결과를 선택할 조건을 지정하고 싶다면 
--       having절을 사용한다.
select 
    r.loc,
    count(*) as cnt
from
    room r
group by    
    r.loc
having 
    r.loc = '종로'; -- having의 조건은 그룹으로 묶을 때 사용한 컬럼이어야 한다.

-- 다음은 실행 오류!
select 
    r.loc,
    count(*) as cnt
from
    room r
group by    
    r.loc
having 
    r.name = '301'; -- having의 조건은 그룹으로 묶을 때 사용한 컬럼이어야 한다.

-- 다음은 실행 오류!
select 
    r.loc,
    count(*) as cnt
from
    room r
group by    
    r.loc
having 
    r.cnt > 3; -- having의 조건은 그룹으로 묶을 때 사용한 컬럼이어야 한다.