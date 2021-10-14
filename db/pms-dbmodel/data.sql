-- 회원 입력
insert into pms_member(member_no, name, email, password)
values(1, 'aaa', 'aaa@test.com', password('1111'));

insert into pms_member(member_no, name, email, password)
values(2, 'bbb', 'bbb@test.com', password('1111'));

insert into pms_member(member_no, name, email, password)
values(3, 'ccc', 'ccc@test.com', password('1111'));

insert into pms_member(member_no, name, email, password)
values(4, 'ddd', 'ddd@test.com', password('1111'));

insert into pms_member(member_no, name, email, password)
values(5, 'eee', 'eee@test.com', password('1111'));

insert into pms_member(member_no, name, email, password)
values(6, 'fff', 'fff@test.com', password('1111'));

-- 게시글 입력
insert into pms_board(board_no, title, content, member_no) values(1, '제목1', '내용', 1);
insert into pms_board(board_no, title, content, member_no) values(2, '제목2', '내용', 1);
insert into pms_board(board_no, title, content, member_no) values(3, '제목3', '내용', 1);
insert into pms_board(board_no, title, content, member_no) values(4, '제목4', '내용', 2);
insert into pms_board(board_no, title, content, member_no) values(5, '제목5', '내용', 2);
insert into pms_board(board_no, title, content, member_no) values(6, '제목6', '내용', 3);
insert into pms_board(board_no, title, content, member_no) values(7, '제목7', '내용', 4);
insert into pms_board(board_no, title, content, member_no) values(8, '제목8', '내용', 4);
insert into pms_board(board_no, title, content, member_no) values(9, '제목9', '내용', 5);
insert into pms_board(board_no, title, content, member_no) values(10, '제목10', '내용', 5);
insert into pms_board(board_no, title, content, member_no) values(11, '제목11', '내용', 5);

-- 게시글 첨부파일 입력 
insert into pms_board_file(board_file_no, filepath, board_no) values(11, 'a1.gif', 1);
insert into pms_board_file(board_file_no, filepath, board_no) values(12, 'a2.gif', 1);
insert into pms_board_file(board_file_no, filepath, board_no) values(13, 'a3.gif', 1);
insert into pms_board_file(board_file_no, filepath, board_no) values(14, 'b1.gif', 3);
insert into pms_board_file(board_file_no, filepath, board_no) values(15, 'b2.gif', 3);
insert into pms_board_file(board_file_no, filepath, board_no) values(16, 'c1.gif', 4);
insert into pms_board_file(board_file_no, filepath, board_no) values(17, 'd1.gif', 5);
insert into pms_board_file(board_file_no, filepath, board_no) values(18, 'e1.gif', 10);
insert into pms_board_file(board_file_no, filepath, board_no) values(19, 'f1.gif', 11);


-- 프로젝트 입력
insert into pms_project(project_no, title, content, start_dt, end_dt, member_no)
values(101, 'project1', 'xxx', '2021-1-1', '2021-2-2', 1);
insert into pms_project(project_no, title, content, start_dt, end_dt, member_no)
values(102, 'project2', 'xxx', '2021-2-1', '2021-3-1', 1);
insert into pms_project(project_no, title, content, start_dt, end_dt, member_no)
values(103, 'project3', 'xxx', '2021-3-1', '2021-4-1', 3);

-- 프로젝트 멤버 입력
insert into pms_project_member(project_no, member_no) 
values (101, 1), (101, 2), (101, 3);

insert into pms_project_member(project_no, member_no) 
values (102, 1), (102, 3);

insert into pms_project_member(project_no, member_no) 
values (103, 3), (103, 2), (103, 4), (103, 5);

-- 작업 상태 입력
insert into pms_task_status(task_status_no, title) values(1110, '신규');
insert into pms_task_status(task_status_no, title) values(1111, '작업중');
insert into pms_task_status(task_status_no, title) values(1112, '완료');
insert into pms_task_status(task_status_no, title) values(1113, '보류');

-- 작업 입력
insert into pms_task(task_no, content, deadline, task_status_no, project_no, member_no)
values(2001, '작업aaa1', '2021-1-20', 1110, 101, 1);
insert into pms_task(task_no, content, deadline, task_status_no, project_no, member_no)
values(2002, '작업aaa2', '2021-2-20', 1111, 101, 2);
insert into pms_task(task_no, content, deadline, task_status_no, project_no, member_no)
values(2003, '작업aaa3', '2021-3-20', 1110, 101, 3);
insert into pms_task(task_no, content, deadline, task_status_no, project_no, member_no)
values(2004, '작업ccc1', '2021-1-20', 1111, 103, 2);
insert into pms_task(task_no, content, deadline, task_status_no, project_no, member_no)
values(2005, '작업ccc2', '2021-1-20', 1111, 103, 4);
insert into pms_task(task_no, content, deadline, task_status_no, project_no, member_no)
values(2006, '작업ccc3', '2021-1-20', 1112, 103, 4);