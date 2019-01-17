SELECT 
l.Id, 
sc.Company,
sc.FirstName,
sc.LastName,
sc.Street,
sc.City,
sc.State,
sc.PostalCode,
sc.Phone,
sc.Website,
sc.FT_Employees__c,
MIN(rn)
FROM
(
SELECT *, ROW_NUMBER () OVER (PARTITION BY Id ORDER BY Tier) rn
FROM SalesforceReporting..Shropshire_Chambers_Bridge
) detail
inner join Salesforce..Lead l ON detail.Id = l.Id
inner join SalesforceReporting..Shropshire_Chambers_June2017 sc ON detail.sc_Id = sc.Id
WHERE 
(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
and (Source__c not like '%Closed Lost%' or Source__c is null) and (Data_Supplier__c not like '%Closed Lost%' or Data_Supplier__c is null)
GROUP BY 
l.Id, 
sc.Company,
sc.FirstName,
sc.LastName,
sc.Street,
sc.City,
sc.State,
sc.PostalCode,
sc.Phone,
sc.Website,
sc.FT_Employees__c