drop table if exists Caretakers, RoomTypes, Buildings, Rooms, HousingAssignments, Attendance, Students, Attendance, Advisors, Specialties, Faculties, Curriculums, Enrollments, Courses, CurriclumItems, Semesters, Cabinets, CourseSections, ScheduleSlots, Instructors cascade; 

create table Caretakers (
    caretaker_ID serial primary key,
    caretaker_name varchar(255),
    caretaker_surname varchar(255),
    caretaker_gender varchar(10)
);

create table RoomTypes (
    room_type_ID serial primary key,
    capacity integer,
    room_name varchar(255),
    semester_price decimal(10,2)
);

create table Advisors (
    advisor_ID serial primary key,
    advisor_name varchar(255),
    advisor_surname varchar(255),
    advisor_email varchar(255),
    advisor_birthday varchar(255),
    advisor_gender varchar(255)
);

create table Faculties (
    faculty_ID serial primary key,
    faculty_name varchar(255),
    faculty_description text,
    faculty_office integer
);

create table Courses (
    course_ID serial primary key,
    course_name varchar(255),
    course_code varchar(10),
    course_credits integer,
    course_syllabus json
);

create table Semesters (
    semester_ID serial primary key,
    semester_name varchar(255),
    semester_start_date date,
    semester_end_date date
);

create table Instructors (
    instructor_ID serial primary key,
    instructor_name varchar(255),
    instructor_surname varchar(255),
    instructor_email varchar(255),
    academic_degree varchar(255)
);

create table Cabinets (
    cabinet_ID serial primary key,
    cabinet_code varchar(10),
    cabinet_name varchar(255)
);


create table Buildings (
    building_ID serial primary key,
    building_code varchar(3),
    gender_type varchar(10),
    caretaker_ID integer,
	foreign key caretaker_ID references Caretakers(Caretaker_ID)
);

create table Specialties (
    specialty_ID serial primary key,
    specialty_name varchar(255),
    specialty_code varchar(10),
    faculty_ID integer,
	foreign key faculty_ID references Faculties(faculty_ID)
);

create table Rooms (
    room_ID serial primary key,
    building_ID integer,
    room_type_ID integer,
    room_code varchar(10),
    floor integer,
    is_occupied boolean,
	foreign key building_ID references Buildings(building_ID),
	foreign key room_type_ID  references Roomtypes(room_type_id)
);

create table Curriculums (
    curriculum_ID serial primary key,
    curriculum_description text,
    curriculum_year integer,
    curriculum_name varchar(100),
    specialty_ID integer,
	foreign key specialty_ID references Specialties(specialty_ID)
);

create table CourseSections (
    course_section_id serial primary key,
    course_ID integer references courses(course_id),
    semester_ID integer references semesters(semester_id),
    instructor_ID integer references instructors(instructor_id),
    course_capacity integer
);

create table Students (
    student_ID serial primary key,
    student_name varchar(255),
    student_surname varchar(255),
    student_email varchar(255),
    student_birthday date,
    student_gender varchar(20),
    student_nationality varchar(255),
    advisor_ID integer references advisors(advisor_id),
    curriculum_ID integer references curriculums(curriculum_id),
    student_grant_type varchar(255)
);

create table HousingAsignments (
    housing_assignment_id serial primary key,
    room_id integer references rooms(room_id),
    student_id integer references students(student_id),
    housing_check_in date,
    housing_check_out date,
    assignment_status varchar(30),
	unique(room_ID, StudentID)
);

create table Attendance (
    attendance_id serial primary key,
    student_id integer references students(student_id),
    course_id integer references courses(course_id),
    attendance_percent integer
);

create table CurriculumItems (
    curriculum_item_id serial primary key,
    curriculum_id integer references curriculums(curriculum_id),
    course_id integer references courses(course_id),
    semester_id integer references semesters(semester_id),
    is_required boolean,
    semester_number integer,
    course_category varchar(255)
);

create table ScheduleSlots (
    schedule_slot_id serial primary key,
    course_section_id integer references course_sections(course_section_id),
    cabinet_id integer references cabinets(cabinet_id),
    day_of_week varchar(255),
    schedule_start_time time,
    schedule_end_time time
);

create table Enrollments (
    enrollment_id serial primary key,
    student_id integer references students(student_id),
    course_section_id integer references course_sections(course_section_id),
    prefinal_grade float,
    final_grade float,
    letter_grade varchar(3),
    enrollment_status varchar(30)
);