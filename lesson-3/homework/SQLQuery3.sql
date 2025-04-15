use lesson3;
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99, 150),
(2, 'Bluetooth Speaker', 'Electronics', 49.99, 80),
(3, 'Yoga Mat', 'Fitness', 20.00, 120),
(4, 'Running Shoes', 'Footwear', 75.50, 60),
(5, 'Laptop Stand', 'Office Supplies', 30.25, 100),
(6, 'Water Bottle', 'Fitness', 12.00, 200),
(7, 'LED Monitor', 'Electronics', 180.00, 40),
(8, 'Backpack', 'Accessories', 45.00, 90),
(9, 'Desk Lamp', 'Office Supplies', 22.50, 75),
(10, 'T-Shirt', 'Clothing', 15.00, 180),
(11, 'Wireless Keyboard', 'Electronics', 35.99, 70),
(12, 'Fitness Tracker', 'Fitness', 59.99, 55),
(13, 'Sneakers', 'Footwear', 65.00, 65),
(14, 'Notebook', 'Office Supplies', 5.00, 300),
(15, 'Sunglasses', 'Accessories', 25.00, 85),
(16, 'Jeans', 'Clothing', 40.00, 110),
(17, 'Gaming Mouse', 'Electronics', 49.99, 50),
(18, 'Duffel Bag', 'Accessories', 60.00, 45),
(19, 'Office Chair', 'Office Supplies', 120.00, 30),
(20, 'Hoodie', 'Clothing', 35.00, 95);

select 
Category,
max(Price) as max_price 
from products
group by Category



select *,

iif(Stock=0, 'Out of stock',
iif(Stock between 1 and 10, 'Low Stock', 'In Stock')) as inv

from Products
order by price desc
offset 5 rows