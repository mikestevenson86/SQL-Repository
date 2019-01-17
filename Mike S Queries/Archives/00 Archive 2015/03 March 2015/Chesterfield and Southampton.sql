SELECT
case when LEFT(PostalCode,2) in ('S1','S2','S3','S4','S5','S6','S7','S8','S9') then 'Chesterfield' else 'Southampton' end Seminar,
COUNT(seqno) Dials,
SUM(case when call_type = 4 then 1 else 0 end) Callbacks
INTO #Callbacks
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
WHERE listid = 22227 and LEFT(PostalCode,2) in ('S1','S2','S3','S4','S5','S6','S7','S8','S9','SO')
GROUP BY case when LEFT(PostalCode,2) in ('S1','S2','S3','S4','S5','S6','S7','S8','S9') then 'Chesterfield' else 'Southampton' end

SELECT
case when LEFT(PostalCode,2) in ('S1','S2','S3','S4','S5','S6','S7','S8','S9') then 'Chesterfield' else 'Southampton' end Seminar,
COUNT(Id) Bookings
INTO #Appts
FROM
Salesforce..Lead
WHERE Date_Made__c is not null and LEFT(PostalCode,2) in ('S1','S2','S3','S4','S5','S6','S7','S8','S9','SO') and MADE_Criteria__c like '%seminar%'
GROUP BY case when LEFT(PostalCode,2) in ('S1','S2','S3','S4','S5','S6','S7','S8','S9') then 'Chesterfield' else 'Southampton' end

SELECT
case when listid = 2641 then 'Chesterfield' else 'Southampton' end Seminar,
COUNT(seqno) Dials,
SUM(case when call_type in (0,2) then 1 else 0 end) ColdCalls
INTO #Calls
FROM
SalesforceReporting..call_history
WHERE
listid in (2641,2667)
GROUP BY case when listid = 2641 then 'Chesterfield' else 'Southampton' end

SELECT c.Seminar, c.Dials+cb.Dials Dials, c.ColdCalls+cb.Callbacks LiveConnects, c.ColdCalls, cb.Callbacks, a.Bookings
FROM #Calls c
left outer join #Callbacks cb ON c.Seminar = cb.Seminar
left outer join #Appts a ON c.Seminar= a.Seminar

DROP TABLE #Callbacks
DROP TABLE #Appts
DROP TABLE #Calls