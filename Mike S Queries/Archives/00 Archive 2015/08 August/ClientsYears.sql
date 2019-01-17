DECLARE @Start as int
DECLARE @End as int
DECLARE @Year as int

SELECT clientId, MIN(SignDate) StartDate, MAX(renewDate) EndDate
INTO #Clients
FROM Shorthorn..cit_sh_deals
GROUP BY clientID

SELECT @Start = DATEPART(Year,MIN(StartDate)) FROM #Clients
SELECT @End = DATEPART(Year,MAX(EndDate)) FROM #Clients

SET @Year = @Start

CREATE TABLE Temp (
	[1998] int,
	[1999] int,
	[2000] int,
	[2001] int,
	[2002] int,
	[2003] int,
	[2004] int,
	[2005] int,
	[2006] int,
	[2007] int,
	[2008] int,
	[2009] int,
	[2010] int,
	[2011] int,
	[2012] int,
	[2013] int,
	[2014] int,
	[2015] int,
	[2016] int,
	[2017] int,
	[2018] int,
	[2019] int,
	[2020] int,
	[2021] int,
	[2022] int,
	[2023] int,
	[2024] int,
	[2025] int)


WHILE @Year <= @End

BEGIN

	INSERT INTO Temp 
	(
	[1998],
	[1999],
	[2000],
	[2001],
	[2002],
	[2003],
	[2004],
	[2005],
	[2006],
	[2007],
	[2008],
	[2009],
	[2010],
	[2011],
	[2012],
	[2013],
	[2014],
	[2015],
	[2016],
	[2017],
	[2018],
	[2019],
	[2020],
	[2021],
	[2022],
	[2023],
	[2024],
	[2025]
	)
	
	SELECT
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=1998 then 1 else 0 end) [1998],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=1999 then 1 else 0 end) [1999],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2000 then 1 else 0 end) [2000],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2001 then 1 else 0 end) [2001],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2002 then 1 else 0 end) [2002],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2003 then 1 else 0 end) [2003],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2004 then 1 else 0 end) [2004],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2005 then 1 else 0 end) [2005],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2006 then 1 else 0 end) [2006],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2007 then 1 else 0 end) [2007],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2008 then 1 else 0 end) [2008],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2009 then 1 else 0 end) [2009],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2010 then 1 else 0 end) [2010],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2011 then 1 else 0 end) [2011],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2012 then 1 else 0 end) [2012],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2013 then 1 else 0 end) [2013],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2014 then 1 else 0 end) [2014],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2015 then 1 else 0 end) [2015],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2016 then 1 else 0 end) [2016],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2017 then 1 else 0 end) [2017],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2018 then 1 else 0 end) [2018],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2019 then 1 else 0 end) [2019],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2020 then 1 else 0 end) [2020],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2021 then 1 else 0 end) [2021],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2022 then 1 else 0 end) [2022],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2023 then 1 else 0 end) [2023],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2024 then 1 else 0 end) [2024],
	COUNT(clientId)-SUM(case when DATEPART(Year,EndDate)<=2025 then 1 else 0 end) [2025]
	FROM #Clients
	WHERE DATEPART(Year,StartDate) = @Year

	SET @Year = @Year + 1

END

SELECT * FROM Temp

DROP TABLE Temp
DROP TABLE #Clients