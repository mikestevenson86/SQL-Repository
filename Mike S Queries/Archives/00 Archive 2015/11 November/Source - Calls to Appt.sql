SELECT l.Source__c, 
COUNT(seqno) Calls, 
SUM(case when op.DateMade__c >= '2015-01-01' then 1 else 0 end) Appt,
SUM(case when op.SAT_Date__c >= '2015-01-01' then 1 else 0 end) SAT, 
SUM(case when op.StageName = 'Closed Won' and op.CloseDate >= '2015-01-01' then 1 else 0 end) Deal
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
left outer join Salesforce..Account a ON l.ConvertedAccountId = a.Id
left outer join Salesforce..Opportunity op ON a.ID = op.AccountId
WHERE call_type in (0,2,4) and act_date >= '2015-01-01'
GROUP BY l.Source__c
ORDER BY l.Source__c