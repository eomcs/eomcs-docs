/* 조인
=> 서로 관련된 테이블의 데이터를 연결하여 추출하는 방법
=> 기법
1) CROSS 조인(=Cartesian product)
2) NATURAL 조인
3) JOIN ~ USING(컬럼명)
4) JOIN ~ ON
5) OUTER JOIN
*/

-- 2) NATURAL 조인
--    같은 이름을 가진 컬럼 값을 기준으로 레코드를 연결한다.
select b.bno, title, content, fno, filepath, a.bno
from board1 b natural join attach_file1 a;

-- 고전 문법
select b.bno, title, content, fno, filepath, a.bno
from board1 b, attach_file1 a
where b.bno = a.bno;

-- natural join 의 문제점
-- 가. 두 테이블의 조인 기준이 되는 컬럼 이름이 다를 때 연결되지 못한다.
-- 나. 상관 없는 컬럼과 이름이 같을 때 잘못 연결된다.
-- 다. 같은 이름의 컬럼이 여러 개 있을 경우 잘못 연결된다.
--    모든 컬럼의 값이 일치할 경우에만 연결되기 때문이다.


-- 가. 두 테이블의 조인 기준이 되는 컬럼 이름이 다를 때:
--
create table board2 (
  no int primary key auto_increment,
  title varchar(255) not null,
  content text
);

create table attach_file2 (
  fno int primary key auto_increment,
  filepath varchar(255) not null,
  bno int not null 
);
alter table attach_file2
  add constraint attach_file2_fk foreign key (bno) references board2 (no);

insert into board2 values(1, '제목1', '내용');
insert into board2 values(2, '제목2', '내용');
insert into board2 values(3, '제목3', '내용');

insert into attach_file2 values(101, 'a1.gif', 1);
insert into attach_file2 values(102, 'a2.gif', 1);
insert into attach_file2 values(103, 'c1.gif', 3);

-- natural join의 기준이 되는 같은 이름을 가진 컬럼이 양 테이블에 존재하지 않는다.
-- => cross join 처럼 실행된다.
select no, title, content, fno, filepath, bno
from board2 b natural join attach_file2 a;

-- 고전 문법 : 
-- 고전 문법에서는 where 절의 조건으로 두 테이블의 조인 기준이 되는 컬럼 값을 검사하기 때문에 
-- 실행 결과는 정상적으로 나온다.
select no, title, content, fno, filepath, bno
from board2 b, attach_file2 a
where b.no = a.bno;

-- 나. 같은 이름을 가진 컬럼이 있지만 서로 상관(PK와 FK 관계)이 없는 컬럼일 때:
--
create table board3 (
  no int primary key auto_increment,
  title varchar(255) not null,
  content text
);

create table attach_file3 (
  no int primary key auto_increment,
  filepath varchar(255) not null,
  bno int not null 
);
alter table attach_file3
  add constraint attach_file3_fk foreign key (bno) references board3 (no);

insert into board3 values(1, '제목1', '내용');
insert into board3 values(2, '제목2', '내용');
insert into board3 values(3, '제목3', '내용');

insert into attach_file3 values(1, 'a1.gif', 1);
insert into attach_file3 values(2, 'a2.gif', 1);
insert into attach_file3 values(3, 'c1.gif', 3);
insert into attach_file3 values(4, 'x1.gif', 2);
insert into attach_file3 values(5, 'x2.gif', 2);
insert into attach_file3 values(6, 'x3.gif', 2);

-- board3의 no와 attach_file3의 no는 PK/FK 관계가 아니다.
-- 그럼에도 불구하고 이름이 같기 때문에 이 컬럼을 기준으로 데이터를 연결한다.
select b.no, title, content, a.no, filepath, bno
from board3 b natural join attach_file3 a;

-- 고전 문법 : 
-- 고전 문법에서는 where 절의 조건으로 두 테이블의 조인 기준이 되는 컬럼 값을 검사하기 때문에 
-- 실행 결과는 정상적으로 나온다.
select b.no, title, content, a.no, filepath, bno
from board3 b, attach_file3 a
where b.no = a.bno;


-- 다. 같은 이름을 가진 컬럼이 여러 개 있을 때:
--
create table board4 (
  bno int primary key auto_increment,
  title varchar(255) not null,
  content text
);

create table attach_file4 (
  fno int primary key auto_increment,
  title varchar(255) not null,
  bno int not null 
);
alter table attach_file4
  add constraint attach_file4_fk foreign key (bno) references board4 (bno);

insert into board4 values(1, '제목1', '내용');
insert into board4 values(2, '제목2', '내용');
insert into board4 values(3, '제목3', '내용');

insert into attach_file4 values(1, 'a1.gif', 1);
insert into attach_file4 values(2, 'a2.gif', 1);
insert into attach_file4 values(3, 'c1.gif', 3);


-- board4와 attach_file4에 같은 이름을 가진 컬럼이 여러 개 있다.
-- 해당 컬럼들의 값이 같을 때만 두 테이블의 데이터를 연결한다.
-- 따라서 실행 결과 데이터는 없을 것이다.
select b.bno, b.title, content, a.fno, a.title, a.bno
from board4 b natural join attach_file4 a;

-- 고전 문법 : 
-- 고전 문법에서는 where 절의 조건으로 두 테이블의 조인 기준이 되는 컬럼 값을 검사하기 때문에 
-- 실행 결과는 정상적으로 나온다.
select b.bno, b.title, content, a.fno, a.title, a.bno
from board4 b, attach_file4 a
where b.bno = a.bno;


