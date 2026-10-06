USE HarvestBoxDB;
GO

-- REPORT 1: Detailed order report
SELECT
    o.OrderID,
    c.CustomerName,
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
GO


-- REPORT 2: Customer order summary
SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS OrderCount,
    COALESCE(SUM(o.Quantity * p.UnitPrice), 0) AS TotalSpent
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
LEFT JOIN Products AS p
    ON o.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;
GO
