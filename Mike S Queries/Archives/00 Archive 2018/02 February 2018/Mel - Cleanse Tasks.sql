SELECT a.Id
FROM Salesforce..Account a
inner join Salesforce..Contact c ON a.Id = c.AccountId
WHERE S__c in ('Silver','Bronze') and Citation_Client__c = 'true' and QMSClientCheck__c <> 'true' and ActiveComplaint__c is null and a.OnHold__c is null
and a.Account_Data_Cleansed__c <> 'true' and (ISNULL(Renewal_Date__c, '') = '' or Renewal_Date__c < GETDATE())