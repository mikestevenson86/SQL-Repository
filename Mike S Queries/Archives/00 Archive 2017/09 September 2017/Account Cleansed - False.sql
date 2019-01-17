IF OBJECT_ID('tempdb..#Updated') IS NOT NULL
	BEGIN
		DROP TABLE #Updated
	END

CREATE TABLE #Updated
(
Id NCHAR(18)
)
		
		INSERT INTO #Updated (Id)
		SELECT a.Id 
		FROM Salesforce..Account a
		left outer join Salesforce..AccountHistory ah ON a.Id = ah.AccountId
		left outer join Salesforce..[User] u ON ah.CreatedById = u.Id
		left outer join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
		WHERE Account_Data_Cleansed__c = 'true' and (uMan.Name = 'Melanie Johnston' or u.Name = 'Carl Lord')
		
		INSERT INTO #Updated (Id)
		SELECT a.Id 
		FROM Salesforce..Account a
		left outer join Salesforce..Contact c ON a.Id = c.AccountId
		left outer join Salesforce..ContactHistory ch ON c.Id = ch.ContactId
		left outer join Salesforce..[User] u ON ch.CreatedById = u.Id
		left outer join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
		WHERE Account_Data_Cleansed__c = 'true' and uMan.Name = 'Melanie Johnston' or u.Name = 'Carl Lord'
		
SELECT a.ID
FROM Salesforce..Account a
left outer join Salesforce..AccountHistory ah ON a.Id = ah.AccountId
left outer join Salesforce..Contact c ON a.Id = c.AccountId
left outer join Salesforce..ContactHistory ch ON c.Id = ch.ContactId
left outer join #Updated up ON a.Id = up.Id
WHERE 
Account_Data_Cleansed__c = 'true' 
and 
up.Id is null
and
(
	(
	ah.Id is null 
	and
	ch.Id is null
	)
)