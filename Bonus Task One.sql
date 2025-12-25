drop table if exists books, authors, publishers, orders cascade;
create table books (
    book_id serial primary key,
    book_title text not null
);

create table authors (
    author_id serial primary key,
    author_name text not null,
    book_id int not null references books(book_id)
);

create table publishers (
    publisher_id serial primary key,
    publisher_name text not null,
    author_id int not null references authors(author_id)
);

create table orders (
    order_id serial primary key,
    customer_name text not null,
    order_date date not null,
    book_id int not null references books(book_id)
);

insert into books (book_id, book_title) values
(1, 'the great gatsby'),
(2, 'to kill a mockingbird'),
(3, '1984'),
(4, 'pride and prejudice'),
(5, 'the catcher in the rye');

insert into authors (author_id, author_name, book_id) values
(1, 'f. scott fitzgerald', 1),
(2, 'harper lee', 2),
(3, 'george orwell', 3),
(4, 'jane austen', 4),
(5, 'j.d. salinger', 5);

insert into publishers (publisher_id, publisher_name, author_id) values
(1, 'scribner', 1),
(2, 'harpercollins', 2),
(3, 'penguin books', 3),
(4, 'vintage books', 4),
(5, 'random house', 5);

insert into orders (order_id, customer_name, order_date, book_id) values
(1, 'john doe', '2023-01-15', 1),
(2, 'jane smith', '2023-02-22', 2),
(3, 'bob johnson', '2023-03-10', 3),
(4, 'alice williams', '2023-04-05', 4),
(5, 'charlie brown', '2023-05-20', 5);

select orders.customer_name, authors.author_name, books.book_title, publishers.publisher_name
from orders
join books on orders.book_id = books.book_id
join authors on books.book_id = authors.book_id
join (
	select publisher_id, publisher_name, author_id
	from publishers
	where publisher_name like 'scribner'
) as publishers on authors.author_id = publishers.author_id

-- Books (book_id) -> Orders (book_id)
-- Books (book_id) -> Authors (book_id) -- Authors(author_id) -> Publishers(author_id)

