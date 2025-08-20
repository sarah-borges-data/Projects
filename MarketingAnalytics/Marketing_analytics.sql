SELECT * FROM dbo.products

SELECT
	ProductID,
	ProductName,
	Price,
	-- Leave the Category column out since it has redundant information (all products are sport)

	CASE -- Creating a new column to classify the prices
		WHEN Price < 100 THEN 'Low'
		WHEN Price BETWEEN 100 AND 250 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory

	FROM dbo.products;