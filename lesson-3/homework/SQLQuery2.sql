use lesson3;
INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(1, 'John Doe', '2023-04-01', 150.75, 'Shipped'),
(2, 'Jane Smith', '2023-04-03', 250.50, 'Pending'),
(3, 'Alice Johnson', '2023-03-25', 190.00, 'Delivered'),
(4, 'Robert Brown', '2023-04-05', 85.30, 'Cancelled'),
(5, 'Emily Davis', '2023-03-20', 350.60, 'Shipped'),
(6, 'Michael Wilson', '2023-04-02', 120.25, 'Delivered'),
(7, 'Sarah Miller', '2023-03-18', 210.40, 'Pending'),
(8, 'David Anderson', '2023-04-08', 500.00, 'Shipped'),
(9, 'Laura Thomas', '2023-04-04', 75.90, 'Cancelled'),
(10, 'Daniel Taylor', '2023-03-30', 130.15, 'Shipped'),
(11, 'Emma Moore', '2023-04-06', 160.40, 'Pending'),
(12, 'James Jackson', '2023-04-07', 250.00, 'Delivered'),
(13, 'Olivia White', '2023-03-22', 400.10, 'Shipped'),
(14, 'William Harris', '2023-03-28', 320.75, 'Pending'),
(15, 'Sophia Martin', '2023-04-01', 45.60, 'Cancelled'),
(16, 'Benjamin Thompson', '2023-04-09', 125.90, 'Shipped'),
(17, 'Isabella Garcia', '2023-03-15', 350.00, 'Delivered'),
(18, 'Logan Martinez', '2023-03-23', 180.00, 'Shipped'),
(19, 'Mia Robinson', '2023-03-29', 220.20, 'Pending'),
(20, 'Ethan Clark', '2023-04-10', 90.00, 'Cancelled');

select
case
	when Status='Shipped ' or Status='Delivered' then 'Completed' 
	when Status='Pending' then 'Pending'
	else 'Cancelled'
	end as OrderStatus,
count(*) as TotalOrders,
sum(TotalAmount) as TotalRevenue
from orders
where OrderDate between '2023-01-01' and '2023-12-31'
group by case
	when Status='Shipped ' or Status='Delivered' then 'Completed' 
	when Status='Pending' then 'Pending'
	else 'Cancelled'
	end 
Having sum(TotalAmount)>50000
order by TotalRevenue





