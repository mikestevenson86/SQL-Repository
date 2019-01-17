SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Phone = cqc.Phone
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.MobilePhone = cqc.Phone
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Other_Phone__c = cqc.Phone
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Phone = cqc.MobilePhone__c
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.MobilePhone = cqc.MobilePhone__c
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Other_Phone__c = cqc.MobilePhone__c

UNION

SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Phone = RIGHT(cqc.Phone, 10)
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.MobilePhone = RIGHT(cqc.Phone, 10)
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Other_Phone__c = RIGHT(cqc.Phone, 10)
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Phone = RIGHT(cqc.MobilePhone__c, 10)
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.MobilePhone = RIGHT(cqc.MobilePhone__c, 10)
UNION
SELECT l.Id, l.Company, cqc.Company, cqc.Street, cqc.City, cqc.PostalCode, cqc.IsTPS__c, cqc.Phone, cqc.MobilePhone__c, cqc.Title, cqc.FirstName, cqc.Surname, cqc.Position__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[CQC Data] cqc ON 
l.Other_Phone__c = RIGHT(cqc.MobilePhone__c,10)