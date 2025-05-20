create database lesson12
use lesson12

-- TASK 1

declare @name varchar(255);
declare @i int = 1;
declare @count int;
select @count = count(1)
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')

declare @sql nvarchar(max)=''
while @i <= @count
begin
	;with cte as (
		select name, ROW_NUMBER() OVER(order BY name) as rn
		from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @name=name from cte
	where rn = @i;

	-- Construct the query for the current database
    DECLARE @part1 nvarchar(max) = N'
    SELECT 
        TABLE_CATALOG AS DatabaseName,
        TABLE_SCHEMA AS SchemaName,
        TABLE_NAME AS TableName,
        COLUMN_NAME AS ColumnName,
        CONCAT(
            DATA_TYPE,
            CASE 
                WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN 
                    ''('' + 
                    CASE 
                        WHEN CAST(CHARACTER_MAXIMUM_LENGTH AS varchar) = ''-1'' THEN ''max''
                        ELSE CAST(CHARACTER_MAXIMUM_LENGTH AS varchar)
                    END + 
                    '')''
                WHEN DATA_TYPE IN (''decimal'', ''numeric'') THEN 
                    ''('' + CAST(NUMERIC_PRECISION AS varchar) + '','' + CAST(NUMERIC_SCALE AS varchar) + '')''
                ELSE ''''
            END
        ) AS DataType
    FROM ' + QUOTENAME(@name) + N'.INFORMATION_SCHEMA.COLUMNS';

    -- Append UNION ALL only if not the last database
    IF @i < @count
        SET @sql = @sql + @part1 + N' UNION ALL ';
    ELSE
        SET @sql = @sql + @part1;

    SET @i = @i + 1;
END


IF @sql <> N''
BEGIN
    BEGIN TRY
        EXEC sp_executesql @sql;
    END TRY
    BEGIN CATCH
        PRINT 'Error executing query: ' + ERROR_MESSAGE();
    END CATCH
END
ELSE
    PRINT 'No user databases found.';



