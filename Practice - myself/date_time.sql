select current_date - 1


-- Adding a birthdate column in employee
-- & apply techniques on birthdate column


select * from employee

alter table employee
add column birthdate timestamp 

update employee
set birthdate = '2017-03-01'


select birthdate, strftime('%y',birthdate) as year
from employee