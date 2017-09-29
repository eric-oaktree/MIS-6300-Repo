use AdventureWorksDW2012;


/*1, Display number of orders and total sales amount(sum of SalesAmount) of Internet Sales in 1st quarter each year in each country. Note: your result set should produce a total of 18 rows. */
Select dd.CalendarYear, dg.EnglishCountryRegionName, sum(fi.SalesAmount) as Amount
FROM dbo.DimDate as dd INNER JOIN dbo.FactInternetSales as fi
ON dd.DateKey = fi.OrderDateKey
INNER JOIN dbo.DimGeography as dg
ON dg.SalesTerritoryKey = fi.SalesTerritoryKey 
WHERE dd.CalendarQuarter = 1
group by dd.CalendarYear, dg.EnglishCountryRegionName;

/*2, Show total reseller sales amount (sum of SalesAmount), calendar quarter of order date, product category name and reseller’s business type by quarter by category and by business type in 2006. Note: your result set should produce a total of 44 rows. */
SELECT dd.CalendarQuarter, dpc.englishproductcategoryname as 'Category Name', dr.BusinessType, sum(rs.SalesAmount) as Amount
FROM dbo.DimDate as dd INNER JOIN dbo.FactResellerSales as rs  ON dd.DateKey = rs.OrderDateKey
INNER JOIN dbo.DimProduct as dp ON dp.productkey = rs.productkey
INNER JOIN dbo.DimProductSubcategory as dps ON dp.productsubcategorykey = dps.productsubcategorykey
INNER JOIN dbo.DimProductCategory as dpc ON dps.productcategorykey = dpc.productcategorykey
INNER JOIN dbo.DimReseller as dr ON rs.ResellerKey = dr.ResellerKey
WHERE dd.CalendarYear = 2006
GROUP BY dd.CalendarQuarter, dpc.englishproductcategoryname, dr.BusinessType
ORDER BY dd.CalendarQuarter, dpc.EnglishProductCategoryName, dr.BusinessType;

/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing, i.e. what do you do to what dimension(s)? Why is it a operation of slicing?*/
/* I will perform a slice by selecting "bikes" by using a where clause on the Category Name dimension.  this is a slice because it restricts one dimension, showing a slice of the olap cube*/
SELECT dd.CalendarQuarter, dpc.englishproductcategoryname as 'Category Name', dr.BusinessType, sum(rs.SalesAmount) as Amount
FROM dbo.DimDate as dd INNER JOIN dbo.FactResellerSales as rs  ON dd.DateKey = rs.OrderDateKey
INNER JOIN dbo.DimProduct as dp ON dp.productkey = rs.productkey
INNER JOIN dbo.DimProductSubcategory as dps ON dp.productsubcategorykey = dps.productsubcategorykey
INNER JOIN dbo.DimProductCategory as dpc ON dps.productcategorykey = dpc.productcategorykey
INNER JOIN dbo.DimReseller as dr ON rs.ResellerKey = dr.ResellerKey
WHERE dd.CalendarYear = 2006 and dpc.englishproductcategoryname = 'Bikes'
GROUP BY dd.CalendarQuarter, dpc.englishproductcategoryname, dr.BusinessType
ORDER BY dd.CalendarQuarter, dpc.EnglishProductCategoryName, dr.BusinessType;

/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the drill-down, i.e. what do you do to what dimension(s)? Why is it a operation of drilling-down?*/
/* I am perfoming a drill down by moving from quarters to months of the year.  This is a drill down beacause it increases the detail of the data along the Year, Quarter, Month Hierarchy.  You could also drill down by increasing the category detail to subcategory instead of category. */
SELECT dd.EnglishMonthName, dpc.englishproductcategoryname as 'Category Name', dr.BusinessType, sum(rs.SalesAmount) as Amount
FROM dbo.DimDate as dd INNER JOIN dbo.FactResellerSales as rs  ON dd.DateKey = rs.OrderDateKey
INNER JOIN dbo.DimProduct as dp ON dp.productkey = rs.productkey
INNER JOIN dbo.DimProductSubcategory as dps ON dp.productsubcategorykey = dps.productsubcategorykey
INNER JOIN dbo.DimProductCategory as dpc ON dps.productcategorykey = dpc.productcategorykey
INNER JOIN dbo.DimReseller as dr ON rs.ResellerKey = dr.ResellerKey
WHERE dd.CalendarYear = 2006
GROUP BY dd.EnglishMonthName, dpc.englishproductcategoryname, dr.BusinessType
ORDER BY dd.EnglishMonthName, dpc.EnglishProductCategoryName, dr.BusinessType;