/*SELECT Id, SIC2007_Description3__c
FROM Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code]
WHERE af.Partner = 'Care' and Company not like '%dental%' and SIC2007_Description3__c not like '%dental%' and Company not like '%dentist%'*/

SELECT a.Id, c.StartDate, c.EndDate, a.Name
FROM Salesforce..Account a
inner join SalesforceReporting..AffinitySICCodes af ON a.SIC2007_Code3__c = af.[SIC Code]
inner join Salesforce..Contract c ON a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
WHERE af.Partner = 'Care' and a.Name not like '%dental%' and SIC2007_Description3__c not like '%dental%' and a.Name not like '%dentist%' and c.Cancellation_Date__c is null and EndDate > GETDATE()

SELECT a.Id, c.StartDate, c.EndDate, a.Name
FROM Salesforce..Account a
inner join SalesforceReporting..AffinitySICCodes af ON a.SIC2007_Code3__c = af.[SIC Code]
inner join Salesforce..Contract c ON a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
WHERE af.Partner = 'Care' and (a.Name not like '%dental%' or SIC2007_Description3__c like '%dental%' or a.Name like '%dentist%') and c.Cancellation_Date__c is null and EndDate > GETDATE()