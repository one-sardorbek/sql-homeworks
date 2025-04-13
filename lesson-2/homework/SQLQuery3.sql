create table photo(
	id int,
	image varbinary(max)
)
insert into photo
select 1,
BulkColumn
FROM OPENROWSET(
	BULK 'C:\Users\sardorbek\OneDrive\Documents\Sql\lesson-2\image\image.jpg',
	SINGLE_BLOB
) AS img;


