drop table if exists employee, department;
create table employee (
	employee_id int not null primary key,
	salary int not null,
	department_id int not null
);
create table department (
	department_id int not null primary key,
	department_name text not null
);
insert into employee (employee_id, salary, department_id) values 
(1, 20000, 1),
(2, 22500, 2),
(3, 10000, 3),
(4, 8700, 4),
(5, 39800, 5),
(6, 5670, 6),
(7, 30000, 1),
(8, 23800, 2),
(9, 15680, 3),
(10, 9560, 4),
(11, 36900, 5),
(12, 4380, 6);

insert into department (department_id, department_name) values
(1, 'Human Resources'),
(2, 'IT'),
(3, 'Accounting and Finance'),
(4, 'Marketing'),
(5, 'Research and Development'),
(6, 'Production'); 

select department.department_name, 
       avg(employee.salary) as average_salary
from department
inner join employee on department.department_id = employee.department_id
group by department.department_name
order by average_salary desc;