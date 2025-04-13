create table worker(
	id int,
	name varchar(50)
)
bulk insert worker
from 'C:\Users\sardorbek\OneDrive\Documents\Sql\lesson-2\sample.csv'
with(
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
)

select * from worker