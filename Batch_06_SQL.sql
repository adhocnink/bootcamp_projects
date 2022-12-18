create table orders (
  order_id INT,
  order_date date,
  customer_id INT,
  amount real,
  primary key (order_id),
  foreign key (customer_id) references customers(customer_id)
);

insert into orders values
( 1, '2022-08-01', 101, 12.5),
( 2, '2022-08-02', 102, 250),
( 3, '2022-08-04', 102, 1256),
( 4, '2022-08-02', 103, 234),
( 5, '2022-08-01', 103, 100),
( 6, '2022-09-01', 104, 288),
( 7, '2022-06-24', 105, 599),
( 8, '2022-07-13', 102, 3500),
( 9, '2022-08-13', 105, 1499),
( 10, '2022-08-16', 106, 2100); 

create table customers (
  customer_id INT,
  FirstName TEXT,
  LastName TEXT,
  PhoneNumber INT,
  Segment TEXT,
  order_id INT,
  primary key (customer_id),
  foreign key (order_id) references orders(order_id)
);

insert into customers values
( 101, 'Bank', 'Bankbank', 0611001234, 'Classic' , 1),
( 102, 'Green', 'Geernn', 0812001255, 'Silver' , 2),
( 103, 'Deck', 'Deckkra', 0951995534, 'Silver' , 4),
( 104, 'Jack', 'Jackson', 0656886634, 'Classic' , 6),
( 105, 'Panpui', 'Pannan', 0692255634, 'Gold' , 9),
( 106, 'Zara', 'Zarahill', 0611001299, 'Classic' , 10),
( 107, 'Frog', 'Frogol', 0661002659, 'Classic' ,null),
( 108, 'Hazzon', 'Hazill', 0925001244, 'Classic' , null ),
( 109, 'Mack', 'Macky', 0655001458, 'Classic' , null ),
( 110, 'Orange', 'Orangejuice', 0815001474, 'Classic' , null ); 

create table fooditems (
  food_id INT,
  name TEXT,
  order_id INT,
  primary key (food_id),
  foreign key (order_id) references orders(order_id)
);

insert into fooditems values
( 1, 'Burger',  1),
( 2, 'Tomyum', 2),
( 3, 'Pizza', 4),
( 4, 'Noodle', 6),
( 5, 'Fish and Ship', 9);


create table payments (
  payment_id INT,
  customer_id INT,
  order_id INT,
  payment_date DATE,
  amount real,
  primary key (payment_id),
  foreign key (order_id) references orders(order_id)
  foreign key (customer_id) references customers(customer_id)
);

insert into payments values
( 1, 101 ,1 , '2022-08-01', 12.5),
( 2, 102, 2, '2022-08-02', 250),
( 3, 102, 2, '2022-08-02', 1256 ),
( 4, 103, 3, '2022-08-02', 234),
( 5, 104, 4, '2022-08-02', 288);


create table employees (
  employee_id INT,
  firstname TEXT,
  lastname TEXT,
  Hiredate DATE,
  order_id INT,
  primary key (employee_id),
  foreign key (order_id) references orders(order_id)
);

insert into employees values
( 1, 'Game', 'Gaming', '2020-02-01', 1),
( 2, 'Fah', 'Filaloon', '2019-11-02', 4),
( 3, 'Mac', 'Muttaly', '2020-09-25', 1),
( 4, 'John', 'Pillow', '2019-05-16', 6),
( 5, 'Marry', 'Terrace', '2020-12-31', 10),
( 6, 'Happy', 'Yieldize', '2020-01-18', null);

.mode markdown 
.header on

select 
  b.segment,
  round(avg(amount),2) Avg_amount
from orders a 
JOIN customers b ON a.order_id = b.order_id
group by b.segment
order by round(avg(amount),2) DESC;

select 
  a.payment_id,
  b.order_id,
  a.amount payment_amount,
  c.name food_name
from payments a 
JOIN orders b ON a.order_id = b.order_id
JOIN fooditems c ON b.order_id = c.order_id
group by c.name
order by a.amount;

select 
  a.firstname Employee_Name,
  b.amount,
	CAST (strftime('%Y' , a.hiredate) AS INT) AS hire_year,
	strftime('%M', a.hiredate) AS hire_month,               
	strftime('%d', a.hiredate) AS hire_day
from employees a 
JOIN orders b ON a.order_id = b.order_id
where hire_year > 2019
group by a.firstname;

select 
   round(avg (order_amount),2) avg_amount,
   count(*)
from 
(select 
  a.firstname Employee_Name,
  b.amount order_amount,
	CAST (strftime('%Y' , a.hiredate) AS INT) AS hire_year,
	strftime('%M', a.hiredate) AS hire_month,               
	strftime('%d', a.hiredate) AS hire_day
from employees a 
JOIN orders b ON a.order_id = b.order_id
where hire_year > 2019
group by a.firstname
) AS sub;

WITH sub1 AS (
select 
  a.firstname Employee_Name,
  b.amount order_amount,
	CAST (strftime('%Y' , a.hiredate) AS INT) AS hire_year,
	strftime('%M', a.hiredate) AS hire_month,               
	strftime('%d', a.hiredate) AS hire_day
from employees a 
JOIN orders b ON a.order_id = b.order_id
where hire_year > 2019
group by a.firstname
)

select 
  round(avg (order_amount),2) avg_amount,
   count(*)
from sub1 ;
