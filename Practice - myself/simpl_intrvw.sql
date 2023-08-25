select * from transaction_table


-- altr 2

select 	t.user_id, 
		t.month_sales,
		t.next_month
from
(select user_id, 
 		extract('month' from transaction_date) as month_sales,
		lead(extract('month' from transaction_date)) over(partition by user_id) as next_month
		from transaction_table) t
where t.month_sales + 1 = t.next_month