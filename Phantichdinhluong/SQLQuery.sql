use [AdventureWorks2022]

SELECT OD.ProductID, OH.CustomerID , OH.SalesOrderID ,OD.OrderQty, OD.UnitPrice, OD.UnitPriceDiscount,P1.Class,
OH.OrderDate, SS.Name as StoreName,C.Name as Region, sum(OD.[OrderQty] * OD.[UnitPrice]*(1 - OD.[UnitPriceDiscount])) as totalsale
from [Sales].[SalesOrderDetail] OD join [Sales].[SalesOrderHeader] OH
on OD.SalesOrderID = OH.SalesOrderID
JOIN [Sales].[Customer] SC ON OH.CustomerID = SC.CustomerID
JOIN [Sales].[Store] SS ON SC.StoreID = SS.BusinessEntityID
JOIN [Person].[BusinessEntity] P ON P.BusinessEntityID = SS.BusinessEntityID

JOIN [Person].[BusinessEntityAddress] PA ON P.BusinessEntityID = PA.BusinessEntityID
JOIN [Person].[Address] A ON PA.AddressID = A.AddressID
JOIN [Person].[StateProvince] SP ON A.StateProvinceID = SP.StateProvinceID
JOIN [Person].[CountryRegion] C ON SP.CountryRegionCode = C.CountryRegionCode

JOIN [Production].[Product] P1 ON P1.ProductID = OD.ProductID

where OD.ProductID in (select  P.ProductID from
[Production].[Product] P join [Production].[ProductSubcategory] PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN [Production].[ProductCategory] PC
ON PC.ProductCategoryID = PS.ProductCategoryID
where PC.ProductCategoryID= 1)
group by OD.ProductID, OH.CustomerID , OH.SalesOrderID ,OD.OrderQty, OD.UnitPrice, OD.UnitPriceDiscount,P1.Class,
OH.OrderDate, SS.Name ,C.Name 



CREATE TABLE BikeSales1( 
	ProductID int,
    CustomerID int,
    SalesOrderID int,
    OrderQty smallint,
	Class nchar(2),
    UnitPrice nvarchar(50),
    UnitPriceDiscount nvarchar(50),
    OrderDate datetime,
    StoreName nvarchar(50),
    Region nvarchar(50),
    Totalsale money
);
insert into  BikeSales1(ProductID, CustomerID,SalesOrderID,OrderQty,Class,UnitPrice,UnitPriceDiscount, OrderDate,StoreName,Region,
				 Totalsale)
SELECT OD.ProductID, OH.CustomerID , OH.SalesOrderID ,OD.OrderQty,P1.Class ,OD.UnitPrice, OD.UnitPriceDiscount,
OH.OrderDate, SS.Name as StoreName,C.Name as Region, sum(OD.[OrderQty] * OD.[UnitPrice]*(1 - OD.[UnitPriceDiscount])) as totalsale
from [Sales].[SalesOrderDetail] OD join [Sales].[SalesOrderHeader] OH
on OD.SalesOrderID = OH.SalesOrderID
JOIN [Sales].[Customer] SC ON OH.CustomerID = SC.CustomerID
JOIN [Sales].[Store] SS ON SC.StoreID = SS.BusinessEntityID
JOIN [Person].[BusinessEntity] P ON P.BusinessEntityID = SS.BusinessEntityID

JOIN [Person].[BusinessEntityAddress] PA ON P.BusinessEntityID = PA.BusinessEntityID
JOIN [Person].[Address] A ON PA.AddressID = A.AddressID
JOIN [Person].[StateProvince] SP ON A.StateProvinceID = SP.StateProvinceID
JOIN [Person].[CountryRegion] C ON SP.CountryRegionCode = C.CountryRegionCode

JOIN [Production].[Product] P1 ON P1.ProductID = OD.ProductID

where OD.ProductID in (select  P.ProductID from
[Production].[Product] P join [Production].[ProductSubcategory] PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN [Production].[ProductCategory] PC
ON PC.ProductCategoryID = PS.ProductCategoryID
where PC.ProductCategoryID= 1)
group by OD.ProductID, OH.CustomerID , OH.SalesOrderID ,OD.OrderQty,P1.Class, OD.UnitPrice, OD.UnitPriceDiscount,OH.Status,
OH.OrderDate, SS.Name ,C.Name 