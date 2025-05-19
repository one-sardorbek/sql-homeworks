create database lesson11
use lesson11 


-- TASK 1

create table Employees(

	EmployeeId int primary key,
	Name varchar(50),
	Department varchar(50),
	Salary int

) 

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES 
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);

create table #EmployeeTransfers(

	EmployeeId int primary key,
	Name varchar(50),
	Department varchar(50),
	Salary int

) 

insert into  #EmployeeTransfers
select EmployeeId,Name,
case 
	when Department='HR' then 'IT'
	when Department='IT' then 'Sales'
	else 'HR'  end as Department,
Salary
from Employees

select * from #EmployeeTransfers

--TASK 2

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);


INSERT INTO Orders_DB1 (OrderID, CustomerName, Product, Quantity)
VALUES 
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);


CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity)
VALUES 
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

declare @MissingOrders table (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
)
insert into @MissingOrders
select *
from Orders_DB1
where OrderID not in (
	select OrderID
	from Orders_DB2
)

select *
from @MissingOrders


-- TASK 3

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);
INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked)
VALUES 
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

create view vw_MonthlyWorkSummary as 
select distinct 
	e.EmployeeID,
	e.EmployeeName,
	e.Department,
	sum(HoursWorked) over (partition by EmployeeID) TotalHoursWorked,
	d.TotalHoursDepartment,
	d.AvgHoursDepartment
from WorkLog as e
join
(select Department,
		sum(HoursWorked) TotalHoursDepartment,
		avg(HoursWorked * 1.0) AvgHoursDepartment
	from WorkLog
	group by Department
) as d
on e.Department=d.Department

select * from vw_MonthlyWorkSummary



