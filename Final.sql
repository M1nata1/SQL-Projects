drop table if exists Students, StudentContacts, Admissions, Enrollments, Transcripts, DegreeProgress, Courses, Instructors, Departments, Advisors, StudentGroups, Housing, MealPlans, StudentFees, Library, HealthServices, StudentAchievements, Internships, StudyAbroad, StudentEvents, Graduation, Alumni, Faculty, Staff cascade;

create table Departments (
	department_id int primary key,
	department_name text not null,
	description text not null,
	place text not null
);

create table Faculty (
	faculty_id int primary key,
	faculty_name text not null,
	description text not null,
	place text not null
);

create table StudentEvents (
	event_id int primary key,
	event_name text not null,
	event_date date not null,
	location text not null,
	description text not null
);

create table Advisors (
	advisor_id int primary key,
	first_name text not null,
	last_name text not null,
	email text not null,
	title text not null,
	department_id int not null,
	foreign key (department_id) references Departments(department_id)
);

create table Students (
	student_id int primary key,
	first_name text not null,
	last_name text not null,
	age int not null,
	gender text not null,
	nationality text not null,
	advisor_id int,
	faculty_id int not null,
	event_id int,
	department_id int,
	foreign key (department_id) references Departments(department_id),
	foreign key (event_id) references StudentEvents(event_id),
	foreign key (advisor_id) references Advisors(advisor_id),
	foreign key (faculty_id) references Faculty(faculty_id)
);

create table Instructors (
	instructor_id int primary key,
	first_name text not null,
	last_name text not null,
	email text not null,
	title text not null,
	specific_research_areas text,
	department_id int not null,
	foreign key (department_id) references Departments(department_id)
);

create table StudentContacts (
	contact_id int primary key,
	student_id int not null,
	mobile_phone text not null,
	email text not null,
	foreign key (student_id) references Students(student_id)
);

create table Admissions (
	admission_id int primary key,
	student_id int not null,
	admission date not null,
	level_of_english_IELTS float not null,
	high_school_assessment int not null,
	foreign key (student_id) references Students(student_id)
);

create table Courses (
	course_id int primary key,
	course_name text not null,
	course_code text not null,
	major boolean not null,
	credits int not null,
	department_id int not null,
	instructor_id int not null,
	required_GPA int,
	foreign key (department_id) references Departments(department_id),
	foreign key (instructor_id) references Instructors(instructor_id)
);

create table Enrollments (
	enrollment_id int primary key,
	student_id int not null,
	course_id int not null,
	semester text not null,
	foreign key (student_id) references Students(student_id),
	foreign key (course_id) references Courses(course_id)
);

create table Transcripts (
	transcript_id int primary key,
	student_id int not null,
	total_credits int not null,
	average_GPA float not null,
	foreign key (student_id) references Students(student_id)
);

create table DegreeProgress (
	degree_progress_id int primary key,
	student_id int not null,
	majors_completed int not null,
	total_majors int not null,
	foreign key (student_id) references Students(student_id)
);

create table StudentGroups (
	group_id int primary key,
	group_name text not null,
	description text not null,
	advisor_id int not null,
	foreign key (advisor_id) references Advisors(advisor_id)
);

create table Housing (
	housing_id int primary key,
	student_id int,
	building text not null,
	room_number int not null,
	ocupancy_status text not null,
	move_in_date date,
	move_out_date date,
	foreign key (student_id) references Students(student_id)
);

create table MealPlans (
	meal_plan_id int primary key,
	meal_plan_name text not null,
	description text not null,
	mounthly_cost int not null,
	student_id int not null,
	debt float,
	foreign key (student_id) references Students(student_id)
);

create table StudentFees (
	student_fee_id int primary key,
	student_id int not null,
	fee_type text not null,
	cost_of_fee int not null,
	due_date date not null,
	payment_status text not null,
	debt float,
	foreign key (student_id) references Students(student_id)
);

create table Library (
	library_id int primary key,
	recourse_type text not null,
	title text not null,
	author text not null,
	check_out_status text not null
);

create table HealthServices (
	health_service_id int primary key,
	student_id int not null,
	visit_date date not null,
	convalescence_date date not null,
	reason_for_visit text not null,
	foreign key (student_id) references Students(student_id)
);

create table StudentAchievements (
	achievement_id int primary key,
	student_id int not null,
	achievement_type text not null,
	description text not null,
	foreign key (student_id) references Students(student_id)
);

create table Internships (
	internship_id int primary key,
	student_id int not null,
	company text not null,
	position text not null,
	start_date date not null,
	end_date date not null,
	foreign key (student_id) references Students(student_id)
);

create table StudyAbroad (
	study_abroad_id int primary key,
	student_id int not null,
	program_name text not null,
	university_name text not null,
	country text not null,
	start_date date not null,
	end_date date not null,
	foreign key (student_id) references Students(student_id)
);

create table Graduation (
	graduation_id int primary key,
	student_id int not null,
	graduation_date date not null,
	degree_awarded text not null,
	foreign key (student_id) references Students(student_id)
);

create table Alumni (
	alumni_id int primary key,
	student_id int not null,
	graduation_year int not null,
	email text not null,
	foreign key (student_id) references Students(student_id)
);

create table Staff (
	staff_id int primary key,
	first_name text not null,
	last_name text not null,
	title text not null,
	email text not null,
	department_id int not null,
	foreign key (department_id) references Departments(department_id)
);

insert into Departments (department_id, department_name, description, place) values
(1, 'Computer Science', 'Department of Computer Science', 'Science Building'),
(2, 'Mathematics', 'Department of Mathematics', 'Mathematics Building'),
(3, 'Physics', 'Department of Physics', 'Physics Building'),
(4, 'History', 'Department of History', 'Humanities Building'),
(5, 'Biology', 'Department of Biology', 'Life Sciences Building'),
(6, 'Chemistry', 'Department of Chemistry', 'Chemistry Building'),
(7, 'English', 'Department of English', 'Humanities Building'),
(8, 'Psychology', 'Department of Psychology', 'Psychology Building'),
(9, 'Economics', 'Department of Economics', 'Social Sciences Building'),
(10, 'Engineering', 'Department of Engineering', 'Engineering Building'),
(11, 'Business Administration', 'Department of Business Administration', 'Business Building'),
(12, 'Political Science', 'Department of Political Science', 'Social Sciences Building'),
(13, 'Sociology', 'Department of Sociology', 'Social Sciences Building'),
(14, 'Art', 'Department of Art', 'Arts Building'),
(15, 'Music', 'Department of Music', 'Arts Building');

insert into Faculty (faculty_id, faculty_name, description, place) values
(1, 'Faculty of Science', 'Committed to scientific excellence', 'Science Building'),
(2, 'Faculty of Arts', 'Fostering creativity and critical thinking', 'Humanities Building'),
(3, 'Faculty of Social Sciences', 'Advancing knowledge in social sciences', 'Social Sciences Building'),
(4, 'Faculty of Business', 'Preparing future business leaders', 'Business Building'),
(5, 'Faculty of Engineering', 'Innovating for a better tomorrow', 'Engineering Building'),
(6, 'Faculty of Music and Arts', 'Celebrating the beauty of expression', 'Arts Building'),
(7, 'Faculty of Health Sciences', 'Promoting health and well-being', 'Health Sciences Building'),
(8, 'Faculty of Education', 'Nurturing future educators', 'Education Building'),
(9, 'Faculty of Law', 'Promoting justice and legal excellence', 'Law Building'),
(10, 'Faculty of Agriculture', 'Sustainable solutions for a growing world', 'Agriculture Building'),
(11, 'Faculty of Communication', 'Connecting through effective communication', 'Communication Building'),
(12, 'Faculty of Technology', 'Driving technological innovation', 'Technology Building'),
(13, 'Faculty of Environmental Science', 'Safeguarding our planet future', 'Environmental Science Building'),
(14, 'Faculty of Medicine', 'Advancing healthcare through education and research', 'Medical Sciences Building'),
(15, 'Faculty of Languages', 'Exploring linguistic diversity', 'Languages Building');

insert into Advisors (advisor_id, first_name, last_name, email, title, department_id) values
(1, 'John', 'Doe', 'john.doe@example.com', 'Professor', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'Associate Professor', 2),
(3, 'Robert', 'Johnson', 'robert.johnson@example.com', 'Assistant Professor', 3),
(4, 'Emily', 'Davis', 'emily.davis@example.com', 'Professor', 4),
(5, 'Michael', 'Brown', 'michael.brown@example.com', 'Associate Professor', 5),
(6, 'Sarah', 'Wilson', 'sarah.wilson@example.com', 'Assistant Professor', 6),
(7, 'Daniel', 'Miller', 'daniel.miller@example.com', 'Professor', 7),
(8, 'Megan', 'Jones', 'megan.jones@example.com', 'Associate Professor', 8),
(9, 'Christopher', 'White', 'christopher.white@example.com', 'Assistant Professor', 9),
(10, 'Lauren', 'Anderson', 'lauren.anderson@example.com', 'Professor', 10),
(11, 'David', 'Thompson', 'david.thompson@example.com', 'Associate Professor', 11),
(12, 'Amy', 'Clark', 'amy.clark@example.com', 'Assistant Professor', 12),
(13, 'Kevin', 'Garcia', 'kevin.garcia@example.com', 'Professor', 13),
(14, 'Rachel', 'Moore', 'rachel.moore@example.com', 'Associate Professor', 14),
(15, 'Brian', 'Taylor', 'brian.taylor@example.com', 'Assistant Professor', 15);

insert into StudentEvents (event_id, event_name, event_date, location, description) values 
(1, 'Welcome Back Party', '2023-09-05', 'Student Center', 'Celebrate the start of the new academic year with music, food, and fun!'),
(2, 'Fall Fest', '2023-10-15', 'Quad', 'Enjoy autumn festivities with pumpkin carving, games, and a costume contest.'),
(3, 'International Food Fair', '2023-11-20', 'Cafeteria', 'Experience a diverse range of cuisines from around the world.'),
(4, 'Winter Gala', '2023-12-10', 'Grand Hall', 'Dress up and join us for a night of dancing, music, and holiday cheer.'),
(5, 'Spring Picnic', '2024-04-25', 'Lawn', 'Relax outdoors with friends, games, and a picnic lunch.'),
(6, 'Career Fair', '2024-02-15', 'Convention Center', 'Connect with employers and explore internship and job opportunities.'),
(7, 'Art Exhibition', '2024-03-20', 'Art Gallery', 'Showcase of student artwork from various disciplines.'),
(8, 'Concert Under the Stars', '2024-05-10', 'Amphitheater', 'An evening of live music featuring student performers.'),
(9, 'Academic Achievement Awards', '2024-04-05', 'Auditorium', 'Recognizing outstanding academic accomplishments.'),
(10, 'Sports Day', '2024-03-05', 'Athletic Fields', 'Compete in various sports and enjoy a day of friendly competition.'),
(11, 'Science and Technology Expo', '2024-02-28', 'Science Building', 'Showcasing innovations and projects in science and technology.'),
(12, 'Diversity and Inclusion Seminar', '2024-01-22', 'Conference Room', 'Discussing the importance of diversity and inclusion on campus.'),
(13, 'Health and Wellness Fair', '2024-04-15', 'Gymnasium', 'Promoting physical and mental well-being with interactive exhibits and workshops.'),
(14, 'Music Festival', '2024-05-30', 'Outdoor Stage', 'Celebration of musical talent with performances from various genres.'),
(15, 'Graduation Ceremony', '2024-06-15', 'Stadium', 'Commencement ceremony for graduating students and the start of a new chapter in their lives.');

insert into Students (student_id, first_name, last_name, age, gender, nationality, advisor_id, faculty_id, event_id, department_id) values
    (1, 'John', 'Doe', 20, 'Male', 'USA', 1, 1, 1, 1),
    (2, 'Jane', 'Smith', 22, 'Female', 'Canada', 2, 2, 2, 2),
    (3, 'Alice', 'Johnson', 21, 'Female', 'UK', 3, 3, 3, 3),
    (4, 'Bob', 'Williams', 19, 'Male', 'Australia', 4, 4, 4, 4),
    (5, 'Eva', 'Brown', 23, 'Female', 'Germany', 5, 5, 5, 5),
    (6, 'Mike', 'Anderson', 20, 'Male', 'France', 6, 6, 6, 6),
    (7, 'Sophia', 'Lee', 22, 'Female', 'Japan', 7, 7, 7, 7),
    (8, 'Daniel', 'Kim', 21, 'Male', 'South Korea', 8, 8, 8, 8),
    (9, 'Mia', 'Garcia', 19, 'Female', 'Spain', 9, 9, 9, 10),
    (10, 'David', 'Martinez', 23, 'Male', 'Mexico', 10, 10, 10, 10),
	(16, 'Liam', 'Johnson', 20, 'Male', 'USA', 1, 1, 1, 1),
    (17, 'Ava', 'Davis', 22, 'Female', 'Canada', 2, 2, 2, 2),
    (18, 'Logan', 'Taylor', 21, 'Male', 'UK', 3, 3, 3, 3),
    (19, 'Chloe', 'Smith', 19, 'Female', 'Australia', 4, 4, 4, 4),
    (20, 'Ethan', 'Wilson', 23, 'Male', 'France', 5, 5, 5, 5),
    (21, 'Aria', 'Brown', 20, 'Female', 'France', 6, 6, 6, 6),
    (22, 'Jackson', 'Garcia', 22, 'Male', 'Japan', 7, 7, 7, 7),
    (23, 'Amelia', 'Kim', 21, 'Female', 'South Korea', 8, 8, 8, 8),
    (24, 'Henry', 'Jones', 19, 'Male', 'Spain', 10, 9, 9, 10),
    (25, 'Emma', 'Miller', 23, 'Female', 'Mexico', 10, 10, 10, 10);
insert into Students (student_id, first_name, last_name, gender, nationality, age, faculty_id) values
(11, 'Felix', 'Gigachad', 'Male', 'Poland', 30, 11),
(12, 'Leo', 'Moore', 'Male', 'Italia', 31, 12),
(13, 'Mia', 'Thompson', 'Famale', 'Kazakhstan', 32, 13),
(14, 'Noah', 'Clark', 'Male', 'Norway', 33, 14),
(15, 'Olivia', 'White', 'Famale', 'Russia', 34, 15);

insert into Instructors (instructor_id, first_name, last_name, email, title, specific_research_areas, department_id) values 
(1, 'John', 'Doe', 'john.doe@email.com', 'Professor', 'Machine Learning', 1),
(2, 'Jane', 'Smith', 'jane.smith@email.com', 'Associate Professor', 'Data Science', 2),
(3, 'Bob', 'Johnson', 'bob.johnson@email.com', 'Assistant Professor', 'Artificial Intelligence', 3),
(4, 'Alice', 'Williams', 'alice.williams@email.com', 'Professor', 'Computer Networks', 4),
(5, 'Charlie', 'Brown', 'charlie.brown@email.com', 'Associate Professor', 'Database Systems', 5),
(6, 'Eva', 'Davis', 'eva.davis@email.com', 'Assistant Professor', 'Software Engineering', 6),
(7, 'Frank', 'Miller', 'frank.miller@email.com', 'Professor', 'Cybersecurity', 7),
(8, 'Grace', 'Taylor', 'grace.taylor@email.com', 'Associate Professor', 'Human-Computer Interaction', 8),
(9, 'Harry', 'Moore', 'harry.moore@email.com', 'Assistant Professor', 'Cloud Computing', 9),
(10, 'Ivy', 'Roberts', 'ivy.roberts@email.com', 'Professor', 'Big Data Analytics', 10),
(11, 'Jack', 'Harrison', 'jack.harrison@email.com', 'Associate Professor', 'Mobile App Development', 11),
(12, 'Kelly', 'Baker', 'kelly.baker@email.com', 'Assistant Professor', 'Web Development', 12),
(13, 'Leo', 'Anderson', 'leo.anderson@email.com', 'Professor', 'Computer Graphics', 13),
(14, 'Mia', 'Clark', 'mia.clark@email.com', 'Associate Professor', 'Artificial Neural Networks', 14),
(15, 'Nathan', 'Evans', 'nathan.evans@email.com', 'Assistant Professor', 'Machine Vision', 15);

insert into StudentContacts (contact_id, student_id, mobile_phone, email) values 
(1, 1, '123-456-7890', 'alice.johnson@example.com'),
(2, 2, '234-567-8901', 'bob.williams@example.com'),
(3, 3, '345-678-9012', 'charlie.smith@example.com'),
(4, 4, '456-789-0123', 'david.jones@example.com'),
(5, 5, '567-890-1234', 'eva.brown@example.com'),
(6, 6, '678-901-2345', 'frank.miller@example.com'),
(7, 7, '789-012-3456', 'grace.davis@example.com'),
(8, 8, '890-123-4567', 'henry.anderson@example.com'),
(9, 9, '901-234-5678', 'ivy.wilson@example.com'),
(10, 10, '012-345-6789', 'jack.taylor@example.com'),
(11, 11, '123-234-5678', 'kelly.garcia@example.com'),
(12, 12, '234-345-6789', 'leo.moore@example.com'),
(13, 13, '345-456-7890', 'mia.thompson@example.com'),
(14, 14, '456-567-8901', 'noah.clark@example.com'),
(15, 15, '567-678-9012', 'olivia.white@example.com');

insert into Admissions (admission_id, student_id, admission, level_of_english_IELTS, high_school_assessment) values
(1, 1, '2022-09-01', 7.0, 90),
(2, 2, '2022-09-01', 6.5, 80),
(3, 3, '2022-09-01', 7.5, 85),
(4, 4, '2022-09-01', 6.0, 88),
(5, 5, '2022-09-01', 8.0, 92),
(6, 6, '2022-09-01', 5.5, 87),
(7, 7, '2022-09-01', 8.5, 91),
(8, 8, '2022-09-01', 6.5, 89),
(9, 9, '2022-09-01', 7.0, 93),
(10, 10, '2022-09-01', 5.0, 86),
(11, 11, '2022-09-01', 9.0, 94),
(12, 12, '2022-09-01', 6.5, 82),
(13, 13, '2022-09-01', 7.5, 96),
(14, 14, '2022-09-01', 7.0, 84),
(15, 15, '2022-09-01', 8.5, 98);

insert into Courses (course_id, course_name, course_code, major, credits, department_id, instructor_id, required_GPA) values 
    (1, 'Introduction to Computer Science', 'CS101', true, 3, 1, 1, 3),
    (2, 'Data Structures', 'CS201', true, 4, 1, 2, 4),
    (3, 'Algorithms', 'CS301', true, 3, 1, 3, 4),
    (4, 'Introduction to Psychology', 'PSY101', true, 3, 2, 4, 2),
    (5, 'Statistics', 'STAT201', true, 4, 2, 5, 3),
    (6, 'English Composition', 'ENG101', true, 3, 3, 6, 4),
    (7, 'World History', 'HIS101', true, 3, 4, 7, 2),
    (8, 'Chemistry 101', 'CHEM101', true, 4, 5, 8, 3),
    (9, 'Physics 101', 'PHYS101', true, 4, 5, 9, 3),
    (10, 'Calculus I', 'MATH101', true, 4, 6, 10, 3),
    (11, 'Introduction to Business', 'BUS101', true, 3, 7, 11, 4),
    (12, 'Marketing Principles', 'MKTG201', true, 3, 7, 12, 2),
    (13, 'Microeconomics', 'ECON101', true, 3, 8, 13, 3),
    (14, 'Macroeconomics', 'ECON201', true, 3, 8, 14, 4),
    (15, 'Spanish 101', 'SPAN101', true, 3, 9, 15, 3),
    (16, 'Art History', 'ART101', true, 3, 10, 1, 4),
    (17, 'Digital Marketing', 'MKTG301', true, 3, 11, 2, 3),
    (18, 'Political Science', 'POL101', true, 3, 12, 3, 2),
    (19, 'Organic Chemistry', 'CHEM201', true, 4, 13, 14, 3),
    (20, 'Astronomy', 'ASTRO101', true, 3, 14, 5, 4),
    (21, 'Linear Algebra', 'MATH201', true, 4, 15, 6, 3),
    (22, 'Financial Accounting', 'ACCT101', true, 3, 1, 7, 4),
    (23, 'Operations Management', 'OM301', true, 3, 2, 8, 3),
    (24, 'Human Anatomy', 'BIO101', true, 4, 3, 9, 3),
    (25, 'Environmental Science', 'ENV101', true, 3, 4, 10, 3),
    (26, 'Introduction to Sociology', 'SOC101', true, 3, 5, 11, 2),
    (27, 'Software Engineering', 'SE301', true, 4, 6, 12, 4),
    (28, 'International Relations', 'IR101', true, 3, 7, 14, 3),
    (29, 'Artificial Intelligence', 'AI401', true, 4, 8, 14, 4),
    (30, 'Philosophy 101', 'PHIL101', true, 3, 9, 15, 3);

insert into Enrollments (enrollment_id, student_id, course_id, semester) values 
    (1, 7, 10, 'Fall 2022'),
    (2, 2, 5, 'Fall 2022'),
    (3, 12, 1, 'Fall 2022'),
    (4, 8, 7, 'Fall 2022'),
    (5, 3, 3, 'Fall 2022'),
    (6, 15, 13, 'Fall 2022'),
    (7, 1, 6, 'Fall 2022'),
    (8, 11, 8, 'Fall 2022'),
    (9, 6, 14, 'Fall 2022'),
    (10, 10, 2, 'Fall 2022'),
    (11, 5, 9, 'Fall 2022'),
    (12, 14, 1, 'Fall 2022'),
    (13, 4, 12, 'Fall 2022'),
    (14, 9, 11, 'Fall 2022'),
    (15, 13, 15, 'Fall 2022'),
    (16, 7, 2, 'Spring 2023'),
    (17, 1, 8, 'Spring 2023'),
    (18, 15, 14, 'Spring 2023'),
    (19, 10, 3, 'Spring 2023'),
    (20, 2, 1, 'Spring 2023'),
    (21, 11, 9, 'Spring 2023'),
    (22, 4, 6, 'Spring 2023'),
    (23, 8, 10, 'Spring 2023'),
    (24, 14, 11, 'Spring 2023'),
    (25, 12, 11, 'Spring 2023'),
    (26, 3, 13, 'Spring 2023'),
    (27, 9, 5, 'Spring 2023'),
    (28, 6, 7, 'Spring 2023'),
    (29, 13, 14, 'Spring 2023'),
    (30, 5, 12, 'Spring 2023'),
	(31, 5, 14, 'Spring 2023');

insert into Transcripts (transcript_id, student_id, total_credits, average_GPA) values 
(1, 1, 60, 3.5),
(2, 2, 58, 3.4),
(3, 3, 62, 3.7),
(4, 4, 59, 3.6),
(5, 5, 65, 3.9),
(6, 6, 61, 3.8),
(7, 7, 200, 3.9),
(8, 8, 63, 3.8),
(9, 9, 67, 4.0),
(10, 10, 60, 3.5),
(11, 11, 68, 4.0),
(12, 12, 56, 3.2),
(13, 13, 70, 4.1),
(14, 14, 66, 3.9),
(15, 15, 120, 4.1),
(16, 16, 55, 3.1),
(17, 17, 59, 3.6),
(18, 18, 62, 3.7),
(19, 19, 64, 3.9),
(20, 20, 58, 3.4),
(21, 21, 63, 3.8),
(22, 22, 61, 3.8),
(23, 23, 66, 3.9),
(24, 24, 57, 3.3),
(25, 25, 65, 3.9);

insert into DegreeProgress (degree_progress_id, student_id, majors_completed, total_majors) values 
(1, 1, 2, 4),
(2, 2, 3, 4),
(3, 3, 2, 3),
(4, 4, 4, 4),
(5, 5, 3, 4),
(6, 6, 2, 3),
(7, 7, 4, 4),
(8, 8, 3, 3),
(9, 9, 3, 3),
(10, 10, 2, 4),
(11, 11, 4, 4),
(12, 12, 3, 4),
(13, 13, 2, 3),
(14, 14, 4, 4),
(15, 15, 3, 3);

insert into StudentGroups (group_id, group_name, description, advisor_id) values 
(1, 'Programming Club', 'For enthusiasts of coding and software development', 1),
(2, 'Mathematics Society', 'Promoting love for mathematics and its applications', 2),
(3, 'Physics Explorers', 'Unraveling the mysteries of the universe', 3),
(4, 'History Buffs', 'Exploring the past to understand the present', 4),
(5, 'Biology Enthusiasts', 'Celebrating the diversity of life', 5),
(6, 'Chemistry Wizards', 'Where reactions and discoveries happen', 6),
(7, 'Literary Circle', 'For lovers of words and stories', 7),
(8, 'Psychology Club', 'Exploring the human mind and behavior', 8),
(9, 'Economics Forum', 'Discussing economic theories and real-world applications', 9),
(10, 'Engineering Innovators', 'Creating solutions for a better world', 10),
(11, 'Business Leaders Society', 'Shaping the future of business', 11),
(12, 'Political Science Debate Club', 'Analyzing and debating political issues', 12),
(13, 'Sociology Advocates', 'Advancing social justice and understanding', 13),
(14, 'Art Appreciation Club', 'Exploring the world of artistic expression', 14),
(15, 'Music Ensemble', 'Harmony in musical diversity', 15);

insert into Housing (housing_id, student_id, building, room_number, ocupancy_status, move_in_date, move_out_date) values 
    (1, 1, 'Building A', 201, 'Occupied', '2023-01-01', '2023-06-30'),
    (2, 2, 'Building B', 305, 'Occupied', '2022-08-15', '2023-05-15'),
    (3, null, 'Building C', 102, 'Vacant', null, null),
    (4, null, 'Building A', 305, 'Vacant', null, null),
    (5, 5, 'Building B', 101, 'Occupied', '2023-03-01', '2023-12-31'),
    (6, 6, 'Building C', 203, 'Occupied', '2023-04-10', '2023-05-15'),
    (7, null, 'Building A', 304, 'Vacant', null, null),
    (8, 8, 'Building B', 102, 'Occupied', '2023-05-20', '2024-01-31'),
    (9, null, 'Building C', 101, 'Vacant', null, null),
    (10, 10, 'Building A', 202, 'Occupied', '2023-06-15', '2023-05-15'),
    (11, null, 'Building B', 203, 'Vacant', null, null),
    (12, 12, 'Building C', 304, 'Occupied', '2023-07-01', '2023-05-15'),
    (13, 13, 'Building A', 103, 'Occupied', '2023-08-10', '2023-05-15'),
    (14, null, 'Building B', 301, 'Vacant', null, null),
    (15, 15, 'Building C', 204, 'Occupied', '2023-09-01', '2023-12-31');

insert into MealPlans (meal_plan_id, meal_plan_name, description, mounthly_cost, student_id, debt) values 
(1, 'Standard Meal Plan', 'Three meals a day on weekdays', 300, 1, null),
(2, 'Vegetarian Meal Plan', 'Vegetarian options for all meals', 280, 2, null),
(3, 'Flexible Meal Plan', 'Customize your meal choices', 320, 3, 120),
(4, 'All-Access Meal Plan', 'Unlimited access to dining facilities', 350, 4, 125),
(5, 'Healthy Choices Meal Plan', 'Focus on nutritious and balanced meals', 330, 5, 100),
(6, 'International Cuisine Meal Plan', 'Explore dishes from around the world', 360, 6, 85),
(7, 'Budget-Friendly Meal Plan', 'Affordable options for cost-conscious students', 290, 7, 450),
(8, 'Gourmet Meal Plan', 'Indulge in high-quality and diverse gourmet options', 380, 8, null),
(9, 'Family-Style Meal Plan', 'Share meals with friends in a communal setting', 310, 9, null),
(10, 'On-the-Go Meal Plan', 'Quick and convenient options for busy schedules', 340, 10, null),
(11, 'Dietary-Restriction Meal Plan', 'Catering to specific dietary needs', 325, 11, null),
(12, 'Late-Night Snack Plan', 'Access to late-night dining options', 300, 12, null),
(13, 'Fitness Enthusiast Meal Plan', 'Focus on meals that support an active lifestyle', 370, 13, 230),
(14, 'Culinary Arts Meal Plan', 'For students with a passion for cooking and gastronomy', 355, 14, 150),
(15, 'Special Occasion Meal Plan', 'Reserved for special events and celebrations', 400, 15, 240);

insert into StudentFees (student_fee_id, student_id, fee_type, cost_of_fee, due_date, payment_status, debt) values 
(1, 1, 'Tuition Fee', 5000, '2022-09-01', 'Paid', 2000),
(2, 2, 'Tuition Fee', 4800, '2022-09-01', 'Paid', 1200),
(3, 3, 'Tuition Fee', 5200, '2022-09-01', 'Paid', 1300),
(4, 4, 'Tuition Fee', 4900, '2022-09-01', 'Paid', 1430),
(5, 5, 'Tuition Fee', 5500, '2022-09-01', 'Paid', 540),
(6, 6, 'Tuition Fee', 5300, '2022-09-01', 'Paid', 845),
(7, 7, 'Tuition Fee', 5400, '2022-09-01', 'Paid', null),
(8, 8, 'Tuition Fee', 5350, '2022-09-01', 'Paid', null),
(9, 9, 'Tuition Fee', 5700, '2022-09-01', 'Paid', null),
(10, 10, 'Tuition Fee', 5000, '2022-09-01', 'Paid', null),
(11, 11, 'Tuition Fee', 5800, '2022-09-01', 'Paid', 5000),
(12, 12, 'Tuition Fee', 4700, '2022-09-01', 'Paid', null),
(13, 13, 'Tuition Fee', 6000, '2022-09-01', 'Paid', null),
(14, 14, 'Tuition Fee', 5600, '2022-09-01', 'Paid', 3000),
(15, 15, 'Tuition Fee', 5900, '2022-09-01', 'Paid', null);

insert into Library (library_id, recourse_type, title, author, check_out_status) values 
(1, 'Book', 'Introduction to Algorithms', 'Thomas H. Cormen', 'Available'),
(2, 'Journal', 'Nature', 'Various Authors', 'Available'),
(3, 'Magazine', 'National Geographic', 'Various Authors', 'Available'),
(4, 'Book', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Checked Out'),
(5, 'Journal', 'Science', 'Various Authors', 'Available'),
(6, 'Magazine', 'Time', 'Various Authors', 'Available'),
(7, 'Book', 'The Art of Computer Programming', 'Donald E. Knuth', 'Available'),
(8, 'Journal', 'Psychological Review', 'Various Authors', 'Checked Out'),
(9, 'Magazine', 'The Economist', 'Various Authors', 'Available'),
(10, 'Book', 'Structures and Interpretation of Computer Programs', 'Harold Abelson', 'Checked Out'),
(11, 'Journal', 'The New England Journal of Medicine', 'Various Authors', 'Available'),
(12, 'Magazine', 'National Review', 'Various Authors', 'Available'),
(13, 'Book', 'The Elements of Style', 'William Strunk Jr. and E.B. White', 'Available'),
(14, 'Journal', 'Social Forces', 'Various Authors', 'Checked Out'),
(15, 'Magazine', 'Vogue', 'Various Authors', 'Available');

insert into HealthServices (health_service_id, student_id, visit_date, convalescence_date, reason_for_visit) values 
    (1, 1, '2023-01-05', '2023-01-10', 'Common cold'),
    (2, 2, '2023-02-12', '2023-02-15', 'Headache'),
    (3, 3, '2023-03-20', '2023-03-25', 'Flu'),
    (4, 4, '2023-04-08', '2023-04-12', 'Allergies'),
    (5, 5, '2023-05-15', '2023-05-20', 'Sore throat'),
    (6, 6, '2023-06-02', '2023-06-07', 'Sprained ankle'),
    (7, 7, '2023-07-18', '2023-07-22', 'Fever'),
    (8, 8, '2023-08-25', '2023-08-30', 'Stomachache'),
    (9, 9, '2023-09-14', '2023-09-18', 'Migraine'),
    (10, 10, '2023-10-03', '2023-10-08', 'Influenza'),
    (11, 11, '2023-11-11', '2023-11-16', 'Cough'),
    (12, 12, '2023-12-19', '2023-12-24', 'Back pain'),
    (13, 13, '2024-01-02', '2024-01-07', 'Ear infection'),
    (14, 14, '2024-02-09', '2024-02-14', 'Fatigue'),
    (15, 15, '2024-03-15', '2024-03-20', 'Dizziness');

insert into StudentAchievements (achievement_id, student_id, achievement_type, description) values 
(1, 1, 'Academic', 'Dean''s List for the Fall Semester'),
(2, 2, 'Sports', 'Winner of the Annual Chess Tournament'),
(3, 3, 'Art', 'Exhibited a Painting at the Student Art Show'),
(4, 4, 'Leadership', 'President of the Student Government'),
(5, 5, 'Research', 'Published Research Paper in Biology Journal'),
(6, 6, 'Music', 'Performed Solo at the Annual Music Concert'),
(7, 7, 'Community Service', 'Volunteered at Local Homeless Shelter'),
(8, 8, 'Academic', 'Recipient of the Economics Excellence Award'),
(9, 9, 'Leadership', 'Vice President of the Engineering Club'),
(10, 10, 'Sports', 'Captain of the Soccer Team'),
(11, 11, 'Research', 'Received Grant for Political Science Research'),
(12, 12, 'Community Service', 'Organized Charity Fundraiser'),
(13, 13, 'Art', 'Won First Place in Sculpture Category'),
(14, 14, 'Music', 'Played Piano at the College Music Festival'),
(15, 15, 'Academic', 'Top Performer in Music Theory');

insert into Internships (internship_id, student_id, company, position, start_date, end_date) values 
(1, 1, 'TechCorp', 'Software Developer Intern', '2022-06-01', '2022-08-31'),
(2, 2, 'Finance Solutions', 'Financial Analyst Intern', '2022-06-01', '2022-08-31'),
(3, 3, 'Health Innovations', 'Research Intern','2022-06-01', '2022-08-31'),
(4, 4, 'Global Consulting', 'Marketing Intern', '2022-06-01', '2022-08-31'),
(5, 5, 'Biotech Labs', 'Lab Assistant Intern', '2022-06-01', '2022-08-31'),
(6, 6, 'Green Energy Solutions', 'Environmental Engineering Intern', '2022-06-01', '2022-08-31'),
(7, 7, 'Wordsmith Publishing', 'Editorial Intern', '2022-06-01', '2022-08-31'),
(8, 8, 'Financial Insights', 'Economic Analyst Intern', '2022-06-01', '2022-08-31'),
(9, 9, 'InnovateTech', 'Software Development Intern', '2022-06-01', '2022-08-31'),
(10, 10, 'Engineering Innovations', 'Mechanical Engineering Intern', '2022-06-01', '2022-08-31'),
(11, 11, 'Global Business Strategies', 'Strategic Planning Intern', '2022-06-01', '2022-08-31'),
(12, 12, 'Community Outreach Organization', 'Social Work Intern', '2022-06-01', '2022-08-31');
-- (13, 13, 'Artistry Studios', 'Graphic Design Intern', '2022-06-01', '2022-08-31'),
-- (14, 14, 'Harmony Music Productions', 'Music Production Intern', '2022-06-01', '2022-08-31'),
-- (15, 15, 'Tech Innovators', 'Computer Science Research Intern', '2022-06-01', '2022-08-31');

insert into StudyAbroad (study_abroad_id, student_id, program_name, university_name, country, start_date, end_date) values 
(1, 1, 'Global Exchange Program', 'University of Edinburgh', 'United Kingdom', '2023-01-15', '2023-05-15'),
(2, 2, 'Language Immersion Program', 'Sorbonne University', 'France', '2023-01-15', '2023-05-15'),
(3, 3, 'Cultural Studies Program', 'University of Tokyo', 'Japan', '2023-01-15', '2023-05-15'),
(4, 4, 'Business Internship Program', 'Sydney Business School', 'Australia', '2023-01-15', '2023-05-15'),
(5, 5, 'Biomedical Research Program', 'ETH Zurich', 'Switzerland', '2023-01-15', '2023-05-15'),
(6, 6, 'Environmental Science Program', 'University of British Columbia', 'Canada', '2023-01-15', '2023-05-15'),
(7, 7, 'Journalism and Media Program', 'University of Cape Town', 'South Africa', '2023-01-15', '2023-05-15'),
(8, 8, 'Economics and Finance Program', 'National University of Singapore', 'Singapore', '2023-01-15', '2023-05-15'),
(9, 9, 'Computer Science and Technology Program', 'KAIST', 'South Korea', '2023-01-15', '2023-05-15'),
(10, 10, 'Engineering and Innovation Program', 'Technion – Israel Institute of Technology', 'Israel', '2023-01-15', '2023-05-15'),
(11, 11, 'Political Science and International Relations Program', 'Sciences Po', 'France', '2023-01-15', '2023-05-15'),
(12, 12, 'Sociology and Community Development Program', 'University of Toronto', 'Canada', '2023-01-15', '2023-05-15'),
(13, 13, 'Art and Design Program', 'Royal College of Art', 'United Kingdom', '2023-01-15', '2023-05-15'),
(14, 14, 'Music and Performing Arts Program', 'Juilliard School', 'United States', '2023-01-15', '2023-05-15'),
(15, 15, 'Computer Science Research Program', 'Swiss Federal Institute of Technology (EPFL)', 'Switzerland', '2023-01-15', '2023-05-15');

insert into Graduation (graduation_id, student_id, graduation_date, degree_awarded) values 
(1, 1, '2024-06-15', 'Bachelor of Science in Computer Science'),
(2, 2, '2024-06-15', 'Bachelor of Arts in Economics'),
(3, 3, '2024-06-15', 'Bachelor of Science in Physics'),
(4, 4, '2024-06-15', 'Bachelor of Business Administration'),
(5, 5, '2024-06-15', 'Bachelor of Science in Biology'),
(6, 6, '2024-06-15', 'Bachelor of Science in Environmental Engineering'),
(7, 7, '2024-06-15', 'Bachelor of Arts in English Literature'),
(8, 8, '2024-06-15', 'Bachelor of Arts in Psychology'),
(9, 9, '2024-06-15', 'Bachelor of Arts in Economics'),
(10, 10, '2024-06-15', 'Bachelor of Science in Mechanical Engineering'),
(11, 11, '2024-06-15', 'Bachelor of Arts in Political Science'),
(12, 12, '2024-06-15', 'Bachelor of Arts in Sociology'),
(13, 13, '2024-06-15', 'Bachelor of Fine Arts in Visual Arts'),
(14, 14, '2024-06-15', 'Bachelor of Music in Music Production'),
(15, 15, '2024-06-15', 'Bachelor of Science in Computer Science');

insert into Alumni (alumni_id, student_id, graduation_year, email) values 
(1, 1, 2024, 'alumni1@example.com'),
(2, 2, 2024, 'alumni2@example.com'),
(3, 3, 2024, 'alumni3@example.com'),
(4, 4, 2024, 'alumni4@example.com'),
(5, 5, 2024, 'alumni5@example.com'),
(6, 6, 2024, 'alumni6@example.com'),
(7, 7, 2024, 'alumni7@example.com'),
(8, 8, 2024, 'alumni8@example.com'),
(9, 9, 2024, 'alumni9@example.com'),
(10, 10, 2024, 'alumni10@example.com'),
(11, 11, 2024, 'alumni11@example.com'),
(12, 12, 2024, 'alumni12@example.com'),
(13, 13, 2024, 'alumni13@example.com'),
(14, 14, 2024, 'alumni14@example.com'),
(15, 15, 2024, 'alumni15@example.com');

insert into Staff (staff_id, first_name, last_name, title, email, department_id) values 
(1, 'Staff1', 'Lastname1', 'IT Specialist', 'staff1@example.com', 1),
(2, 'Staff2', 'Lastname2', 'HR Coordinator', 'staff2@example.com', 2),
(3, 'Staff3', 'Lastname3', 'Academic Advisor', 'staff3@example.com', 3),
(4, 'Staff4', 'Lastname4', 'Library Assistant', 'staff4@example.com', 4),
(5, 'Staff5', 'Lastname5', 'Finance Manager', 'staff5@example.com', 5),
(6, 'Staff6', 'Lastname6', 'Facilities Manager', 'staff6@example.com', 6),
(7, 'Staff7', 'Lastname7', 'Marketing Specialist', 'staff7@example.com', 7),
(8, 'Staff8', 'Lastname8', 'Counselor', 'staff8@example.com', 8),
(9, 'Staff9', 'Lastname9', 'Economics Professor', 'staff9@example.com', 9),
(10, 'Staff10', 'Lastname10', 'Mechanical Engineering Professor', 'staff10@example.com', 10),
(11, 'Staff11', 'Lastname11', 'Political Science Professor', 'staff11@example.com', 11),
(12, 'Staff12', 'Lastname12', 'Sociology Professor', 'staff12@example.com', 12),
(13, 'Staff13', 'Lastname13', 'Art Professor', 'staff13@example.com', 13),
(14, 'Staff14', 'Lastname14', 'Music Professor', 'staff14@example.com', 14),
(15, 'Staff15', 'Lastname15', 'Computer Science Professor', 'staff15@example.com', 15);

-- List of Students and Their Enrollments:
select Students.student_id, Students.first_name, Students.last_name, Courses.course_name, Courses.course_code, Enrollments.semester
from Students
join Enrollments on Students.student_id = Enrollments.student_id
join Courses on Enrollments.course_id = Courses.course_id;

-- Retrieve a list of all students and the courses they are currently enrolled in, including course details.
select Students.student_id, Students.first_name, Students.last_name, Courses.course_name, Courses.course_code, Enrollments.semester, Departments.department_name
from Students
join Enrollments on Students.student_id = Enrollments.student_id
join Courses on Enrollments.course_id = Courses.course_id
join Departments on Courses.department_id = Departments.department_id;

-- Find the students who do not have assigned advisors.
select student_id, first_name, last_name
from Students
where advisor_id is null;

-- Identify the student(s) with the highest GPA and their academic records.
select Students.student_id, Students.first_name, Students.last_name, Transcripts.average_GPA, Transcripts.total_credits, StudentAchievements.achievement_type, StudentAchievements.description 
from Students
join Transcripts on Students.student_id = Transcripts.student_id
full join StudentAchievements on Students.student_id = StudentAchievements.student_id
order by Transcripts.average_GPA desc
limit 1;

-- Calculate the average GPA for students in each major.
select Courses.course_id, Courses.course_name, Courses.major, avg(Transcripts.average_GPA) as average_GPA
from Courses
join Enrollments on Courses.course_id = Enrollments.course_id
join Students on Enrollments.student_id = Students.student_id
join Transcripts on Students.student_id = Transcripts.student_id
group by Courses.course_id
having Courses.major = true;

-- Determine which departments offer the most courses by counting the number of courses offered in each department.
select Departments.department_id, Departments.department_name, count(Courses.department_id) as total_count
from Departments
left join Courses on Departments.department_id = Courses.department_id
group by Departments.department_id, Departments.department_name
order by total_count desc;

-- List faculty advisors along with the students they advise.
select Advisors.advisor_id, Advisors.first_name as adviser_name, 
Advisors.last_name as advisor_surname, Students.student_id, Students.first_name, Students.last_name 
from Advisors
join Students on Advisors.advisor_id = Students.advisor_id
order by Advisors.advisor_id asc;

-- Find the student groups with the most members and list the group names and member counts.
select StudentGroups.group_id, StudentGroups.group_name, count(Students.student_id) as total_count
from StudentGroups
join Advisors on StudentGroups.advisor_id = Advisors.advisor_id
join Students on Advisors.advisor_id = Students.advisor_id
group by StudentGroups.group_id, StudentGroups.group_name
order by total_count desc;

-- Calculate the occupancy rate of the university's student housing facilities.
select count(distinct Housing.student_id) as occupied_room, 
count(distinct Housing.housing_id) as total_count, 
count(distinct Housing.student_id) * 100 /  count(distinct Housing.housing_id) as ocuppancy_rate
from Housing;

-- Compute the average cost of meal plans for different student groups (e.g., freshmen, sophomores, etc.).
select Enrollments.semester, avg(MealPlans.mounthly_cost) as average_cost
from Enrollments
join Students on Enrollments.student_id = Students.student_id
join MealPlans on Students.student_id = MealPlans.student_id
group by Enrollments.semester
order by average_cost;

-- Calculate the total tuition revenue generated by each academic department.
select Departments.department_id, Departments.department_name, sum(StudentFees.cost_of_fee) as revenue
from Departments
join Students on Departments.department_id = Students.department_id
join StudentFees on Students.student_id = StudentFees.student_id
group by Departments.department_id, Departments.department_name
order by revenue desc;

-- Find the number of available library resources and the number checked out by students.
select count(check_out_status) filter(where check_out_status = 'Available') as available_books, 
count(check_out_status) filter(where check_out_status = 'Checked Out') as check_out_books
from Library;

-- Calculate the number of student visits to health services and their average visit duration.
select Students.student_id, Students.first_name, Students.last_name, 
avg(extract(epoch from age(HealthServices.convalescence_date, HealthServices.visit_date)) / (24 * 3600)) as average_time_in_day
from Students
join HealthServices on Students.student_id = HealthServices.student_id
group by Students.student_id, Students.first_name, Students.last_name
order by average_time_in_day desc;

-- List student achievements (awards, honors) and group them by the student's department.
select Departments.department_id, Departments.department_name, StudentAchievements.achievement_type, StudentAchievements.description
from Departments
join Students on Departments.department_id = Students.department_id
join StudentAchievements on Students.student_id = StudentAchievements. student_id;

-- Determine the percentage of students who have participated in internships.
select count(Internships.internship_id) as student_internship, 
count(Students.student_id) as total_count, 
count(Internships.internship_id) * 100 / count(Students.student_id) as persentage
from Internships
right join Students on Internships.student_id = Students.student_id;

-- Find the countries where students have studied abroad and the number of students in each country.
select StudyAbroad.country, count(StudyAbroad.student_id)
from StudyAbroad
group by StudyAbroad.country;

-- List the upcoming campus events and their details, sorted by date.
select * from StudentEvents
where event_date > current_date
order by event_date desc;

--  Determine which departments produce the most employed alumni.
select Departments.department_id, Departments.department_name, count(Alumni.student_id) as total_count
from Departments
join Students on Departments.department_id = Students.department_id
join Alumni on Students.student_id = Alumni.student_id
group by Departments.department_id, Departments.department_name
order by total_count desc
limit 1;

-- Identify faculty members who have expertise in specific research areas, based on their academic records.
select * from Instructors
where specific_research_areas = 'Database Systems';

-- Analyze the historical enrollment data to identify trends in student enrollment over the past few years.
select extract(year from admission) as year, 
avg(level_of_english_IELTS) as average_english_level, 
avg(high_school_assessment) as average_asessment
from Admissions
group by year;

-- Verify if students enrolling in advanced courses meet the prerequisites by checking their transcript records.
select Students.student_id, Students.first_name, Students.last_name, Transcripts.average_GPA, Courses.required_GPA
from Students
join Enrollments on Students.student_id = Enrollments.student_id
join Courses on Enrollments.course_id = Courses.course_id
join Transcripts on Students.student_id = Transcripts.student_id
where Transcripts.average_GPA >= Courses.required_GPA;

-- List students with outstanding fees, including the total amount owed.
select Students.student_id, Students.first_name, Students.last_name, sum(MealPlans.debt + StudentFees.debt) as total_debt
from Students
join MealPlans on Students.student_id = MealPlans.student_id
join StudentFees on Students.student_id = StudentFees.student_id
group by Students.student_id, Students.first_name, Students.last_name
order by total_debt desc nulls last;

-- Identify instructors who are teaching multiple courses in the same term and list the courses they are teaching.
select Instructors.instructor_id, Instructors.first_name, Instructors.last_name, array_agg(Courses.course_name) as courses
from Instructors
join Courses on Instructors.instructor_id = Courses.instructor_id
group by Instructors.instructor_id, Instructors.first_name, Instructors.last_name
having array_length(array_agg(Courses.course_name), 1) >= 2;
-- ?

-- Calculate statistics on student diversity, such as the distribution of gender, ethnicity, or nationality.
select count(student_id) as count_of_students, avg(age) as average_age, 
count(gender) filter(where gender = 'Female') as count_of_female,
count(gender) filter(where gender = 'Male') as count_of_male, count(distinct nationality)
from Students;

select nationality, count(nationality) as count_of_nationality
from (
	select nationality
	from Students
) as nationality
group by nationality
order by count_of_nationality desc;

-- Find the most popular combinations of courses (sets of courses taken together) among students.
select course_combination, count(course_combination) as total_count
from (
    select array_agg(course_id order by course_id) as course_combination
    from Enrollments
    group by student_id
) as course_combinations
group by course_combination
order by total_count desc
limit 1;

-- Compare the academic performance (GPA) of students based on their faculty advisors.
select Advisors.advisor_id, Advisors.first_name, Advisors.last_name, avg(Transcripts.average_GPA) as average_GPA
from Advisors
join Students on Advisors.advisor_id = Students.advisor_id
join Transcripts on Students.student_id = Transcripts.student_id
group by Advisors.advisor_id, Advisors.first_name, Advisors.last_name
order by average_GPA desc;

-- Identify student groups that have members from a wide range of majors, promoting interdisciplinary collaboration.
select StudentGroups.group_id, StudentGroups.group_name, course_combination
from StudentGroups
join Advisors on StudentGroups.advisor_id = Advisors.advisor_id
join Students on Advisors.advisor_id = Students.advisor_id
join (
	select student_id, array_agg(course_id order by course_id) as course_combination
	from Enrollments
	group by student_id
	having array_length( array_agg(course_id order by course_id), 1) >= 2
) as course_combination on Students.student_id = course_combination.student_id;

-- List courses with consistently high enrollment, helping with scheduling and resource allocation.
select Courses.course_id, Courses.course_name, count(Enrollments.course_id) as total_count
from Courses
join Enrollments on Courses.course_id = Enrollments.course_id
group by Courses.course_id, Courses.course_name
order by total_count desc;

-- Calculate the average time it takes students to graduate, considering their major and any changes in degree programs.
select Students.student_id, Students.first_name, 
Students.last_name, 4 - (sum(Courses.credits) + Transcripts.total_credits) / 60 as total_semesters
from Students
join Enrollments on Students.student_id = Enrollments.student_id
join Courses on Enrollments.course_id = Courses.course_id
join Transcripts on Students.student_id = Transcripts.student_id
group by Students.student_id, Students.first_name, Students.last_name, Transcripts.total_credits
order by total_semesters asc;

-- Determine if students who complete internships have a higher graduation rate compared to those who do not.
select avg(case when Internships.internship_id is not null then Transcripts.average_GPA end) as Internships_average_GPA, 
avg(case when Internships.internship_id is null then Transcripts.average_GPA end) as Non_internships_average_GPA
from Students
left join Internships on Students.student_id = Internships.student_id
join Transcripts on Students.student_id = Transcripts.student_id;

