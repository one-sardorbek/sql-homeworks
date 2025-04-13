use mySql

create table test_identity(
	id int identity,
	something int 
)

insert into test_identity(something)
values(1)
insert into test_identity(something)
values(2)
insert into test_identity(something)
values(3)
insert into test_identity(something)
values(4)
insert into test_identity(something)
values(5)
delete test_identity
delete test_identity where id=2;
truncate table test_identity;
drop table test_identity;

select * from test_identity;

-- if we use delete the inserted values will be vanished but all the commands are remained for example after i use delete and insert new value to somthing its id will be 6
-- if we use truncate it will delete all the things in the table including used commands for example after i use truncate and insert new value to somthing its id will be 1
-- drop will delete table itself, in the database there is table named test_identity after i use drop that table