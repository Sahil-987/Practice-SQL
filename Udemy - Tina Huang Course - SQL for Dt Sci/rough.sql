SELECT * FROM interviews.eu_energy
UNION ALL
SELECT * FROM interviews.asia_energy
UNION ALL
SELECT * FROM interviews.na_energy;




-----------------------------------------------------------------------------------------------
## section 4 | mock interview 6

WITH
	users as
(SELECT 
	* 
FROM
	interviews.users
WHERE
	DATE_PART('year', joined_at) >= '2018'
AND
	DATE_PART('year', joined_at) <= '2020'),
comments_ as (	
SELECT 
	* 
FROM
	interviews.comments
WHERE
	DATE_PART('month', created_at) = '01'
AND
	DATE_PART('year', created_at) = '2020'
)
SELECT
	comments_.user_id,
	COUNT(comments_.body)
FROM
	comments_
JOIN
	users
ON 
	users.id = comments_.user_id
WHERE
	comments_.created_at > users.joined_at
GROUP BY
	comments_.user_id
ORDER BY
	count desc;




## section 4 | mock interview 7


WITH
	sales_
AS (
SELECT
	created_at,
	count(purchase_id) as quantity,
	sum(value) as value_
FROM
	interviews.transactions
GROUP BY
	created_at
ORDER BY
	created_at)
SELECT
	created_at,
	quantity * value_ as revenue
FROM
	sales_;
	





-----------------------------------------------------------------------------------------------
## section 4 | mock interview 9


## question --> find customer with highest total order cost between 2019-02-01 to 2019-05-01

## output  -->   first_name | total_order_cost | date


WITH orders as (
SELECT
	*
FROM interviews.orders
WHERE order_date > '2019-02-01' and order_date < '2019-05-01'),
customer_info as (
SELECT 
	orders.id,
	customers.first_name,
	sum(orders.order_quantity) as quantity,
	sum(orders.order_cost) as cost
FROM orders
JOIN
interviews.customers
ON
interviews.customers.id = orders.cust_id
GROUP BY
	orders.id, customers.first_name)

SELECT
	first_name,
	sum(quantity * cost) as total_order_cost
FROM
	customer_info
GROUP BY
	first_name
ORDER BY
	total_order_cost desc;



## Alternate way | orders table

-- orders table

WITH orders_total_cost as (
	SELECT 
	orders.id,
	(order_quantity * order_cost) as total_order_cost
	FROM interviews.orders
)		
SELECT
	orders.cust_id,
	orders.order_date,
	sum(orders_total_cost.total_order_cost)	as total_cost
FROM
	interviews.orders
JOIN
	orders_total_cost
ON
	orders_total_cost.id = orders.id
WHERE
	order_date >= '2019-02-01' AND order_date <= '2019-05-01'
GROUP BY
	cust_id, order_date
ORDER BY
	total_cost desc


-- isko join kardo with customers table (on customer id)