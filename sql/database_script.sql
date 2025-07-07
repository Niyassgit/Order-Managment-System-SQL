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

