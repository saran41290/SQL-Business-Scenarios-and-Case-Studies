-- Create Database
CREATE DATABASE Sales_Analytics;
USE Sales_Analytics;

-- -----------------------------------------------------
-- 1. CUSTOMERS TABLE (30 CUSTOMERS)
-- -----------------------------------------------------
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    Gender VARCHAR(10),
    City VARCHAR(50),
    Email VARCHAR(100)
);

INSERT INTO Customers (CustomerName, Gender, City, Email) VALUES
('Arjun Kumar', 'Male', 'Chennai', 'arjun@gmail.com'),
('Priya Sharma', 'Female', 'Bangalore', 'priya@gmail.com'),
('John Mathew', 'Male', 'Mumbai', 'john@gmail.com'),
('Sneha Reddy', 'Female', 'Hyderabad', 'sneha@gmail.com'),
('Vikram Iyer', 'Male', 'Chennai', 'vikram@gmail.com'),
('Lakshmi Devi', 'Female', 'Coimbatore', 'lakshmi@gmail.com'),
('Rahul Verma', 'Male', 'Delhi', 'rahul@gmail.com'),
('Nisha Patel', 'Female', 'Ahmedabad', 'nisha@gmail.com'),
('Krishna Rao', 'Male', 'Hyderabad', 'krishna@gmail.com'),
('Ananya Gupta', 'Female', 'Pune', 'ananya@gmail.com'),
('Suresh Kumar', 'Male', 'Chennai', 'suresh@gmail.com'),
('Swati Singh', 'Female', 'Lucknow', 'swati@gmail.com'),
('Karan Malhotra', 'Male', 'Noida', 'karan@gmail.com'),
('Divya Menon', 'Female', 'Kochi', 'divya@gmail.com'),
('Amit Shah', 'Male', 'Surat', 'amit@gmail.com'),
('Pooja Mehta', 'Female', 'Mumbai', 'pooja@gmail.com'),
('Rajesh Nair', 'Male', 'Kerala', 'rajesh@gmail.com'),
('Harini Mohan', 'Female', 'Chennai', 'harini@gmail.com'),
('Rohit Singh', 'Male', 'Kanpur', 'rohit@gmail.com'),
('Meena Kumari', 'Female', 'Patna', 'meena@gmail.com'),
('Aditya Rao', 'Male', 'Hyderabad', 'aditya@gmail.com'),
('Neha Gupta', 'Female', 'Indore', 'neha@gmail.com'),
('Sameer Khan', 'Male', 'Bangalore', 'sameer@gmail.com'),
('Bhavana R', 'Female', 'Mysore', 'bhavana@gmail.com'),
('Raj Kumar', 'Male', 'Chennai', 'raj@gmail.com'),
('Sangeetha', 'Female', 'Bangalore', 'sangeetha@gmail.com'),
('Aravind', 'Male', 'Hyderabad', 'aravind@gmail.com'),
('Snehal', 'Female', 'Pune', 'snehal@gmail.com'),
('Joseph', 'Male', 'Kochi', 'joseph@gmail.com'),
('Maya', 'Female', 'Delhi', 'maya@gmail.com');

-- -----------------------------------------------------
-- 2. PRODUCTS TABLE
-- -----------------------------------------------------
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductName, Category, Price) VALUES
('Laptop', 'Electronics', 55000),
('Headphones', 'Electronics', 2500),
('Office Chair', 'Furniture', 9000),
('Keyboard', 'Electronics', 1500),
('Mouse', 'Electronics', 800),
('Monitor', 'Electronics', 12000);
INSERT INTO Products (ProductName, Category, Price) VALUES
('Webcam', 'Electronics', 3000),
('Tablet', 'Electronics', 20000),
('Desk Lamp', 'Furniture', 1500),
('Standing Desk', 'Furniture', 18000),
('Bluetooth Speaker', 'Electronics', 3500),
('USB Hub', 'Electronics', 700),
('Printer', 'Electronics', 8500),
('Pen Drive 64GB', 'Electronics', 600),
('Router', 'Electronics', 2500);

-- -----------------------------------------------------
-- 3. SALESPERSON TABLE
-- -----------------------------------------------------
CREATE TABLE Salespersons (
    SalespersonID INT PRIMARY KEY AUTO_INCREMENT,
    SalespersonName VARCHAR(100),
    Region VARCHAR(50),
    TargetAmount DECIMAL(10,2)
);

INSERT INTO Salespersons (SalespersonName, Region, TargetAmount) VALUES
('Meera', 'South', 300000),
('Rahul', 'North', 250000),
('Karthik', 'West', 200000),
('Neha', 'East', 180000);

-- -----------------------------------------------------
-- 4.ORDERS TABLE 
-- -----------------------------------------------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    SalespersonID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalespersonID) REFERENCES Salespersons(SalespersonID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Sample Order Data
INSERT INTO Orders (CustomerID, SalespersonID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 1, 1, '2025-01-10'),   -- laptop
(2, 2, 3, 1, '2025-01-11'),   -- chair
(3, 1, 4, 3, '2025-01-12'),   -- keyboard
(4, 3, 1, 1, '2025-01-14'),   -- laptop
(5, 4, 2, 2, '2025-01-15'),   -- headphones
(6, 2, 6, 1, '2025-01-16'),   -- monitor
(1, 1, 2, 1, '2025-01-17'),   -- headphones
(3, 4, 5, 2, '2025-01-18'),   -- mouse
(2, 3, 1, 1, '2025-01-19'),   -- laptop
(4, 2, 3, 4, '2025-01-20'),   -- chairs
(5, 1, 6, 2, '2025-01-21'),   -- monitors
(6, 3, 4, 1, '2025-01-22'),   -- keyboard
(1, 4, 5, 3, '2025-01-23'),   -- mouse
(2, 1, 2, 2, '2025-01-24'),   -- headphones
(3, 3, 6, 1, '2025-01-25'),   -- monitor
(4, 4, 4, 2, '2025-01-26'),   -- keyboard
(5, 2, 1, 1, '2025-01-27'),   -- laptop
(6, 1, 3, 3, '2025-01-28'),   -- chair
(1, 3, 6, 1, '2025-01-29'),   -- monitor
(2, 4, 5, 2, '2025-01-30');   -- mouse