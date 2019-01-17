SELECT lm_filler2, SUM(calls) Calls
INTO #CallCount
FROM
(SELECT lm_filler2,COUNT(seqno) calls
FROM Enterprise..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join SalesforceReporting..SIC3 s3 ON l.SIC2007_Code3__c = s3.[SIC Code 3]
GROUP BY lm_filler2
UNION
SELECT lm_filler2,COUNT(seqno) calls
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join SalesforceReporting..SIC3 s3 ON l.SIC2007_Code3__c = s3.[SIC Code 3]
GROUP BY lm_filler2
) detail
GROUP BY lm_filler2

SELECT s3.Description,COUNT(l.Id) Records, AVG(cc.Calls) AverageCallCount
FROM Salesforce..Lead l
inner join SalesforceReporting..SIC3 s3 ON l.SIC2007_Code3__c = s3.[SIC Code 3]
left outer join #CallCount cc ON l.Id collate latin1_general_CS_AS = cc.lm_filler2 collate latin1_general_CS_AS
GROUP BY s3.Description
ORDER BY s3.Description

DROP TABLE #CallCount