drop table if exists customers, orders;
create table customers (
	customer_id int not null,
	customer_name text not null,
	order_id int
);
create table orders(
	order_id int primary key,
	customer_id int not null,
	order_date date not null
);
insert into customers (customer_id, customer_name, order_id) values
(1, 'David', 1);
insert into customers (customer_id, customer_name) values
(2, 'Bob');
insert into customers (customer_id, customer_name, order_id) values
(3, 'Test', 2),
(4, 'Marry', 3),
(1, 'David', 4),
(5, 'Clare', 5);
insert into orders (order_id, customer_id, order_date) values
(1, 1, '2020-08-08'),
(2, 3, '2020-08-08'),
(3, 4, '2020-08-09'),
(4, 1, '2020-08-09'),
(5, 5, '2020-08-10');
-- select * from customers;
select customers.customer_name, count(customers.customer_id) as order_count
from customers
left join orders on customers.order_id = orders.order_id
where customers.customer_name not like 'Test'
group by customers.customer_name;