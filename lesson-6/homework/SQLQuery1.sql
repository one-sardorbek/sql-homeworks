create database lesson6
use lesson6

create table emp
(
EmployeeID int,
Name varchar(50) not null,
DepartmentID int,
Salary int
)

create table Dep
(
DepartmentID int,
DepartmentName varchar(100)
)

create table projects
(
ProjectID int primary key,
ProjectName varchar(50),
EmployeeID int
)

insert into emp (EmployeeID, Name, DepartmentID, Salary)
values
(1,'Alice',101,60000),
(2,	'Bob',102,70000),
(3,	'Charlie',101,65000),
(4,	'David',103,72000),
(5,	'Eva',NULL,	68000)


insert into Dep values
(101,'IT'),
(102,'HR'),
(103,'Finance'),
(104,'Marketing')

insert into projects values
(1,'Alpha',1),
(2,'Beta',2),
(3,'Gamma',1),
(4,'Delta',4),
(5,'Omega',null)

--TASK 1

select 
emp.*, Dep.DepartmentName
from emp
join Dep
on emp.DepartmentID=Dep.DepartmentID

--TASK 2

select 
*
from emp as e
left join Dep as d
on e.DepartmentID=d.DepartmentID

--TASK 3 


select 
*
from emp as e
right join Dep as d
on e.DepartmentID=d.DepartmentID

--Task 4

select 
*
from emp as e
full outer join Dep as d
on e.DepartmentID=d.DepartmentID

--TASK 5

Select 
d.DepartmentName,
sum(e.salary) as total_salary
from Dep as d
left join emp as e
on e.DepartmentID=d.DepartmentID
group by d.DepartmentName
order by d.DepartmentName

--TASK 6

select
*
from Dep as d
cross join projects as p

--TASK 7

select 
e.Name, d.DepartmentName, p.ProjectName
from emp as e
left join Dep as d
on d.DepartmentID=e.DepartmentID
left join projects as p
on e.EmployeeID=p.EmployeeID
