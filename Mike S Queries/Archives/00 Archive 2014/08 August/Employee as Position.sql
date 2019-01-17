SELECT ID
INTO #emps
FROM Salesforce..Lead
WHERE Position__c = 'employee'

SELECT l.Id, Position__c
FROM SalesforceTemp..Lead l
inner join #emps e ON l.Id collate latin1_general_CS_AS = e.Id collate latin1_general_CS_AS
WHERE Position__c is not null

DROP TABLE #emps