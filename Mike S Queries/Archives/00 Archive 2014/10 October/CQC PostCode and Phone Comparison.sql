SELECT l.Id, cqc.Company, cqc.[Company Group], cqc.Street, cqc.City, cqc.[State], cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c, cqc.Affinity_Industry_type__c, '2014-10-23' Completed_Date__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON l.PostalCode = cqc.PostalCode and
l.Phone = cqc.Phone

SELECT cqc.Company, cqc.[Company Group], cqc.Street, cqc.City, cqc.[State], cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c, cqc.Affinity_Industry_Type__c, '2014-10-23' Completed_Date__c
FROM SalesforceReporting..[CQC Data] cqc
left outer join Salesforce..Lead l ON 
cqc.PostalCode = l.PostalCode and 
cqc.Phone = l.Phone
WHERE l.PostalCode is null and l.Phone is null

SELECT l.Id, l.Name, cqc.Company, cqc.Street, cqc.City, cqc.[State], cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c, type
FROM Salesforce..Account l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.BillingPostalCode = cqc.PostalCode and 
l.Phone = cqc.Phone

SELECT *
FROM
(
SELECT ROW_NUMBER () OVER (PARTITION BY Phone, PostalCode ORDER BY Phone) rown, Company, Phone
FROM SalesforceReporting..[CQC Data]
) detail
ORDER BY rown