USE AdventureWorks2012; /*Set current database*/


/*1, Display the total amount collected from the orders for each order date. */
SELECT sh.OrderDate
      ,SUM(sh.TotalDue)
FROM sales.SalesOrderHeader as sh
GROUP BY sh.OrderDate
ORDER BY SUM(sh.TotalDue) DESC;

/*2, Display the total amount collected from selling each of the products, 774 and 777.*/
SELECT sd.ProductID
      ,SUM(sh.TotalDue)
FROM sales.SalesOrderHeader as sh INNER JOIN sales.SalesOrderDetail as sd
ON sh.SalesOrderID = sd.SalesOrderID
WHERE sd.ProductID IN (774, 777)
GROUP BY sd.ProductID
ORDER BY SUM(sh.TotalDue) DESC;


/*3, Write a query to display the sales person BusinessEntityID, last name and first name of ALL the sales persons and the name of the territory to which they belong, even though they don't belong to any territory.*/
SELECT p.BusinessEntityID, p.FirstName, p.LastName, st.name
FROM person.Person as p INNER JOIN sales.SalesPerson as sp 
		ON sp.BusinessEntityID = p.BusinessEntityID 
	LEFT OUTER JOIN sales.SalesTerritory as st 
		ON sp.TerritoryID = st.TerritoryID;


/*4,  Write a query to display the Business Entities (IDs, names) of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
SELECT cc.BusinessEntityID, p.FirstName, p.LastName, s.CardType
FROM Person.Person as p
INNER JOIN sales.PersonCreditCard as cc
ON p.BusinessEntityID = cc.BusinessEntityID
INNER JOIN sales.CreditCard as s 
ON cc.CreditCardID = s.CreditCardID
WHERE s.CardType = 'Vista';

/*5, Write a query to display ALL the countries/regions along with their corresponding territory IDs, including those the countries/regions that do not belong to any territory.*/
/* tables: Sales.SalesTerritory and Person.CountryRegion*/
SELECT cr.CountryRegionCode, st.TerritoryID
FROM Person.CountryRegion as cr LEFT OUTER JOIN sales.SalesTerritory as st
ON cr.CountryRegionCode = st.CountryRegionCode;


/*6, Find out the average of the total dues of all the orders.*/
SELECT avg(s.TotalDue)
FROM sales.SalesOrderHeader as s;

/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/
SELECT oh.SalesOrderID
FROM sales.SalesOrderHeader as oh
WHERE oh.TotalDue >
	(SELECT avg(TotalDue)
	 FROM sales.SalesOrderHeader);
