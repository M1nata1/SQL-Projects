drop table if exists Employees, Departments, Jobs, Salaries, Managers, Locations, Countries cascade;

create table Countries (
	country_id serial primary key,
	country_name text not null,
	country_language text not null,
	country_currency text not null
);

create table Locations (
	location_id serial primary key,
	location_name text not null,
	location_description text not null,
	country_id int not null,
	foreign key (country_id) references Countries(country_id)
);

create table Salaries (
	salary_id serial primary key,
	employee_id int not null,
	salary_amount int not null,
	payment_method text not null -- on card or in cash
);

create table Departments (
	department_id serial primary key,
	department_name text not null,
	department_role text not null,
	location_id int not null,
	foreign key (location_id) references Locations(location_id)
);

create table Managers (
	manager_id serial primary key,
	first_name text not null,
	last_name text not null,
	manager_salary int not null,
	department_id int not null,
	foreign key (department_id) references Departments(department_id)
);

create table Employees (
	employee_id serial primary key,
	name text not null,
	surname text not null,
	salary_id int not null,
	foreign key (salary_id) references Salaries(salary_id)
);

create table Jobs (
	job_id serial primary key,
	job_title text not null,
	job_description text not null,
	department_id int not null,
	employee_id int not null,
	foreign key (department_id) references Departments(department_id),
	foreign key (employee_id) references Employees(employee_id)
);

insert into Countries (country_name, country_language, country_currency) values 
    ('United States', 'English', 'USD'),
    ('Canada', 'English and French', 'CAD'),
    ('United Kingdom', 'English', 'GBP'),
    ('Germany', 'German', 'EUR'),
    ('France', 'French', 'EUR'),
	('Kazakhstan', 'Kazakh', 'KZT');
	
insert into Locations (location_name, location_description, country_id) values
    ('New York', 'The city that never sleeps', 1),
    ('Toronto', 'Canada''s largest city', 2),
    ('London', 'Capital of the United Kingdom', 3),
    ('Berlin', 'Germany''s capital and largest city', 4),
    ('Paris', 'City of Love and Light', 5),
	('Almaty', 'City of apples', 6);

insert into Salaries (employee_id, salary_amount, payment_method) values
    (1, 75000, 'On card'),
    (2, 60000, 'On card'),
    (3, 55000, 'On card'),
    (4, 70000, 'In cash'),
    (5, 80000, 'On card'),
    (6, 65000, 'In cash');
	
insert into Departments (department_name, department_role, location_id) values
    ('Human Resources', 'HR Management', 1),
    ('Sales', 'Sales Team', 2),
    ('Customer Service', 'Customer Support', 3),
    ('Finance', 'Finance Department', 4),
    ('Information Technology', 'IT Department', 5),
    ('Marketing', 'Marketing Team', 6);
	
insert into Managers (first_name, last_name, manager_salary, department_id) values
    ('John', 'Smith', 80000, 1),
    ('Mary', 'Johnson', 75000, 2),
    ('David', 'Brown', 72000, 3),
    ('Sarah', 'Wilson', 85000, 4),
    ('Michael', 'Davis', 90000, 5),
    ('Jennifer', 'Lee', 82000, 5);
	
insert into Employees (name, surname, salary_id) values
    ('Alice', 'Johnson', 1),
    ('Bob', 'Smith', 2),
    ('Catherine', 'Williams', 3),
    ('Daniel', 'Miller', 4),
    ('Ella', 'Brown', 5),
    ('Frank', 'Wilson', 6);

insert into Jobs (job_title, job_description, department_id, employee_id) values
    ('Manager', 'Management role', 1, 1),
    ('Sales Associate', 'Sales team member', 2, 2),
    ('Customer Service Representative', 'Customer support role', 3, 3),
    ('Accountant', 'Finance department role', 4, 4),
    ('IT Specialist', 'IT department role', 5, 5),
    ('Marketing Coordinator', 'Marketing team role', 6, 6);
	
-- List all employees who have never changed their job.
select Employees.name, Employees.surname, count(Jobs.employee_id) as total_count
from Employees
join Jobs on Employees.employee_id = Jobs.employee_id
group by Employees.employee_id
having count(Jobs.employee_id) <= 1;

-- Find the average salary for each department.
select Departments.department_name, avg (Salaries.salary_amount) as average_salary
from Departments
join Jobs on Departments.department_id = Jobs.department_id
join Employees on Jobs.employee_id = Employees.employee_id
join Salaries on Employees.salary_id = Salaries.salary_id
group by Departments.department_id
order by average_salary desc;

-- Identify the employees who have had the most managers.
select Employees.name, Employees.surname, count(Managers.department_id) as total_count_of_managers
from Employees
join Jobs on Employees.employee_id = Jobs.employee_id
join Departments on Jobs.department_id = Departments.department_id
join Managers on Departments.department_id = Managers.department_id
group by Employees.employee_id
order by total_count_of_managers desc;

-- List the employees who have the same job title but different salaries in the same department.
select Employees.name, Employees.surname
from Employees
join Jobs on Employees.employee_id = Jobs.employee_id
join Departments on Jobs.department_id = Departments.department_id
join Salaries on Employees.salary_id = Salaries.salary_id
where (Jobs.job_title, Departments.department_id) in (
	select Jobs.job_title, Jobs.department_id
	from Jobs
	group by Jobs.job_title, Job.department_id
having count(distinct Salaries.salary_id) > 1)
order by Departments.department_name, Jobs.job_title, Employees.name, Employees.surname;