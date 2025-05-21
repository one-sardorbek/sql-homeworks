
declare @day date = '09-05-2025'
declare @month int = month(@day)
set @day= DATEADD(day, 1 - DAY(@day), @day);

declare @all_days table(day int,Weekday nvarchar(55),WeekNumber INT)
while @month=month(@day)
begin
	insert into @all_days
	values
	(day(@day),
	datename(dw,@day),
	DATEPART(WEEK, @day) - DATEPART(WEEK, DATEADD(DAY, 1 - DAY(@day), @day)) + 1
	)

	set @day = dateadd(day,1,@day)
end

declare my_cursor cursor for
	select * from @all_days


create table #cl  (
	Week int,
	Sunday int,
	Monday int,
	Tuesday int,
	Wednesday int,
	Thursday int,
	Friday int,
	Saturday int
	)

INSERT INTO #cl (Week)
SELECT DISTINCT WeekNumber
FROM @all_days
ORDER BY WeekNumber

declare @sql nvarchar(max)
declare @i int = 1

open my_cursor
DECLARE @day_val INT
DECLARE @weekday_val NVARCHAR(55)
declare @week_val int
fetch next from my_cursor into @day_val, @weekday_val,@week_val

while @@FETCH_STATUS = 0
begin
	
	SET @sql = N'UPDATE #cl SET ' + QUOTENAME(@weekday_val) + ' = ' + CAST(@day_val AS NVARCHAR(10)) +
               ' WHERE Week = ' + CAST(@week_val AS NVARCHAR(10))
    EXEC sp_executesql @sql


	fetch next from my_cursor into @day_val, @weekday_val,@week_val
end;

close my_cursor;
deallocate my_cursor;
select * from #cl
drop table #cl
