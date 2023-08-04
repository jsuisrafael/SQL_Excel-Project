-- Projeto de Integra��o SQL/Excel

-- Banco de dados usado: AdventureWorksDW2014

-- Indicadores do projeto: 

-- 1) Total de Vendas Internet por Categoria
-- 2) Receita Total Internet por M�s do Pedido
-- 3) Receita e Custo Total Internet por Pa�s
-- 4) Total de Vendas Internet por Sexo 

-- Ano de an�lise: 2013

-- Tabelas Usadas:

-- FactInternetSales
-- DimProductCategory
-- DimSalesTerritory
-- DimCustomer

---------------------------------------------------

-- Criando a view com os dados necess�rios:

CREATE OR ALTER VIEW Vendas_Internet AS
SELECT 
	fis.SalesOrderNumber AS 'N�mero do pedido',
	fis.OrderDate AS 'Data do pedido',
	fis.OrderQuantity AS 'Quantidade do Pedido',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
	dc.Gender AS 'Sexo',
	fis.TotalProductCost AS 'Custo Venda',
	fis.SalesAmount AS 'Receita Venda',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dst.SalesTerritoryCountry AS 'Pa�s'
FROM
	FactInternetSales fis
INNER JOIN DimProduct dp
	ON fis.ProductKey = dp.ProductKey
INNER JOIN DimProductSubcategory dps
	ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
INNER JOIN DimProductCategory dpc
	ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimSalesTerritory dst
	ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
INNER JOIN DimCustomer dc
	ON fis.CustomerKey = dc.CustomerKey
WHERE YEAR(OrderDate) = 2013

GO

SELECT * FROM Vendas_Internet