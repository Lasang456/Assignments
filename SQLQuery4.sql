--1 A view is a virtual table that contains data from one or multiple table.. It contains rows and column.
--2 A views can be used in quaries to modify data.
--3 Stored procedure ia a collection of SQL statements and commands login stored and compiled in database. It is prepared sql quary that we can save and reuse. 
--4 View ia a simple showcasing data stored in the database tables and stored procedure is acollection of statements that can be executed. A view is faster.
--5 In a function there must be a return value but in stored procedure it is optional. Function can be called from stored procedure whereas procedure cannot be called from function.
--6 Yes, stored procedure can return multiple result sets.
--7 Yes, stored procedure can be executed as part of SELECT Statement because stored procedure returns a result set.
--8 Trigger is a special type of stored procedure which defines a set of actions that are performed in response to operations on a specified table. Different types of trigger are:
	--DML: INSERT UPDATE DELETE
	--DDL: CREATE ALTER DROP
	--LOGON: AUTHENTICATION
--9 Stored is a user defined written in a local version of SQL where as trigger is a stored procedure that runs automatically when various operations takes place.

SELECT * FROM Products

--QUestion 1
CREATE VIEW view_product_order_Lama
AS 
SELECT ProductName,SUM(Quantity) AS lOrderQuantity 
FROM [Order Details] od JOIN Products p ON od.ProductID = p.ProductID
GROUP BY ProductName

--Question 2
 CREATE PROC sp_product_order_quantity_Lama
 @id int,
 @quantity int out
 AS
 BEGIN
 SELECT @quantity = SUM(Quantity) 
 FROM [Order Details] od JOIN Products p ON od.ProductID = p.ProductID 
 WHERE @id=p.ProductID
 END

 DECLARE @Ans INT
EXEC sp_Product_Order_Quantity_Lama 9,@Ans OUT
PRINT @ans 

 SELECT * FROM Products

 --Question 3
  CREATE PROC sp_product_order_city_Lama
 @ProductName VARCHAR(55)
 AS
 BEGIN
 SELECT TOP 5 ShipCity, SUM(Quantity) AS TheSum
 FROM  [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
 WHERE @ProductName=ProductName 
 GROUP BY ShipCity, ProductName
 ORDER BY SUM(Quantity) DESC
 END


 EXEC sp_product_order_city_Lama 'Hanari Carnes'


 --Question 4
 CREATE TABLE People_Lama(
 Id int,
 Name nvarchar(25),
 City int
 )

 CREATE TABLE City_Lama(
 ID int,
 City nvarchar(25) 
 )

 INSERT into People_Lama VALUES(1, 'Aaron Rodgers', 2)
 INSERT into People_Lama VALUES(2, 'Russell Wilson', 1)
 INSERT into People_Lama VALUES(3, 'Jody Nelson', 2)

 SELECT *FROM People_Lama

 INSERT INTO City_Lama VALUES(1, 'Seattle')
 INSERT INTO City_Lama VALUES(2, 'Green Bay')
  SELECT *FROM City_Lama
  
  IF exists(SELECT Id FROM People_Lama WHERE City=(SELECT Id FROM City_Lama WHERE City='Seattle'))
  BEGIN
  INSERT INTO City_Lama VALUES(3, 'Madison')
  UPDATE People_Lama
  SET City = 'Madison'
  WHERE Id in(select Id from People_Lama where city = (SELECT Id from City_Lama where city = 'Seatle'))
  END
  DELETE FROM City_Lama WHERE City='Seattle'

  CREATE VIEW Packers_Lama
  AS
  SELECT Name FROM People_Lama WHERE City='Green Bay'

  SELECT * FROM Packers_Lama
  COMMIT
  DROP TABLE People_Lama
  DROP TABLE City_Lama
  DROP VIEW Packers_Lama

  --Question 5
  ALTER PROC sp_birthday_employee_Lama
  AS
  BEGIN
  SELECT * INTO #EmployeeTemp
  FROM Employees WHERE DATEPART(MM,BirthDate) = 02
  SELECT * FROM #EmployeeTemp
  END

  --6 By using EXCEPT keyword

 --7 SELECT firstName+' '+lastName 
 --FROM Person 
 --WHERE middleName is null 
 --UNION
 --SELECT firstName+' '+lastName+' '+middelName+'.' 
 --FROM Person 
 --WHERE middleName is not null

 --8 SELECT TOP 1 marks
 --FROM student 
 --WHERE sex = 'F' 
 --ORDER BY marks desc

 --9
 --SELECT * FROM students ORDER BY Sex, Marks