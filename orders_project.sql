

select * from data_orders


--find top 10 highest reveue generating products 
select top 10 product_id,sum(sale_price) as sales
from data_orders
group by product_id
order by sales desc

--find top 5 highest selling products in each region
with cte as (
select region,product_id,sum(sale_price) as sales
from data_orders
group by region,product_id)
select * from (
select *
, row_number() over(partition by region order by sales desc) as rn
from cte) A
where rn<=5

--for each category which month had highest sales 
with cte as (
select category,format(order_date,'yyyyMM') as order_year_month
, sum(sale_price) as sales 
from data_orders
group by category,format(order_date,'yyyyMM')
--order by category,format(order_date,'yyyyMM')
)
select * from (
select *,
row_number() over(partition by category order by sales desc) as rn
from cte
) a
where rn=1