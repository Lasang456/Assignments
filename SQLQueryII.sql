use AdventureWorks2019
GO
1.	What is a result set?
Result set is a set of records, could be empty or not, returned by a select statement, or a stored procedure, that is saved in RAM or displayed on the screen.

2.	What is the difference between Union and Union All?
Union removes duplicate records, but Union All does not remove duplicates. While using Union the records from the first column will be sorted ascendingly. Union cannot be used in recursive cte, but Union All can be used.
 
3.	What are the other Set Operators SQL Server has?
Intersect, Except, and MINUS are other Set Operators other than Union and Union All in the SQL Server.

4.	What is the difference between Union and Join?
Union combines the result-set of two or more SELECT statements whereas, Join combines data from many tables based on a matched condition. Union combines data into new row, but Join combines data into new column. 

5.	What is the difference between INNER JOIN and FULL JOIN?
INNER JOIN returns all the matching rows between both tables and other rows are eliminated, whereas, FULL JOIN returns all the rows from both the tables.

6.	What is difference between left join and outer join?
Left join is a kind of outer join. Left outer join will return all rows from left query, even if there are unmatched data. There are another two kinds of outer joins, which are right join and full join.  


7.	What is cross join?
A cross join returns the Cartesian product of rows from the rowsets in the join. In other words, it will combine each row from the first rowset with each row from the second rowset.

8.	What is the difference between WHERE clause and HAVING clause?
A HAVING clause is like a WHERE clause but applies only to groups as a whole (that is, to the rows in the result set representing groups), whereas the WHERE clause applies to individual rows.

9.	Can there be multiple group by columns?
Yes, clause can contain multiple columns.


--Question 1
SELECT COUNT(*)
FROM Production.Product

--Question 2
SELECT COUNT(ProductID)
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL;

--Question 3
SELECT ProductSubcategoryID, COUNT(ProductID) AS CountedProducts
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

--Question 4
SELECT COUNT(ProductID)
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NULL

--Question 5
SELECT SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY ProductID;

--Question 6
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory 
WHERE LocationID=40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;
 

--Question 7
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID =40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity)<100;

--Question 8
SELECT ProductID, AVG(Quantity)
FROM Production.ProductInventory
WHERE LocationID=10
GROUP BY ProductID

--Question 9
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY Shelf, ProductID

--Question 10
SELECT ProductID, Shelf, AVG(Quantity)
FROM Production.ProductInventory
WHERE Shelf <> 'N/A'
GROUP BY ProductID, Shelf;

--Question 11
SELECT Color, Class, Count(*) AS TheSum, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class;

--Question 12
SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s
ON c.CountryRegionCode=s.CountryRegionCode

--Question 13
SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s
ON c.CountryRegionCode=s.CountryRegionCode
WHERE c.Name = 'Germany' OR c.Name = 'Canada' 

--Using Northwind Database
--Question 14
SELECT DISTINCT p.ProductID, p.ProductName
FROM Orders o JOIN [Order Details] od
ON o.OrderID =  od.OrderID JOIN Products p
ON od.ProductID = p.ProductID
WHERE DATEDIFF(year, o.OrderDate, GETDATE())< 25;

--Question 15
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) as Quantity 
FROM Orders o JOIN [Order Details] od
ON o.OrderID =  od.OrderID
WHERE o.ShipPostalCode IS NOT NULL
GROUP BY ShipPostalCode
ORDER BY Quantity DESC;

--Question 16
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity) as Quantity 
FROM Orders o JOIN [Order Details] od
ON o.OrderID =  od.OrderID
WHERE o.ShipPostalCode IS NOT NULL AND DATEDIFF(year, o.OrderDate, GETDATE())< 25
GROUP BY ShipPostalCode

--Question 17
SELECT City, COUNT(CustomerID) AS TheSumofCustomers
FROM Customers
GROUP BY City

--Question 18
SELECT City, COUNT(CustomerID) AS TheSumofCustomers
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID)>2

--Question 19
SELECT c.CustomerID, c.CompanyName, c.ContactName, o.OrderDate
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE OrderDate > '1998-1-1'

--Question 20
SELECT c.ContactName, o.OrderDate
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY OrderDate DESC

--Question 21
SELECT c.CustomerID, c.CompanyName, c.ContactName, SUM(od.Quantity) AS Quantity 
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] odON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName
ORDER BY Quantity

--Question 22
SELECT c.CustomerID, SUM(od.Quantity) AS Quantity 
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity)>100
ORDER BY Quantity

--Question 23
SELECT DISTINCT sup.CompanyName, ship.CompanyName 
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
RIGHT JOIN Suppliers sup ON p.SupplierID = sup.SupplierID
INNER JOIN Shippers ship  ON o.ShipVia = ship.ShipperID;

--Question 24
SELECT DISTINCT o.OrderDate, p.ProductNAme 
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate

--Question 25
SELECT Title, FirstName+' '+LastName AS Name
FROM Employees
ORDER BY Title

--Question 26
SELECT T1.EmployeeId, T1.LastName, T1.FirstName,T2.ReportsTo, COUNT(T2.ReportsTo) AS Subordinate  
FROM Employees T1 JOIN Employees T2 ON T1.EmployeeId = T2.ReportsTo
WHERE T2.ReportsTo IS NOT NULL
GROUP BY T1.EmployeeId, T1.LastName, T1.FirstName,T2.ReportsTo
HAVING COUNT(T2.ReportsTo) > 2

--Question 27
SELECT c.City, c.CompanyName, c.ContactName, 'Customer' as Type
FROM Customers c
UNION
SELECT s.City, s.CompanyName, s.ContactName, 'Supplier' as Type
FROM Suppliers s;

SELECT * FROM Customers
SELECT * FROM Employees 
SELECT * FROM Production.ProductInventory

