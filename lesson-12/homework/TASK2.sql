
DECLARE @name varchar(255)=null -- can be speficified if needed
DECLARE @i int = 1;
DECLARE @count int;
DECLARE @sql nvarchar(max) = N'';
DECLARE @targetDb varchar(255);

-- Get count of user databases
SELECT @count = COUNT(1)
FROM sys.databases 
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');
if @name is null
begin
	-- Find the database with procedures
	SELECT @targetDb = name
	FROM sys.databases
	WHERE database_id > 4 -- Exclude system databases (master, tempdb, model, msdb)
	AND EXISTS (
		SELECT 1
		FROM sys.all_objects
		WHERE type IN ('P', 'FN', 'IF', 'TF') -- Procedures and functions
		AND database_id = sys.databases.database_id
	);
		IF @targetDb IS NULL
	BEGIN
		PRINT 'No database with procedures or functions found.';
		RETURN;
	END

	-- If @name is specified, use it; otherwise, use the found database
	SET @name = COALESCE(@name, @targetDb);
	IF @count = 0
    BEGIN
        PRINT 'No user databases found.';
        RETURN;
    END
	WHILE @i <= @count
	BEGIN
		-- Get the database name for the current iteration
		WITH cte AS (
			SELECT name, ROW_NUMBER() OVER (ORDER BY name) AS rn
			FROM sys.databases 
			WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
		)
		SELECT @name = name 
		FROM cte
		WHERE rn = @i;

		-- Construct the query for stored procedures, functions, and their parameters
		DECLARE @part1 nvarchar(max) = N'
		SELECT 
			''' + QUOTENAME(@name) + N''' AS DatabaseName,
			r.ROUTINE_SCHEMA AS SchemaName,
			r.ROUTINE_NAME AS RoutineName,
			r.ROUTINE_TYPE AS RoutineType,
			p.PARAMETER_NAME AS ParameterName,
			COALESCE(
				CONCAT(
					p.DATA_TYPE,
					CASE 
						WHEN p.CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN 
							''('' + 
							CASE 
								WHEN CAST(p.CHARACTER_MAXIMUM_LENGTH AS varchar) = ''-1'' THEN ''max''
								ELSE CAST(p.CHARACTER_MAXIMUM_LENGTH AS varchar)
							END + 
							'')''
						WHEN p.DATA_TYPE IN (''decimal'', ''numeric'') THEN 
							''('' + CAST(p.NUMERIC_PRECISION AS varchar) + '','' + CAST(p.NUMERIC_SCALE AS varchar) + '')''
						ELSE ''''
					END
				),
				'''' -- Empty string if no parameters
			) AS ParameterDataType,
			r.CREATED AS CreateDate,
			r.LAST_ALTERED AS ModifyDate
		FROM ' + QUOTENAME(@name) + N'.INFORMATION_SCHEMA.ROUTINES r
		LEFT JOIN ' + QUOTENAME(@name) + N'.INFORMATION_SCHEMA.PARAMETERS p
			ON r.SPECIFIC_SCHEMA = p.SPECIFIC_SCHEMA 
			AND r.SPECIFIC_NAME = p.SPECIFIC_NAME
		WHERE r.ROUTINE_TYPE IN (''PROCEDURE'', ''FUNCTION'')
		ORDER BY r.ROUTINE_SCHEMA, r.ROUTINE_NAME, p.ORDINAL_POSITION';

		-- Append UNION ALL only if not the last database
		IF @i = 1
			SET @sql = @part1;
		ELSE
			SET @sql = @sql + N' UNION ALL ' + @part1;

		SET @i = @i + 1;
	END
end
else
begin
	IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = @name)
    BEGIN
        PRINT 'Database ' + QUOTENAME(@name) + ' does not exist.';
        RETURN;
    END
	set  @sql = N'
		SELECT 
			''' + QUOTENAME(@name) + N''' AS DatabaseName,
			r.ROUTINE_SCHEMA AS SchemaName,
			r.ROUTINE_NAME AS RoutineName,
			r.ROUTINE_TYPE AS RoutineType,
			p.PARAMETER_NAME AS ParameterName,
			COALESCE(
				CONCAT(
					p.DATA_TYPE,
					CASE 
						WHEN p.CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN 
							''('' + 
							CASE 
								WHEN CAST(p.CHARACTER_MAXIMUM_LENGTH AS varchar) = ''-1'' THEN ''max''
								ELSE CAST(p.CHARACTER_MAXIMUM_LENGTH AS varchar)
							END + 
							'')''
						WHEN p.DATA_TYPE IN (''decimal'', ''numeric'') THEN 
							''('' + CAST(p.NUMERIC_PRECISION AS varchar) + '','' + CAST(p.NUMERIC_SCALE AS varchar) + '')''
						ELSE ''''
					END
				),
				'''' -- Empty string if no parameters
			) AS ParameterDataType,
			r.CREATED AS CreateDate,
			r.LAST_ALTERED AS ModifyDate
		FROM ' + QUOTENAME(@name) + N'.INFORMATION_SCHEMA.ROUTINES r
		LEFT JOIN ' + QUOTENAME(@name) + N'.INFORMATION_SCHEMA.PARAMETERS p
			ON r.SPECIFIC_SCHEMA = p.SPECIFIC_SCHEMA 
			AND r.SPECIFIC_NAME = p.SPECIFIC_NAME
		WHERE r.ROUTINE_TYPE IN (''PROCEDURE'', ''FUNCTION'')
		ORDER BY r.ROUTINE_SCHEMA, r.ROUTINE_NAME, p.ORDINAL_POSITION';

end

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
