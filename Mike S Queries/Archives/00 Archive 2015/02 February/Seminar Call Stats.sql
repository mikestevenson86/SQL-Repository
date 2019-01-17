SELECT lm_filler2 SemLeads, case when listid = 2939 then 'Plymouth' when listid = 2860 then 'Stafford' end Seminar
INTO #SemLeads
FROM SalesforceReporting..call_history
WHERE listid in (2939,2860)

SELECT 
case when listid = 2939 then 'Plymouth' when listid = 2860 then 'Stafford' end Seminar,
COUNT(seqno) Dials,
SUM(case when call_type in (0,2,4) then 1 else 0 end) ColdCalls
INTO #Cold
FROM
SalesforceReporting..call_history
WHERE listid in (2939,2860)
GROUP BY
case when listid = 2939 then 'Plymouth' when listid = 2860 then 'Stafford' end

SELECT
sl.Seminar,
COUNT(seqno) Dials,
SUM(case when call_type in (4) then 1 else 0 end) Callbacks
INTO #CallBack
FROM
SalesforceReporting..call_history ch
inner join #SemLeads sl ON ch.lm_filler2 = sl.SemLeads
WHERE listid = 22227
GROUP BY
sl.Seminar

SELECT
sl.Seminar,
COUNT(Id) Bookings
INTO #Apps
FROM Salesforce..Lead l
inner join #SemLeads sl ON l.Id = sl.SemLeads
WHERE l.Date_Made__c is not null
GROUP BY
sl.Seminar

SELECT
co.Seminar,
co.Dials+ca.Dials Dials,
co.ColdCalls+ca.Callbacks LiveConnects,
co.ColdCalls,
ca.Callbacks,
ap.Bookings
FROM
#Cold co
inner join #CallBack ca ON co.Seminar = ca.Seminar
left outer join #Apps ap ON co.Seminar = ap.Seminar

DROP TABLE #SemLeads
DROP TABLE #CallBack
DROP TABLE #Cold
DROP TABLE #Apps