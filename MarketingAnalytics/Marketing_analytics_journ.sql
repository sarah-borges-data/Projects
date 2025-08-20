SELECT * FROM dbo.customer_journey

--running a Common table expression (CTE) to verify duplicates
WITH DuplicateRecords AS (
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		--Using Row number to assign a unique row number for each record
		ROW_NUMBER() OVER(
			PARTITION BY  CustomerID, ProductID, VisitDate, Stage, Action
			ORDER BY JourneyID
		) AS row_num	
	FROM dbo.customer_journey
)

SELECT *
FROM DuplicateRecords
WHERE row_num > 1
ORDER BY JourneyID

SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, avg_duration) AS Duration --replacing null values in duration for the average for the corresponding date
FROM
	(
		SELECT
			JourneyID,
			CustomerID,
			ProductID,
			VisitDate,
			UPPER(Stage) AS Stage,
			Action,
			Duration,
			AVG(Duration) OVER(PARTITION BY VisitDate) AS avg_duration,
			ROW_NUMBER() OVER(
				PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action
				ORDER BY JourneyID
			) AS row_num
		FROM 
			dbo.customer_journey	
	) AS subquery
WHERE
	row_num = 1;