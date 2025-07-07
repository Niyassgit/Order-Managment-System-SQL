--Table for Customers:

create table customers(
    customers_id serial primary key,
    name varchar(100) not null,
    email varchar(100) unique not null,
    phone varchar(15),
    created_at  timestamp default current_timestamp
);

--Table for Products:

create table products (
    product_id serial primary key,
    name varchar(100) not null,
    description text,
    price decimal(10,2) not null,
    stock int default 0,
    created_at timestamp default current_timestamp
);

--Table for Orders:

create table orders(
    order_id serial primary key,
    customer_id int  not null,
    order_date date default current_date,
    status varchar(20) not null check(status in ('pending','shipped','delivered','cancelled')),
    total_amount decimal(10,2),
    foreign key (customer_id) refrences customers(customer_id)
);

--Table for Payments:

create table payments (
    payment_id serial primary key,
    order_id int not null,
    payment_date date default current_date,
    amount decimal(10,2) not null,
    status varchar(20) check (status in ('paid', 'failed', 'refunded')),
    payment_method varchar(50),
    foreign key(order_id) refrences orders(order_id)
);


--Datas Entered for the corresponding tables 

-- Sample Data: Customers:

insert into customers(name,email,phone)
values
('Niyas','niyas28nazar@gmail.com','7907291887'),
('Akhil','akhil007@gmial.com','8958845658');

--Sample Dta:Products:

insert into products(name,description,price,stock)
values
('Axxor','Retro style',2500.00,10),
('Mt','Apex style',6000.00,5);


--Sample Data :Orders:

insert into orders(customer_id,order_date,status,total_amount)
values
(1,'2025-07-06','delivered',1500.00),
(2, '2025-07-07', 'pending', 6000.00);


--sample Data: Payments:
insert into payments(order_id,payment_date,amount,payment_method,status)
values
(1,'2025-07-06',2500.00,'UPI','paid'),
(2,'2025-07-07',6000.00,'Cash','failed');


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
