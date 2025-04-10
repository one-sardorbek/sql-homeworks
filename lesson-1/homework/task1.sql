Create database mySql
use mySql;
drop table if exists student
create table student(
	id int,
	name varchar(100), 
	age int 
)

ALTER TABLE student
ALTER COLUMN id INT not null;
