drop database if exists Library
create database Library
use Library
drop table if exists book
create table Book(
	book_id int primary key identity,
	title varchar(250) not null,
	author varchar(100) not null,
	published_year int
)
drop table if exists member
create table member(
	member_id int primary key identity,
	name varchar(100) not null,
	email varchar(100) default 'unknown',
	phone_number varchar(100) not null
)
drop table if exists loan
create table loan(
	loan_id int primary key identity,
	book_id int foreign key references book(book_id),
	member_id int foreign key references member(member_id),
	loan_date date not null,
	return_date date null
)
insert into Book(title, author, published_year)
values
	('nice book','nice author',1234),
	('good book','good author',2345)
insert into member(name, email, phone_number)
values
	('John','unknown','12345678'),
	('Caleb','caleb@gmail.com','12344456')
insert into loan(book_id, member_id, loan_date, return_date)
values
	(1,2,'2025-04-11',null),
	(2,1,'2025-04-11',null)
select * from book
select * from member
select * from  loan
