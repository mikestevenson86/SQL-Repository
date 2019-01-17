IF OBJECT_ID ('tempdb..#ActiveDeals') IS NOT NULL
BEGIN
	DROP TABLE #ActiveDeals
END

SELECT clientId
INTO #ActiveDeals
FROM [database].Shorthorn.dbo.cit_sh_deals
WHERE RenewDate > GETDATE() and DealStatus not in (2,5,10,18)
GROUP BY clientId

TRUNCATE TABLE SalesforceReporting.dbo.ShorthornContacts

INSERT INTO SalesforceReporting.dbo.ShorthornContacts
(
UserName,
SH_Id,
SF_Id,
ClientActive,
ContactActive,
Contacts
)

SELECT 
REPLACE(ISNULL(CONVERT(VarChar, cl.clientId),'') + ISNULL(fName,'') + ISNULL(sName,''),' ','') UserName, 

cl.clientId SH_Id, cl.SFDC_AccountId SF_Id, case when acd.clientId is not null then 1 else 0 end ClientActive, c.enabled ContactActive, COUNT(contactId) Contacts

FROM [database].Shorthorn.dbo.cit_sh_contacts c
left outer join [database].Shorthorn.dbo.cit_sh_sites s ON c.siteID = s.siteID
left outer join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
left outer join #ActiveDeals acd ON cl.clientId = acd.clientId
GROUP BY REPLACE(ISNULL(CONVERT(VarChar, cl.clientId),'') + ISNULL(fName,'') + ISNULL(sName,''),' ',''), cl.clientId, cl.SFDC_AccountId, case when acd.clientId is not null then 1 else 0 end, c.enabled
ORDER BY REPLACE(ISNULL(CONVERT(VarChar, cl.clientId),'') + ISNULL(fName,'') + ISNULL(sName,''),' ',''), cl.clientId, cl.SFDC_AccountId, case when acd.clientId is not null then 1 else 0 end, c.enabled

IF OBJECT_ID ('SalesforceReporting..SalesforceContacts') IS NOT NULL
BEGIN
	DROP TABLE SalesforceReporting..SalesforceContacts
END

SELECT 
REPLACE(ISNULL(CONVERT(VarChar, a.Shorthorn_Id__c),'') + ISNULL(FirstName,'') + ISNULL(LastName,''),' ','') UserName, 
a.Shorthorn_id__c SH_Id, a.Id SF_Id, a.IsActive__c ClientActive, c.Active__c ContactActive, COUNT(c.Id) Contacts
INTO SalesforceReporting..SalesforceContacts
FROM Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
GROUP BY REPLACE(ISNULL(CONVERT(VarChar, a.Shorthorn_Id__c),'') + ISNULL(FirstName,'') + ISNULL(LastName,''),' ',''), a.Shorthorn_id__c , a.Id, a.IsActive__c, c.Active__c
ORDER BY REPLACE(ISNULL(CONVERT(VarChar, a.Shorthorn_Id__c),'') + ISNULL(FirstName,'') + ISNULL(LastName,''),' ',''), a.Shorthorn_id__c , a.Id, a.IsActive__c, c.Active__c

SELECT ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY UserName) Id, *
FROM
(
SELECT sfc.*, 'Shorthorn' MissingIn
FROM SalesforceReporting..SalesforceContacts sfc
left outer join SalesforceReporting..ShorthornContacts shc ON sfc.UserName = shc.UserName
WHERE shc.UserName is null
UNION
SELECT shc.*, 'Salesforce' MissingIn
FROM SalesforceReporting..ShorthornContacts shc
left outer join SalesforceReporting..SalesforceContacts sfc ON shc.UserName = sfc.UserName
WHERE sfc.UserName is null
) detail