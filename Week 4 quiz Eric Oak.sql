use AdventureWorks2012;

/*a.	Show First name and last name of employees whose job title is “Sales Representative”, ranking from oldest to youngest. 
You may use HumanResources.Employee table and Person.Person table. (14 rows)*/
SELECT p.FirstName, p.LastName
FROM HumanResources.Employee as e INNER JOIN Person.Person as p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.JobTitle = 'Sales Representative'
ORDER BY e.BirthDate;
/* i only showed the first and last name - if you want to see the title and birth date ranking the SELECT function would be SELECT p.FirstName, p.LastName, e.JobTitle, e.BirthDate*/

/*b.	Find out all the products which sold more than $5000 in total. Show product ID and name and total amount collected after selling the products. 
You may use LineTotal from Sales.SalesOrderDetail table and Production.Product table. (254 rows)*/
SELECT p.ProductID, p.Name, sum(od.LineTotal)
FROM Sales.SalesOrderDetail as od INNER JOIN Production.Product as p ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.Name
HAVING sum(od.linetotal) > 5000;

/*c.	Show BusinessEntityID, territory name and SalesYTD of all sales persons whose SalesYTD is greater than $500,000, regardless of whether they are 
assigned a territory. You may use Sales.SalesPerson table and Sales.SalesTerritory table. (16 rows)*/
SELECT sp.BusinessEntityID, st.Name, sp.SalesYTD
FROM Sales.SalesPerson as sp LEFT OUTER JOIN Sales.SalesTerritory as st ON sp.TerritoryID = st.TerritoryID
WHERE sp.SalesYTD > 500000;


/*d.	Show the sales order ID of those orders in the year 2008 of which the total due is great than 
the average total due of all the orders of the 
same year. (3200 rows)*/
SELECT SalesOrderID
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2008 and TotalDue > (SELECT avg(TotalDue) FROM Sales.SalesOrderHeader WHERE YEAR(OrderDate) = 2008 );