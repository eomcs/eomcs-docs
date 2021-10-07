# FK(Foreign Key)
- 다른 테이블의 PK를 참조하는 컬럼이다.

첨부파일 정보가 포함된 게시글을 저장하는 테이블을 정의해 보자.

## 한 개의 테이블로 게시글과 첨부파일을 저장하기

최대 5개의 첨부파일 경로를 저장할 컬럼을 만든다.


/* 게시글을 저장할 테이블 */
create table test1(
  no int primary key auto_increment,
  title varchar(255) not null,
  content text,
  rdt datetime default now(),
  filepath1 varchar(255),
  filepath2 varchar(255),
  filepath3 varchar(255),
  filepath4 varchar(255),
  filepath5 varchar(255)
);


고민해볼 사항!
- 첨부 파일의 개수를 5 개로 정해 놓았다.
- 따라서 최대 5개의 첨부 파일만 테이블에 저장할 수 있다.
- 첨부파일이 없더라도 5개의 컬럼은 메모리를 차지한다.

실무에서 원하는 것!
- 첨부 파일의 개수에 제한을 받고 싶지 않다.
- 첨부 파일 개수만큼만 값을 저장하고 싶다.

이렇게 같은 데이터를 저장할 컬럼이 중복된 경우에는,
- 중복 컬럼을 별도의 테이블로 분리한다.
- 중복 컬럼의 값이 어느 테이블의 어느 데이터의 값인지 지정한다.


## 게시글과 첨부파일의 정보를 여러 개의 테이블에 분산 저장하기


/* 게시판 테이블 */
create table test1(
  no int not null primary key auto_increment,
  title varchar(255) not null,
  content text,
  rdt datetime not null default now()
);

/* 첨부 파일 테이블 */
create table test2(
  fno int not null primary key auto_increment, /* 첨부파일 고유번호 */
  filepath varchar(255) not null, /* 파일시스템에 저장된 첨부파일의 경로 */
  bno int not null /* 게시글 번호 */
);


게시판 데이터 입력:

insert into test1(title) values('aaa');
insert into test1(title) values('bbb');
insert into test1(title) values('ccc');
insert into test1(title) values('ddd');
insert into test1(title) values('eee');
insert into test1(title) values('fff');
insert into test1(title) values('ggg');
insert into test1(title) values('hhh');
insert into test1(title) values('iii');
insert into test1(title) values('jjj');


첨부파일 데이터 입력:

insert into test2(filepath, bno) values('c:/download/a.gif', 1);
insert into test2(filepath, bno) values('c:/download/b.gif', 1);
insert into test2(filepath, bno) values('c:/download/c.gif', 1);
insert into test2(filepath, bno) values('c:/download/d.gif', 5);
insert into test2(filepath, bno) values('c:/download/e.gif', 5);
insert into test2(filepath, bno) values('c:/download/f.gif', 10);


## FK 제약 조건이 없을 때
- 첨부파일 데이터를 입력할 때 존재하지 않는 게시물 번호가 들어 갈 수 있다.
- 그러면 첨부파일 데이터는 무효한 데이타 된다.

insert into test2(filepath, bno) values('c:/download/x.gif', 100);


- 첨부 파일이 있는 게시물을 삭제할 수 있다.
- 마찬가지로 해당 게시물을 참조하는 첨부파일 데이터는 무효한 데이터가 된다.

delete from test1 where no=1;


이런 문제가 발생한 이유?
- 다른 테이블의 데이터를 참조하는 경우, 참조 데이터의 존재 유무를 검사하지 않기 때문이다.
- 테이블의 데이터를 삭제할 때 다른 테이블이 참조하는지 여부를 검사하지 않기 때문이다.

해결책?
- 다른 데이터를 참조하는 경우 해당 데이터의 존재 유무를 검사하도록 강제한다.
- 다른 테이터에 의해 참조되는지 여부를 검사하도록 강제한다.
- 이것을 가능하게 하는 문법이 "외부키(Foreign Key)" 이다.


## FK(foreign key) 제약 조건 설정
- 다른 테이블의 데이터와 연관된 데이터를 저장할 때 무효한 데이터가 입력되지 않도록 제어하는 문법이다.
- 다른 테이블의 데이터가 참조하는 데이터를 임의의 지우지 못하도록 제어하는 문법이다.
- 그래서 데이터의 무결성(data integrity; 결함이 없는 상태)을 유지하게 도와주는 문법이다.


다른 테이블의 PK를 참조하는 컬럼으로 선언한다.

alter table 테이블명
    add constraint 제약조건이름 foreign key (컬럼명) references 테이블명(컬럼명);

예)
/* 기존에 테이블에 무효한 데이터가 있을 수 있기 때문에 먼저 테이블의 데이터를 지운다.*/
delete from test2;

alter table test2
    add constraint test2_bno_fk foreign key (bno) references test1(no);


위와 같이 test2 테이블에 FK 제약 조건을 건 다음에 데이터를 입력해보자!

/* 1번 게시물이 존재하지 않기 때문에 데이터를 입력할 수 없다 */
insert into test2(filepath, bno) values('c:/download/a.gif', 1);
insert into test2(filepath, bno) values('c:/download/b.gif', 1);
insert into test2(filepath, bno) values('c:/download/c.gif', 1);

/* 5번, 10번 게시물은 존재하기 때문에 첨부파일 데이터를 입력할 수 있다.*/
insert into test2(filepath, bno) values('c:/download/d.gif', 5);
insert into test2(filepath, bno) values('c:/download/e.gif', 5);
insert into test2(filepath, bno) values('c:/download/f.gif', 10);

/* 2번 게시물은 test2 테이블의 데이터들이 참조하지 않기 때문에 마음대로 지울 수 있다.*/
delete from test1 where no=2; -- OK!

/* 그러나 5번 게시물은 삭제할 수 없다. 왜? test2 테이블의 데이터 중 일부가 참조하기 때문이다.*/
delete from test1 where no=5; -- Error!


## 용어 정리 
- test1 처럼 다른 테이블에 의해 참조되는 테이블을 '부모 테이블'이라 부른다.
- test2 처럼 다른 테이블의 데이터를 참조하는 테이블을 '자식 테이블'이라 부른다.























