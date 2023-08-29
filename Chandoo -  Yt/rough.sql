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


-- Joins

select s.SPID, s.GeoID, s.PID, s.Amount,
	p.Salesperson
	from sales s
join people p
on s.SPID = p.SPID;



select s.SPID, p.SPID, pr.PID, 
	s.Amount,
	p.Salesperson
 from
sales s
join people p 
join products pr
on s.SPID = p.SPID = pr.PID;


-- Group by

select PID,
	avg(Amount) as mean_amount
from
sales
group by PID
order by mean_amount desc;


select *,
	year(SaleDate) as Year,
    month(SaleDate) as Month
 from 
 sales;
 
 
 select 
	year(SaleDate) as Year,
    month(SaleDate) as Month,
    avg(Amount) as avg_monthly_sales
 from 
 sales
 group by
	year(SaleDate),
	month(SaleDate)
order by
	avg_monthly_sales desc;


