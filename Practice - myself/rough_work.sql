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
(2,'Dwight',80000,'sales'),
(3,'Andy',60000,'sales'),
(4,'Toby',90000,'HR'),
(5,'Holly',69000,'HR'),
(6,'Kevin',85000,'Accounts'),
(7,'Angela',70000,'Accounts')



select * from employee

select avg(salary) from employee


-- this query do not work --


select name, salary from employee
where salary > avg(salary)


--using with clause --


with average_salary (avg_sal) as 
 (select avg(salary) from employee)
select * from employee, average_salary
where salary > average_salary.avg_sal



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



-------------Select unique records from a table-----------------

create table customers
(
	cName varchar(20),
	city varchar(20)
)

insert into customers
values
('prateek','Mumbai'),
('ramesh','Mumbai'),
('ramesh','Mumbai'),
('suresh','Mumbai')


select * from customers

select distinct cName 
from customers



