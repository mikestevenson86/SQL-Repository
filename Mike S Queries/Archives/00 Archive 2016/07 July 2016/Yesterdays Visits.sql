IF OBJECT_ID('Salesforce..SiteVisit__c_Load') IS NOT NULL 
	BEGIN
		DROP TABLE Salesforce..SiteVisit__c_Load
	END

SELECT 
'http://database/shorthorn/shClient.asp?clientID=' + CONVERT(varchar,clientId) + '&dealid=' + CONVERT(varchar,dealId) link,
*
INTO
#Results
FROM
(
SELECT 
cl.clientId,
dhs.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c,  
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'Install' VisitNumber__c, 
'H&S' TypeOfVisit__c, 
dateInstalled VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhs.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactHS = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_contacts c2 ON s.genContact = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.installConID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.Postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE 
CONVERT(date, dateInstalled) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhs.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c,  
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'1st Visit' VisitNumber__c, 
'H&S' TypeOfVisit__c, 
firstVisit VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhs.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactHS = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.visit1ConID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE 
CONVERT(date, firstvisit) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhs.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c, 
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'2nd Visit' VisitNumber__c, 
'H&S' TypeOfVisit__c, 
secVisit VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhs.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactHS = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.visit2ConID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE 
CONVERT(date, secVisit) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhs.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c,   
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'3rd Visit' VisitNumber__c, 
'H&S' TypeOfVisit__c, 
thirVisit VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhs.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactHS = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.visit3ConID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE 
CONVERT(date, thirVisit) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhs.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c,  
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'4th Visit' VisitNumber__c, 
'H&S' TypeOfVisit__c, 
fourthVisit VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhs.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactHS = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.visit4ConID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE 
CONVERT(date, fourthVisit) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhs.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c,   
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'5th Visit' VisitNumber__c, 
'H&S' TypeOfVisit__c, 
fifthVisit VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhs.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactHS = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.visit5ConID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE 
CONVERT(date, fifthVisit) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhs.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c, 
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'6th Visit' VisitNumber__c, 
'H&S' TypeOfVisit__c, 
SixthVisit VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhs.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactHS = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.visit6ConID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE 
CONVERT(date, sixthVisit) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhr.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c,  
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'1st Visit' VisitNumber__c, 
'PEL' TypeOfVisit__c,
firstVisit VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsPEL dhr
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhr.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactPEL = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhr.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhr.firstVisitConsultantID = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE
CONVERT(date, firstVisit) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))

UNION

SELECT 
cl.clientId,
dhr.dealId,
cl.SFDC_AccountId Account__c, 
ISNULL(s.SFDC_SiteId, sfs.Id) AccountSite__c, 
sfu.Id Consultant__c,
ISNULL(c.SFDC_ContactId, con.Id) MainContact__c,
'Install' VisitNumber__c, 
'PEL' TypeOfVisit__c,
installed VisitDate__c,
s.postcode

FROM [database].Shorthorn.dbo.cit_sh_dealsPEL dhr
inner join [database].Shorthorn.dbo.cit_sh_sites s ON dhr.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_contacts c ON s.mainContactPEL = c.contactID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON dhr.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_users u ON dhr.installConsul = u.userID
inner join Salesforce..[User] sfu ON u.email = sfu.Email
left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Salesforce..Site__c sfs ON a.Id = sfs.Account__c and REPLACE(s.postcode,' ','') = REPLACE(sfs.postcode__c,' ','')
left outer join Salesforce..Contact con ON a.Id = con.AccountId and c.fName = con.FirstName and c.sName = con.LastName

WHERE
CONVERT(date, installed) = CONVERT(date, DATEADD(day,case when DATENAME(weekday,GETDATE()) = 'Monday' then -3 else -1 end,GETDATE()))
)detail

SELECT 
CAST('' as NCHAR(18)) Id,
r.Account__c, 
r.AccountSite__c, 
r.Consultant__c, 
r.MainContact__c, 
r.TypeOfVisit__c, 
r.VisitDate__c, 
r.VisitNumber__c,
CAST('' as nvarchar(255)) Error

INTO
Salesforce..SiteVisit__c_Load

FROM #Results r
left outer join Salesforce..SiteVisit__c s ON r.Account__c = s.Account__c
											and r.AccountSite__c = s.AccountSite__c
											and CONVERT(date,r.VisitDate__c) = CONVERT(date,s.VisitDate__c)
											and r.VisitNumber__c = s.VisitNumber__c
WHERE s.Id is null

-- Build Exceptions Report

IF OBJECT_ID('SalesforceReporting..VisitExceptions') IS NOT NULL 
	BEGIN
		DROP TABLE SalesforceReporting..VisitExceptions
	END

SELECT
r.link,
r.Account__c, 
r.AccountSite__c, 
r.Consultant__c, 
r.MainContact__c, 
r.TypeOfVisit__c, 
r.VisitDate__c, 
r.VisitNumber__c,
r.postcode,
a.Id AccountID,
s.Id SiteID,
case when r.Account__c is null then 'No Account ID ' else '' end r1,
case when r.Account__c is not null and a.Id is null then 'Invalid Account ID ' else '' end r2,
case when r.AccountSite__c is null then 'No Site ID ' else '' end r3,
case when r.AccountSite__c is not null and s.Id is null then 'Invalid Site ID ' end r4

INTO
SalesforceReporting..VisitExceptions

FROM
#Results r
left outer join Salesforce..Account a ON LEFT(r.Account__c, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
left outer join Salesforce..Site__c s ON LEFT(r.AccountSite__c, 15) collate latin1_general_CS_AS = LEFT(s.Id, 15) collate latin1_general_CS_AS

WHERE
r.AccountSite__c is null or r.Account__c is null or a.Id is null or s.Id is null

-- Update Salesforce

exec Salesforce..SF_BulkOps 'Insert:batchsize(200)','Salesforce','SiteVisit__c_Load'

DROP TABLE #Results