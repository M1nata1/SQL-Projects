drop table if exists customers, orders, order_items, products, categories cascade;
create table customers (
	customer_id int primary key,
	customer_name text not null,
	email text not null,
	phone text not null
);

create table orders (
	order_id int primary key,
	customer_id int not null,
	order_date date not null,
	total_amount numeric not null
);

create table order_items (
	order_item_id int primary key,
	order_id int not null,
	product_id int not null,
	quantity int not null,
	unit_price numeric not null
);

create table products (
	product_id int primary key,
	product_name text not null,
	category_id int not null,
	description text not null
);

create table categories (
	category_id int primary key,
	category_name text
);

insert into customers (customer_id, customer_name, email, phone) values
  (1, 'John Doe', 'john.doe@example.com', '123-456-7890'),
  (2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210'),
  (3, 'Alice Johnson', 'alice.johnson@example.com', '555-555-5555'),
  (4, 'Bob Williams', 'bob.williams@example.com', '777-777-7777'),
  (5, 'Emily Davis', 'emily.davis@example.com', '888-888-8888'),
  (6, 'Michael Brown', 'michael.brown@example.com', '666-666-6666'),
  (7, 'Sarah Wilson', 'sarah.wilson@example.com', '444-444-4444'),
  (8, 'David Lee', 'david.lee@example.com', '222-222-2222'),
  (9, 'Linda Miller', 'linda.miller@example.com', '999-999-9999'),
  (10, 'William Jones', 'william.jones@example.com', '333-333-3333');
  
insert into orders (order_id, customer_id, order_date, total_amount) values
  (1, 1, '2023-11-01', 100.00),
  (2, 2, '2023-11-02', 150.50),
  (3, 3, '2023-11-03', 75.25),
  (4, 4, '2023-11-04', 200.00),
  (5, 5, '2023-11-05', 50.75),
  (6, 1, '2023-11-06', 85.00),
  (7, 2, '2023-11-07', 120.25),
  (8, 3, '2023-11-08', 175.50),
  (9, 4, '2023-11-09', 95.75),
  (10, 5, '2023-11-10', 60.00);
  
insert into order_items (order_item_id, order_id, product_id, quantity, unit_price) values
  (1, 1, 101, 2, 25.00),
  (2, 2, 102, 3, 15.50),
  (3, 3, 103, 1, 50.25),
  (4, 4, 104, 4, 10.00),
  (5, 5, 105, 2, 12.75),
  (6, 1, 102, 2, 15.00),
  (7, 2, 103, 3, 20.25),
  (8, 3, 104, 2, 9.75),
  (9, 4, 105, 5, 14.00),
  (10, 5, 101, 3, 22.00);
  
insert into products (product_id, product_name, category_id, description) values
  (101, 'Smartphone X', 1, 'A high-end smartphone with advanced features.'),
  (102, 'Laptop Pro', 1, 'Powerful laptop for professional use.'),
  (103, 'T-shirt', 2, 'Comfortable cotton T-shirt in various colors.'),
  (104, 'Garden Tools Kit', 3, 'Complete set of gardening tools for enthusiasts.'),
  (105, 'Bestseller Novel', 4, 'New York Times bestseller novel by a renowned author.'),
  (106, 'LEGO City Set', 5, 'Build your own city with this LEGO set.'),
  (107, 'Outdoor Adventure Gear', 6, 'Gear for hiking, camping, and outdoor activities.'),
  (108, 'Skincare Bundle', 7, 'A bundle of skincare products for a healthy skin regimen.'),
  (109, 'Car Maintenance Kit', 8, 'Essential tools and products for car maintenance.'),
  (110, 'Acoustic Guitar', 9, 'A high-quality acoustic guitar for music enthusiasts.');

  
insert into categories (category_id, category_name) values
  (1, 'Electronics'),
  (2, 'Clothing'),
  (3, 'Home and Garden'),
  (4, 'Books'),
  (5, 'Toys'),
  (6, 'Sports and Outdoors'),
  (7, 'Beauty and Personal Care'),
  (8, 'Automotive'),
  (9, 'Music'),
  (10, 'Health and Wellness');
  
select customers.customer_id, customers.customer_name
from customers
where customer_id = (
	select customer_id
	from orders
	group by customer_id
	order by count(order_id) desc
	limit 1
);

select product_id, product_name
from products
where product_id = (
	select product_id 
	from order_items
	group by product_id
	order by sum(quantity) desc
	limit 1
);

select product_id, product_name
from products
where product_id = (
	select product_id
	from order_items
	group by product_id
	order by sum(unit_price * quantity) desc
	limit 1
);

select sum(total_amount) as revenue
from orders
where customer_id = (
	select customer_id 
	from orders
	group by customer_id
	order by count(order_id) desc
	limit 1
);

  
  