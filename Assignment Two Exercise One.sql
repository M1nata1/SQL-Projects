drop table if exists products;
create table products(
	product_id int not null,
	product_date date not null,
	revenue_in_dollar int not null
);
insert into products (product_id, product_date, revenue_in_dollar) values
(1, '2020-08-08', 20300),
(2, '2020-08-08', 10900),
(3, '2020-08-08', 15900),
(4, '2020-08-08', 12400),
(5, '2020-08-08', 10000),
(1, '2020-08-09', 20600),
(2, '2020-08-09', 13900),
(3, '2020-08-09', 19900),
(4, '2020-08-09', 9400),
(5, '2020-08-09', 3900),
(1, '2020-08-10', 24300),
(2, '2020-08-10', 8900),
(3, '2020-08-10', 19900),
(4, '2020-08-10', 8000),
(5, '2020-08-10', 7000);
-- select * from products;
-- select * from products
-- order by revenue_in_dollar desc
-- limit 5;

-- select * from products
-- order by product_date desc, revenue_in_dollar desc
-- limit 5;