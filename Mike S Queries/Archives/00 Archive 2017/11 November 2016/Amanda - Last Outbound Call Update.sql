exec Salesforce..SF_Refresh 'Salesforce','Lead'

SELECT l.Id, Last_Call_Date__c LastOutboundCall__c_NEW, Last_Call_Date__c, LastOutboundCall__c
FROM Salesforce..Lead l
left outer join	(
				SELECT l.Id
				FROM Salesforce..Lead l
				left outer join Salesforce..[Group] g ON l.OwnerId = g.Id
				WHERE g.Name like '%Website Lead%' or l.Status = 'Approved'
				) ex ON l.Id = ex.Id
WHERE ex.Id is null
and 
(
	ISNULL(LastOutboundCall__c, '') = '' 
	or 
	CONVERT(date, LastOutboundCall__c) > CONVERT(date, GETDATE())
)
and
Last_Call_Date__c is not null
UNION
SELECT l.Id, Last_Call_Date__c LastOutboundCall__c_NEW, Last_Call_Date__c, LastOutboundCall__c 
FROM Salesforce..Lead l
left outer join	(
				SELECT l.Id
				FROM Salesforce..Lead l
				left outer join Salesforce..[Group] g ON l.OwnerId = g.Id
				WHERE g.Name like '%Website Lead%' or l.Status = 'Approved'
				) ex ON l.Id = ex.Id
WHERE ex.Id is null
and ISNULL(LastOutboundCall__c, '') <> '' and ISNULL(Last_Call_Date__c, '') <> '' and LastOutboundCall__c < Last_Call_Date__c