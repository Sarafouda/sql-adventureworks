SELECT *
FROM Production.Product
WHERE ListPrice > 100

SELECT * FROM Sales.SalesOrderHeader WHERE YEAR(OrderDate) > 2013
SELECT * FROM Sales.SalesTerritory WHERE [Group] = 'North America'
SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 1
SELECT * FROM Production.Product WHERE SafetyStockLevel < 500
SELECT * FROM Sales.SalesOrderHeader WHERE OrderDate BETWEEN '2011-05-31' AND '2013-04-22' AND TotalDue > 1000
SELECT * FROM Production.Product WHERE ListPrice > 500 AND Color IS NOT NULL

SELECT DISTINCT Name FROM Sales.SalesTerritory
SELECT DISTINCT * FROM Sales.SalesTerritory
SELECT DISTINCT Name FROM Production.ProductCategory
SELECT DISTINCT YEAR(OrderDate) AS OrderYear From Sales.SalesOrderHeader
SELECT DISTINCT Color FROM Production.Product WHERE Color IS NOT Null 
SELECT DISTINCT Name FROM Production.ProductSubcategory
SELECT DISTINCT ProductID FROM Sales.SalesOrderDetail
SELECT DISTINCT [Group] FROM Sales.SalesTerritory

SELECT * FROM Production.Product WHERE ListPrice BETWEEN 50 AND 200
SELECT * FROM Production.Product WHERE Name LIKE 'B%'
SELECT * FROM Sales.SalesOrderHeader WHERE TerritoryID IN (1, 3)
SELECT * FROM Sales.SalesOrderHeader WHERE OrderDate BETWEEN '2011-05-31' AND '2013-04-22'
SELECT * FROM Production.Product WHERE ProductSubcategoryID NOT IN (1, 4 ,5)
SELECT * FROM Production.Product WHERE Name LIKE '%Road%'
SELECT * FROM Sales.SalesOrderHeader WHERE TotalDue >= 5000

SELECT ProductID, Name, ListPrice FROM Production.Product ORDER BY ListPrice ASC
SELECT Name FROM Sales.SalesTerritory ORDER BY Name DESC
SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader ORDER BY OrderDate ASC
SELECT LineTotal FROM Sales.SalesOrderDetail ORDER BY LineTotal DESC
SELECT Name, ListPrice FROM Production.Product ORDER BY ListPrice ASC
SELECT SalesOrderID, TotalDue FROM Sales.SalesOrderHeader ORDER BY TotalDue DESC
SELECT ProductCategoryID, Name FROM Production.ProductSubcategory ORDER BY ProductCategoryID ASC
-- Aggregation --
SELECT SUM(LineTotal) AS Total_Line_Amount FROM Sales.SalesOrderDetail
SELECT AVG(ListPrice) AS Avg_Price FROM Production.Product 
SELECT COUNT(SalesOrderID) AS Total_Orders FROM Sales.SalesOrderHeader
SELECT MIN(ListPrice) AS MinTotal_Orders FROM Production.Product
SELECT Max(ListPrice) AS MaxTotal_Orders FROM Production.Product
SELECT
    YEAR(OrderDate)  AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(TotalDue)    AS TotalSales
    from sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth

SELECT TerritoryID,
AVG(TotalDue) AS AvgOrderTotal
From Sales.SalesOrderHeader
GROUP BY TerritoryID
ORDER BY TerritoryID

--JOINS--
SELECT p.Name AS ProductName,
ps.Name AS SubcategoryName
FROM Production.Product P 
JOIN Production.ProductSubcategory ps 
ON p.ProductSubcategoryID = ps.ProductSubcategoryID

select * from Production.ProductCategory


SELECT P.Name AS ProductName,
pc.Name AS CategoryName
FROM Production.Product P
JOIN Production.ProductSubcategory Ps 
ON P.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON Ps.ProductCategoryID = pc.ProductCategoryID

select * from sales.SalesOrderHeader
SELECT O.SalesOrderID , O.OrderDate, O.TotalDue,
T.Name AS TerritoryName

FROM Sales.SalesOrderHeader O
LEFT JOIN Sales.SalesTerritory T
ON O.TerritoryID = T.TerritoryID

SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Production.Product
SELECT S.SalesOrderID, S.OrderQty, S.UnitPrice,
p.Name AS ProductName
FROM Sales.SalesOrderDetail S
LEFT JOIN Production.product p
ON S.ProductID = p.ProductID

--PRODUCT HIERARCHY--

SELECT * FROM Sales.SalesOrderHeader
SELECT SOH.SalesOrderID, SOH.OrderDate,
SOD.OrderQty, SOD.UnitPrice,
P.Name AS ProductName,
Ps.Name AS SubCategoryName,
Pc.Name AS CategoryName,
T.Name AS TerritoryName
From Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesOrderDetail SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
LEFT JOIN Production.Product P
ON SOD.ProductID = P.ProductID
LEFT JOIN Production.ProductSubcategory Ps
ON Ps.ProductSubcategoryID = P.ProductSubcategoryID
LEFT JOIN Production.ProductCategory Pc
ON Pc.ProductCategoryID = Ps.ProductCategoryID
LEFT JOIN Sales.SalesTerritory T
ON T.TerritoryID = SOH.TerritoryID

--Sales total per territory--

SELECT * FROM Sales.SalesOrderHeader
SELECT T.Name AS TerritoryName,
SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory T
ON SOH.TerritoryID = T.TerritoryID
GROUP BY T.Name
ORDER BY TotalSales DESC

--Total Revenue by Category--
SELECT Pc.Name AS CategoryName,
SUM(SOD.orderQTY * SOD.UnitPrice) AS TotalRevenue
FROM Sales.SalesOrderDetail SOD
LEFT JOIN Production.Product P
ON SOD.ProductID = P.ProductID
LEFT JOIN Production.ProductSubcategory Ps
ON Ps.ProductSubcategoryID = P.ProductSubcategoryID
LEFT JOIN Production.ProductCategory Pc
ON Pc.ProductCategoryID = Ps.ProductCategoryID
GROUP BY Pc.Name
ORDER BY TotalRevenue DESC

--Total Quantity Sold per subcategory--
SELECT Ps.Name AS SubCategoryName,
SUM(OrderQTY) AS TotalQtySold
FROM Sales.SalesOrderDetail SOD
LEFT JOIN Production.Product P
ON SOD.ProductID = P.ProductID
LEFT JOIN Production.ProductSubcategory Ps
ON Ps.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY Ps.Name 
ORDER BY TotalQtySold DESC

--Territory sales totals with order counts--

SELECT * FROM Sales.SalesOrderHeader
SELECT T.Name AS TerritoryName,
COUNT(SalesOrderID) AS TotalOrders,
SUM(TotalDUE) AS TotalSales
FROM Sales.SalesOrderHeader SOH
LEFT JOIN Sales.SalesTerritory T
ON SOH.TerritoryID = T.TerritoryID
GROUP BY T.Name
ORDER BY TotalSales DESC

--Product revenue with category name--
SELECT Pc.Name AS CategoryName,
P.Name AS ProductName,
SUM(SOD.OrderQTY * SOD.UnitPrice) AS ProductRevenue
FROM Sales.SalesOrderDetail SOD
LEFT JOIN Production.Product P
ON SOD.ProductID = P.ProductID
LEFT JOIN Production.ProductSubcategory Ps
ON Ps.ProductSubcategoryID = P.ProductSubcategoryID
LEFT JOIN Production.ProductCategory Pc
ON Pc.ProductCategoryID = Ps.ProductSubcategoryID
GROUP BY Pc.Name, P.Name
ORDER BY ProductRevenue DESC

--GROUP BY--

