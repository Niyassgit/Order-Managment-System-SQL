
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

