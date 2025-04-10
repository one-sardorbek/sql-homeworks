use mySql
create table category(
	category_id int primary key,
	category_name varchar(100)
)
create table item(
	item_id int primary key,
	item_name varchar(250),
	category_id int constraint FK_category_id foreign key references category(category_id)
)
alter table item
drop constraint FK_category_id
alter table item
add constraint FK_category_id foreign key(category_id) references category(category_id)