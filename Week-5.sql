create database bills;
use bills; 
create table orders ( 
    order_id int primary key, 
    customer_id int 
); 
insert into orders values 
(1, 101), 
(2, 102), 
(3, 103), 
(4, 104), 
(5, 105); 
create table payment ( 
    payment_id int auto_increment primary key, 
    order_id int not null unique, 
    payment_date date not null, 
    payment_mode varchar(30) not null, 
    payment_status varchar(20) not null default 'pending', 
    transaction_amount decimal(10,2) not null, 
 
    check (payment_mode in ( 
        'upi', 
        'credit card', 
        'debit card', 
        'net banking', 
        'cash on delivery' 
    )), 
 
    check (payment_status in ( 
        'pending', 
'success', 
'failed' 
)), 
check (transaction_amount > 0), 
foreign key (order_id) 
references orders(order_id) 
); 
insert into payment 
(order_id, payment_date, payment_mode, payment_status, transaction_amount) 
values 
(1, '2026-10-20', 'upi', 'success', 1500.00), 
(2, '2026-10-21', 'credit card', 'success', 2500.00), 
(3, '2026-10-22', 'debit card', 'failed', 1200.00), 
(4, '2026-10-23', 'net banking', 'pending', 3000.00), 
(5, '2026-10-24', 'cash on delivery', 'pending', 800.00); 
select * from payment; 
select * from payment 
where payment_status = 'success'; 
select * from payment 
where payment_status = 'failed'; 
select * from payment 
where payment_status = 'pending'; 
select * from payment 
where order_id = 1; 
update payment 
set payment_status = 'success', 
payment_date = '2026-10-27' 
where order_id = 3 
and payment_status = 'failed'; 
select count(*) as successful_payments 
from payment 
where payment_status = 'success'; 
select count(*) as failed_payments 
from payment 
where payment_status = 'failed'; 
select payment_mode, count(*) as total_transactions 
from payment 
group by payment_mode; 
select payment_mode, count(*) as total_transactions 
from payment 
group by payment_mode 
order by total_transactions desc 
limit 1; 
select sum(transaction_amount) as total_revenue 
from payment 
where payment_status = 'success'; 
select payment_mode, 
sum(transaction_amount) as total_revenue 
from payment 
where payment_status = 'success' 
group by payment_mode; 
 
select avg(transaction_amount) as average_amount 
from payment; 
 
select payment_status, count(*) as total_transactions 
from payment 
group by payment_status; 
 
select c.customer_id, 
       c.customer_name, 
       o.order_id, 
       p.payment_id, 
       p.payment_date, 
       p.payment_mode, 
       p.payment_status, 
       p.transaction_amount 
from payment p 
join orders o on p.order_id = o.order_id 
join customer c on o.customer_id = c.customer_id; 
 
select c.customer_id, 
       c.customer_name, 
       p.order_id, 
       p.payment_date, 
       p.payment_mode, 
       p.payment_status, 
       p.transaction_amount 
from payment p 
join orders o on p.order_id = o.order_id 
join customer c on o.customer_id = c.customer_id 
order by c.customer_id, p.payment_date desc; 
 
select o.order_id, 
       p.payment_mode, 
       p.payment_status, 
       p.transaction_amount 
from orders o 
join payment p on o.order_id = p.order_id 
where p.payment_status in ('failed', 'pending'); 
 
select 
    sum(case when payment_status = 'success' then 1 else 0 end) 
        as successful_transactions, 
    sum(case when payment_status = 'failed' then 1 else 0 end) 
        as failed_transactions, 
    sum(case when payment_status = 'pending' then 1 else 0 end) 
        as pending_transactions 
from payment;