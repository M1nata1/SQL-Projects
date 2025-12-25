drop table if exists Students, Instructors, Courses, Departments, Enrollments, Grades, Classrooms, Events cascade;

create table Students (
	student_id int primary key,
	first_name varchar not null,
	last_name varchar not null,
	date_of_birth date not null,
	email varchar not null
);

create table Departments (
	department_id int primary key,
	department_name varchar not null
);

create table Instructors (
	instructor_id int primary key,
	position varchar not null,
	first_name varchar not null,
	last_name varchar not null,
	email varchar not null,
	department_id int not null,
	foreign key (department_id) references Departments(department_id)
);

create table Courses (
	course_id int primary key,
	course_name varchar not null,
	instructor_id int not null,
	credits int not null,
	foreign key (instructor_id) references Instructors(instructor_id)
);

create table Enrollments (
	enrollment_id int primary key,
	student_id int not null,
	course_id int not null,
	foreign key (student_id) references Students(student_id),
	foreign key (course_id) references Courses(course_id)
);

create table Grades (
	grade_id int primary key,
	enrollment_id int not null,
	grade varchar not null,
	grade_date date not null,
	foreign key (enrollment_id) references Enrollments(enrollment_id)
);

create table Classrooms (
	classroom_id int primary key,
	classroom_name varchar not null,
	capacity int not null
);

create table Events (
	event_id int primary key,
	event_name varchar not null,
	event_date date not null,
	location varchar not null
);

insert into Students (student_id, first_name, last_name, date_of_birth, email) values
	(1, 'John', 'Doe', '1995-03-12', 'john.doe@example.com'),
	(2, 'Jane', 'Smith', '1998-07-22', 'jane.smith@example.com'),
	(3, 'Bob', 'Johnson', '1994-05-18', 'bob.johnson@example.com'),
	(4, 'Alice', 'Williams', '1997-11-30', 'alice.williams@example.com'),
	(5, 'Charlie', 'Brown', '1996-09-05', 'charlie.brown@example.com'),
	(6, 'Emma', 'Davis', '1999-02-14', 'emma.davis@example.com'),
	(7, 'Michael', 'Taylor', '1993-08-08', 'michael.taylor@example.com'),
	(8, 'Olivia', 'Moore', '1992-04-25', 'olivia.moore@example.com'),
	(9, 'William', 'Anderson', '1991-12-17', 'william.anderson@example.com'),
	(10, 'Sophia', 'Miller', '1990-06-28', 'sophia.miller@example.com'),
	(11, 'Daniel', 'Clark', '1994-10-03', 'daniel.clark@example.com'),
	(12, 'Mia', 'Wilson', '1996-01-19', 'mia.wilson@example.com'),
	(13, 'Matthew', 'White', '1998-04-07', 'matthew.white@example.com'),
	(14, 'Ava', 'Hall', '1997-03-26', 'ava.hall@example.com'),
	(15, 'Ethan', 'Lee', '1992-09-14', 'ethan.lee@example.com'),
	(16, 'Isabella', 'Garcia', '1993-11-11', 'isabella.garcia@example.com'),
	(17, 'James', 'Brown', '1995-07-31', 'james.brown@example.com'),
	(18, 'Sophie', 'Johnson', '1999-05-04', 'sophie.johnson@example.com'),
	(19, 'Logan', 'Martin', '1990-12-22', 'logan.martin@example.com'),
	(20, 'Grace', 'Moore', '1991-04-15', 'grace.moore@example.com');

insert into Departments (department_id, department_name) values
  (1, 'Computer Science'),
  (2, 'Mathematics'),
  (3, 'Physics'),
  (4, 'Biology'),
  (5, 'Chemistry'),
  (6, 'History'),
  (7, 'English'),
  (8, 'Art'),
  (9, 'Music'),
  (10, 'Physical Education');

insert into Instructors (instructor_id, position, first_name, last_name, email, department_id) values
  (1, 'Professor', 'Robert', 'Johnson', 'robert.johnson@example.com', 1),
  (2, 'Assistant Professor', 'Jennifer', 'Williams', 'jennifer.williams@example.com', 2),
  (3, 'Associate Professor', 'Thomas', 'Davis', 'thomas.davis@example.com', 3),
  (4, 'Professor', 'Susan', 'Smith', 'susan.smith@example.com', 4),
  (5, 'Assistant Professor', 'Richard', 'Brown', 'richard.brown@example.com', 5),
  (6, 'Associate Professor', 'Karen', 'Miller', 'karen.miller@example.com', 6),
  (7, 'Professor', 'Michael', 'Wilson', 'michael.wilson@example.com', 7),
  (8, 'Assistant Professor', 'Mary', 'Anderson', 'mary.anderson@example.com', 8),
  (9, 'Associate Professor', 'John', 'Lee', 'john.lee@example.com', 9),
  (10, 'Professor', 'Laura', 'Harris', 'laura.harris@example.com', 10);

insert into Courses (course_id, course_name, instructor_id, credits) values
  (1, 'INF 202', 1, 3),
  (11, 'Computer Science', 1, 5),
  (2, 'Calculus I', 2, 4),
  (3, 'Mechanics', 3, 3),
  (4, 'Cell Biology', 4, 4),
  (5, 'Organic Chemistry', 5, 4),
  (6, 'World History', 6, 3),
  (7, 'English Literature', 7, 3),
  (8, 'Art History', 8, 3),
  (9, 'Music Theory', 9, 2),
  (10, 'Physical Education Activities', 10, 2);

insert into Enrollments (enrollment_id, student_id, course_id) values
  (1, 1, 1),
  (2, 2, 2),
  (3, 3, 3),
  (4, 4, 11),
  (5, 5, 5),
  (6, 6, 6),
  (7, 7, 7),
  (8, 8, 11),
  (9, 4, 11),
  (10, 10, 10),
  (11, 10, 11);

insert into Grades (grade_id, enrollment_id, grade, grade_date) values
  (1, 1, '1', '2023-05-15'),
  (2, 2, '2', '2023-06-20'),
  (3, 3, '3', '2023-07-10'),
  (4, 4, '4', '2023-08-05'),
  (5, 5, '5', '2023-06-30'),
  (6, 6, '6', '2023-07-25');

insert into Classrooms (classroom_id, classroom_name, capacity) values
  (1, 'Room A', 50),
  (2, 'Room B', 60),
  (3, 'Room C', 40),
  (4, 'Room D', 30),
  (5, 'Room E', 70),
  (6, 'Room F', 45),
  (7, 'Room G', 55),
  (8, 'Room H', 65),
  (9, 'Room I', 35),
  (10, 'Room J', 75);
  
insert into Events (event_id, event_name, event_date, location) values
  (1, 'Conference 1', '2023-11-15', 'Room A'),
  (2, 'Seminar 1', '2023-12-10', 'Room B'),
  (3, 'Workshop 1', '2023-10-25', 'Room C'),
  (4, 'Exhibition 1', '2023-09-05', 'Room D'),
  (5, 'Lecture 1', '2023-11-20', 'Room J'),
  (6, 'Meeting 1', '2023-12-03', 'Room F'),
  (7, 'Symposium 1', '2023-10-15', 'Room G'),
  (8, 'Trade Show 1', '2023-09-20', 'Room H'),
  (9, 'Presentation 1', '2023-11-10', 'Room J'),
  (10, 'Gala Dinner 1', '2023-12-18', 'Room J');

-- Retrieve the names of students who are enrolled in a course named "INF 202" and the IDs of their instructors.
select Students.student_id, Students.first_name, Courses.instructor_id
from Students
join Enrollments on Students.student_id = Enrollments.student_id
join Courses on Enrollments.course_id = Courses.course_id
where Courses.instructor_id = (
	select instructor_id 
	from Courses
	where course_name like 'INF 202'
);

-- Find the total number of enrollments for each department.
select Departments.department_id, Departments.department_name, count(Enrollments.enrollment_id) as total_enrollments
from Departments
join Instructors on Departments.department_id = Instructors.department_id
join Courses on Instructors.instructor_id = Courses.instructor_id
join Enrollments on Courses.course_id = Enrollments.course_id
group by Departments.department_id, Departments.department_name
order by total_enrollments desc;

-- Retrieve the average grade for each student in the "Computer Science" department.
select Students.student_id, Students.first_name, Students.last_name, avg(case when Grades.grade ~ '^[0-9]+$' then Grades.grade::numeric else null end)
from Students
join (
    select Enrollments.enrollment_id, Enrollments.student_id, Enrollments.course_id
    from Enrollments
    join Courses on Enrollments.course_id = Courses.course_id
    where Courses.course_name = 'Computer Science'
) as Enrollments on Students.student_id = Enrollments.student_id
join Grades on Enrollments.enrollment_id = Grades.enrollment_id
group by Students.first_name, Students.last_name, Students.student_id;

-- List students who have not enrolled in any courses.
select Students.student_id, Students.first_name, Students.last_name
from Students
where Students.student_id not in (
	select student_id
	from Enrollments
);

-- Find the classroom with the highest capacity and the event that is scheduled there.
select Classrooms.classroom_id, Classrooms.classroom_name, Events.event_name
from Classrooms
join Events on Classrooms.classroom_name = Events.location
order by capacity desc
limit 1;


