use mySql
create table customer(
	customer_id int primary key,
	name varchar(250),
	city varchar(250) constraint DC_city default 'Unknown'
)
alter table customer
drop DC_city
alter table customer
add constraint DC_city default 'Unknown' for city
