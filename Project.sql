drop table if exists Products, Categories, ArrivedProducts, Warehouse, DeadProducts;
drop trigger if exists arrive_products on ArrivedProducts;
drop function if exists arrive_products_function();
drop trigger if exists dead_products on DeadProducts;
drop function if exists dead_products_function();
create table Categories (
	id int primary key,
	name text not null,
	description text not null
);

create table Products (
	id int primary key,
	name text not null,
	price int not null,
	category_id int not null,
	foreign key (category_id) references Categories(id)
);

create table ArrivedProducts (
	arrive_id int primary key,
	product_id int not null,
	arrive_date date not null,
	count int not null,
	foreign key (product_id) references Products(id)
);

create table Warehouse (
	product_id int unique not null,
	count int not null,
	foreign key (product_id) references Products(id)
);

create table DeadProducts (
	dead_id int primary key,
	product_id int not null,
	dead_date date not null,
	count int not null,
	foreign key (product_id) references Products(id)
);

create or replace function arrive_products_function()
returns trigger as $$
begin
insert INTO WareHouse(product_id, count)
VALUES(new.product_id, new.count)
ON CONFLICT(product_id) DO UPDATE
SET count = WareHouse.count + EXCLUDED.count;
	
	return new;
end;
$$ language plpgsql;

create trigger arrive_products 
after insert on ArrivedProducts
for each row
execute function arrive_products_function();

create or replace function dead_products_function()
returns trigger as $$
begin
    update Warehouse 
    set product_id = new.product_id, count = count - new.count
    where product_id = new.product_id and count >= new.count;
   
    return new;
end;
$$ language plpgsql;

create trigger dead_products
after insert on DeadProducts
for each row
execute function dead_products_function();

insert into Categories (id, name, description) values
    (1, 'Electronics', 'Electronic devices and gadgets'),
    (2, 'Furniture', 'Office and home furniture'),
    (3, 'Office Supplies', 'Printer, scanner, etc.'),
    (4, 'Appliances', 'Kitchen appliances'),
    (5, 'Audio', 'Audio devices and accessories'),
    (6, 'Sportswear', 'Clothing for sports activities'),
    (7, 'Accessories', 'Fashion accessories'),
    (8, 'Books', 'Literature and educational material'),
    (9, 'Toys', 'Children toys'),
    (10, 'Home Decor', 'Decorative items for home'),
    (11, 'Footwear', 'Various types of shoes'),
    (12, 'Bags', 'Bags and backpacks'),
    (13, 'Eyewear', 'Glasses and sunglasses'),
    (14, 'Watches', 'Timepieces and wristwatches'),
    (15, 'Fitness Equipment', 'Exercise and fitness gear');
	
insert into Products (id, name, price, category_id) values
    (1, 'Laptop', 1000, 1),
    (2, 'Smartphone', 500, 2),
    (3, 'Tablet', 300, 3),
    (4, 'Desk Chair', 150, 4),
    (5, 'Office Desk', 200, 5),
    (6, 'Printer', 120, 6),
    (7, 'Scanner', 80, 7),
    (8, 'Coffee Maker', 50, 8),
    (9, 'Toaster', 30, 9),
    (10, 'Bluetooth Speaker', 70, 10),
    (11, 'Headphones', 100, 11),
    (12, 'Running Shoes', 80, 12),
    (13, 'Backpack', 40, 13),
    (14, 'Sunglasses', 25, 14),
    (15, 'Watch', 150, 15);
	
insert into ArrivedProducts (arrive_id, product_id, arrive_date, count) values
    (1, 1, '2023-01-10', 150),
    (2, 3, '2023-02-15', 30),
    (3, 1, '2023-03-20', 20),
    (4, 1, '2023-04-25', 15),
    (5, 9, '2023-05-30', 25),
    (6, 11, '2023-06-05', 40),
    (7, 13, '2023-07-10', 10),
    (8, 15, '2023-08-15', 5),
    (9, 2, '2023-09-20', 60),
    (10, 3, '2023-10-25', 35),
    (11, 6, '2023-11-30', 18),
    (12, 8, '2023-12-05', 8),
    (13, 10, '2024-01-10', 22),
    (14, 12, '2024-02-15', 15),
    (15, 14, '2024-03-20', 12);
	
insert into DeadProducts (dead_id, product_id, dead_date, count) values
    (1, 1, '2024-04-01', 0),
    (2, 3, '2024-04-02', 8),
    (16, 5, '2024-04-03', 12),
    (17, 7, '2024-04-04', 7),
    (18, 9, '2024-04-05', 10),
    (19, 11, '2024-04-06', 15),
    (20, 13, '2024-04-07', 3),
    (21, 15, '2024-04-08', 9),
    (22, 2, '2024-04-09', 6),
    (23, 4, '2024-04-10', 4),
    (24, 6, '2024-04-11', 11),
    (25, 8, '2024-04-12', 8),
    (26, 10, '2024-04-13', 14),
    (27, 12, '2024-04-14', 5),
    (28, 14, '2024-04-15', 2),
    (29, 15, '2024-04-16', 7),
    (30, 15, '2024-04-17', 9);
	
select * from WareHouse
order by product_id asc;