use mySql
drop table if exists product;
create table product(
	product_id int constraint UC_product_id unique,
	product_name varchar(250),
	price float 
)
ALTER TABLE product
drop constraint UC_product_id;
ALTER TABLE product
add  constraint UC_product_id unique(product_id)
ALTER TABLE product
add  constraint UC_comb_id_name unique(product_id,product_name)
