/* ============================================================
UŽDUOTIS 3 Produktų kategorijų pelningumo analizė per laiką, teritorijose ir pardavimo 
kanaluose 
Naudok Production_Product, Production_ProductSubcategory, Production_ProductCategory, 
Sales_SalesOrderDetail, Sales_SalesTerritory ir Sales_SalesOrderHeader lenteles.

- Šiose lentelėse NETURIME savikainos (COGS), todėl „pelningumas“
  šiame uždavinyje reiškia PAJAMAS (Revenue).
- Pajamos imamos iš Sales_SalesOrderDetail.LineTotal (eilutės suma).
============================================================ */
 
 
/* ============================================================
1) Susiek produktus su subkategorijomis, kategorijomis, teritorijomis
   ir pardavimo kanalais.

Idėja: pirmiausia pasidarom „švarią bazę“ su teisingu grūdėtumu:
Category x Territory x Channel x Year x Quarter.
============================================================ */

USE adv;


WITH main_CTE AS (
	SELECT
		pc.ProductCategoryID,
		pc.Name category_name,
		st.TerritoryID,
		st.Name territory_name,
		CASE
			WHEN soh.OnlineOrderFlag = 1 THEN 'Online'
			ELSE 'Direct'
		END AS payment_channel,
		YEAR(soh.orderDate) AS order_year,
		QUARTER(soh.OrderDate) AS order_quarter,
		ROUND(SUM(sod.LineTotal), 2) AS subtotal_revenue
	FROM
		production_product p
	LEFT JOIN production_productsubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	LEFT JOIN production_productcategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
	JOIN sales_salesorderdetail sod ON p.ProductID = sod.ProductID
	JOIN sales_salesorderheader soh ON sod.SalesOrderID = soh.SalesOrderID
	JOIN sales_salesterritory st ON soh.TerritoryID = st.TerritoryID
	GROUP BY pc.ProductCategoryID, pc.Name, st.TerritoryID, st.Name, payment_channel, order_year, order_quarter
    ORDER BY pc.ProductCategoryID, st.TerritoryID, payment_channel, order_year, order_quarter
)
SELECT
	main_CTE.*,
    SUM(subtotal_revenue) OVER (
        PARTITION BY ProductCategoryID, TerritoryID, payment_channel, order_year, order_quarter
        -- ORDER BY year, quarter
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningRevenueQuarterTD,
    
    SUM(subtotal_revenue) OVER (
        PARTITION BY ProductCategoryID, TerritoryID, payment_channel, order_year
        -- ORDER BY year, quarter
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningRevenueYearTD
FROM
	main_CTE;

