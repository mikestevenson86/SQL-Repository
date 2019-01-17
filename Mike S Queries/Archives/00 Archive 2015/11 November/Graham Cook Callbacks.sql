SELECT l.Id, '005D0000004G2ExIAK' BDC__c
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE 
u.Name = 'Graham Cook' 
and DATEPART(week, Callback_Date_Time__c) = DATEPART(week, GETDATE())
and DATEPART(Year, Callback_Date_Time__c) = DATEPART(Year, GETDATE())

SELECT Id
FROM Salesforce..[User]
WHERE Name = 'Marion Casserley'