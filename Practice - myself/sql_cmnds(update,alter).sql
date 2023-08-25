

Create table If Not Exists Salary 
(id int, name varchar(100), sex char(1), salary int)

Truncate table salary

insert into salary
values 
('1', 'A', 'm', '2500'),
('2', 'B', 'f', '1500'),
('3', 'C', 'm', '5500'),
('4', 'D', 'f', '500')

select * from salary

/* swap salary */

update salary
set sex = case
when sex = 'm' then 'f'
when sex = 'f' then 'm'
end

select * from salary



-- Alter clause


alter table salary
add bonus int

alter table salary
drop column bonus

alter table salary
rename id to emp_id