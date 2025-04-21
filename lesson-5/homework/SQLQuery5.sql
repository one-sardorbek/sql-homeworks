create database lesson5
use lesson5
drop table if exists Employees
create table Employees
(
	EmployeeID int,
	Name varchar(50),
	Department varchar(50),
	Salary decimal(10,2),
	HireDate date
)
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Alice Johnson', 'HR', 55000.00, '2018-06-12'),
(2, 'Bob Smith', 'IT', 72000.50, '2019-03-22'),
(3, 'Catherine Lee', 'Finance', 68000.75, '2020-07-15'),
(4, 'David Brown', 'Marketing', 61000.00, '2021-01-10'),
(5, 'Eva Green', 'Sales', 50000.00, '2017-09-30'),
(6, 'Frank White', 'IT', 75000.25, '2022-04-25'),
(7, 'Grace Kim', 'Finance', 66500.00, '2020-11-05'),
(8, 'Harry Wilson', 'HR', 54000.00, '2016-12-01'),
(9, 'Isla Moore', 'Marketing', 63000.00, '2019-08-20'),
(10, 'Jack Taylor', 'Sales', 52000.00, '2018-02-14'),
(11, 'Karen Scott', 'Finance', 70000.00, '2023-01-19'),
(12, 'Leo Adams', 'IT', 77000.00, '2020-06-01'),
(13, 'Mia Turner', 'HR', 56000.00, '2019-11-30'),
(14, 'Nathan King', 'Sales', 51000.00, '2021-05-21'),
(15, 'Olivia Allen', 'Marketing', 64000.00, '2017-10-12'),
(16, 'Paul Baker', 'Finance', 69000.00, '2018-08-15'),
(17, 'Queenie Roberts', 'I', 78000.00, '2023-03-10'),
(18, 'Ryan Carter', 'HR', 53000.00, '2020-01-27'),
(19, 'Sophia Evans', 'Sales', 50500.00, '2022-07-11'),
(20, 'Tom Harris', 'Marketing', 61500.00, '2021-12-03'),
(21, 'Alice John', 'HR', 55000.00, '2018-05-12');
--task1
Select *,
Rank() Over(Order by Salary desc) as SalaryRank
from Employees
--task2
select *,
count(*) over (partition by Salary) as Samae_Salary_Rank
from Employees
where count(*) over (partition by Salary)>1
--task3
with Ranked as(
select *,
Rank() over (partition by Department order by Salary desc) as DeptSalaryRank
from Employees
)
select 
EmployeeID,
Name,
Department,
Salary,
HireDate

from Ranked
where DeptSalaryRank<=2

--task4
with Ranked as(
select *,
Rank() over (partition by Department order by Salary asc) as DeptSalaryRank
from Employees
)
select 
EmployeeID,
Name,
Department,
Salary,
HireDate

from Ranked
where DeptSalaryRank=1

--task5
select *,
sum(Salary) over(partition by Department order by Salary desc) as Sum_runnig
from Employees

--task6

select *,
sum(Salary) over(partition by Department) as Sum_total
from Employees

--task7

select *,
Avg(Salary) over(partition by Department) as AvgSalaryDep
from Employees

--task8
select *,
Avg(Salary) over(partition by Department) as AvgSalaryDep,
Salary-Avg(Salary) over(partition by Department) as diff
from Employees

--task9

SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees;

--task10
with filtered as (
select *
from Employees
order by HireDate desc
offset 0 row fetch next 3 rows only
) 
select *,
sum(Salary) over () as Summ
from filtered

--task11

select*,
avg(Salary) over(order by EmployeeID) as running_avg
from Employees

--task12

--I wont fcking do that

--task13

select*,
sum(salary) over(partition by Department) as DepTotal,
Salary*100/sum(salary) over(partition by Department) as ContributionToDep
from Employees













