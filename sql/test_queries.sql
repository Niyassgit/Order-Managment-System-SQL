
--Quering and Joins

-- recent orders with customer info


select o.order_id, o.order_date, o.status, o.total_amount,
       c.name as customer_name, c.email
from orders o
join customers c on o.customer_id = c.customers_id
order by o.order_date desc;



-- total sales per customer


select c.name, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customers_id = o.customer_id
where o.status = 'delivered'
group by c.name;



-- daily sales report


select order_date, count(*) as total_orders, sum(total_amount) as daily_revenue
from orders
where status = 'delivered'
group by order_date
order by order_date desc;



-- create index for optimization

create index idx_orders_date_status on orders(order_date, status);


-- view for reporting


create view customer_sales_summary as
select c.customers_id, c.name, count(o.order_id) as order_count, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customers_id = o.customer_id
group by c.customers_id, c.name;
