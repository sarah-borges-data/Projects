SELECT * FROM dbo.engagement_data

SELECT
	EngagementID,
	ContentID,
	CampaignID, 
	ProductID,
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType, --standardize the Content type column
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) -1) AS Views, -- separate the column into two
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,
	Likes,
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate -- Changing the date format


FROM DBO.engagement_data
WHERE ContentType != 'Newsletter'; -- filtering out rows that contain newsletter for not being relevatn