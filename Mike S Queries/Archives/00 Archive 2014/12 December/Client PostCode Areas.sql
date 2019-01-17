SELECT LEFT(a.BillingPostalCode, (PATINDEX('%[0-9]%',a.BillingPostalCode)-1)) PostCodeArea, COUNT(a.id) Clients
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE a.BillingPostalCode is not null and a.BillingPostalCode <> '' and (PATINDEX('%[0-9]%',a.BillingPostalCode)-1)>=1 and c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
GROUP BY LEFT(a.BillingPostalCode, (PATINDEX('%[0-9]%',a.BillingPostalCode)-1))