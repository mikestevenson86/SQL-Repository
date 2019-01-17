SELECT 
a.Name,
a.Phone,
DATENAME(month, c.StartDate) SignMonth, 
DATEPART(Year, c.StartDate) SignYear, 
c.Status,
a.CitationSector__c CitationSector, 
a.Sector__c Sector, 
a.FT_Employees__c FTE, 
c.Contract_Value__c Payroll,
c.ContractTerm, 
a.Services_Taken_Long__c ServiceType, 
case when c.Business_Type__c = 'Existing Business' then 1 else 0 end Renewed,
case when c.Business_Type__c = 'Existing Business' then DATEPART(Year, c.EndDate) else NULL end RenewedYear,
case when c.Business_Type__c = 'Existing Business' then DATENAME(Month, c.EndDate) else NULL end RenewedMonth,
CONVERT(decimal,c.Contract_Value__c/c.ContractTerm) ValuePerMonth,
ISNULL(l.LeadSource, l.Source__c) [Source],
case when c.Cancellation_Date__c is not null then 1 else 0 end Cancelled,
case when c.Cancellation_Date__c is not null then DATEPART(Year, c.Cancellation_Date__c) else NULL end CancelledYear,
case when c.Cancellation_Date__c is not null then DATENAME(Month, c.Cancellation_Date__c) else NULL end CancelledMonth,
c.Cancellation_Reason__c
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
left outer join Salesforce..Lead l ON a.Id = l.ConvertedAccountId
WHERE c.StartDate >= '2014-04-01' and (c.RecordTypeId <> '012D0000000Nav7IAC' or c.RecordTypeId is null)
ORDER BY c.StartDate