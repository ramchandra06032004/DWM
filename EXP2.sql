-- Create the Course table
CREATE TABLE course (
    course_id INTEGER PRIMARY KEY,
    course_name VARCHAR(100),
    units VARCHAR(100),
    section_id INTEGER,
    room_id INTEGER,
    room_capacity INTEGER
);

-- Insert data into the Course table
INSERT INTO course VALUES
(1, 'Maths', '3E', 11, 50, 60),
(2, 'Maths', '4E', 22, 51, 120),
(3, 'Maths', '5E', 33, 52, 100),
(4, 'Physics', '3F', 44, 53, 100),
(5, 'Physics', '4F', 55, 54, 150),
(6, 'Physics', '5F', 66, 55, 70),
(7, 'Biology', '3G', 77, 56, 60),
(8, 'Biology', '4G', 88, 57, 120);

-- Create the Professor table
CREATE TABLE professor (
    professor_id INTEGER PRIMARY KEY,
    prof_name VARCHAR(100),
    title VARCHAR(100),
    dept_id INTEGER,
    dept_name VARCHAR(100)
);

-- Insert data into the Professor table
INSERT INTO professor VALUES
(1, 'Mr. Srinivas', 'Doctor', 111, 'Science'),
(2, 'Miss. Pallavi', 'Engineer', 222, 'Technology'),
(3, 'Miss. Shamika', 'Doctor', 333, 'Science'),
(4, 'Mr. Raghav', 'Engineer', 444, 'Technology');

-- Create the Student table
CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    student_major VARCHAR(100)
);

-- Insert data into the Student table
INSERT INTO student VALUES
(1, 'Maths'),
(2, 'Biology'),
(3, 'Physics'),
(4, 'Maths');

-- Create the Period table
CREATE TABLE period (
    period_id INTEGER PRIMARY KEY,
    year VARCHAR(100),
    semester VARCHAR(100)
);

-- Insert data into the Period table
INSERT INTO period VALUES
(1, '2021', '1-6'),
(2, '2021', '7-12'),
(3, '2022', '1-6'),
(4, '2022', '7-12');

-- Create the Fact table
CREATE TABLE uni_fact (
    course_id INTEGER,
    professor_id INTEGER,
    student_id INTEGER,
    period_id INTEGER,
    grades INTEGER,
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (professor_id) REFERENCES professor(professor_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (period_id) REFERENCES period(period_id)
);

-- Insert data into the Fact table
INSERT INTO uni_fact VALUES
(1, 1, 1, 1, 90),
(1, 1, 2, 2, 82),
(1, 1, 3, 4, 56),
(1, 1, 4, 3, 56),
(2, 2, 1, 4, 54),
(2, 1, 2, 3, 63),
(2, 3, 3, 1, 97),
(2, 2, 4, 2, 54),
(3, 1, 1, 3, 75),
(3, 4, 2, 1, 74),
(3, 3, 1, 2, 64),
(3, 4, 4, 2, 88),
(4, 1, 2, 3, 95),
(4, 1, 4, 4, 100),
(6, 1, 1, 1, 57),
(5, 2, 2, 3, 80),
(7, 4, 2, 1, 99),
(4, 1, 2, 3, 55),
(7, 3, 2, 4, 81),
(1, 4, 4, 3, 93),
(8, 2, 2, 4, 69),
(5, 3, 3, 1, 78),
(7, 3, 4, 3, 86),
(8, 2, 2, 4, 94);


--above code is mandatory to run before running below code

-- cube operation
SELECT course_name, units, section_id, room_id, room_capacity, prof_name, title, dept_id, dept_name, student_major, year, semester, grades
FROM course C
JOIN uni_fact F ON C.course_id = F.course_id
JOIN professor P ON P.professor_id = F.professor_id
JOIN student S ON S.student_id = F.student_id
JOIN period Pe ON Pe.period_id = F.period_id;

-- Roll-up operation
SELECT course_name, SUM(grades) AS total_grades
FROM course C
JOIN uni_fact F ON C.course_id = F.course_id
JOIN period Pe ON Pe.period_id = F.period_id
GROUP BY course_name;

-- drill down operation
SELECT F.grades, C.course_name, C.room_capacity, Pe.year, Pe.semester, P.dept_name
FROM course C
JOIN uni_fact F ON C.course_id = F.course_id
JOIN period Pe ON Pe.period_id = F.period_id
JOIN professor P ON P.professor_id = F.professor_id
WHERE P.dept_name = 'Technology';

--slice operation
SELECT F.grades, C.course_name, C.room_capacity, Pe.year, P.dept_name
FROM course C
JOIN uni_fact F ON C.course_id = F.course_id
JOIN period Pe ON Pe.period_id = F.period_id
JOIN professor P ON P.professor_id = F.professor_id
WHERE P.dept_name = 'Technology' AND C.course_name = 'Physics' AND Pe.year = '2022';

-- Dice operation
SELECT F.grades
FROM course C
JOIN uni_fact F ON C.course_id = F.course_id
JOIN period Pe ON Pe.period_id = F.period_id
JOIN professor P ON P.professor_id = F.professor_id
WHERE P.dept_name = 'Science' AND P.title = 'Doctor' AND C.course_name = 'Physics' AND C.room_capacity = 150 AND Pe.year = '2021' AND Pe.semester = '1-6';