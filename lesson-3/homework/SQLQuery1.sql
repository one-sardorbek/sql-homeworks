create database lesson3;
use lesson3;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'John', 'Doe', 'HR', 55000.00, '2018-06-15'),
(2, 'Jane', 'Smith', 'IT', 72000.00, '2019-03-22'),
(3, 'Alice', 'Johnson', 'Finance', 68000.00, '2020-01-10'),
(4, 'Robert', 'Brown', 'Marketing', 60000.00, '2021-09-01'),
(5, 'Emily', 'Davis', 'IT', 75000.00, '2017-11-30'),
(6, 'Michael', 'Wilson', 'Finance', 70000.00, '2016-05-25'),
(7, 'Sarah', 'Miller', 'HR', 54000.00, '2022-02-14'),
(8, 'David', 'Anderson', 'Sales', 63000.00, '2020-08-17'),
(9, 'Laura', 'Thomas', 'IT', 80000.00, '2019-07-07'),
(10, 'Daniel', 'Taylor', 'Marketing', 59000.00, '2021-01-12'),
(11, 'Emma', 'Moore', 'HR', 56000.00, '2023-04-01'),
(12, 'James', 'Jackson', 'Sales', 64000.00, '2020-10-10'),
(13, 'Olivia', 'White', 'Finance', 71000.00, '2018-03-05'),
(14, 'William', 'Harris', 'IT', 79000.00, '2016-12-22'),
(15, 'Sophia', 'Martin', 'Marketing', 61000.00, '2017-06-06'),
(16, 'Benjamin', 'Thompson', 'Sales', 62000.00, '2019-09-09'),
(17, 'Isabella', 'Garcia', 'HR', 57000.00, '2022-11-11'),
(18, 'Logan', 'Martinez', 'Finance', 69000.00, '2021-04-18'),
(19, 'Mia', 'Robinson', 'IT', 77000.00, '2023-05-20'),
(20, 'Ethan', 'Clark', 'Marketing', 60500.00, '2020-02-28'),
(21, 'Ava', 'Rodriguez', 'HR', 58500.00, '2020-12-05'),
(22, 'Lucas', 'Wright', 'Finance', 72000.00, '2018-08-01'),
(23, 'Charlotte', 'Martinez', 'Sales', 63000.00, '2021-03-25'),
(24, 'Mason', 'Young', 'IT', 65000.00, '2022-04-07'),
(25, 'Amelia', 'Walker', 'Finance', 78000.00, '2021-07-22'),
(26, 'Oliver', 'Perez', 'Marketing', 62000.00, '2019-10-30'),
(27, 'Liam', 'Hill', 'IT', 71000.00, '2018-12-18'),
(28, 'Ella', 'Scott', 'HR', 59000.00, '2020-09-12'),
(29, 'Jack', 'Adams', 'Sales', 66000.00, '2022-01-19'),
(30, 'Harper', 'Nelson', 'Finance', 68000.00, '2023-02-10'),
(31, 'Samuel', 'Carter', 'Marketing', 59500.00, '2017-05-11'),
(32, 'Archer', 'Green', 'HR', 62000.00, '2021-12-05'),
(33, 'Grace', 'Baker', 'IT', 72000.00, '2022-03-03'),
(34, 'Chloe', 'Gonzalez', 'Finance', 71000.00, '2020-11-15'),
(35, 'Matthew', 'Evans', 'Sales', 65000.00, '2018-09-02'),
(36, 'Henry', 'King', 'IT', 75000.00, '2021-06-18'),
(37, 'Zoe', 'Lopez', 'Finance', 69000.00, '2017-10-20'),
(38, 'Daniel', 'Hill', 'HR', 58000.00, '2022-06-12'),
(39, 'Wyatt', 'Bennett', 'Sales', 62000.00, '2021-11-07'),
(40, 'Caroline', 'Moore', 'Marketing', 60500.00, '2020-07-25'),
(41, 'Carter', 'Young', 'IT', 74000.00, '2021-01-05'),
(42, 'Victoria', 'Baker', 'Finance', 75000.00, '2023-04-14'),
(43, 'Lily', 'Hall', 'HR', 57000.00, '2022-02-22'),
(44, 'Benjamin', 'Campbell', 'Sales', 64000.00, '2022-11-01'),
(45, 'Ryan', 'Green', 'IT', 67000.00, '2018-04-25'),
(46, 'Scarlett', 'Baker', 'Finance', 69000.00, '2017-09-05'),
(47, 'Jackson', 'Lopez', 'HR', 62000.00, '2020-11-18'),
(48, 'Grace', 'Morris', 'Sales', 67000.00, '2023-03-30'),
(49, 'Mason', 'Martinez', 'IT', 75000.00, '2021-12-05'),
(50, 'Ella', 'Harris', 'Finance', 68000.00, '2019-04-14'),
(51, 'Owen', 'Allen', 'HR', 57000.00, '2022-01-06'),
(52, 'Jack', 'Taylor', 'Sales', 64000.00, '2020-10-02'),
(53, 'Avery', 'Wilson', 'IT', 74000.00, '2022-07-15'),
(54, 'Peyton', 'Davis', 'Finance', 72000.00, '2018-06-17'),
(55, 'Sophia', 'Thomas', 'HR', 59000.00, '2021-04-22'),
(56, 'Daniel', 'Moore', 'Sales', 65000.00, '2019-08-07'),
(57, 'Aiden', 'Walker', 'Finance', 75000.00, '2020-12-28'),
(58, 'Harper', 'Rodriguez', 'HR', 58000.00, '2017-12-10'),
(59, 'James', 'Wilson', 'IT', 76000.00, '2018-08-05'),
(60, 'Olivia', 'Adams', 'Sales', 67000.00, '2020-11-22'),
(61, 'Lucas', 'White', 'Finance', 70000.00, '2022-09-30'),
(62, 'Charlotte', 'Young', 'HR', 55000.00, '2021-05-03'),
(63, 'Mason', 'Thomas', 'Sales', 63000.00, '2021-07-18'),
(64, 'Ethan', 'Davis', 'IT', 71000.00, '2020-01-01'),
(65, 'Olivia', 'Carter', 'Marketing', 62000.00, '2017-02-10'),
(66, 'William', 'King', 'HR', 58000.00, '2019-09-11'),
(67, 'Scarlett', 'Nelson', 'Sales', 67000.00, '2021-08-02'),
(68, 'Jack', 'Thompson', 'Finance', 71000.00, '2023-02-06'),
(69, 'Chloe', 'Harris', 'IT', 77000.00, '2019-07-14'),
(70, 'Benjamin', 'Adams', 'HR', 56000.00, '2022-04-08'),
(71, 'Samuel', 'Brown', 'Finance', 68000.00, '2020-10-25'),
(72, 'Liam', 'Wilson', 'Marketing', 64000.00, '2021-09-01'),
(73, 'Victoria', 'Clark', 'Sales', 65000.00, '2022-05-17'),
(74, 'Matthew', 'Baker', 'IT', 73000.00, '2018-11-14'),
(75, 'Eleanor', 'Young', 'Finance', 72000.00, '2021-12-11'),
(76, 'Eli', 'Scott', 'HR', 60000.00, '2022-06-13'),
(77, 'Eve', 'Martin', 'Sales', 69000.00, '2021-10-02'),
(78, 'Sophie', 'Davis', 'IT', 75000.00, '2020-03-10'),
(79, 'Zoe', 'Parker', 'Finance', 72000.00, '2022-01-12'),
(80, 'William', 'Lee', 'HR', 58000.00, '2021-04-16'),
(81, 'Jackson', 'Gonzalez', 'IT', 69000.00, '2018-09-25'),
(82, 'Benjamin', 'Evans', 'Sales', 65000.00, '2021-11-14'),
(83, 'Amelia', 'Wright', 'Finance', 74000.00, '2022-03-30'),
(84, 'Charlotte', 'Brown', 'HR', 57000.00, '2020-07-05'),
(85, 'Jack', 'Thomas', 'IT', 76000.00, '2019-10-15'),
(86, 'Lillian', 'Taylor', 'Sales', 66000.00, '2022-01-07'),
(87, 'Logan', 'Lee', 'HR', 59000.00, '2021-12-09'),
(88, 'Emma', 'Carter', 'Finance', 75000.00, '2020-04-19'),
(89, 'Mason', 'Parker', 'Marketing', 63000.00, '2021-08-23'),
(90, 'Ava', 'Gonzalez', 'Sales', 67000.00, '2022-10-05'),
(91, 'Matthew', 'Evans', 'IT', 71000.00, '2020-06-12'),
(92, 'Zoe', 'Martin', 'HR', 58000.00, '2022-02-02'),
(93, 'David', 'Thompson', 'Finance', 74000.00, '2021-05-19'),
(94, 'Sophia', 'Moore', 'IT', 75000.00, '2020-08-09'),
(95, 'Benjamin', 'Carter', 'Sales', 67000.00, '2021-11-27'),
(96, 'Charlotte', 'Davis', 'Finance', 70000.00, '2020-03-01'),
(97, 'Liam', 'Harris', 'HR', 59000.00, '2022-10-10'),
(98, 'Jack', 'Wright', 'IT', 76000.00, '2019-07-02'),
(99, 'Grace', 'Adams', 'Sales', 64000.00, '2021-04-11'),
(100, 'Emily', 'Taylor', 'Finance', 73000.00, '2022-02-23');


WITH Top10Percent AS (
    SELECT TOP 10 PERCENT *
    FROM Employees
    ORDER BY Salary DESC
),
DepartmentAverages as(
	select 
	Department,
	Avg(salary) as Average_Salary,
	case
		when avg(salary) > 80000 then 'HIGH'
		when avg(salary) between 50000 and 80000 then 'MEDIUM'
		else 'LOW'
	end as Salary_Category
	from Top10Percent
	group by Department
)
select *
from DepartmentAverages
order by Average_Salary desc
offset 2 rows fetch next 5 rows only




