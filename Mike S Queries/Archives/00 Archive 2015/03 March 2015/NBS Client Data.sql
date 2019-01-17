SELECT a.Id, a.Name Company, c.Name, a.BillingStreet, a.BillingCity, a.BillingState, a.BillingCountry, a.BillingPostalCode, a.Phone, c.Email, Website,
SIC2007_Code__c, SIC2007_Description__c, SIC2007_Code2__c, SIC2007_Description2__c, SIC2007_Code3__c, SIC2007_Description3__c
FROM Salesforce..Account a
left outer join Salesforce..Contact c ON a.Id = c.AccountId
left outer join Salesforce..Contract con ON a.Id = con.AccountId
WHERE con.StartDate <= GETDATE() and con.EndDate > GETDATE() and con.Cancellation_Date__c is null 
and LEFT(a.BillingPostalCode,2) in ('CA', 'DL', 'DH', 'SR', 'TS')