SELECT Id SFDC_Id, Company company_name, CONVERT(date, GETDATE()) date_imported, 
case when IsTPS__c = 'Yes' and Status not in ('Closed','Suspended') then 'TPS' else Suspended_Closed_Reason__c end Reason
FROM Salesforce..Lead
WHERE IsTPS__c = 'Yes' or
Status = 'Closed' or
(
Status = 'Suspended' and Suspended_Closed_Reason__c in ('Tier 4 SIC Code','Bad Sector')
)