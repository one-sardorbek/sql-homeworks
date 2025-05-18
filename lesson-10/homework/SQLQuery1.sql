create database lesson10
use lesson10

CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);
INSERT INTO Shipments (N, Num) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(20, 4),
(21, 4),
(22, 4),
(23, 4),
(24, 4),
(25, 4),
(26, 5),
(27, 5),
(28, 5),
(29, 5),
(30, 5),
(31, 5),
(32, 6),
(33, 7);


select AVG(CAST(Num AS DECIMAL(10, 2))) as median
from
(
select 
isnull(sh.N,0) as N,
isnull(sh.Num,0) as Num,
ROW_NUMBER() over(order by sh.Num) as rn
from (
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N,
0 AS Num
FROM STRING_SPLIT(REPLICATE(',', 39), ',')
)as z
left join  Shipments as sh
on z.N=sh.N
) as t
where rn=20 or rn=21