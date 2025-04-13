
drop table if exists data_types_demo
-- Create the table
CREATE TABLE data_types_demo(
	first TINYINT,
	two SMALLINT,
	three INT,
	four BIGINT,
	five DECIMAL(10,2),
	six FLOAT,
	seven VARCHAR(49),
	eight DATE,
	nine TIME,
	ten DATETIME,
	eleven VARBINARY(MAX)
);

-- Insert with image using SELECT ... FROM OPENROWSET
INSERT INTO data_types_demo (
	first, two, three, four, five, six, seven, eight, nine, ten, eleven
)
SELECT 
	224,
	31000,
	2000000,
	3400000000,
	10.34,
	23.2323,
	'salom',
	'2024-12-12',
	'11:11:11',
	'2024-12-12 11:11:11',
	BulkColumn
FROM OPENROWSET(
	BULK 'C:\Users\sardorbek\OneDrive\Documents\Sql\lesson-2\image\image.jpg',
	SINGLE_BLOB
) AS img;

select * from data_types_demo