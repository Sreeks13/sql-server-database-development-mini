IF DB_ID('HarvestBoxDB') IS NOT NULL
BEGIN
    ALTER DATABASE HarvestBoxDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HarvestBoxDB;
END
GO

CREATE DATABASE HarvestBoxDB;
GO

USE HarvestBoxDB;
GO

CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    City NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    OrderDate DATE NOT NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
GO

INSERT INTO Customers (CustomerName, City)
VALUES
('Rahul Sharma', 'Mumbai'),
('Priya Singh', 'Delhi'),
('Arjun Kumar', 'Bengaluru'),
('Neha Reddy', 'Hyderabad');
GO

INSERT INTO Products (ProductName, UnitPrice)
VALUES
('Organic Tomatoes', 80.00),
('Fresh Spinach', 40.00),
('Farm Potatoes', 60.00),
('Organic Carrots', 50.00);
GO

INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate)
VALUES
(1, 1, 5, '2026-10-01'),
(1, 2, 3, '2026-10-02'),
(2, 3, 4, '2026-10-02'),
(3, 4, 6, '2026-10-03'),
(4, 1, 2, '2026-10-04');
GO
