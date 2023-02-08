/* 조인
=> 서로 관련된 테이블의 데이터를 연결하여 추출하는 방법
=> 기법
1) CROSS 조인(=Cartesian product)
2) NATURAL 조인
3) JOIN ~ USING(컬럼명)
4) JOIN ~ ON
5) OUTER JOIN
*/

-- 1) CROSS 조인(=Cartesian product) - 두 테이블의 데이터를 1:1로 모두 연결한다.
create table board1 (
  bno int primary key auto_increment,
  title varchar(255) not null,
  content text
);

create table attach_file1 (
  fno int primary key auto_increment,
  filepath varchar(255) not null,
  bno int not null 
);
alter table attach_file1
  add constraint attach_file1_fk foreign key (bno) references board1 (bno);

insert into board1 values(1, '제목1', '내용');
insert into board1 values(2, '제목2', '내용');
insert into board1 values(3, '제목3', '내용');

insert into attach_file1 values(101, 'a1.gif', 1);
insert into attach_file1 values(102, 'a2.gif', 1);
insert into attach_file1 values(103, 'c1.gif', 3);

select bno, title from board1;
select fno, filepath, bno from attach_file1;

-- bno 컬럼이 두 테이블에 모두 존재한다.
-- 따라서 어떤 테이블의 컬럼인지 지정하지 않으면 실행 오류!
select bno, title, content, fno, filepath
from board1 cross join attach_file1;

-- select 컬럼이 두 테이블에 모두 있을 경우,
-- 컬럼명 앞에 테이블명을 명시하여 구분하라!
select board1.bno, title, content, fno, filepath, attach_file1.bno
from board1 cross join attach_file1;

-- cross join 고전 문법 */
select board1.bno, title, content, fno, filepath, attach_file1.bno
from board1, attach_file1;

-- 컬럼명 앞에 테이블명을 붙이면 너무 길다.
-- 테이블에 별명을 부여하고 그 별명을 사용하여 컬럼을 지정하라.
select b.bno, title, content, fno, filepath, a.bno
from board1 as b cross join attach_file1 as a;

-- as는 생략 가능
select b.bno, title, content, fno, filepath, a.bno
from board1 b cross join attach_file1 a;

-- 고전 문법
select b.bno, title, content, fno, filepath, a.bno
from board1 b, attach_file1 a;
