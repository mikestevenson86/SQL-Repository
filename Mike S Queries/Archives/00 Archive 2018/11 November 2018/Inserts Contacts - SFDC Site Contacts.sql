SELECT
shs.clientId,
s.SHsiteID__c siteId
,c.Id SFDC_ContactId	
,case when c.Salutation = 'Mr' then 1
when c.Salutation = 'Mrs' then 2
when c.Salutation = 'Miss' then 3
when c.Salutation = 'Ms' then 4
when c.Salutation = 'Dr' then 5
else NULL end title
,c.FirstName fName
,c.LastName sName
,c.Position__c position
,c.Phone tel
,c.MobilePhone mob
,c.Email email
,c.Description notes
,1

FROM
Salesforce..Site_Junction__c sj
inner join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
inner join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
inner join [database].shorthorn.dbo.cit_sh_sites shs ON s.SHsiteID__c = shs.siteId

WHERE
c.AccountId = s.Account__c
and
REPLACE(c.FirstName + + c.LastName,' ','') not in
(
	SELECT REPLACE(fName + sName,' ','')
	FROM [database].shorthorn.dbo.cit_sh_contacts
	WHERE siteID = s.SHsiteID__c
)
and
c.Active__c = 'true'