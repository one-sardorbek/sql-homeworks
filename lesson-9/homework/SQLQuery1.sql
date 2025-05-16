create database lesson9
use lesson9


-- TASK 1

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

with cte as (
	select e.EmployeeID,m.ManagerID
	from Employees e
	join Employees m
	on e.ManagerID=m.EmployeeID
	union all
	select e.EmployeeID,m.ManagerID
	from cte e
	join Employees m
	on e.ManagerID=m.EmployeeID
	
)
select t2.*,count(t2.ManagerID) as Depth
from cte t1
right join Employees t2
on t1.EmployeeID=t2.EmployeeID 
group by t2.EmployeeID,t2.ManagerID,t2.JobTitle;

-- TASK 2

with fac as (

	select 1 as Num,
	cast(1 as bigint) as Factorial
	union all
	select Num+1 as Num, cast((Num+1) * Factorial as bigint)
	from fac
	where Num<10 -- for 10 numbers (can be adjusted) 

)
select * from fac

-- TASK 3 

;with fib as (

	SELECT 0 AS n, CAST(0 AS BIGINT) AS Fibonacci_Number
    UNION ALL
    SELECT 1 AS n, CAST(1 AS BIGINT) AS Fibonacci_Number
    UNION ALL
	select
	f1.n+1,
	cast(f1.Fibonacci_Number+f2.Fibonacci_Number as bigint)
	from fib as f1
	join fib as f2 on f1.n=f2.n-1
	where n<10
)
select * from fib