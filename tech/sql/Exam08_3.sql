/* 조인
=> 서로 관련된 테이블의 데이터를 연결하여 추출하는 방법
=> 기법
1) CROSS 조인(=Cartesian product)
2) NATURAL 조인
3) JOIN ~ USING(컬럼명)
4) JOIN ~ ON
5) OUTER JOIN
*/

-- 3) JOIN ~ USING
--    같은 이름을 가진 컬럼이 여러 개 있을 경우 USING을 사용하여 컬럼을 명시할 수 있다.
select b.bno, b.title, content, a.fno, a.title, a.bno
from board4 b join attach_file4 a using (bno);

-- join ~ using 의 한계
-- => 두 테이블에 같은 이름의 컬럼이 없을 경우 연결하지 못한다.

create table board5 (
  no int primary key auto_increment,
  title varchar(255) not null,
  content text
);

create table attach_file5 (
  fno int primary key auto_increment,
  filepath varchar(255) not null,
  bno int not null 
);
alter table attach_file5
  add constraint attach_file5_fk foreign key (bno) references board5 (no);

insert into board5 values(1, '제목1', '내용');
insert into board5 values(2, '제목2', '내용');
insert into board5 values(3, '제목3', '내용');

insert into attach_file5 values(1, 'a1.gif', 1);
insert into attach_file5 values(2, 'a2.gif', 1);
insert into attach_file5 values(3, 'c1.gif', 3);

-- 두 테이블의 데이터를 연결할 때 기준이 되는 컬럼이 이름이 같지 않다.
-- 이런 경우 using을 사용할 수 없다. 실행 오류!
select no, title, content, fno, filepath, bno
from board5 b join attach_file5 a using (bno);
