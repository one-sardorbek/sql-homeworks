use mySql
drop table if exists orders
CREATE TABLE orders(
	order_id int constraint PK_order_id primary key,
	customer_name varchar(100),
	order_date date
)
alter table orders
drop constraint PK_order_id
alter table orders
add constraint PK_orders_id primary key(order_id)