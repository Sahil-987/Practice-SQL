/*
Case Study 1: (SQL)

(You can write queries in any sql syntax. Please specify the sql syntax you are using.)
Given a transactions table:
TRANSACTION_ID,USER_ID,MERCHANT_NAME,TRANSACTION_DATE,AMOUNT
1.  a. Write a query to find the first merchant a user transacts on
	b. Extract count of users who transacted for the first time on a Monday for each merchant
2. Write a query to extract alternate rows ordered by date for each user.
3. Write a query to extract the top 25% of users based on
	3.1. amount spent for each month. (Here you need to find top 25% users for each
		month)
	3.2. Transaction count for each month.(Here you need to find top 25% users for each
		month)
	3.3. Total Amount spent till date. (Here you need to find top 25% users for overall)
	3.4. Total transaction count till date. (Here you need to find top 25% users for overall)
4. Write a query to calculate time difference (in days) between current and previous order of
   each customer for every row and the avg time difference between two orders for every customer.
5. Write a query to get the count of users who transact in 3 continuous months.

Note - PostgreSQL format

*/



-- Creating a Transaction Table --

CREATE TABLE 
	transaction_table
		(transaction_id varchar(30) NOT NULL,
		user_id int NOT NULL, 
		merchant_name varchar(255), transaction_date date NOT NULL, 
		amount int NOT NULL);

INSERT INTO transaction_table
	(transaction_id, user_id, merchant_name, transaction_date, amount) 
VALUES 
	('1abc2015-01-17', 1 ,'mrch1', '2015-01-17', 100),
	('2abc2015-01-17', 2 ,'mrch2', '2015-01-17', 120),
	('4abc2015-01-17', 4 ,'mrch3', '2015-01-17', 130),
	('3abc2015-01-17', 3 ,'mrch4', '2015-01-17', 150),
	('5abc2015-01-17', 5 ,'mrch1', '2015-01-17', 300),
	('7abc2015-01-17', 7 ,'mrch1', '2015-01-17', 90),
	('8abc2015-01-17', 8 ,'mrch3', '2015-01-17', 200),
	('6abc2015-01-17', 6 ,'mrch5', '2015-01-17', 100),
	('2abc2015-01-17', 2, 'mrch4', '2015-01-20', 125),
	('1abc2015-02-16', 1, 'mrch2', '2015-02-16', 120),
	('1abc2015-03-17', 1 ,'mrch2', '2015-03-17', 110),
	('3abc2015-03-17', 3, 'mrch3', '2015-03-17', 150),
	('2abc2015-04-17', 2 ,'mrch5', '2015-04-17', 130), 
	('5abc2015-07-17', 5,'mrch4', '2015-07-17', 100),
	('7abc2015-08-17', 7 ,'mrch3', '2015-08-17', 100),
	('9abc2015-10-17', 9 ,'mrch1', '2015-10-17', 105),
	('4abc2015-12-17', 4 ,'mrch1', '2015-12-17', 240),
	('3abc2015-12-23', 3 ,'mrch2', '2015-12-23', 130)


SELECT * 
	from 
	transaction_table

DROP TABLE transaction_table

-- ********************************** --


-- 1.a Write a query to find the first merchant a user transacts on

select 
	a.user_id,
	a.merchant_name,
	a.transaction_date
	from
		(select *,
			row_number() over(partition by user_id order by transaction_date)
		from transaction_table) a
		where
		a.row_number = 1



-- 1.b Extract count of users who transacted for the first time on a Monday for each merchant


select 
	a.merchant_name,
	count(a.user_id)
	from
		(select *,
			row_number() over(partition by merchant_name order by transaction_date)
		from transaction_table) a
	where
		extract(dow from a.transaction_date) = 1
	group by
		merchant_name


-- ****************************************************************************
-- 2. Write a query to extract alternate rows ordered by date for each user.


select 
	rn.user_id,
	rn.row_number,
	rn.transaction_date
	from
	(select *,row_number()  over(partition by user_id order by transaction_date) from transaction_table) rn
where mod(rn.row_number,2) != 0


-- ****************************************************************************
-- 3. Write a query to extract the top 25% of users based on

-- 3.1 amount spent for each month. (Here you need to find top 25% users for each month)

SELECT
		t.sales_month,
		t.user_id,
		t.amount
FROM (
    SELECT
		rn.sales_month,
		rn.user_id, 
        rn.amount,
        percent_rank() over (partition by rn.sales_month order by amount desc) as pct_rank
    FROM 
		(select *,
		 		extract(month from transaction_date) as sales_month
				FROM transaction_table) as rn
    			) t
				WHERE pct_rank <= 0.25 


-- 3.2 Transaction count for each month.(Here you need to find top 25% users for each month)

SELECT
	u.sales_month,
	u.user_id,
	u.trans_cnt
	FROM
	(
	SELECT
		*,
		percent_rank() over (partition by t.sales_month order by t.trans_cnt desc) as pct_rank
	FROM (
		SELECT
			rn.sales_month,
			rn.user_id,
			count(rn.user_id) as trans_cnt		
		FROM 
			(select *,
					extract(month from transaction_date) as sales_month
					FROM transaction_table) as rn
		GROUP BY
			rn.sales_month,
			rn.user_id
		ORDER BY
			rn.sales_month
					) t ) u
					WHERE pct_rank <= 0.25 



-- 	3.3 Total Amount spent till date. (Here you need to find top 25% users for overall)


SELECT
	u.user_id,
	u.amnt_spent
FROM
	(SELECT
		t.*,
		percent_rank() over (order by amnt_spent desc) as pct_rank
		FROM
		(
		SELECT
			user_id,
			sum(amount) as amnt_spent
			FROM 
			transaction_table
			group by
				user_id
			order by
				amnt_spent desc) as t) as u
		where
			pct_rank <= 0.25



-- 	3.4 Total transaction count till date. (Here you need to find top 25% users for overall)

SELECT
	u.user_id,
	u.trns_cnt
FROM
	(SELECT
		t.*,
		percent_rank() over (order by t.trns_cnt desc) as pct_rank
		FROM
		(
		SELECT
			user_id,
			count(user_id) as trns_cnt
			FROM 
			transaction_table
			group by
				user_id
			order by
				trns_cnt desc) as t) as u
		where
			pct_rank <= 0.25


-- ****************************************************************************

-- 4. Write a query to calculate time difference (in days) between current and previous order of
--    each customer for every row and the avg time difference between two orders for every customer.

select
	*
	from
	(Select
	 	r.user_id,
	 	r.transaction_date as current_order_date,
		r.transaction_date - r.last_ordr_date as days_dffr_last_ordr
		from
		(
		select *,
			  lag(transaction_date) over(partition by user_id order by transaction_date) as last_ordr_date
		from transaction_table ) r)t
where
	days_dffr_last_ordr IS NOT NULL


-- 5. Write a query to get the count of users who transact in 3 continuous months.


select 
	count(a.user_id) as total_users
	from
		(select *,
		 	lead(transaction_date) over(partition by user_id order by transaction_date),
		 	lag(transaction_date) over(partition by user_id order by transaction_date)
		from transaction_table) as a
	where
		extract(month from a.transaction_date) = extract(month from a.lag) + 1
			and 
		extract(month from a.transaction_date) = extract(month from a.lead) - 1
	group by
		a.user_id
	

-- **************  ROUGH     *************** -----------------------------


select * from transaction_table


select *,
	rank() over(partition by merchant_name order by amount desc),
	percent_rank() over(partition by merchant_name order by amount desc)
	from transaction_table

select *,
	extract('month' from transaction_date),
	rank() over(partition by extract('month' from transaction_date) order by amount desc)
	from transaction_table


select
	r.*,
	row_number() over(partition by extract order by transaction_date)
from
(
select
	transaction_date,
	extract ('month' from transaction_date)
from
	transaction_table ) as r
	