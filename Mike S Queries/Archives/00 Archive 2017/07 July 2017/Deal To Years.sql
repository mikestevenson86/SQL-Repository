DECLARE @clientId int

SET @clientId = 71029

IF OBJECT_ID('tempdb..#OutputTABLE') IS NOT NULL
	BEGIN
		DROP TABLE #OutputTABLE
	END

CREATE TABLE #OutputTABLE
(
clientId int,
dealId int,
YearNo VarChar(20),
startdate DATETIME,
enddate DATETIME
)

IF OBJECT_ID('tempdb..#Visits') IS NOT NULL
	BEGIN
		DROP TABLE #Visits
	END
	
CREATE TABLE #Visits
(
ClientId int,
DealId int,
SiteId int,
[Service] VarChar(20),
VisitType VarChar(20),
VisitDate Date
)

IF OBJECT_ID('tempdb..#Advice') IS NOT NULL
	BEGIN
		DROP TABLE #Advice
	END
	
CREATE TABLE #Advice
(
ClientId int,
SiteId int,
AdviceDate Date
)

-- Health & Safety Visits
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'Health & Safety', 'Install', dateInstalled
FROM cit_sh_dealsHS
WHERE clientID = @clientId and dateInstalled is not null
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'Health & Safety', 'First Visit', firstVisit
FROM cit_sh_dealsHS
WHERE clientID = @clientId and firstVisit is not null
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'Health & Safety', 'Second Visit', secVisit
FROM cit_sh_dealsHS
WHERE clientID = @clientId and secVisit is not null
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'Health & Safety', 'Third Visit', thirVisit
FROM cit_sh_dealsHS
WHERE clientID = @clientId and thirVisit is not null
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'Health & Safety', 'Fourth Visit', fourthVisit
FROM cit_sh_dealsHS
WHERE clientID = @clientId and fourthVisit is not null
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'Health & Safety', 'Fifth Visit', fifthVisit
FROM cit_sh_dealsHS
WHERE clientID = @clientId and fifthVisit is not null
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'Health & Safety', 'Sixth Visit', sixthVisit
FROM cit_sh_dealsHS
WHERE clientID = @clientId and sixthVisit is not null
-- EL & HR Visits
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'EL & HR', 'Install', installed
FROM cit_sh_dealsPEL
WHERE clientID = @clientId and installed is not null
INSERT INTO #Visits
SELECT ClientId, DealId, siteID, 'EL & HR', 'First Visit', firstVisit
FROM cit_sh_dealsPEL
WHERE clientID = @clientId and firstVisit is not null

-- Get Advice
INSERT INTO #Advice
SELECT s.ClientId, s.siteID, dateOfCall
FROM cit_sh_advice ad
inner join cit_sh_sites s ON ad.siteID = s.siteID
WHERE s.clientID = @clientId

DECLARE @cnt int
DECLARE @startDate datetime
DECLARE @endDate datetime
DECLARE @incr int
DECLARE @tempDate datetime 

DECLARE @dealID int

SELECT @dealID = MIN(dealId) FROM cit_sh_deals WHERE clientID = @clientId and dealStatus <> 10

WHILE @dealId is not null
	BEGIN

	SET @startDate=(Select signdate from cit_sh_deals where dealID = @dealID)
	SET @endDate=(Select renewdate from cit_sh_deals where dealID = @dealID)
	SET @cnt=DATEDIFF(yy,@startDate,@endDate)
	SET @incr=0

	SET @tempDate=DATEADD(yy,@incr,Cast(@startDate As datetime))

	WHILE @cnt>0
		BEGIN

		insert into #OutputTABLE values(@clientId,@dealId,'Year '+CONVERT(VarChar,@incr+1), @tempDate,DATEADD(yy,1,@tempDate));

			  
		   SET @tempDate=DATEADD(yy,@incr+1,@startDate)

		   SET @cnt=@cnt-1
		   SET @incr=@incr+1

		END

	SELECT @dealID = min(dealId) FROM cit_sh_deals WHERE dealId > @dealID and clientID = @clientId

END

SELECT 
ott.*, 
dt.dealType, 
COUNT(v.VisitDate) Visits, 
SUM(case when v.[Service] = 'Health & Safety' then 1 else 0 end) HS_Visits, 
SUM(case when v.[Service] = 'EL & HR' then 1 else 0 end) HR_Visits,
ad.Advice, 
ad.FirstAdvice, 
ad.LastAdvice
FROM 
#OutputTABLE ott
left outer join cit_sh_deals dl ON ott.dealId = dl.dealID
left outer join cit_sh_dealTypes dt ON dl.dealType = dt.dealTypeID
left outer join #Visits v ON v.VisitDate between ott.startdate and ott.enddate
left outer join	(
				SELECT ott.*, COUNT(ad.AdviceDate) advice, MIN(ad.AdviceDate) FirstAdvice, MAX(ad.AdviceDate) LastAdvice
				FROM #OutputTABLE ott
				left outer join #Advice ad ON ad.AdviceDate between ott.startdate and ott.enddate
				GROUP BY ott.clientId, ott.dealId, ott.YearNo, ott.startdate, ott.enddate
				) ad ON ott.clientId = ad.clientId and ott.dealId = ad.dealId and ott.YearNo = ad.YearNo
GROUP BY ott.clientId, ott.dealId, ott.YearNo, ott.startdate, ott.enddate, dt.dealType, ad.advice, ad.FirstAdvice, ad.LastAdvice