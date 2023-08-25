USE `awesome chocolates`;

select * from sales;

select * from people
where Team = 'Jucies' or Team = 'Delish';


select * from people
where Team in ('Jucies','Delish');


select * from people
where Salesperson like 'D%';


select SaleDate, 
		Amount,
		case when Amount < 1000 then 'under 1k'
			when Amount < 5000 then 'under 5k'
			when Amount <= 10000 then 'under 10k'
		else 'greater than 10k'
end as 'Amount Category'
from sales;


