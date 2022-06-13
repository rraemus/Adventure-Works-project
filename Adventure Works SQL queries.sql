-- I selected and cleansed the data that will be used in the creation of a Power BI dashboard

-- Cleansed DimDate table --
SELECT [DateKey],
      [FullDateAlternateKey] AS Date,
      [EnglishDayNameOfWeek] AS Day,
      [EnglishMonthName] AS Month,
	  Left([EnglishMonthName], 3) AS MonthShort,
      [MonthNumberOfYear] AS MonthNo,
      [CalendarQuarter] AS Quarter,
      [CalendarYear] AS Year
  FROM [AdventureWorksDW2019].[dbo].[DimDate]
  WHERE CalendarYear >= 2019


-- Cleansed DimProduct table --
SELECT p.[ProductKey],
       p.[ProductAlternateKey] AS ProductItemCode,
       p.[EnglishProductName] AS ProductName,
	   ps.EnglishProductSubcategoryName AS ProductSubCategory,
	   pc.EnglishProductCategoryName AS ProductCategory,
       p.[Color] AS ProductColor,
       p.[Size] AS ProductSize,
       p.[ProductLine] AS ProductLine,
       p.[ModelName] AS ProductModelName,
       p.[EnglishDescription] AS ProductDescription,
       ISNULL(p.Status, 'Outdated') AS ProductStatus
FROM [AdventureWorksDW2019].[dbo].[DimProduct] AS p
LEFT JOIN [AdventureWorksDW2019].dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN [AdventureWorksDW2019].dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY p.ProductKey ASC


-- Cleansed DimCustomer table --
SELECT c.[CustomerKey] AS CustomerKey,
       c.[FirstName] AS FirstName,
       c.[LastName] AS LastName,
	   c.[FirstName] +' '+ [LastName] AS FullName,
       CASE [Gender] WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender,
       c.[DateFirstPurchase] AS DateFirstPurchase,
	   g.[city] AS CustomerCity
FROM   [AdventureWorksDW2019].[dbo].[DimCustomer] AS c
LEFT JOIN AdventureWorksDW2019.dbo.DimGeography AS g on g.geographykey = c.geographykey
ORDER BY CustomerKey ASC


-- Cleansed FactInternetSales table --
SELECT [ProductKey],
       [OrderDateKey],
       [DueDateKey],
       [ShipDateKey],
       [CustomerKey],      
       [SalesOrderNumber],
       [SalesAmount]
FROM   [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE  LEFT (OrderDateKey, 4) >= 2019
ORDER BY OrderDateKey ASC