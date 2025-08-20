SELECT * FROM dbo.customer_reviews

SELECT
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	--cleaning reviewstext by replacing double spaces with single spaces
	REPLACE(ReviewText, '  ', ' ') AS ReviewText
FROM
	dbo.customer_reviews;