select * from employee e

select * from invoice i 

select * from customer c 


-- 1 Start --
select 
	e.employee_id 
	, concat(e.first_name , ' ' , e.last_name) as full_name 
	, e.title 
	, e.reports_to
	, (select 
		concat(e1.first_name , ' ' , e1.last_name , ' , ' , e1.title)
		from employee e1
		where e.reports_to = e1.employee_id
	)
from employee e ;
-- 1 End --

-- 2 Start --
select
	invoice_id 
	, invoice_date 
	, concat(extract (year from invoice_date) , '.' , extract (month from invoice_date)) as monthkey
	, customer_id
	, total
from invoice i 
-- 2 End --

-- 3 Start --
select
	invoice_id 
	, invoice_date 
	, concat(extract (year from invoice_date) , '.' , extract (month from invoice_date)) as monthkey
	, customer_id
	, (select email from customer c where i.customer_id = c.customer_id )
	, total
from invoice i
-- 3 End --

-- 4 Start --
select
	invoice_id 
	, invoice_date 
	, concat(extract (year from invoice_date) , '.' , extract (month from invoice_date)) as monthkey
	, customer_id
	, (select email from customer c where i.customer_id = c.customer_id ) as email
	, total
from invoice i
where 
	not((select email from customer c where i.customer_id = c.customer_id ) like '%gmail%')
-- 4 End --

-- 5 Start --
	select 
		total
		, Round((total * 100) / (select sum(total) from invoice i where extract (year from invoice_date) = 2024) , 4) 
	from invoice i
	where
		extract (year from invoice_date) = 2024
	 -- 477.53
-- 5 End --
	
-- 6 Start -- 
	
	select 
		concat(first_name , ' ' , last_name)
		, (select sum(total) from invoice i where i.customer_id = c.customer_id and extract (year from i.invoice_date) = 2024)* 100
		, round( (select sum(total) from invoice i where i.customer_id = c.customer_id and extract (year from i.invoice_date) = 2024) * 100 / 
			(select sum(total) from invoice i where extract (year from invoice_date) = 2024) , 4)
	from customer c
	
-- 6 End --
	





