/*
==================================================================================
We'll develop a project for a "Fictional Online Retail Company". 
This project will cover creating a database, tables, and indexes, inserting data,
and writing various queries for reporting and data analysis.
==================================================================================

Project Overview: Fictional Online Retail Company
--------------------------------------
A.	Database Design
	-- Database Name: OnlineRetailDB

B.	Tables:
	-- Customers: Stores customer details.
	-- Products: Stores product details.
	-- Orders: Stores order details.
	-- OrderItems: Stores details of each item in an order.
	-- Categories: Stores product categories.

C.	Insert Sample Data:
	-- Populate each table with sample data.

D. Write Queries:
	-- Retrieve data (e.g., customer orders, popular products).
	-- Perform aggregations (e.g., total sales, average order value).
	-- Join tables for comprehensive reports.
	-- Use subqueries and common table expressions (CTEs).
*/

/* LET'S GET STARTED 


-- Create the Customers table

DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
	CustomerID INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Email NVARCHAR(100),
	Phone NVARCHAR(50),
	Address NVARCHAR(255),
	City NVARCHAR(50),
	State NVARCHAR(50),
	ZipCode NVARCHAR(50),
	Country NVARCHAR(50),
	CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(CustomerID)
);

-- Create the Products table
CREATE TABLE Products (
	ProductID INT,
	ProductName NVARCHAR(100),
	CategoryID INT,
	Price DECIMAL(10,2),
	Stock INT,
	CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(ProductID)
);

-- Create the Categories table
CREATE TABLE Categories (
	CategoryID INT,
	CategoryName NVARCHAR(100),
	Description NVARCHAR(255),
    PRIMARY KEY(CategoryID)
);

-- Create the Orders table
CREATE TABLE Orders (
	OrderId INT,
	CustomerId INT,
	OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
	TotalAmount DECIMAL(10,2),
    PRIMARY KEY(OrderId)

);

-- Alter / Rename the Column Name

-- Create the OrderItems table
CREATE TABLE OrderItems (
	OrderItemID INT,
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Price DECIMAL(10,2),
    PRIMARY KEY (OrderItemID),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (OrderId) REFERENCES Orders(OrderID)
);*/

/*
-- Insert sample data into Categories table
INSERT INTO Categories (CategoryID,CategoryName, Description) 
VALUES 
(11,'Electronics', 'Devices and Gadgets'),
(12,'Clothing', 'Apparel and Accessories'),
(13,'Books', 'Printed and Electc Books'),
(14,'Books', 'Printed and Eleronic Books'),
(15,'Books', 'Printed actronic Books'),
(16,'Books', 'Prind Electronic Books'),
(17,'Books', 'Printks');
*/
/*
-- Insert sample data into Products table
INSERT INTO Products(ProductID,ProductName, CategoryID, Price, Stock)
VALUES 
(1,'Smartphone', 1, 699.99, 50),
(2,'Laptop', 1, 999.99, 30),
(3,'T-shirt', 2, 19.99, 100),
(4,'Jeans', 2, 49.99, 60),
(5,'Fiction Novel', 3, 14.99, 200),
(6,'Science Journal', 3, 29.99, 150);
*/
-- Insert sample data into Customers table
INSERT INTO Customers(CustomerID,FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country)
VALUES 
(12,'Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', '123 Elm St.', 'Springfield', 
'IL', '62701', 'USA'),
(21,'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St.', 'Madison', 
'WI', '53703', 'USA'),
(13,'harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '789 Dalal St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA'),
(4,'harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '789 Dal St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA'),
(5,'harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '789 Dl St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA'),
(6,'harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '7 Dalal St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA'),
(7,'harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '74659 Dalal St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA');

/*
-- Insert sample data into Orders table
INSERT INTO Orders(OrderId,CustomerId, OrderDate, TotalAmount)
VALUES 
(4,1, Date_add(CURDATE(),Interval 20 day), 719.98),
(5,2, Date_add(CURDATE(),Interval 20 day), 49.99),
(6,3, Date_add(CURDATE(),Interval 20 day), 44.98),
(7,3, Date_add(CURDATE(),Interval 10 day), 44.98),
(8,3, Date_add(CURDATE(),Interval 6 day), 44.98),
(9,3, Date_add(CURDATE(),Interval 10 day), 44.98);
*/

/*
-- Insert sample data into OrderItems table
INSERT INTO OrderItems(OrderItemID,ProductId,OrderId, Quantity, Price)
VALUES 
(30, 1,1,1, 699.99),
(31,2,3,1, 19.99),
(32, 3,3,4,  49.99),
(33, 4,1,3, 14.99),
(34, 6,2,2, 29.99),
(35, 6,1,2, 29.99),
(36, 6,3,2, 29.99),
(37, 6,1,2, 29.99),
(38, 6,2,2, 29.99);
*/

-- Retreive all orders in a customer id 
select CustomerId,count(OrderId) as order_id from Orders group by CustomerId;
select o.CustomerId,o.OrderId,p.ProductID,p.ProductName,ord.Quantity,p.Price from Orders o join Orderitems ord on o.OrderId=ord.OrderId join
Products p on ord.ProductID=p.ProductID where CustomerId=3;

-- find the total sales of each product
select * from Orderitems;
select p.ProductID,p.ProductName,count(ord.OrderID) as orderidcnt,sum(ord.Quantity) as quant_or from Orderitems ord inner join Products p on ord.ProductID=p.ProductID group by p.ProductID,ord.OrderID;

-- average order value 
select OrderId,avg(Price) as Price_av from Orderitems group by OrderId;
select * from Categories;

-- list customers by total spending
select o.CustomerId,i.FirstName,i.LastName from Orders o join Customers i on o.CustomerId=i.CustomerID order by TotalAmount desc
limit 5;

-- most popular product category
select c.CategoryID,c.CategoryName,sum(ord.Quantity) as Quant_ord from Categories c join Products p on c.CategoryID=p.CategoryID join Orderitems ord on p.ProductID=ord.ProductID
group by p.ProductID,c.CategoryID,ord.OrderID order by Quant_ord desc limit 1;

-- list products out of stock
select * from Customers;

-- customers who placed order in last 30 days
select p.* from (
select  o.*,row_number() over(partition by o.ord_day order by o.ord_day desc) as rn_partition from (
select FirstName,LastName,OrderDate,Day(OrderDate) as ord_day
from orders o join customers c on c.CustomerId=o.CustomerId order by date(OrderDate) desc
)o
)p where rn_partition<30;

-- list products that are out of stock
select e.* from ( 
select o.ProductID,Stock,sum(Quantity) as quantity from Orderitems o join products p on o.ProductID=p.ProductID
group by o.ProductID
)e where Stock<quantity;
-- if a column in select clause have unique value in group by column even if it is not selected in group by 
-- clause and selected in select clause whether aggregated or non-aggregated that column will not throw the
-- error showing select columns is not present in group by list 

select * from Products;

-- calculate the total no of orders placed each month
select month(OrderDate),count(OrderId)  from orders group by month(OrderDate);

-- most recent order details
select  * from Orders order by OrderDate limit 1;

-- find the avg price of products 
select CategoryID,avg(Price) as pric_pr from products group by CategoryID;

-- list customers who never placed an order
select c.CustomerID,c.FirstName,c.LastName from orders o right join Customers c on o.CustomerId=c.CustomerID where OrderId is null;

-- total quantity sold for each product
select o.ProductID,p.ProductName,sum(Quantity) as quantity from Orderitems o join products p on o.ProductID=p.ProductID
group by o.ProductID;

-- revenue generated per total price
select p.CategoryID,sum(o.Quantity)*sum(o.Price) as rev_gen from orderitems o join Products p on p.ProductID=o.ProductID group by CategoryID,Price;

-- highest pirce in each category
select p.CategoryID,max(o.Price) as Price_max  from orderitems o join Products p on p.ProductID=o.ProductID group by p.CategoryID;

-- retreive orders with a total amount greater than specific value
select OrderId from orders where TotalAmount>523;

-- list product and no of orders they appear in 
select o.ProductID,p.ProductName,count(OrderId) as no_of_orders from Orderitems o join products p on o.ProductID=p.ProductID
group by o.ProductID;

-- top 3 most frequent order products
select o.ProductID,p.ProductName,count(OrderId) as no_of_orders from Orderitems o join products p on o.ProductID=p.ProductID
group by o.ProductID order by no_of_orders desc limit 3;

-- cacluate total of cust for each country
select * from customers;
select Country,count(CustomerID) as totl_cust from customers group by Country;

-- list of cusetomers alng with total spending
select c.CustomerID,FirstName,LastName,Email from Orders o join Customers c on o.CustomerId=c.CustomerId;

-- list orders more than specified number of items
select OrderID from orderitems where quantity>2;


