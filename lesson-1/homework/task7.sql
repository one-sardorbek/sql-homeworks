use mySql
drop table if exists invoice;
create table invoice(
	invoice_id int identity,
	amount float
)
insert into invoice
values
	(11),
	(12),
	(13.4),
	(14),
	(15.6)
SET IDENTITY_INSERT invoice ON
insert into invoice(invoice_id,amount)
values (100,16.3)

SET IDENTITY_INSERT invoice OFF

select * from invoice
