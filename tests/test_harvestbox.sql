USE HarvestBoxDB;
GO

DECLARE @CustomerCount INT;
DECLARE @ProductCount INT;
DECLARE @OrderCount INT;

SELECT @CustomerCount = COUNT(*) FROM Customers;
SELECT @ProductCount = COUNT(*) FROM Products;
SELECT @OrderCount = COUNT(*) FROM Orders;

IF @CustomerCount <> 4
    THROW 50001, 'Customer test failed.', 1;

IF @ProductCount <> 4
    THROW 50002, 'Product test failed.', 1;

IF @OrderCount <> 5
    THROW 50003, 'Order test failed.', 1;

IF OBJECT_ID('dbo.usp_GetOrderReport', 'P') IS NULL
    THROW 50004, 'usp_GetOrderReport is missing.', 1;

IF OBJECT_ID('dbo.usp_GetCustomerOrderSummary', 'P') IS NULL
    THROW 50005, 'usp_GetCustomerOrderSummary is missing.', 1;

DECLARE @ReportRows INT;

SELECT @ReportRows = COUNT(*)
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
INNER JOIN Products AS p
    ON o.ProductID = p.ProductID;

IF @ReportRows <> 5
    THROW 50006, 'Order report test failed.', 1;

DECLARE @ExpectedTotal DECIMAL(10,2);

SELECT @ExpectedTotal =
    SUM(o.Quantity * p.UnitPrice)
FROM Orders AS o
INNER JOIN Products AS p
    ON o.ProductID = p.ProductID;

IF @ExpectedTotal <> 1220.00
    THROW 50007, 'Total amount test failed.', 1;

PRINT 'ALL HARVESTBOX TESTS PASSED';
GO
