SELECT a.Id [Account ID], a.Name [Company Name], o.Id [Old Opportunity ID], o.DateMade__c [Date Made]
FROM Salesforce..Account a
inner join Salesforce..Opportunity o ON a.Id = o.AccountId
WHERE o.DateMade__c < DATEADD(mm,-6,GETDATE()) and o.SAT__c = 'false' and LEFT(a.BillingPostalCode, 2) = 'BT'
ORDER BY [Date Made]