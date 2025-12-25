drop table if exists  students, courses, enrollments;
create table students(
	student_id int primary key,
	first_name text not null,
	last_name text not null,
	date_of_birth date not null,
	major text not null
);

create table courses(
	course_id int primary key,
	course_name text not null,
	department text not null,
	instructor_idenrollments text not null
);

create table enrollments(
	enrollment_id int primary key,
	student_id int not null,
	course_id int not null,
	enrollment_date date not null
);

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES
    (1, 1, 1, '2023-01-15'),
	(6, 1, 3, '2023-01-15'),
    (2, 2, 1, '2023-01-20'),
    (3, 3, 1, '2023-02-05'),
    (4, 4, 4, '2023-02-10'),
    (5, 5, 4, '2023-02-15');
	
INSERT INTO courses (course_id, course_name, department, instructor_idenrollments)
VALUES
    (1, 'Introduction to Computer Science', 'Computer Science', 101),
    (2, 'Biology 101', 'Biology', 101),
    (3, 'History of Ancient Civilizations', 'History', 301),
    (4, 'Calculus I', 'Mathematics', 401),
    (5, 'Organic Chemistry', 'Chemistry', 501);
	
INSERT INTO students (student_id, first_name, last_name, date_of_birth, major)
VALUES
    (1, 'John', 'Doe', '1998-05-15', 'Computer Science'),
    (2, 'Jane', 'Smith', '1999-03-22', 'Biology'),
    (3, 'David', 'Johnson', '1997-11-10', 'History'),
    (4, 'Emily', 'Brown', '2000-08-28', 'Mathematics'),
    (5, 'Sarah', 'Wilson', '1996-06-04', 'Chemistry');
	

-- select courses.department, avg(age(date_of_birth)) as age
-- from students
-- join enrollments on students.student_id = enrollments.student_id
-- join courses on enrollments.course_id = courses.course_id
-- where courses.department like 'Mathematics'
-- group by courses.department

select students.first_name, count(enrollments.course_id) as course_count
from enrollments
join students on enrollments.student_id = students.student_id
group by students.student_id
order by course_count desc

select courses.instructor_idenrollments, count(courses.course_id) as total_count
from courses
group by courses.instructor_idenrollments
order by total_count desc;

SELECT Courses.instructor_idenrollments,  count(Courses.instructor_idenrollments) from Courses
INNER JOIN Enrollments ON Courses.course_id = Enrollments.course_id															  
GROUP BY Courses.instructor_idenrollments
ORDER BY count(Courses.instructor_idenrollments)

SELECT Courses.instructor_idenrollments,  count(Courses.instructor_idenrollments) from Courses
GROUP BY Courses.instructor_idenrollments
ORDER BY count(Courses.instructor_idenrollments)


