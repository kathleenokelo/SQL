-- Question 1 : What is the total number of orders placed in the year 2005?

use classicmodels;

select * from orders;
select count(orderNumber) as total_orders 
from orders 
where year(orderDate) = 2005;


-- Question 2 : Find the names and contact information (city, country)
-- of all customers from Germany who have placed orders with a total amount exceeding $500.

select * from customers;
select * from payments;
select customers.customerName, customers.city, customers.country, payments.amount 
from customers
join payments on customers.customerNumber = payments.customerNumber
 where amount > 1500 and country = 'Germany';

-- Question 3 : Find the product line with the highest average order quantity.
select * from orders;
select * from productlines;
select * from products;
select * from orderdetails;

select products.productLine, avg(quantityOrdered) as avg_order_qty 
from orderdetails
join products
on products.productCode = orderdetails.productCode
group by products.productCode
order by (avg_order_qty) desc
limit 1;

select max(avg_order_qty) as max_avg_order_qty
from (select products.productLine, avg(quantityOrdered) as avg_order_qty 
from orderdetails
join products
on products.productCode = orderdetails.productCode
group by products.productCode)
as subquery;


-- Question 4 : How many different employee offices are there in the database?
select * from employees;
select * from offices;
select count(officeCode) as no_of_employee_offices from offices;


-- Question 5 : Find the names of all employees who manage at least one employee
-- who has completed more orders than the average number of orders per employee.

select * from employees;
select * from orders;
select * from customers;

select e.lastName ,
 e.firstName ,
 e.employeeNumber,
 c.customerNumber
from customers c
join employees e
on c.salesRepEmployeeNumber = e.reportsTo;

select e.firstName, e.lastName 
from employees e
where employeeNumber =
(select e.reportsTo 
from employees e
join customers c
on e.reportsTo = c.salesRepEmployeeNumber);

select firstName, lastName 
from employees 
where employeeNumber =
(select distinct e.reportsTo 
from Employees e 
join Customers c
on e.reportsTo = c.salesRepEmployeeNumber);

select firstName, lastName from employees where employeeNumber = 1621;





-- Question 6 : Find the total number of orders placed between the first day of the current month and today's date.
select * from orders;
select count(orderNumber) from orders where orderDate between month(05) and curdate();

select count(*) from orders where orderDate between DATETIME(now(),%Y-%M-01) AND  now();


-- Question 7 : List all products with a price exceeding $100.
-- Include an additional column indicating "High Price" for these products and "Low Price" for products with a price of $100 or less.

select buyPrice, productName,
case
when buyPrice > 100 then 'High Price'
when buyPrice < 100 then 'Low Price'
else 'null'
end as productPrice 
from products;
 

-- Question 8 : Find the product with the most orders placed in total.
select p.productName 
from (
SELECT od.productCode, count(o.orderNumber) as total_orders
from orderdetails od
join orders o
on od.orderNumber = o.orderNumber
group by od.productCode
) as sub
join products p 
on sub.productCode = p.productCode
order by total_orders desc
limit 1;


-- Question 9 : Find the top 5 customer cities (by city name) with the highest total order amounts.

select * from customers;
select * from orders;

select count(customers.city), customers.city 
from customers 
join orders on customers.customerNumber = orders.customerNumber
group by customers.city
order by count(customers.city) desc
limit 5;

