SELECT WhoId, COUNT(Id) NoAns
INTO #NoAnswers
FROM Salesforce..Task
WHERE CallDisposition like '%no answer%' and CallDurationInSeconds = 0 and Type = 'Call'
GROUP BY WhoId

SELECT Id [Prospect ID], ISNULL(Market_Location_URN__c,'') [ML URN], Source__c [Source], NoAns
FROM Salesforce..Lead l
inner join #NoAnswers na ON l.Id = na.WhoId
WHERE na.NoAns >= 3 and Source__c like '%ML%'

DROP TABLE #NoAnswers