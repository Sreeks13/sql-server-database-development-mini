USE HarvestBoxDB;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetOrderReport
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        o.OrderID,
        c.CustomerName,
        c.City,
        p.ProductName,
        o.Quantity,
        p.UnitPrice,
        o.Quantity * p.UnitPrice AS TotalAmount,
        o.OrderDate
    FROM Orders AS o
    INNER JOIN Customers AS c
        ON o.CustomerID = c.CustomerID
    INNER JOIN Products AS p
        ON o.ProductID = p.ProductID
    ORDER BY o.OrderDate, o.OrderID;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetCustomerOrderSummary
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.CustomerID,
        c.CustomerName,
        COUNT(o.OrderID) AS OrderCount,
        COALESCE(SUM(o.Quantity * p.UnitPrice), 0) AS TotalSpent
    FROM Customers AS c
    LEFT JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    LEFT JOIN Products AS p
        ON o.ProductID = p.ProductID
    GROUP BY
        c.CustomerID,
        c.CustomerName
    ORDER BY c.CustomerID;
END;
GO
