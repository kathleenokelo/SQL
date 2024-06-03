use classicmodels;


Question 1: Create a view named high_value_customers that lists the customer number, customer name, and total order amount for customers who have placed orders exceeding $10,000.

select * from customers;
select * from orders;

create view high_value_customers as
select c.customerNumber, c. customerName , sum(o. orderNumber) as total_orders
from customers c
join orders o
on c.customerNumber = o.customerNumber 
group by c.customerNumber , c.customerName
having sum(o.orderNumber) > 10000;

select * from high_value_customers;


Question 2: Find the names of customers who have placed orders for products from the 'Classic Cars' product line.

select
c.customerName,
c.customerNumber,
o.orderNumber,
od.productCode,
p.productLine
from
customers c 
join orders o
on c.customerNumber= o.customerNumber 
join orderdetails od 
on od.orderNumber = o.orderNumber
join products p
on p.productCode = od.productCode
where  p.productLine = ' Classic Cars';

select c.customerName,
c.customerNumber,
o.orderNumber,
od.productCode,
p.productLine
from
customers c join orders o
on c.customerNumber= o.customerNumber 
join orderdetails od 
on od.orderNumber = o.orderNumber
join products p
on p.productCode = od.productCode
where  p.productLine = ' Classic Cars';

Question 3: List the employees who work in the office with the maximum number of employees.

select e.employeeNumber, e.firstName, e.lastName, e.officeCode, o.country, o.city
from employees e
join offices o 
on o.officeCode = e.officeCode 
where e.officeCode = (
     select officeCode
     from employees 
	 group by officeCode
     order by count (*) desc
	 limit 1
);




Question 4: Write a stored procedure named get_customer_orders that takes a customer number as input and returns the order numbers and order dates for that customer.

delimiter //
create procedure get_customers_orders( in customerno int, out orderno int, out date_of_order date)
begin
select orderNumber, orderDate
into orderno, date_of_order
from orders
where customerNumber = customerno;
end //
delimiter ;



Question 5: Write a stored procedure named total_sales_by_employee that takes an employee number as input and returns the total sales amount for that employee.

delimiter //
create procedure total_sales_by_employee (in empno int,out total_sales int)
begin
select  sum(quantityOrdered*priceEach)
into total_sales 
from orderdetails
where 
end //
delimiter ;



Question 6: Use a CTE to find the top 3 employees by the number of customers they manage.

with Cust_emp_mngment as
(select c.customerName, e.firstName, e.lastName ,e.employeeNumber
from customers c
join employees e
on c.salesrepEmployeeNumber = e.employeeNumber
group by e.employeeNumber
order by e.employeeNumber desc)

select * from Cust_emp_mngment 
limit 3;
 

Question 7: Use a CTE to find the average payment amount for each customer and list those with an average payment greater than $2000.

with average_payments as
(select c.customerNumber, c.customerName , avg(p.amount) as avg_payment
from customers c
join payments p
on c.customerNumber= p.customerNumber 
group by c.customerNumber,c.customerName)

select * from average_payments 
where avg_payment > 2000;

Question 8: Create a union query that lists all customer names and employee names.

select customerName as customers_employees_names
from customers
UNION
select firstName
from employees;

Question 9: Write a union query to list all office cities and customer cities, making sure there are no duplicates.

select city as office_customer_cities
from customers
UNION
select city
from offices;

Question 10: Create a union query that lists all product codes from the orderdetails table along with the respective order number and indicates whether it is from the 'Classic Cars' or 'Motorcycles' product line.

select od.orderNumber, od.productCode, p.productLine
from orderdetails od
join products p
on od. productCode = p. productCode
where p.productLine = 'Classic Cars'

union all

select od.orderNumber, od.productCode, p.productLine
from orderdetails od
join products p
on od.productCode = p.productCode
where p.productLine = 'Motorcycles';