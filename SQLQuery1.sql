use AdventureWorks2019
GO

--Question 1
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product

--Question 2
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product
WHERE ListPrice != '0'

--Question 3
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product
WHERE Color IS Null

--Question 4
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product
WHERE Color IS NOT Null

--Question 5
SELECT ProductID, Name, Color, ListPrice 
FROM Production.Product
WHERE Color IS NOT Null AND ListPrice >'0'

--Question 6
SELECT (Name+' '+Color) 
FROM Production.Product
WHERE Color IS NOT Null

--Question 7
SELECT ('NAME: '+Name+' -- '+'COLOR: '+Color) AS 'Name And Color'
FROM Production.Product
WHERE Color IS NOT Null

--Question 8
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN '400' AND '500'

--Question 9
SELECT ProductID, Name, Color 
FROM Production.Product
WHERE Color != 'black' AND Color !='blue'

--Question 10
SELECT Name AS Products 
FROM Production.Product
WHERE Name LIKE 'S%'

--Question 11
SELECT Name AS Name, ListPrice AS ListPrice
FROM Production.Product
WHERE Color IS Null
ORDER BY Name

--Question 12
SELECT Name AS Name, ListPrice AS ListPrice
FROM Production.Product
WHERE Name LIKE 'A%' OR Name LIKE 'S%'
ORDER BY Name

--Question 13
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY Name

--Question 14
SELECT DISTINCT Color
FROM Production.Product
WHERE Color IS NOT Null
ORDER BY Color DESC

--Question 15
SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE Color IS NOT Null AND ProductSubcategoryID IS NOT NULL
