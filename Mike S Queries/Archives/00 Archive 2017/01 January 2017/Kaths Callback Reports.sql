SELECT u.Name BDC, bdm.Name BDM, Last_Call_Date__c [Last Call Date], Company, Rating, COUNT(t.seqno) Calls
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
inner join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
inner join SalesforceReporting..call_history t ON l.Id = t.lm_filler2 
								and u.DiallerFK__c = t.tsr
								and call_type in (0,2,4)
WHERE u.Name in ('Louise Clarke','Julie Hargreaves','Matthew Deeney')
and l.Status = 'Callback Requested'
GROUP BY u.Name, bdm.Name, Last_Call_Date__c, Company, Rating
ORDER BY u.Name, bdm.Name