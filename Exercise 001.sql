DROP DATABASE IF EXISTS SalesDB;
CREATE DATABASE SalesDB;
USE SalesDB;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ProductID)
);

CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    PRIMARY KEY (SaleID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Insert data into Customers
INSERT INTO Customers (FirstName, LastName, Email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Michael', 'Brown', 'michael.brown@example.com');

-- Insert data into Products
INSERT INTO Products (ProductName, Price) VALUES
('Laptop', 1200.00),
('Smartphone', 800.00),
('Tablet', 300.00);

-- Insert data into Sales
INSERT INTO Sales (CustomerID, ProductID, SaleDate, Quantity) VALUES
(1, 1, '2024-05-01', 1),
(1, 2, '2024-05-03', 2),
(2, 1, '2024-05-04', 1),
(2, 3, '2024-05-05', 1),
(3, 2, '2024-05-06', 3),
(3, 3, '2024-05-07', 2);

-- Calculate the average quantity
select avg(Quantity) AS average_quantity from sales;
-- Calculate the number of sales made
select count(*) as number_of_sales from sales;
-- Calculate the maximum quantity sold
select max(Quantity) as max_quantity from sales; 
-- Calculate the minimum quantity sold
select min(Quantity) as min_quantity from sales;
-- Calculate the total sales made
select sum(Quantity*Price) AS total_sales from sales
join products on products.ProductID = sales.ProductID;

select * from sales;
select * from products;
select * from customers;

-- Calculate the Total Sales Amount by Customer
select products.Price, sales.Quantity,(products.Price*sales.Quantity) from products
join sales on products.ProductID = sales.ProductID;
select sum(products.price*sales.Quantity) as Total_Sales from products 
join sales on products.ProductID = sales.ProductID;

   
-- Calculate the Total Quantity Sold by Product
select products.ProductName, sales.Quantity as Total_Quantity_Sold from products
join sales on products.ProductID = sales.ProductID;

select products.ProductName,sum(sales.Quantity) as total_qty_sold_by_product from products
join sales on products.ProductID = sales.ProductID 
group by products.ProductName;

-- Calculate the Average Quantity Sold per Customer
select avg(sales.Quantity),customers.FirstName from sales
join customers 
on customers.CustomerID = sales.CustomerID
group by customers.FirstName;


-- Customers with Total Sales Amount Greater Than $1500
select SUM(products.Price*sales.Quantity) as TSA, customers.FirstName,customers.LastName from sales
join products
on products.ProductID = sales.ProductID  
join customers
on customers.CustomerID = sales.CustomerID
group by customers.FirstName,customers.LastName
HAVING TSA > 1500;






