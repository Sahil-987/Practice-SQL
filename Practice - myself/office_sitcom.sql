                         /* with clause */


drop table employee

create table employee(
id integer,
name varchar(100),
salary integer,
department varchar(100)
)


insert into employee
values
(1,'Jim',85000,'sales'),
(2,'Dwight',90000,'sales'),
(3,'Andy',60000,'sales'),
(4,'Toby',80000,'HR'),
(5,'Holly',70000,'HR'),
(6,'Kevin',60000,'Accounts'),
(7,'Angela',70000,'Accounts'),
(8,'Oscar',80000,'Accounts')



/* Q- average salary of employees */

select * from employee

select avg(salary) from employee


-- this query does not work --


select name, salary from employee
where salary > avg(salary)


--using with clause --


with average_salary as 
 (select avg(salary) from employee)
select * from employee, average_salary
where salary > average_salary.avg



-- using aggregate function as window function 
-- {this can be done using over clause}


select * from employee

select *,avg(salary) over() from employee


-- using temporary table approach

select * from employee

create temporary table t1 as
(select avg(salary) from employee)

drop table t1

select * from t1

select * from
employee
inner join t1
on employee.salary > t1.avg




/* Q- department wise average salary */

select * from employee


create temporary table t2 as
select department,avg(salary) from employee
group by department

select * from t2


select employee.name,employee.department,t2.avg from t2
inner join employee
on employee.salary > t2.avg and employee.department = t2.department




-- another example -- 



create table stores(
store_id integer,
store_name varchar(100),
product varchar(100),
quantity int,
cost int
)


insert into stores
values
(1,'Apple Originals 1','iPhone',1,1000),
(1,'Apple Originals 1','iPhone',3,1000),
(1,'Apple Originals 1','iPhone',2,1000),
(2,'Apple Originals 2','iPhone',2,1000),
(3,'Apple Originals 3','iPhone',1,1000),
(3,'Apple Originals 3','iPhone',1,1000),
(3,'Apple Originals 3','iPhone',4,1000),
(3,'Apple Originals 3','iPhone',2,1000),
(3,'Apple Originals 3','iPhone',3,1000),
(4,'Apple Originals 4','iPhone',2,1000),
(4,'Apple Originals 4','iPhone',1,1000)


select * from stores

-- total sales for each store --

select store_id,store_name, sum(cost) as total_sales_per_store
from stores
group by store_id,store_name



-- avg sales across each department --

select avg(total_sales_per_store) from
(select store_id,store_name, sum(cost) as total_sales_per_store
from stores
group by store_id,store_name) x


-- only those stores which have total sales > avg sales --


   -- approach -1 (w/o with clause)
   
select * from
	(select store_id,store_name, sum(cost) as total_sales_per_store
	from stores
	group by store_id,store_name) total_sales
join (select avg(total_sales_per_store) as avg_sales_for_all_stores from
	(select store_id,store_name, sum(cost) as total_sales_per_store
	from stores
	group by store_id,store_name) x) avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sales_for_all_stores



   -- approach -2 (with clause)
   
with total_sales(store_id,store_name,total_sales_per_store) as 
	(select store_id,store_name, sum(cost) as total_sales_per_store
	from stores
	group by store_id,store_name),
	
	avg_sales(avg_sales_for_all_stores) as
	(select avg(total_sales_per_store) as avg_sales_for_all_stores from total_sales)
select * from total_sales
join avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sales_for_all_stores


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Primary & Foreign key


drop table employee
 

create table employee(
id integer primary key,
name varchar(100),
salary integer,
department varchar(100)
)


insert into employee
values
(1,'Jim',85000,'sales'),
(2,'Dwight',90000,'sales'),
(3,'Andy',60000,'sales'),
(4,'Toby',80000,'HR'),
(5,'Holly',70000,'HR'),
(6,'Kevin',60000,'Accounts'),
(7,'Angela',70000,'Accounts'),
(8,'Oscar',80000,'Accounts')

select * from employee

-- surname table


drop table employee_surname

create table employee_surname(
id int,
sur_name varchar(100),
foreign key(id) references employee(id)
)


insert into employee_surname
values
(1,'Helpert'),
(2,'Schrute'),
(3,'idk'),
(4,'idk'),
(5,'idk'),
(6,'idk'),
(7,'idk'),
(8,'idk')

select * from employee_surname


/* joining name & surname */

select employee.name,employee_surname.sur_name from employee_surname
inner join employee
on employee.id = employee_surname.id


------------------------- Update -----------------------------

select * from office_employee

update employee
set salary = 2000 + salary


update office_employee
set marital_status = 'Unmarried'
where name != 'Jim'


------------------------- Alter -----------------------------

alter table employee
add column marital_status varchar(10)

alter table employee
alter column marital_status
set default '_blank'



alter table employee
rename to office_employee



