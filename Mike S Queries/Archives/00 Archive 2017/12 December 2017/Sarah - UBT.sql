SELECT 
ubt.Company, 
a.Id, 
case when Serivces_Taken__c in ('EL & HR','H&S') then 'true' else 'false' end SingleService, 
a.Serivces_Taken__c,
a.IsActive__c,
a.Citation_Client__c,
[Type] ClientType

FROM 
Salesforce..Account a
inner join SalesforceReporting..UBTComms ubt ON REPLACE(REPLACE(a.Name, 'Ltd',''),'Limited','') = REPLACE(REPLACE(ubt.Company, 'Ltd',''),'Limited','')
inner join Salesforce..Contract c ON a.Id = c.AccountId and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null

----------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
ubt.Company,
Id,
FT_Employees__c,
CitationSector__c

FROM
Salesforce..Lead l
inner join SalesforceReporting..UBTComms ubt ON REPLACE(REPLACE(l.Company, 'Ltd',''),'Limited','') = REPLACE(REPLACE(ubt.Company, 'Ltd',''),'Limited','')