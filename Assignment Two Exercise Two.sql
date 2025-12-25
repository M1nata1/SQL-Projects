drop table if exists employee_salary;
create table employee_salary (
	employee_id int not null primary key,
	department_id int not null,
	salary_in_dollar int not null
);
insert into employee_salary (employee_id, department_id, salary_in_dollar) values 
(1, 1, 9000),
(2, 1, 8000),
(3, 1, 10000),
(4, 1, 8700),
(6, 2, 5600),
(7, 2, 3400),
(8, 2, 7800),
(9, 2, 6500),
(10, 3, 10000),
(11, 3, 12700),
(12, 3, 15300),
(13, 3, 16700),
(14, 3, 9800);
select * from employee_salary;
select department_id, 
avg(salary_in_dollar) as average_salary_of_departments 
from employee_salary
group by department_id
order by average_salary_of_departments desc;
