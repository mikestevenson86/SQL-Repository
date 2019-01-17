SELECT case when LEN(REPLACE(lm_filler2,' ','')) = 18 then REPLACE(lm_filler2,' ','') else l.Id end Id, MAX(act_date)LastCB
INTO #LastCB
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Salesforce_Id__c collate latin1_general_CS_AS
WHERE appl = 'SEM1' and ch.status = 'CS' and call_type in (0,2,4)
GROUP BY case when LEN(REPLACE(lm_filler2,' ','')) = 18 then REPLACE(lm_filler2,' ','') else l.Id end

SELECT lh.LeadId, MAX(CONVERT(date, CreatedDate)) LastCB
INTO #LCB
FROM Salesforce..LeadHistory lh
inner join #LastCB lcb ON lh.LeadId = lcb.Id and CONVERT(date, lh.CreatedDate) = CONVERT(date, lcb.LastCB) 
WHERE  Field = 'Callback_Date_Time__c'
GROUP BY lh.LeadId

SELECT l.Id, 'Open' Status, '' Callback_Date_Time__c, '' Suspended_Closed_Reason__C, '' Rating, '' BDC__c, Status, Callback_Date_Time__c, Suspended_Closed_Reason__c, Rating, BDC__C
FROM #LCB lc1
inner join #LastCB lc2 ON lc1.LeadId = lc2.Id
inner join Salesforce..Lead l ON lc1.LeadId = l.Id
inner join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE lc1.LastCB <= lc2.LastCB and l.Status = 'Callback Requested' and l.Rating in ('Warm','Cold') and u.Name <> 'Mike Dundon'

DROP TABLE #LastCB
DROP TABLE #LCB