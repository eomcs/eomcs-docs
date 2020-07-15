-- 수업 예제 데이터 
insert into lms_lesson(lesson_id, titl, conts, sdt, edt, tot_hr, day_hr)
  values(101, '자바 프로그래밍', '자바 프로그래밍 배우기', '2019-1-1', '2019-2-28', 200, 6);
insert into lms_lesson(lesson_id, titl, conts, sdt, edt, tot_hr, day_hr)
  values(102, 'C/C++ 프로그래밍', '프로그래밍 배우기', '2019-2-1', '2019-3-28', 200, 6);
insert into lms_lesson(lesson_id, titl, conts, sdt, edt, tot_hr, day_hr)
  values(103, '파이썬 프로그래밍', '프로그래밍 배우기', '2019-3-1', '2019-4-28', 300, 7);
insert into lms_lesson(lesson_id, titl, conts, sdt, edt, tot_hr, day_hr)
  values(104, '웹 프로그래밍', '프로그래밍 배우기', '2019-1-4', '2019-5-28', 300, 7);
insert into lms_lesson(lesson_id, titl, conts, sdt, edt, tot_hr, day_hr)
  values(105, 'IoT 프로그래밍', '프로그래밍 배우기', '2019-5-1', '2019-6-28', 400, 8);

-- 회원 예제 데이터
insert into lms_member(member_id, name, email, pwd) 
  values(11, 'user1', 'user1@test.com', password('1111'));
insert into lms_member(member_id, name, email, pwd) 
  values(12, 'user2', 'user2@test.com', password('1111'));
insert into lms_member(member_id, name, email, pwd) 
  values(13, 'user3', 'user3@test.com', password('1111'));

-- 게시물 예제 데이터
insert into lms_board(board_id, conts) values(1, '내용1');
insert into lms_board(board_id, conts) values(2, '내용2');
insert into lms_board(board_id, conts) values(3, '내용3');
insert into lms_board(board_id, conts) values(4, '내용4');
insert into lms_board(board_id, conts) values(5, '내용5');

-- 수업 사진 게시물 예제 데이터
insert into lms_photo(photo_id, lesson_id, titl) 
  values(1, 101, '자바 컴파일러 구동 원리');
insert into lms_photo(photo_id, lesson_id, titl) 
  values(2, 101, '자바 클래스 실행하는 방법');
insert into lms_photo(photo_id, lesson_id, titl) 
  values(3, 101, '옵저버 패턴 클래스 다이어그램');
insert into lms_photo(photo_id, lesson_id, titl) 
  values(4, 104, 'HTML/CSS/JavaScript 관계');
insert into lms_photo(photo_id, lesson_id, titl) 
  values(5, 104, '자바 스크립트 구동 원리');

-- 수업 사진 게시물 첨부 파일 예제 데이터
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(1, 1, 'a1.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(2, 1, 'a2.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(3, 1, 'a3.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(4, 2, 'b1.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(5, 3, 'c1.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(6, 3, 'c2.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(7, 4, 'd1.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(8, 5, 'e1.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(9, 5, 'e2.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(10, 5, 'e3.gif');
insert into lms_photo_file(photo_file_id, photo_id, file_path)
  values(11, 5, 'e4.gif');

