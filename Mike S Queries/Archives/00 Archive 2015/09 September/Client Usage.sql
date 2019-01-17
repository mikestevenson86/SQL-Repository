IF OBJECT_ID('tempdb..#HSVisits') IS NOT NULL
	BEGIN
		DROP TABLE #HSVisits
	END

IF OBJECT_ID('tempdb..#HRVisits') IS NOT NULL
	BEGIN	
		DROP TABLE #HRVisits
	END

IF OBJECT_ID('tempdb..#LastUsed') IS NOT NULL
	BEGIN
		DROP TABLE #LastUsed
	END

IF OBJECT_ID('tempdb..#LastCall') IS NOT NULL
	BEGIN
		DROP TABLE #LastCall
	END
	
IF OBJECT_ID('tempdb..#Services') IS NOT NULL
	BEGIN
		DROP TABLE #Services
	END
	
DECLARE @DateStart Date = '2013-08-01'
DECLARE @DateEnd Date = '2013-09-01'

WHILE @DateStart < '2017-06-01'
BEGIN
SELECT *
INTO #Services
FROM
(
SELECT ds.clientID,
REPLACE(
	STUFF(
			(
			SELECT ',' + dt.dealType 
			FROM Shorthorn..cit_sh_deals d 
			inner join Shorthorn..cit_sh_dealTypes dt ON d.dealType = dt.dealTypeID
			WHERE d.clientID = ds.clientID and dealStatus not in (2,5,10,18) and renewDate > GETDATE()
			FOR XML PATH ('')
			), 1, 1, ''
		)
,'&amp;','&') ActiveServices,
MAX(renewDate) [Renewal Date],
SUM(cost) [Contract Value]
FROM Shorthorn..cit_sh_deals ds
GROUP BY ds.clientID
) detail
WHERE ActiveServices is not null

SELECT
d.clientID,
SUM(
	case when sixthVisit between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
	case when fifthVisit between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
	case when fourthVisit between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
	case when thirVisit between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
	case when secVisit between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
	case when firstVisit between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end 
	) HSVisitsMain,
SUM(
	case when sixthVisit between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
	case when fifthVisit between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
	case when fourthVisit between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
	case when thirVisit between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
	case when secVisit between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
	case when firstVisit between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end 
	) HSVisitsOther
INTO #HSVisits
FROM
Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_deals d ON dhs.dealID = d.dealID
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join	(
			SELECT clientId
			FROM Shorthorn..cit_sh_sites
			GROUP BY clientID
			HAVING COUNT(siteId) = 1
			) cl ON s.clientID = cl.clientID
GROUP BY d.clientID

SELECT
d.clientID,
SUM(
       case when dhr.firstVisit between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
       case when dhr.installBooked between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
       case when dhr.firstDraftRetrievalDone between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
       case when dhr.secondDraftRetrievalDone between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
       case when dhr.thirdDraftRetrievalDone between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end +
       case when dhr.midTermReview between @DateStart and @DateEnd and (s.HeadOffice = 1 or cl.clientID is not null) then 1 else 0 end
    ) HRVisitsMain,
SUM(
       case when dhr.firstVisit between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
       case when dhr.installBooked between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
       case when dhr.firstDraftRetrievalDone between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
       case when dhr.secondDraftRetrievalDone between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
       case when dhr.thirdDraftRetrievalDone between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end +
       case when dhr.midTermReview between @DateStart and @DateEnd and (s.HeadOffice = 0 and cl.clientID is null) then 1 else 0 end
    ) HRVisitsOther
INTO #HRVisits
FROM
Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_deals d ON dhr.dealID = d.dealID
inner join Shorthorn..cit_sh_sites s ON dhr.siteID = s.siteID
left outer join	(
			SELECT clientId
			FROM Shorthorn..cit_sh_sites
			GROUP BY clientID
			HAVING COUNT(siteId) = 1
			) cl ON s.clientID = cl.clientID
GROUP BY d.clientId

SELECT sageAC, MAX(au.WhenUsed) LastUsed
INTO #LastUsed
FROM CitationMain..citation_CompanyTable2 ct
inner join CitationMain..citation_appUsage au ON ct.uid = au.compID
GROUP BY ct.sageAC

SELECT cl.clientId, MAX(WhenCalled) LastCalled
INTO #LastCall
FROM Shorthorn..cit_sh_callTracker ct
inner join Shorthorn..cit_sh_advice ad ON ct.adviceCard = ad.adviceCard
inner join Shorthorn..cit_sh_contacts c ON ad.contactID = c.contactID
inner join Shorthorn..cit_sh_sites s ON c.contactID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
GROUP BY cl.clientID

INSERT INTO ReportServer..ClientUsage

SELECT
@DateStart [MonthStart],
cl.clientID,
cu.companyName AS [Company Name], 
cu.sagecode AS [SageCode],
(Shorthorn.dbo.GetServiceTypeChar(cu.sagecode, @DateStart, @DateEnd)) AS [Service],

(Shorthorn.dbo.GetHelplinePELCallCount(cu.sagecode, @DateStart, @DateEnd)) Helpline_EL ,
(Shorthorn.dbo.GetHelplineHSCallCount(cu.sagecode, @DateStart, @DateEnd)) Helpline_HS,
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 1, cu.sagecode)) CitAssess,
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 2, cu.sagecode)) CitMananger,
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 3, cu.sagecode)) CitNet,
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 10, cu.sagecode)) CitTrainer,
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 8, cu.sagecode)) CitDocs,
ISNULL(hsv.HSVisitsMain,0) [Main H&S Visits],
ISNULL(hsv.HSVisitsOther,0) [Other H&S Visits],
ISNULL(hrv.HRVisitsMain,0) [Main EL&HR Visits],
ISNULL(hrv.HRVisitsOther,0) [Other EL&HR Visits],

lu.LastUsed [Last Logged In],
lc.LastCalled [Last Called In],

a.CitationSector__c,

srv.ActiveServices,
srv.[Renewal Date],
srv.[Contract Value],
c.Name [Main Contact],
a.Phone [Main Telephone],
a.BillingPostalCode [Main postcode]

FROM 
Shorthorn.dbo.GetUniqueLiveClientsBetweenDates(@DateStart, @DateEnd) cu
left outer join Shorthorn..cit_sh_clients cl ON cu.sageCode = cl.sageCode
left outer join #HSVisits hsv ON cl.clientID = hsv.clientID
left outer join #HRVisits hrv ON cl.clientID = hrv.clientID
left outer join #LastUsed lu ON cu.sageCode collate latin1_general_CS_AS = lu.sageAC collate latin1_general_CS_AS
left outer join #LastCall lc ON cl.clientID = lc.clientID
left outer join #Services srv ON cl.clientID = srv.clientID
left outer join ReportServer..Account a ON LEFT(cl.SFDC_AccountId, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
left outer join ReportServer..Contact c ON a.Id = c.AccountId and c.Main_User__c = 'Yes'

DROP TABLE #HSVisits
DROP TABLE #HRVisits
DROP TABLE #LastUsed
DROP TABLE #LastCall
DROP TABLE #Services

SET @DateStart = DATEADD(month,1,@DateStart)
SET @DateEnd = DATEADD(month,1,@DateEnd)

END