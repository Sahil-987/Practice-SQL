

                          /* aggregate function --> window functn */
						  
-- {Aggregate function will reduce the number of rows or records 
-- since they perform calculation of a set of row values to return a single value. 
-- Whereas window function does not reduce the number of records.} 


select * from employee

select avg(salary) from employee

select *,avg(salary) over() from employee


//////////////////////////////////////////////////////////////////

select * from employee

select *,
rank() over(),
dense_rank() over()
from employee

select *,
lag(salary) over()
from employee



-------------2nd Highest Scorer-----------------

drop table students

select * from students

create table students
(
	id int,
	name varchar(20),
	marks int
)

insert into students
values
(1,'Sahil',60),
(2,'Akash',70),
(3,'Shubh',65),
(4,'harsh',55),
(5,'Surbhit',55)


select 
	*,
	dense_rank() over(order by marks desc)
from students
-- where
-- 	dense_rank = 2