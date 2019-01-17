SELECT l.Id, l.Status, l.Last_Call_Date__c [Last Call Date],
DATEDIFF(day, l.Last_Call_Date__c, GETDATE()) [Days Since Last Call], ISNULL(COUNT(seqno), 0) Calls, SUM(case when call_type in (0,2,4) then 1 else 0 end) ConnectedCalls
FROM Salesforce..Lead l
left outer join SalesforceReporting..call_history ch ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS
WHERE Source__c = 'ML_Updates_JUL17' and SIC2007_Code3__c = 25990
GROUP BY l.Id, l.Status, l.Last_Call_Date__c

SELECT ID, l.Status, l.Last_Call_Date__c [Last Call Date],
DATEDIFF(day, l.Last_Call_Date__c, GETDATE()) [Days Since Last Call], ISNULL(COUNT(seqno), 0) Calls, SUM(case when call_type in (0,2,4) then 1 else 0 end) ConnectedCalls
FROM Salesforce..Lead l
left outer join SalesforceReporting..call_history ch ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS
WHERE SIC2007_Code3__c = 82990
GROUP BY l.Id, l.Status, l.Last_Call_Date__c