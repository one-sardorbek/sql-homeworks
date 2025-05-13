create database lesson7
use lesson7
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

-- Insert into Customers
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Smith'),
(2, 'Bob Johnson'),
(3, 'Carol White'),
(4, 'David Brown'),
(5, 'Emma Green');

-- Insert into Products
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Notebook', 'Stationery'),
(4, 'Pen', 'Stationery'),
(5, 'Headphones', 'Electronics'),
(6, 'Desk Lamp', 'Furniture');

-- Insert into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2023-01-10'),
(2, 1, '2023-02-15'),
(3, 2, '2023-03-01'),
(4, 3, '2023-04-05'),
(5, 3, '2023-05-10'),
(6, 4, '2023-06-01'),
(7, 3, '2023-07-20');

-- Insert into OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 999.99),    -- Alice: Laptop (Electronics)
(2, 1, 5, 2, 49.99),     -- Alice: Headphones (Electronics)
(3, 2, 3, 5, 2.99),      -- Alice: Notebook (Stationery)
(4, 2, 4, 10, 1.50),     -- Alice: Pen (Stationery)
(5, 3, 2, 1, 699.99),    -- Bob: Smartphone (Electronics)
(6, 4, 1, 1, 999.99),    -- Carol: Laptop (Electronics)
(7, 4, 3, 3, 2.99),      -- Carol: Notebook (Stationery)
(8, 5, 5, 1, 49.99),     -- Carol: Headphones (Electronics)
(9, 5, 2, 1, 699.99),    -- Carol: Smartphone (Electronics)
(10, 6, 3, 2, 2.99),     -- David: Notebook (Stationery)
(11, 6, 4, 5, 1.50),     -- David: Pen (Stationery)
(12, 7, 6, 1, 29.99);    -- Carol: Desk Lamp (Furniture)


-- TASK 1

select c.*,o.OrderID, o.OrderDate
from Customers as c
left join Orders as o
on c.CustomerID=o.CustomerID

-- TASK 2

select c.*
from Customers as c
left join Orders as o
on c.CustomerID=o.CustomerID
where OrderID is null

-- TASK 3

SELECT 
	o.*,p.ProductName,od.Quantity
from Orders as o
join OrderDetails as od
on o.OrderID = od.OrderID
join Products as p
on od.ProductID = p.ProductID

-- TASK 4

select c.*
from Customers as c
left join Orders as o
on c.CustomerID=o.CustomerID
group by c.CustomerID, c.CustomerName
having count(o.OrderID) > 1


-- TASK 5

WITH RankedProducts AS (
    SELECT 
        od.OrderID,
        p.ProductName,
        od.Price,
        ROW_NUMBER() OVER (PARTITION BY od.OrderID ORDER BY od.Price DESC) AS PriceRank
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
)
SELECT 
    OrderID,
    ProductName,
    Price
FROM RankedProducts
WHERE PriceRank = 1;

-- TASK 6

with RankedOrders as (
	select
	c.CustomerID,
	c.CustomerName,
	o.OrderID,
	o.OrderDate,
	ROW_NUMBER() over (partition by o.CustomerID order by o.OrderDate desc) as rank_date
	from Customers as c
	join Orders as o
	on c.CustomerID=o.CustomerID

)
select 
	CustomerID,
	CustomerName,
	OrderID,
	OrderDate
from RankedOrders
where rank_date=1

-- TASK 7
with fulltable as(
select 
	c.*,p.*,
	case 
		when p.Category='Electronics' then 1
		else 0 end as filter
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails od
on o.OrderID=od.OrderID
join Products p
on od.ProductID=p.ProductID
) 
select
	  CustomerID,CustomerName
from fulltable
group by CustomerID,CustomerName
having count(CustomerID)=sum(filter)

--TASK 8

with fulltable as(
select 
	c.*,p.*,
	case 
		when p.Category='Stationery' then 1
		else 0 end as filter
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails od
on o.OrderID=od.OrderID
join Products p
on od.ProductID=p.ProductID
) 
select
	  CustomerID,CustomerName
from fulltable
group by CustomerID,CustomerName
having sum(filter) > 0

-- TASK 9

select
	c.*,
	sum(od.price) as TotalSpent
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails od
on o.OrderID=od.OrderID
group by c.CustomerID,c.CustomerName


