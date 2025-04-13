drop table if exists student
create table student(
	id int primary key identity,
	classes int,
	tuition_per_class decimal(10,2),
	total_tuition as (classes * tuition_per_class)
)
insert into student(classes,tuition_per_class)
values
(1,12000),
(3,1300),
(4,450)
select * from student