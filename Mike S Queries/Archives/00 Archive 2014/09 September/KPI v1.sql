--Collate Call Data
SELECT 
CallDate, 
SUM(LiveConnects) Liveconnects, 
SUM(LiveConnectTime) LiveConnectTime, 
SUM(Dials) Dials, 
SUM(TotalDMC) TotalDMC, 
SUM(threemincalls) threemincalls,
SUM(threemincallsconv) threemincallsconv,
SUM(CallbacksEnded) CallbacksEnded,
SUM(CallbacksStarted) CallbacksStarted,
SUM(HotCallbacksSet) HotCallbacksSet

INTO
#CallStats

FROM
	(
	SELECT
	CONVERT(date, act_date) CallDate,
	SUM(case when call_type in (0,2,4) then 1 else 0 end) LiveConnects,
	SUM(case when call_type in (0,2,4) then time_connect else 0 end) LiveConnectTime,
	COUNT(*) Dials,
	SUM(CONVERT(INT, a.countasdmc)) TotalDMC,
	SUM(case when time_connect >= 180 then 1 else 0 end) threemincalls,
	SUM(case when time_connect >= 180 and ch.[status] = 'AP' and l.Date_Made__c = '2014-09-19' then 1 else 0 end) threemincallsconv,
	SUM(case when ch.[status] in ('CS') and call_type in (0,2,4) then 1 else 0 end) CallbacksEnded,
	SUM(case when call_type = 4 then 1 else 0 end) CallbacksStarted,
	SUM(case when ch.[status] = 'CS' and l.Rating = 'Hot' and call_type in (0,2) then 1 else 0 end) HotCallbacksSet
	
	FROM
	SalesforceReporting..call_history ch
	LEFT OUTER JOIN [Enterprise].[dbo].addistats AS a ON ch.status = a.pstatus
													  AND ISNULL(ch.addi_status,'') = ISNULL(a.addistatus,'')
													  AND ch.appl = a.pappl
	LEFT OUTER JOIN [Enterprise].[dbo].appl_status AS ap ON ch.appl = ap.appl
													  AND ch.status = ap.status
	INNER JOIN Salesforce..[User] u ON ch.tsr = u.DiallerFK__c and u.Department = 'Telemarketing'
	left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	
	WHERE 
	act_date = '2014-09-19'
	
	GROUP BY
	CONVERT(date, act_date)
	
	UNION
	
	SELECT
	CONVERT(date, act_date) CallDate,
	SUM(case when call_type in (0,2,4) then 1 else 0 end) LiveConnects,
	SUM(case when call_type in (0,2,4) then time_connect else 0 end) LiveConnectTime,
	COUNT(*) Dials,
	SUM(CONVERT(INT, a.countasdmc)) TotalDMC,
	SUM(case when time_connect >= 180 then 1 else 0 end) threemincalls,
	SUM(case when time_connect >= 180 and ch.[status] = 'AP' and l.Date_Made__c = '2014-09-19' then 1 else 0 end) threemincallsconv,
	SUM(case when ch.[status] in ('CS') and call_type in (0,2,4) then 1 else 0 end) CallbacksEnded,
	SUM(case when call_type = 4 then 1 else 0 end) CallbacksStarted,
	SUM(case when ch.[status] = 'CS' and l.Rating = 'Hot' and call_type in (0,2) then 1 else 0 end) HotCallbacksSet
	
	FROM
	SalesforceReporting..call_history ch
	LEFT OUTER JOIN [Enterprise].[dbo].addistats AS a ON ch.status = a.pstatus
													  AND ISNULL(ch.addi_status,'') = ISNULL(a.addistatus,'')
													  AND ch.appl = a.pappl
	LEFT OUTER JOIN [Enterprise].[dbo].appl_status AS ap ON ch.appl = ap.appl
													  AND ch.status = ap.status
	INNER JOIN Salesforce..[User] u ON ch.tsr = u.DiallerFK__c and u.Department = 'Telemarketing'
	left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	
	WHERE act_date = '2014-09-19'
	
	GROUP BY
	CONVERT(date, act_date)
	)detail
	
GROUP BY 
CallDate


-- Collate Update Data
SELECT
'2014-09-19' CallDate,
COUNT(Id) Updates

INTO 
#Updates

FROM
Salesforce..Lead

WHERE
Id in
	(
	SELECT
	LeadId
	FROM
	Salesforce..LeadHistory lh
	inner join Salesforce..[User] u ON lh.CreatedById collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS 
	and 
	u.Department = 'Telemarketing' 
	WHERE
	CONVERT(date, lh.CreatedDate) = '2014-09-19'
	)

-- Collate Callback Conversions
SELECT
CONVERT(date, Date_Made__c) BookDate,
COUNT(Id) CallbackConv

INTO
#CBConv

FROM
Salesforce..Lead

WHERE
Date_Made__c = '2014-09-19'
and
Id in
	(
	SELECT 
	LeadId 
	FROM 
	Salesforce..LeadHistory lh 
	inner join Salesforce..[User] u ON lh.CreatedById collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS and u.Department = 'Telemarketing'
	WHERE 
	lh.oldvalue = 'callback requested' and newvalue = 'data quality' and CONVERT(date, lh.CreatedDate) = '2014-09-19'
	)
	
GROUP BY
Date_Made__c

-- Collate Callback Data
SELECT
'2014-09-19' CallDate,
SUM(case when Status = 'callback requested' and Callback_Date_Time__c < GETDATE() then 1 else 0 end) OverdueCallbacks,
SUM(case when Status = 'callback requested' and Callback_Date_Time__c between DATEADD(WK,DATEDIFF(WK,0,GETDATE()),7) and DATEADD(WK,DATEDIFF(WK,0,GETDATE()),6+7) then 1 else 0 end) NextWeeksCallbacks

INTO
#CBStats

FROM
Salesforce..Lead

-- Collate Ticket Data
SELECT 
CONVERT(date, created_at) TicketDate,
COUNT(Id) TicketsRaised

INTO
#TStats

FROM 
[spiceworks]...tickets

WHERE 
CONVERT(date, created_at) = '2014-09-19'

GROUP BY
CONVERT(date, created_at)

SELECT
c.*,
cbs.NextWeeksCallbacks,
cbs.OverdueCallbacks,
cbc.CallbackConv,
ts.TicketsRaised,
sfu.Updates

FROM
#CallStats c
left outer join #CBConv cbc ON c.CallDate = cbc.BookDate 
left outer join #CBStats cbs ON c.CallDate = cbs.CallDate
left outer join #TStats ts ON c.CallDate = ts.TicketDate
left outer join #Updates sfu ON c.CallDate = sfu.CallDate

-- Drop tables
DROP TABLE #CallStats
DROP TABLE #CBStats
DROP TABLE #CBConv
DROP TABLE #TStats
DROP TABLE #Updates