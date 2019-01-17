SELECT 
case when PATINDEX('%[0-9]%', a.BillingPostalCode)-1 < 1 then '00' else LEFT(a.BillingPostalCode,PATINDEX('%[0-9]%', a.BillingPostalCode)-1) end AreaCode,
SUM(case when a.H_S_Service_Taken__c = 'true' then 1 else 0 end) HS,
SUM(case when a.HR_EL_Service_Taken__c = 'true' then 1 else 0 end) HR
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null and a.Type = 'Client'
GROUP BY
case when PATINDEX('%[0-9]%', a.BillingPostalCode)-1 < 1 then '00' else LEFT(a.BillingPostalCode,PATINDEX('%[0-9]%', a.BillingPostalCode)-1) end