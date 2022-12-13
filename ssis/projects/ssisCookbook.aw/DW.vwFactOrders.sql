USE AdventureworksLTDW2016;
GO 

CREATE VIEW [DW].[vwFactOrders] AS
SELECT OrderDate, c.FirstName, c.LastName, c.CompanyName, p.Category, 
       p.ProductName, op.ProvenanceCode, op.ProvenanceDescription, 
       p.EnglishDescription, OrderQy, UnitPrice, Discount, 
       TaxAmount, Freight, SalesOrderNumber, PurchareOrderNumber
	   FROM DW.FactOrders AS f 
       INNER JOIN DW.DimCustomer AS c ON f.IDCustomer=c.IDCustomer
	   INNER JOIN DW.DimProduct AS p ON  f.IDProduct=p.IDProduct
	   INNER JOIN DW.DimOrderProvenance AS op ON f.IDOrderProvenance=op.IDOrderProvenance;
GO

CREATE DATABASE dwstaging;

USE dwstaging;

DROP TABLE SalesExtracts;

CREATE EXTERNAL TABLE SalesExtracts(
OrderDate timestamp,
FirstName string ,
LastName string ,
CompanyName string ,
Category string ,
ProductName string ,
ProvenanceCode smallint ,
ProvenanceDescription string ,
EnglishDescription string ,
OrderQy int,
UnitPrice decimal(12,4),
Discount decimal(12,4),
TaxAmount decimal(12,4),
Freight decimal(12,4),
SalesOrderNumber string ,
PurchaseOrderNumber string,
LoadExecutionId int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/dwstaging/Import/'
tblproperties("skip.header.line.count"="1"); 


CREATE TABLE IF NOT EXISTS HDPDWHiveTable
(                                  
    company         string,                                   
    category        string,  
    qtyordered      int,
    unitprice       decimal(12,4),
    discount        decimal(3,2),
    tax             decimal(12,4),
    freight         decimal(12,4),
    ordernumber     string,
    po              string                               
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',|' LINES TERMINATED BY '10' STORED AS TEXTFILE
LOCATION '/dwstaging/Export/';


INSERT OVERWRITE TABLE HDPDWHiveTable
SELECT CompanyName, Category ,   SUM(OrderQy) AS OrderQy, AVG(UnitPrice) AS UnitPrice, SUM(Discount) AS Discount, SUM(TaxAmount) AS TaxAmount, SUM(Freight) AS Freight, 
             SalesOrderNumber, PurchaseOrderNumber
FROM   SalesExtracts
GROUP BY CompanyName, Category, SalesOrderNumber, PurchaseOrderNumber;