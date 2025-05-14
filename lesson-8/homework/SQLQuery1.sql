create database lesson8
use lesson8


-- TASK 1

create table Groupings
(
	Step_Number int,
	Status varchar(50)
)

insert into Groupings
values
(1,	'Passed'),
(2,	'Passed'),
(3,	'Passed'),
(4,	'Passed'),
(5,	'Failed'),
(6,	'Failed'),
(7,	'Failed'),
(8,	'Failed'),
(9,	'Failed'),
(10,'Passed'),
(11,'Passed'),
(12,'Passed')

select 
MIN(Step_Number) as MinStepNumber,
MAX(Step_Number) as MaxStepNumber,
Status,
count(*) as ConsecutiveCount
from
(select
	Step_Number,
	Status,
	rn,
	rn-ROW_NUMBER() over(partition by Status order by Step_Number) as group_id
from
(select *,
ROW_NUMBER() over(order by Step_Number) as rn
from Groupings
) as OrderedGroupings
)as GroupChanges
group by Status,group_id
order by MinStepNumber

-- TASK 2
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);
INSERT INTO [dbo].[EMPLOYEES_N] ([EMPLOYEE_ID], [FIRST_NAME], [HIRE_DATE]) VALUES
(1, 'John', '1975-01-15'),
(2, 'Alice', '1976-03-20'),
(3, 'Bob', '1977-06-10'),
(4, 'Carol', '1979-02-25'),
(5, 'David', '1980-07-12'),
(6, 'Eve', '1982-04-18'),
(7, 'Frank', '1983-09-30'),
(8, 'Grace', '1984-11-05'),
(9, 'Hank', '1985-03-22'),
(10, 'Ivy', '1990-08-14'),
(11, 'Jack', '1997-12-01');

select *
from
(select 
case when HIRE_YEAR<>L+1 then cast((L+1) as varchar(4)) + '-' + cast((L+(HIRE_YEAR-L)-1) as varchar(4))
else null end as interval_no_hire
from
(select 
YEAR(HIRE_DATE) AS HIRE_YEAR,
isnull((LAG(YEAR(HIRE_DATE)) over(order by HIRE_DATE)),YEAR(HIRE_DATE)-1) as L
from EMPLOYEES_N
union all
SELECT 2026, (SELECT MAX(YEAR(HIRE_DATE)) FROM [dbo].[EMPLOYEES_N]) -- Add a future year to capture the last interval
) as Lagt
) as compl
where interval_no_hire is not null
group by interval_no_hire
