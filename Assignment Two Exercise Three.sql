drop table if exists monthly_sales;
create table monthly_sales (
	year int not null,
	month text not null,
	total_sales_in_dollar int not null,
	region text not null
);
insert into monthly_sales (year, month, total_sales_in_dollar, region) values
(2022, 'March', 20000, 'USA'),
(2022, 'March', 30000, 'Canada'),
(2022, 'March', 17600, 'Russia'),
(2022, 'March', 10000, 'Kazakhstan'),
(2023, 'April', 30000, 'USA'),
(2023, 'April', 56000, 'Canada'),
(2023, 'April', 20000, 'Russia'),
(2023, 'April', 15600, 'Kazakhstan'),
(2024, 'May', 19600, 'USA'),
(2024, 'May', 21450, 'Canada'),
(2024, 'May', 15800, 'Russia'),
(2024, 'May', 18600, 'Kazakhstan');
-- select * from monthly_sales;
-- select region, sum(total_sales_in_dollar) as total_sales_in_dollar
-- from monthly_sales
-- group by region
-- order by total_sales_in_dollar;

-- select month, sum(total_sales_in_dollar) as total_sales_in_dollar
-- from monthly_sales
-- group by month
-- order by total_sales_in_dollar;

-- select year, sum(total_sales_in_dollar) as total_sales_in_dollar
-- from monthly_sales
-- group by year
-- order by total_sales_in_dollar;

-- select year, month, region, sum(total_sales_in_dollar) as total_sales_in_dollar
-- from monthly_sales
-- group by region, year, month
-- order by total_sales_in_dollar;
