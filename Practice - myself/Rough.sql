select * from wwe

alter table wwe
add house varchar(20)

update wwe
set house = 'Smackdown' where id not in (1,2,3)

select *,
rank() over(order by house)
from wwe
--------------------------------
/*   Drop vs Truncate */


drop table death_note

truncate table death_note

create table death_note
(
id int,
name varchar(20)
)

insert into death_note
values
(1,'Light Yagami'),
(2,'L')

select * from death_note

------------------------------------------------------

select *
from office_employee


select *
from employee_surname

select *
from office_employee
inner join employee_surname
on office_employee.id = employee_surname.id


select *
from customers


select *
	from office_employee
join employee_surname
	on office_employee.id = employee_surname.id
join customers
	on office_employee.name = customers.sales_person

