# DDL(Data Definition Language)
- DB 객체(테이블, 뷰, 프로시저, 함수, 트리거) 등을 생성, 변경, 삭제하는 SQL 명령이다.
- 데이터베이스(database) = 스키마(schema)
- 테이블(table)
- 뷰(view)
- 트리거(trigger=listener)
  - 특정 조건에서 자동으로 호출되는 함수
  - 특정 조건? SQL 실행 전/후 등
  - OOP 디자인 패턴에서 옵저버에 해당한다.
- 함수(function)
- 프로시저(procedure)
- 인덱스(index)

## 데이터베이스
데이터베이스 생성
  create database 데이터베이스명 옵션들...;

데이터베이스 삭제
  drop database 데이터베이스명;

데이터베이스 변경
  alter database 데이터베이스명 옵션들...;

## 테이블
테이블 생성
  create table 테이블명 (
    컬럼명 타입 NULL여부 옵션,
    컬럼명 타입 NULL여부 옵션,
    ...
    컬럼명 타입 NULL여부 옵션
  );

예)
  create table test01 (
    name varchar(50) not null,
    kor int not null,
    eng int not null,
    math int not null,
    sum int not null,
    aver float not null
  );

테이블 정보 보기
  describe 테이블명;
  desc 테이블명;
  예) describe test01;
  예) desc test01;

테이블 삭제하기
  drop table 테이블명;
  예) drop table test01;

### 테이블 컬럼 옵션

#### null 허용
데이터를 입력하지 않아도 된다.
  create table test1 (
    no int,
    name varchar(20)
  );

데이터 입력 테스트:
  insert into test1(no, name) values(1, 'aaa');
  insert into test1(no, name) values(null, 'bbb');
  insert into test1(no, name) values(3, null);
  insert into test1(no, name) values(null, null);
  select * from test1;

#### not null
데이터를 입력하지 않으면 입력/변경 거절!
  create table test1(
    no int not null,
    name varchar(20)
  );

데이터 입력 테스트:
  insert into test1(no, name) values(1, 'aaa');
  insert into test1(no, name) values(null, 'bbb'); /* 실행 오류 */
  insert into test1(no, name) values(3, null);

#### 기본값 지정하기
입력 값을 생략하면 해당 컬럼에 지정된 기본값이 대신 입력된다.
  create table test1(
    no int not null,
    name varchar(20) default 'noname',
    age int default 20
  );

  insert into test1(no, name, age) values(1, 'aaa', 30);

값을 입력하지 않는 컬럼은 이름과 값 지정을 생략한다.
  insert into test1(name, age) values('aaa', 30); /* 오류! no는 not null*/

컬럼에 default 값이 설정된 경우, 컬럼 값의 입력을 생략하면 기본값이 사용된다.
  insert into test1(no, age) values(3, 30);
  insert into test1(no, name) values(4, 'ddd');
  insert into test1(no) values(5);

컬럼에 default 옵션이 있는 경우,
- 컬럼 값을 생략하면 default 옵션으로 지정한 값이 사용된다.
- 컬럼 값을 null로 지정하면 기본 값이 사용되지 않는다.
  insert into test1(no, age, name) values(6, null, null);

### 컬럼 타입

#### int
- 4바이트 크기의 정수 값 저장
- 기타 tinyint(1바이트), smallint(2바이트), mediumint(3바이트), bigint(8바이트)

#### float
- 부동소수점 저장

#### numeric = decimal
- 전체 자릿수와 소수점 이하의 자릿수를 정밀하게 지정할 수 있다.
- numeric(n,e) : 전체 n 자릿수 중에서 소수점은 e 자릿수다.
  - 예) numeric(10,2) : 12345678.12
- numeric : numeric(10, 0) 과 같다.

입력 테스트:
  create table test1(
    c1 int,
    c2 float,
    c3 numeric(6,2), /* 소수점 자릿수를 
    지정하면 
    부동소수점으로 사용 */
    c4 numeric -- decimal 과 같다
  );

  insert into test1(c1) values(100);
  insert into test1(c1) values(3.14); /* 소수점 이하 반올림하고 짜름 */
  insert into test1(c1) values(100.98); /* 소수점 이하 반올림하고 짜름 */

  insert into test1(c2) values(100);
  insert into test1(c2) values(3.14);
  insert into test1(c2) values(3.14159);

  insert into test1(c3) values(100);
  insert into test1(c3) values(123456789); /* 입력 오류. 4자리 초과 */
  insert into test1(c3) values(12345); /* 입력 오류. 4자리 초과 */
  insert into test1(c3) values(1234);
  insert into test1(c3) values(3.14);
  insert into test1(c3) values(3.14159); /* 2자리를 초과한 값은 반올림. */
  insert into test1(c3) values(3.14551); /* 2자리를 초과한 값은 반올림. */

  insert into test1(c4) values(1234567890);
  insert into test1(c4) values(12.34567890); /* 소수점은 반올림 처리됨 */
  insert into test1(c4) values(12345678.90); /* 소수점은 반올림 처리됨 */

#### char(n)
- 최대 n개의 문자를 저장.
- 0 <= n <= 255
- 고정 크기를 갖는다.
- 한 문자를 저장하더라도 n자를 저장할 크기를 사용한다.
- 메모리 크기가 고정되어서 검색할 때 빠르다.

#### varchar(n)
- 최대 n개의 문자를 저장.
- 0 ~ 65535 바이트 크기를 갖는다.
- 단, 한 행의 최대 크기 65535 바이트를 초과하지 않아야 한다.
- 만약 초과해야 한다면, TEXT 나 BLOB 를 사용하라.
- n 값은 문자집합에 따라 최대 값이 다르다.
- 한 문자에 1바이트를 사용하는 ISO-8859-n 문자집한인 경우 최대 65535 이다.
- 그러나 UTF-8로 지정된 경우는, n은 최대 21844까지 지정할 수 있다.
- 가변 크기를 갖는다.
- 한 문자를 저장하면 한 문자 만큼 크기의 메모리를 차지한다.
- 메모리 크기가 가변적이라서 데이터 위치를 찾을 때 시간이 오래 걸린다.
  그래서 검색할 때 위치를 계산해야 하기 때문에 검색 시 느리다.

  create table test1(
    c1 char(5),
    c2 varchar(5),
    c3 varchar(21000)
  );

입력 테스트:
  insert into test1(c1) values('');
  insert into test1(c1) values('abcde');
  insert into test1(c1) values('가나다라마'); /* 한글 영어 상관없이 5자 */
  insert into test1(c1) values('abcdefghi'); /* 입력 크기 초과 오류! */
  insert into test1(c1) values('가나다라마바'); /* 입력 크기 초과 오류! */

  insert into test1(c2) values('');
  insert into test1(c2) values('abcde');
  insert into test1(c2) values('abcdefghi'); /* 입력 크기 초과 오류! */

고정 크기와 가변 크기 비교:
  insert into test1(c1) values('abc');
  insert into test1(c2) values('abc');

  select * from test1 where c1='abc';
DBMS 중에는 고정 크기인 컬럼의 값을 비교할 때 빈자리까지 검사하는 경우도 있다.
즉 c1='abc'에서는 데이터를 찾지 못하고, c1='abc  '여야만 데이터를 찾는 경우가 있다.
그러나 mysql은 고정크기 컬럼이더라도 빈자리를 무시하고 데이터를 찾는다.

#### text(65535), mediumtext(약 1.6MB), longtext(약 4GB)
- 긴 텍스트를 저장할 때 사용하는 컬럼 타입이다.
- 오라클의 경우 long 타입(2GB)과 CLOB(character large object) 타입(4GB)이 있다.

#### date
- 날짜 정보를 저장할 때 사용한다.
- 년,월,일 정보를 저장한다.
- 오라클의 경우 날짜 뿐만 아니라 시간 정보도 저장한다.

#### time
- 시간 정보를 저장할 때 사용한다.
- 시, 분, 초 정보를 저장한다.

#### datetime
- 날짜와 시간 정보를 함께 저장할 때 사용한다.

  create table test1(
    c1 date,
    c2 date,
    c3 timestamp
  );

입력 테스터:
  insert into test1(c1) values('2022-02-21');
  insert into test1(c2) values('16:12:35');
  insert into test1(c3) values('2022-2-21 16:5:3');
  insert into test1(c1) values('2022-02-21 16:13:33'); /* 날짜 정보만 저장*/
  insert into test1(c2) values('2022-02-21 16:13:33'); /* 시간 정보만 저장*/
  insert into test1(c3) values('2022-02-21'); /* 시간 정보는 0을 설정된다.*/
  insert into test1(c3) values('16:13:33'); /* 실행 오류!*/

#### boolean
- 보통 true, false를 의미하는 값을 저장할 때는 정수 1 또는 0으로 표현한다.
- 또는 문자로 Y 또는 N으로 표현하기도 한다.
- 실제 컬럼을 생성할 때 tinyint(1) 로 설정한다.

  create table test1(
    c1 char(1),
    c2 int,
    c3 boolean
  );


  insert into test1(c1) values('Y'); /* yes */
  insert into test1(c1) values('N'); /* no */
  insert into test1(c1) values('T'); /* true */
  insert into test1(c1) values('F'); /* false */
  insert into test1(c1) values('1'); /* true */
  insert into test1(c1) values('0'); /* false */

  insert into test1(c2) values(1); /* true */
  insert into test1(c2) values(0); /* false */

  insert into test1(c3) values('Y'); /* error */
  insert into test1(c3) values('N'); /* error */
  insert into test1(c3) values('T'); /* error */
  insert into test1(c3) values('F'); /* error */

  insert into test1(c3) values(true); /* 저장할 때 1 */
  insert into test1(c3) values(false); /* 저장할 때 0 */
  insert into test1(c3) values('1'); /* true -> 1 */
  insert into test1(c3) values('0'); /* false -> 0 */
  insert into test1(c3) values(1); /* true -> 1 */
  insert into test1(c3) values(0); /* false -> 0 */

- 숫자 컬럼인 경우 값을 설정할 때 문자로 표현할 수 있다.
- 즉 문자열을 숫자로 바꿀 수 있으면 된다.

### 키 컬럼 지정

key column : 데이터를 구분할 때 사용하는 값

테이블:
- name, email, jumin, id, pwd, tel, postno, basic_addr, gender

#### key vs candidate key

- key
  - 데이터를 구분할 때 사용하는 컬럼들의 집합
  - 예)
    - {email}, {jumin}, {id}, {name, tel}, {tel, basic_addr, gender, name}
    - {name, jumin}, {email, id}, {id, name, email} ...
- candidate key (후보키 = 최소키)
  - key 들 중에서 최소 항목으로 줄인 키
  - {jumin}, {email}, {id}, {name, tel}

#### alternate key vs primary key

- primary key (주 키)
  - candidate key 중에서 DBMS 관리자가 사용하기로 결정한 키
  - 예) DBMS 관리자가 id 컬럼의 값을 데이터를 구분하는 키로 사용하기로 결정했다면,
    - 주 키는, {id} 가 된다.
    - 주 키로 선택되지 않은 모든 candidate key는 alternate key가 된다.
- alternate key (대안 키)
  - candidate key 중에서 primary key로 선택된 키를 제외한 나머지 키.
  - 비록 primary key는 아니지만, primary key 처럼 데이터를 구분하는
    용도로 대신 사용할 수 있다고 해서 **대안 키(alternate key)** 라 부른다.

#### artificial key (인공키; surrogate key(대리키)))
- Primary key로 사용하기에 적절한 컬럼을 찾을 수 없다면,
  - 예) 게시글 : 제목, 내용, 작성자, 등록일, 조회수
- 이런 경우에 key로 사용할 컬럼을 추가한다.
- 보통 일련번호를 저장할 정수 타입의 컬럼을 추가한다.
  - 예) 게시글 : 게시글 번호
- 대부분의 SNS 서비스들은 일련의 번호를 primary key 사용한다.
- 왜?
  - 회원 탈퇴의 경우,
    - 회원 탈퇴할 때 아이디도 제거한다.
    - 아이디를 지우면 그 아이디와 연결된 게시글을 지워야 한다.
    - 그런데 회원 아이디 대신 일련 번호를 사용하면,
    - 그 회원이 쓴 게시글은 일련번호와 묶인다.
    - 따라서 아이디가 삭제되더라도 해당 글은 계속 유효하게 처리할 수 있다.
  - 이메일 변경,
    - primary key 값은 다른 데이터에서 사용하기 때문에,
      - 예) 게시글을 저장할 때 회원 이메일을 저장한다고 가정하자.
    - pk 값을 변경하면 그 값을 사용한 모든 데이터에 영향을 끼친다.
    - 그래서 PK 값을 다른 데이터에서 사용한 경우,
      DBMS는 PK 값을 변경하지 못하도록 통제한다.
    - 이렇게 변경될 수 있는 값인 경우, PK로 사용하지 말라.
    - 대신 회원 번호와 같은 임의의 키(인공 키)를 만들어 사용하는 것이 좋다.

#### primary key
- 테이블의 데이터를 구분할 때 사용하는 컬럼들이다.
- 줄여서 PK라고 표시한다.
- PK 컬럼을 지정하지 않으면 데이터가 중복될 수 있다.

- PK를 지정하기 전:
  create table test1(
    name varchar(20),
    kor int,
    eng int,
    math int
  );

- 입력 테스트:
  insert into test1(name,kor,eng,math) values('aaa', 100, 100, 100);
  insert into test1(name,kor,eng,math) values('bbb', 90, 90, 90);
  insert into test1(name,kor,eng,math) values('aaa', 100, 100, 100); /* 중복 허용*/

- PK를 지정한 후:
> 컬럼명 타입 primary key
  create table test1(
    name varchar(20) primary key,
    kor int,
    eng int,
    math int
  );

- 입력 테스트:
  insert into test1(name,kor,eng,math) values('aaa', 100, 100, 100);
  insert into test1(name,kor,eng,math) values('bbb', 90, 90, 90);
  insert into test1(name,kor,eng,math) values('aaa', 100, 100, 100); /* 중복 오류!*/
  insert into test1(kor,eng,math) values(100, 100, 100); /* PK는 기본이 not null 이다. */

- 한 개 이상의 컬럼을 PK로 지정하기
  create table test1(
    name varchar(20) primary key,
    age int primary key,
    kor int,
    eng int,
    math int
  ); /* 실행 오류 */

- 두 개 이상의 컬럼을 묶어서 PK로 선언하고 싶다면
  각 컬럼에 대해서 개별적으로 PK를 지정해서는 안된다.
- 여러 개의 컬럼을 묶어서 PK로 지정하려면 별도의 문법을 사용해야 한다.
  - constraint 제약조건이름 primary key (컬럼명, 컬럼명, ...)
  - 제약조건이름은 생략 가능.
  - 제약조건이름을 지정하지 않으면 이름이 자동으로 부여된다.
    그래서 나중에 제약조건을 찾기 힘들다.

  create table test1(
    name varchar(20),
    age int,
    kor int,
    eng int,
    math int,
    constraint test1_pk primary key(name, age)
  );


- 입력 테스트:
  insert into test1(name, age, kor, eng, math) values('aa', 10, 100, 100, 100);
  insert into test1(name, age, kor, eng, math) values('bb', 20, 90, 90, 90);
  insert into test1(name, age, kor, eng, math) values('aa', 11, 88, 88, 88);
  insert into test1(name, age, kor, eng, math) values('ab', 10, 88, 88, 88);

/* 이름과 나이가 같으면 중복되기 때문에 입력 거절이다. */
  insert into test1(name, age, kor, eng, math) values('aa', 10, 88, 88, 88);

- 여러 개의 컬럼을 묶어서 PK로 사용하면 데이터를 다루기가 불편하다.
  즉 데이터를 찾을 때 마다 name과 age 값을 지정해야 한다.
- 그래서 실무에서는 이런 경우 '학번'처럼 임의의 값을 저장하는 컬럼을 만들어 PK로 사용한다. (인공 키의 예!)
  create table test1(
    no int primary key, /* 학번 */
    name varchar(20),
    age int,
    kor int,
    eng int,
    math int
  );

  insert into test1(no,name,age,kor,eng,math) values(1,'a',10,90,90,90);
  insert into test1(no,name,age,kor,eng,math) values(2,'a',11,91,91,91);
  insert into test1(no,name,age,kor,eng,math) values(3,'b',11,81,81,81);
  insert into test1(no,name,age,kor,eng,math) values(4,'c',20,81,81,81);

/* 번호가 중복되었기 때문에 입력 거절 */
  insert into test1(no,name,age,kor,eng,math) values(4,'d',21,81,81,81);

/* 번호는 중복되지 않았지만, name과 age값이 중복되는 경우를 막을 수 없다*/
  insert into test1(no,name,age,kor,eng,math) values(5,'c',20,81,81,81);

- 위와 같은 경우를 대비해 준비된 문법이 unique이다.
- PK는 아니지만 PK처럼 중복되어서는 안되는 컬럼을 지정할 때 사용한다.
- 그래서 PK를 대신해서 사용할 수 있는 key라고 해서 "대안키(alternate key)"라고 부른다.
- 즉 대안키는 DBMS에서 unique 컬럼으로 지정한다.

#### unique = alternate key(대안키)
  create table test1(
    no int primary key,
    name varchar(20),
    age int,
    kor int,
    eng int,
    math int,
    constraint test1_uk unique (name, age)
  );

/* 다음과 같이 제약 조건을 모든 컬럼 선언 뒤에 놓을 수 있다. */
  create table test1(
    no int,
    name varchar(20),
    age int,
    kor int,
    eng int,
    math int,
    constraint primary key(no),
    constraint test1_uk unique (name, age)
  );

- 입력 테스트:
  insert into test1(no,name,age,kor,eng,math) values(1,'a',10,90,90,90);
  insert into test1(no,name,age,kor,eng,math) values(2,'a',11,91,91,91);
  insert into test1(no,name,age,kor,eng,math) values(3,'b',11,81,81,81);
  insert into test1(no,name,age,kor,eng,math) values(4,'c',20,81,81,81);

/* 번호가 중복되었기 때문에 입력 거절 */
  insert into test1(no,name,age,kor,eng,math) values(4,'d',21,81,81,81);

/* 비록 번호가 중복되지 않더라도 name, age가 unique 컬럼으로 지정되었기
   때문에 중복저장될 수 없다.*/
  insert into test1(no,name,age,kor,eng,math) values(5,'c',20,81,81,81);

/* 또는 다음과 같이 테이블 정의 다음에 제약 조건을 둘 수 있다. */
  create table test1(
    no int,
    name varchar(20),
    age int,
    kor int,
    eng int,
    math int
  );

  alter table test1
    add constraint test1_pk primary key (no);

  alter table test1
    add constraint test1_uk unique (name, age);


##### index
- 검색 조건으로 사용되는 컬럼인 경우 따로 정렬해 두면 데이터를 찾을 때 빨리 찾을 수 있다.
- 특정 컬럼의 값을 A-Z 또는 Z-A로 정렬시키는 문법이 인덱스이다.
- DBMS는 해당 컬럼의 값으로 정렬한 데이터 정보를 별도의 파일로 생성한다.
- 보통 책 맨 뒤에 붙어있는 색인표와 같다.
- 인덱스로 지정된 컬럼의 값이 추가/변경/삭제 될 때 인덱스 정보도 갱신한다.
- 따라서 입력/변경/삭제가 자주 발생하는 테이블에 대해 인덱스 컬럼을 지정하면,
  입력/변경/삭제 시 인덱스 정보를 갱신해야 하기 때문에
  입력/변경/삭제 속도가 느려지는 문제가 있다.
- 대신 조회 속도는 빠르다.

  create table test1(
    no int primary key,
    name varchar(20),
    age int,
    kor int,
    eng int,
    math int,
    constraint test1_uk unique (name, age),
    fulltext index test1_name_idx (name)
  );

  insert into test1(no,name,age,kor,eng,math) values(1,'aaa',20,80,80,80);
  insert into test1(no,name,age,kor,eng,math) values(2,'bbb',21,90,80,80);
  insert into test1(no,name,age,kor,eng,math) values(3,'ccc',20,80,80,80);
  insert into test1(no,name,age,kor,eng,math) values(4,'ddd',22,90,80,80);
  insert into test1(no,name,age,kor,eng,math) values(5,'eee',20,80,80,80);

- name 컬럼은 인덱스 컬럼으로 지정되었기 때문에
  DBMS는 데이터를 추가하거나 삭제할 때 name 컬럼의 색인표를 갱신한다.
- 단점, 이런 이유로 이름으로 검색할 때 찾기 속도는 빠르지만,
  입력,변경,삭제 속도는 느리게 된다.

#### 인덱스 컬럼의 활용
검색할 때 사용한다.

select * from test1 where name = 'bbb';


### 테이블 변경
기존에 있는 테이블을 변경할 수 있다.

- 테이블 생성

  create table test1 (
    name varchar(3),
    kor int,
    eng int,
    math int,
    sum int,
    aver int
  );


- 테이블에 컬럼 추가

alter table test1
  add column no int;

alter table test1
  add column age int;

alter table test1
  add column no2 int,
  add column age2 int;


- PK 컬럼 지정, UNIQUE 컬럼 지정, INDEX 컬럼 지정

alter table test1
  add constraint test1_pk primary key (no),
  add constraint test1_uk unique (name, age),
  add fulltext index test1_name_idx (name);


- 컬럼에 옵션 추가

alter table test1
  modify column name varchar(20) not null,
  modify column age int not null,
  modify column kor int not null,
  modify column eng int not null,
  modify column math int not null,
  modify column sum int not null,
  modify column aver float not null;


- 입력 테스트

insert into test1(no,name,age,kor,eng,math,sum,aver)
  values(1,'aaa',20,100,100,100,300,100);

insert into test1(no,name,age,kor,eng,math,sum,aver)
  values(2,'bbb',21,100,100,100,300,100);

/* 다음은 name과 age의 값이 중복되기 때문에 입력 거절된다.*/
insert into test1(no,name,age,kor,eng,math,sum,aver)
  values(3,'bbb',21,100,100,100,300,100);


### 컬럼 값 자동 증가
- 숫자 타입의 PK 컬럼 또는 Unique 컬럼인 경우 값을 1씩 자동 증가시킬 수 있다.
- 즉 데이터를 입력할 때 해당 컬럼의 값을 넣지 않아도 자동으로 증가된다.
- 단 삭제를 통해 중간에 비어있는 번호는 다시 채우지 않는다.
  즉 증가된 번호는 계속 앞으로 증가할 뿐이다.

- 테이블 생성

create table test1(
  no int not null,
  name varchar(20) not null
);


- 특정 컬럼의 값을 자동으로 증가하게 선언한다.
- 단 반드시 key(primary key 나 unique)여야 한다.

alter table test1
  modify column no int not null auto_increment; /* 아직 no가 pk가 아니기 때문에 오류*/

alter table test1
  add constraint primary key (no); /* 일단 no를 pk로 지정한다.*/

alter table test1
  add constraint unique (no); /* no를 unique로 지정해도 한다.*/

alter table test1
  modify column no int not null auto_increment; /* 그런 후 auto_increment를 지정한다.*/


- 입력 테스트

/* auto-increment 컬럼의 값을 직접 지정할 수 있다.*/
insert into test1(no, name) values(1, 'xxx');

/* auto-increment 컬럼의 값을 생략하면 마지막 값을 증가시켜서 입력한다.*/
insert into test1(name) values('aaa');

insert into test1(no, name) values(100, 'yyy');

insert into test1(name) values('bbb'); /* no는 101이 입력된다.*/


insert into test1(name) values('ccc'); /* no=102 */
insert into test1(name) values('ddd'); /* no=103 */

/* 값을 삭제하더라도 auto-increment는 계속 앞으로 증가한다.*/
delete from test1 where no=103;

insert into test1(name) values('eee'); /* no=104 */

insert into test1(name) values('123456789012345678901234');

/* 다른 DBMS의 경우 입력 오류가 발생하더라도 번호는 자동 증가하기 때문에
 * 다음 값을 입력할 때는 증가된 값이 들어간다.
 * 그러나 MySQL(MariaDB)는 증가되지 않는다.
 */
insert into test1(name) values('fff'); /* no=? */


## 뷰(view)
- 조회 결과를 테이블처럼 사용하는 문법
- select 문장이 복잡할 때 뷰로 정의해 놓고 사용하면 편리하다.


create table test1 (
  no int primary key auto_increment,
  name varchar(20) not null,
  class varchar(10) not null,
  working char(1) not null,
  tel varchar(20)
);

insert into test1(name,class,working) values('aaa','java100','Y');
insert into test1(name,class,working) values('bbb','java100','N');
insert into test1(name,class,working) values('ccc','java100','Y');
insert into test1(name,class,working) values('ddd','java100','N');
insert into test1(name,class,working) values('eee','java100','Y');
insert into test1(name,class,working) values('kkk','java101','N');
insert into test1(name,class,working) values('lll','java101','Y');
insert into test1(name,class,working) values('mmm','java101','N');
insert into test1(name,class,working) values('nnn','java101','Y');
insert into test1(name,class,working) values('ooo','java101','N');


- 직장인만 조회

select no, name, class from test1 where working = 'Y';


- 직장인만 조회한 결과를 가상 테이블로 만들기

create view worker
  as select no, name, class from test1 where working = 'Y';


- view가 참조하는 테이블에 데이터를 입력한 후 view를 조회하면?
  => 새로 추가된 컬럼이 함께 조회된다.
- 뷰를 조회할 때 마다 매번 select 문장을 실행한다.
  => 미리 결과를 만들어 놓는 것이 아니다.
- 일종의 조회 함수 역할을 한다.
- 목적은 복잡한 조회를 가상의 테이블로 표현할 수 있어 SQL문이 간결해진다.

insert into test1(name,class,working) values('ppp','java101','Y');
select * from worker;


### 뷰 삭제

drop view worker;



## 제약 조건 조회

1) 테이블의 제약 조건 조회

select table_name, constraint_name, constraint_type
from table_constraints;


2) 테이블의 키 컬럼 정보 조회

select table_name, column_name, constraint_name
from key_column_usage;


3) 테이블과 컬럼의 키 제약 조건 조회

select
  t2.table_name,
  t2.column_name,
  t2.constraint_name,
  t1.constraint_type
from table_constraints t1
  inner join key_column_usage t2 on t2.constraint_name=t1.constraint_name;
