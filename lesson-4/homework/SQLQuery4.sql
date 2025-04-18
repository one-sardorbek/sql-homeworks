use lesson4;
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

--'b' must be first
Select * from letters
order by 
case 
	when letter='b' then 0 else 1 end,
letter;

--'b' must be last
Select * from letters
order by 
case 
	when letter='b' then 1 else 0 end,
letter;