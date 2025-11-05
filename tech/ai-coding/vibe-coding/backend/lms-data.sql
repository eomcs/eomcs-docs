-- =========================
-- 1) 마스터 테이블
-- =========================

-- 지점 (locations)
INSERT INTO locations (location_id, name) VALUES
  (1, 'Gangnam'),
  (2, 'Hongdae'),
  (3, 'Bundang');

-- 과목 (subjects)
INSERT INTO subjects (subject_id, title) VALUES
  (1, 'Java Basics'),
  (2, 'Spring Boot'),
  (3, 'JPA'),
  (4, 'OAuth2'),
  (5, 'PostgreSQL'),
  (6, 'Data Structures'),
  (7, 'Algorithms'),
  (8, 'Frontend Basics');

-- 사용자 (users)
INSERT INTO users
  (user_id, name, email, pwd, grade, tel, photo, post_no, base_address, detail_address) VALUES
  (1, 'Kim Minsoo',  'minsoo.kim@example.com',  'pw$minsoo',  'Bachelor', '010-1111-1111', '/uploads/users/minsoo.jpg', '06236', 'Seoul, Seocho-gu',           'Apt 101-1203'),
  (2, 'Lee Jiyoung', 'jiyoung.lee@example.com', 'pw$jiyoung', 'Master',   '010-2222-2222', '/uploads/users/jiyoung.jpg', '04524', 'Seoul, Jung-gu',             'Sun Bldg 5F'),
  (3, 'Park Chulsoo','chulsoo.park@example.com','pw$chulsoo', 'College',  '010-3333-3333', NULL,                         '13561', 'Seongnam, Bundang-gu',      'Mirae Apt 202-1704'),
  (4, 'Choi Ara',    'ara.choi@example.com',    'pw$ara',     'Bachelor', '010-4444-4444', '/uploads/users/ara.jpg',     '06123', 'Seoul, Gangnam-gu',          'Teheran-ro 321'),
  (5, 'Jung Hana',   'hana.jung@example.com',   'pw$hana',    'PhD',      '010-5555-5555', NULL,                         '03722', 'Seoul, Mapo-gu',             'Hongik-ro 15');

-- =========================
-- 2) 강의실 & 사진
-- =========================

-- 강의실 (classrooms)  — UK(location_id, name) 준수
INSERT INTO classrooms (classroom_id, name, capacity, location_id) VALUES
  (1, 'A-101', 30, 1),  -- Gangnam
  (2, 'B-201', 24, 2),  -- Hongdae
  (3, 'C-301', 20, 3);  -- Bundang

-- 강의실 사진 (classroom_photos)
INSERT INTO classroom_photos (classroom_photo_id, classroom_id, file_path) VALUES
  (1, 1, '/uploads/classrooms/gangnam/A-101-1.jpg'),
  (2, 1, '/uploads/classrooms/gangnam/A-101-2.jpg'),
  (3, 2, '/uploads/classrooms/hongdae/B-201-1.jpg');

-- =========================
-- 3) 교육과정
-- =========================

INSERT INTO courses
  (course_id, start_date,  end_date,    total_hours, day_hours, price, quantity, title,                                content,                                                       classroom_id)
VALUES
  (1, '2025-11-10','2025-12-05', 160, 8, 1800000, 25, 'Fullstack Java Bootcamp',            'Java 기초부터 Spring Boot, JPA, DB, 웹까지 풀스택 과정',                      1),
  (2, '2025-12-08','2025-12-19',  80, 8,  900000, 20, 'Spring Security & OAuth2 Intensive', '스프링 시큐리티와 OAuth2 실무 집중 과정',                                       2),
  (3, '2026-01-06','2026-01-17',  80, 8,  950000, 18, 'JPA Deep Dive',                      'JPA 매핑, 성능 최적화, 쿼리 전략 심화',                                       3);

-- =========================
-- 4) 교육과정-과목 매핑
-- =========================

-- Fullstack Java Bootcamp
INSERT INTO course_subjects (course_id, subject_id) VALUES
  (1, 1),  -- Java Basics
  (1, 6),  -- Data Structures
  (1, 7),  -- Algorithms
  (1, 2),  -- Spring Boot
  (1, 3),  -- JPA
  (1, 5),  -- PostgreSQL
  (1, 8),  -- Frontend Basics
  (1, 4);  -- OAuth2

-- Spring Security & OAuth2 Intensive
INSERT INTO course_subjects (course_id, subject_id) VALUES
  (2, 2),  -- Spring Boot
  (2, 4);  -- OAuth2

-- JPA Deep Dive
INSERT INTO course_subjects (course_id, subject_id) VALUES
  (3, 3),  -- JPA
  (3, 5);  -- PostgreSQL

-- =========================
-- 5) 수강신청 (UK(user_id, course_id) 준수)
-- =========================

INSERT INTO user_course_appl
  (user_course_appl_id, user_id, course_id, registration_date, application_status)
VALUES
  (1, 1, 1, '2025-10-15', 'REQUESTED'),   -- Minsoo -> Fullstack
  (2, 2, 1, '2025-10-16', 'APPROVED'),    -- Jiyoung -> Fullstack
  (3, 3, 2, '2025-10-20', 'CANCELLED'),   -- Chulsoo -> Security/OAuth2
  (4, 4, 3, '2025-10-22', 'REQUESTED'),   -- Ara -> JPA Deep Dive
  (5, 5, 2, '2025-10-23', 'COMPLETED');   -- Hana -> Security/OAuth2

-- =========================
-- 6) IDENTITY 시퀀스 값을 각 테이블 MAX(id)로 조정
--    (비어 있을 가능성까지 고려하려면 COALESCE 적용)
-- =========================

-- users.user_id
SELECT setval(pg_get_serial_sequence('users','user_id'),
              COALESCE((SELECT MAX(user_id) FROM users), 0), TRUE);

-- locations.location_id
SELECT setval(pg_get_serial_sequence('locations','location_id'),
              COALESCE((SELECT MAX(location_id) FROM locations), 0), TRUE);

-- subjects.subject_id
SELECT setval(pg_get_serial_sequence('subjects','subject_id'),
              COALESCE((SELECT MAX(subject_id) FROM subjects), 0), TRUE);

-- classrooms.classroom_id
SELECT setval(pg_get_serial_sequence('classrooms','classroom_id'),
              COALESCE((SELECT MAX(classroom_id) FROM classrooms), 0), TRUE);

-- classroom_photos.classroom_photo_id
SELECT setval(pg_get_serial_sequence('classroom_photos','classroom_photo_id'),
              COALESCE((SELECT MAX(classroom_photo_id) FROM classroom_photos), 0), TRUE);

-- courses.course_id
SELECT setval(pg_get_serial_sequence('courses','course_id'),
              COALESCE((SELECT MAX(course_id) FROM courses), 0), TRUE);

-- user_course_appl.user_course_appl_id
SELECT setval(pg_get_serial_sequence('user_course_appl','user_course_appl_id'),
              COALESCE((SELECT MAX(user_course_appl_id) FROM user_course_appl), 0), TRUE);
