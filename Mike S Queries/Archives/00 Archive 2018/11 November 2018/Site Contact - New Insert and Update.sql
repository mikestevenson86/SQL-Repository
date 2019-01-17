-- Insert

IF OBJECT_ID('SalesforceReporting..SiteJunction_New') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..SiteJunction_New
	END

CREATE TABLE SalesforceReporting..SiteJunction_New
(
Id int identity,
Contact_Junction__c NCHAR(18),
Site_Junction__c NCHAR(18),
Account__c NCHAR(18),
SH_Contact_Id__c int,
Main_Site_Contact__c bit,
Secondary_Site_Contact__c bit,
Main_H_S_Contact__c bit,
Secondary_H_S_Contact__c bit,
Main_PEL_Contact__c bit,
Secondary_PEL_Contact__c bit,
Citweb_Super_User__c bit
)

INSERT INTO SalesforceReporting..SiteJunction_New (Contact_Junction__c, Site_Junction__c, Account__c, SH_Contact_Id__c,
Main_Site_Contact__c, Secondary_Site_Contact__c, Main_H_S_Contact__c, Secondary_H_S_Contact__c, Main_PEL_Contact__c, Secondary_PEL_Contact__c, Citweb_Super_User__c)
SELECT c.Id, s.Id, a.Id, shc.contactID, 1, 0, 0, 0, 0, 0, 0
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.genContact
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.genContact, 0) > 0 and sj.Id is null and mc.active = 1 and a.Id is not null

INSERT INTO SalesforceReporting..SiteJunction_New (Contact_Junction__c, Site_Junction__c, Account__c, SH_Contact_Id__c,
Main_Site_Contact__c, Secondary_Site_Contact__c, Main_H_S_Contact__c, Secondary_H_S_Contact__c, Main_PEL_Contact__c, Secondary_PEL_Contact__c, Citweb_Super_User__c)
SELECT c.Id, s.Id, a.Id, shc.contactID, 0, 1, 0, 0, 0, 0, 0
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.secContact
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
left outer join SalesforceReporting..SiteJunction_New sjn ON c.Id = sjn.Contact_Junction__c
																and s.Id = sjn.Site_Junction__c
WHERE ISNULL(mc.secContact, 0) > 0 and sj.Id is null and mc.active = 1 and a.Id is not null and sjn.Id is null

INSERT INTO SalesforceReporting..SiteJunction_New (Contact_Junction__c, Site_Junction__c, Account__c, SH_Contact_Id__c,
Main_Site_Contact__c, Secondary_Site_Contact__c, Main_H_S_Contact__c, Secondary_H_S_Contact__c, Main_PEL_Contact__c, Secondary_PEL_Contact__c, Citweb_Super_User__c)
SELECT c.Id, s.Id, a.Id, shc.contactID, 0, 0, 1, 0, 0, 0, 0
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.mainContactHS
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
left outer join SalesforceReporting..SiteJunction_New sjn ON c.Id = sjn.Contact_Junction__c
																and s.Id = sjn.Site_Junction__c
WHERE ISNULL(mc.mainContactHS, 0) > 0 and sj.Id is null and mc.active = 1 and a.Id is not null and sjn.Id is null

INSERT INTO SalesforceReporting..SiteJunction_New (Contact_Junction__c, Site_Junction__c, Account__c, SH_Contact_Id__c,
Main_Site_Contact__c, Secondary_Site_Contact__c, Main_H_S_Contact__c, Secondary_H_S_Contact__c, Main_PEL_Contact__c, Secondary_PEL_Contact__c, Citweb_Super_User__c)
SELECT c.Id, s.Id, a.Id, shc.contactID, 0, 0, 0, 1, 0, 0, 0
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.secContactHS
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
left outer join SalesforceReporting..SiteJunction_New sjn ON c.Id = sjn.Contact_Junction__c
																and s.Id = sjn.Site_Junction__c
WHERE ISNULL(mc.secContactHS, 0) > 0 and sj.Id is null and mc.active = 1 and a.Id is not null and sjn.Id is null

INSERT INTO SalesforceReporting..SiteJunction_New (Contact_Junction__c, Site_Junction__c, Account__c, SH_Contact_Id__c,
Main_Site_Contact__c, Secondary_Site_Contact__c, Main_H_S_Contact__c, Secondary_H_S_Contact__c, Main_PEL_Contact__c, Secondary_PEL_Contact__c, Citweb_Super_User__c)
SELECT c.Id, s.Id, a.Id, shc.contactID, 0, 0, 0, 0, 1, 0, 0
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.mainContactPEL
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
left outer join SalesforceReporting..SiteJunction_New sjn ON c.Id = sjn.Contact_Junction__c
																and s.Id = sjn.Site_Junction__c
WHERE ISNULL(mc.mainContactPEL, 0) > 0 and sj.Id is null and mc.active = 1 and a.Id is not null and sjn.Id is null

INSERT INTO SalesforceReporting..SiteJunction_New (Contact_Junction__c, Site_Junction__c, Account__c, SH_Contact_Id__c,
Main_Site_Contact__c, Secondary_Site_Contact__c, Main_H_S_Contact__c, Secondary_H_S_Contact__c, Main_PEL_Contact__c, Secondary_PEL_Contact__c, Citweb_Super_User__c)
SELECT c.Id, s.Id, a.Id, shc.contactID, 0, 0, 0, 0, 0, 1, 0
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.secContactPEL
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
left outer join SalesforceReporting..SiteJunction_New sjn ON c.Id = sjn.Contact_Junction__c
																and s.Id = sjn.Site_Junction__c
WHERE ISNULL(mc.secContactPEL, 0) > 0 and sj.Id is null and mc.active = 1 and a.Id is not null and sjn.Id is null

INSERT INTO SalesforceReporting..SiteJunction_New (Contact_Junction__c, Site_Junction__c, Account__c, SH_Contact_Id__c,
Main_Site_Contact__c, Secondary_Site_Contact__c, Main_H_S_Contact__c, Secondary_H_S_Contact__c, Main_PEL_Contact__c, Secondary_PEL_Contact__c, Citweb_Super_User__c)
SELECT c.Id, s.Id, a.Id, shc.contactID, 0, 0, 0, 0, 0, 0, 1
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.citManSuper
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
left outer join SalesforceReporting..SiteJunction_New sjn ON c.Id = sjn.Contact_Junction__c
																and s.Id = sjn.Site_Junction__c
WHERE ISNULL(mc.citManSuper, 0) > 0 and sj.Id is null and mc.active = 1 and a.Id is not null and sjn.Id is null

--------------------------------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID('Salesforce..Site_Junction__c_Load') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Site_Junction__c_Load
	END

SELECT 
CAST('' as NCHAR(18)) Id,
sjn.Contact_Junction__c, 
sjn.Site_Junction__c, 
sjn.Account__c, 
sjn.SH_Contact_Id__c,
case when SUM(CONVERT(int, sjn.Main_Site_Contact__c)) > 0 then 1 else 0 end Main_Site_Contact__c,
case when SUM(CONVERT(int, sjn.Secondary_Site_Contact__c)) > 0 then 1 else 0 end Secondary_Site_Contact__c,
case when SUM(CONVERT(int, sjn.Main_H_S_Contact__c)) > 0 then 1 else 0 end Main_H_S_Contact__c,
case when SUM(CONVERT(int, sjn.Secondary_H_S_Contact__c)) > 0 then 1 else 0 end Secondary_H_S_Contact__c,
case when SUM(CONVERT(int, sjn.Main_PEL_Contact__c)) > 0 then 1 else 0 end Main_PEL_Contact__c,
case when SUM(CONVERT(int, sjn.Secondary_PEL_Contact__c)) > 0 then 1 else 0 end Secondary_PEL_Contact__c,
case when SUM(CONVERT(int, sjn.Citweb_Super_User__c)) > 0 then 1 else 0 end Citweb_Super_User__c,
CAST('' as NVarChar(255)) Error
INTO 
Salesforce..Site_Junction__c_Load
FROM 
SalesforceReporting..SiteJunction_New sjn
left outer join Salesforce..Site_Junction__c sj ON sjn.Contact_Junction__c = sj.Contact_Junction__c
													and sjn.Site_Junction__c = sj.Site_Junction__c
													and sjn.Account__c = sj.Account__c
WHERE sj.Id is null
GROUP BY sjn.Contact_Junction__c, sjn.Site_Junction__c, sjn.Account__c, sjn.SH_Contact_Id__c

exec Salesforce..SF_BulkOps 'Insert:batchsize(100)','Salesforce','Site_Junction__c_Load'

-- Update Site Junctions

IF OBJECT_ID('tempdb..#Updates_MainSite') IS NOT NULL DROP TABLE #Updates_MainSite
IF OBJECT_ID('tempdb..#Updates_SecSite') IS NOT NULL DROP TABLE #Updates_SecSite
IF OBJECT_ID('tempdb..#Updates_MainHS') IS NOT NULL DROP TABLE #Updates_MainHS
IF OBJECT_ID('tempdb..#Updates_SecHS') IS NOT NULL DROP TABLE #Updates_SecHS
IF OBJECT_ID('tempdb..#Updates_MainHR') IS NOT NULL DROP TABLE #Updates_MainHR
IF OBJECT_ID('tempdb..#Updates_SecHR') IS NOT NULL DROP TABLE #Updates_SecHR
IF OBJECT_ID('tempdb..#Updates_SuperUser') IS NOT NULL DROP TABLE #Updates_SuperUser

SELECT 
sj.Id, 
1 Main_Site_Contact__c
INTO
#Updates_MainSite
FROM 
[database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.genContact
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.genContact, 0) > 0 and sj.Id is not null and sj.Main_Site_Contact__c = 'false' and a.Id is not null

SELECT 
sj.Id, 
1 Secondary_Site_Contact__c
INTO
#Updates_SecSite
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.secContact
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.secContact, 0) > 0 and sj.Id is not null and sj.Secondary_Site_Contact__c = 'false' and a.Id is not null

SELECT 
sj.Id, 
1 Main_H_S_Contact__c
INTO
#Updates_MainHS
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.mainContactHS
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.mainContactHS, 0) > 0 and sj.Id is not null and sj.Main_H_S_Contact__c = 'false' and a.Id is not null

SELECT 
sj.Id, 
1 Secondary_H_S_Contact__c
INTO
#Updates_SecHS
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.secContactHS
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.secContactHS, 0) > 0 and sj.Id is not null and sj.Secondary_H_S_Contact__c = 'false' and a.Id is not null

SELECT 
sj.Id, 
1 Main_PEL_Contact__c
INTO
#Updates_MainHR
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.mainContactPEL
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.mainContactPEL, 0) > 0 and sj.Id is not null and sj.Main_PEL_Contact__c = 'false' and a.Id is not null

SELECT 
sj.Id, 
1 Secondary_PEL_Contact__c
INTO
#Updates_SecHR
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.secContactPEL
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.secContactPEL, 0) > 0 and sj.Id is not null and sj.Secondary_PEL_Contact__c = 'false' and a.Id is not null

SELECT 
sj.Id, 
1 Citweb_Super_User__c
INTO
#Updates_SuperUser
FROM [database].shorthorn.dbo.cit_sh_contacts shc
left outer join [database].shorthorn.dbo.cit_sh_sites mc ON shc.contactId = mc.citManSuper
left outer join Salesforce..Contact c ON shc.contactId = c.Shorthorn_Id__c
left outer join Salesforce..Site__c s ON mc.siteID = s.SHsiteID__c
left outer join Salesforce..Account a ON c.AccountId = a.Id
											and s.Account__c = a.Id
left outer join Salesforce..Site_Junction__c sj ON s.Id = sj.Site_Junction__c
													and c.Id = sj.Contact_Junction__c
WHERE ISNULL(mc.citManSuper, 0) > 0 and sj.Id is not null and sj.Citweb_Super_User__c = 'false' and a.Id is not null

IF OBJECT_ID('Salesforce..Site_Junction__c_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Site_Junction__c_Update
	END

SELECT
CAST(sj.Id as NCHAR(18)) Id,
case when detail.Main_Site_Contact__c is null then sj.Main_Site_Contact__c else 'true' end Main_Site_Contact__c,
case when detail.Secondary_Site_Contact__c is null then sj.Secondary_Site_Contact__c else 'true' end Secondary_Site_Contact__c,
case when detail.Main_H_S_Contact__c is null then sj.Main_H_S_Contact__c else 'true' end Main_H_S_Contact__c,
case when detail.Secondary_H_S_Contact__c is null then sj.Secondary_H_S_Contact__c else 'true' end Secondary_H_S_Contact__c,
case when detail.Main_PEL_Contact__c is null then sj.Main_PEL_Contact__c else 'true' end Main_PEL_Contact__c,
case when detail.Secondary_PEL_Contact__c is null then sj.Secondary_PEL_Contact__c else 'true' end Secondary_PEL_Contact__c,
case when detail.Citweb_Super_User__c is null then sj.Citweb_Super_User__c else 'true' end Citweb_Super_User__c,
CAST('' as NVarChar(255)) Error
INTO
Salesforce..Site_Junction__c_Update
FROM
(	
	SELECT
	sj.Id,
	SUM(ms.Main_Site_Contact__c) Main_Site_Contact__c,
	SUM(ss.Secondary_Site_Contact__c) Secondary_Site_Contact__c,
	SUM(mhs.Main_H_S_Contact__c) Main_H_S_Contact__c,
	SUM(shs.Secondary_H_S_Contact__c) Secondary_H_S_Contact__c,
	SUM(mhr.Main_PEL_Contact__c) Main_PEL_Contact__c,
	SUM(shr.Secondary_PEL_Contact__c) Secondary_PEL_Contact__c,
	SUM(su.Citweb_Super_User__c) Citweb_Super_User__c
	FROM
	Salesforce..Site_Junction__c sj
	left outer join #Updates_MainSite ms ON sj.Id = ms.Id
	left outer join #Updates_SecSite ss ON sj.Id = ss.Id
	left outer join #Updates_MainHS mhs ON sj.Id = mhs.Id
	left outer join #Updates_SecHS shs ON sj.Id = shs.Id
	left outer join #Updates_MainHR mhr ON sj.Id = mhr.Id
	left outer join #Updates_SecHR shr ON sj.Id = shr.Id
	left outer join #Updates_SuperUser su ON sj.Id = su.Id
	WHERE
	ms.Id is not null or ss.Id is not null or mhs.Id is not null or shs.Id is not null or mhr.Id is not null or shr.Id is not null or su.Id is not null
	GROUP BY
	sj.Id
) detail
inner join Salesforce..Site_Junction__c sj ON detail.Id = sj.Id

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Site_Junction__c_Update'

	
	-- Update Contacts From Site Contacts
	
	IF OBJECT_ID('Salesforce..Contact_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Contact_Update
	END

		SELECT 
		CAST(c.Id as NCHAR(18)) Id,
		case when sj.Main_Site_Contact__c = 'true' or sj.Secondary_Site_Contact__c = 'true' then 'Yes' else 'No' end Main_User__c,
		case when sj.Main_H_S_Contact__c = 'true' or sj.Secondary_H_S_Contact__c = 'true' then 'Yes' else 'No' end Helpline_H_S__c,
		case when sj.Main_PEL_Contact__c = 'true' or sj.Secondary_PEL_Contact__c = 'true' then 'Yes' else 'No' end Helpline_PEL__c,
		case when sj.Citweb_Super_User__c = 'true' or c.Online_Super_User__c = 'Yes' then 'Yes' else 'No' end Online_Super_User__c,
		CAST('' as NVarChar(255)) Error

		INTO
		Salesforce..Contact_Update

		FROM 
		Salesforce..Site_Junction__c sj
		inner join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id

		WHERE
		(
			Main_User__c = 'No'
			and
			(
				sj.Main_Site_Contact__c = 'true' or sj.Secondary_Site_Contact__c = 'true'
			)
		)
		or
		(
			Helpline_H_S__c = 'No'
			and
			(
				sj.Main_H_S_Contact__c = 'true' or sj.Secondary_H_S_Contact__c = 'true'
			)
		)
		or
		(
			Helpline_PEL__c = 'No'
			and
			(
				sj.Main_PEL_Contact__c = 'true' or sj.Secondary_PEL_Contact__c = 'true'
			)
		)
		or
		(
			Online_Super_User__c = 'No'
			and
			(
				sj.Citweb_Super_User__c = 'true'
			)
		)

	exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Contact_Update'

-- Load to Shorthorn

INSERT INTO [database].shorthorn.dbo.cit_sh_contacts
(siteId, SFDC_ContactId, title, fName, sName, position, tel, mob, email, [enabled])
SELECT
s.SHsiteID__c siteId
,c.Id SFDC_ContactId	
,case when c.Salutation = 'Mr' then 1
when c.Salutation = 'Mrs' then 2
when c.Salutation = 'Miss' then 3
when c.Salutation = 'Ms' then 4
when c.Salutation = 'Dr' then 5
else NULL end title
,CONVERT(VarChar, c.FirstName) fName
,CONVERT(VarChar, c.LastName) sName
,CONVERT(VarChar, c.Position__c) position
,CONVERT(VarChar, c.Phone) tel
,CONVERT(VarChar, c.MobilePhone) mob
,CONVERT(VarChar, c.Email) email
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

-- Update Shorthorn

IF OBJECT_ID('tempdb..#Roles') IS NOT NULL
	BEGIN
		DROP TABLE #Roles
	END

IF OBJECT_ID('tempdb..#Updates_SH_MainSite') IS NOT NULL DROP TABLE #Updates_SH_MainSite
IF OBJECT_ID('tempdb..#Updates_SH_SecSite') IS NOT NULL DROP TABLE #Updates_SH_SecSite
IF OBJECT_ID('tempdb..#Updates_SH_MainHS') IS NOT NULL DROP TABLE #Updates_SH_MainHS
IF OBJECT_ID('tempdb..#Updates_SH_SecHS') IS NOT NULL DROP TABLE #Updates_SH_SecHS
IF OBJECT_ID('tempdb..#Updates_SH_MainHR') IS NOT NULL DROP TABLE #Updates_SH_MainHR
IF OBJECT_ID('tempdb..#Updates_SH_SecHR') IS NOT NULL DROP TABLE #Updates_SH_SecHR
IF OBJECT_ID('tempdb..#Updates_SH_SuperUser') IS NOT NULL DROP TABLE #Updates_SH_SuperUser

SELECT
contactId, a+b+c+d+e+f+g ExistingRoles
INTO
#Roles
FROM
(
	SELECT
	contactId,
	case when gc.genContact is not null then 1 else 0 end a,
	case when sc.secContact is not null then 1 else 0 end b,
	case when mhs.mainContactHS is not null then 1 else 0 end c,
	case when shs.secContactHS is not null then 1 else 0 end d,
	case when mhr.mainContactPEL is not null then 1 else 0 end e,
	case when shr.secContactPEL is not null then 1 else 0 end f,
	case when cts.citManSuper is not null then 1 else 0 end g

	FROM
	[database].shorthorn.dbo.cit_sh_contacts c
	left outer join [database].shorthorn.dbo.cit_sh_sites gc ON c.contactId = gc.genContact and gc.active = 1
	left outer join [database].shorthorn.dbo.cit_sh_sites sc ON c.contactId = sc.secContact and sc.active = 1
	left outer join [database].shorthorn.dbo.cit_sh_sites mhs ON c.contactId = mhs.mainContactHS and mhs.active = 1
	left outer join [database].shorthorn.dbo.cit_sh_sites shs ON c.contactId = shs.secContactHS and shs.active = 1
	left outer join [database].shorthorn.dbo.cit_sh_sites mhr ON c.contactId = mhr.mainContactPEL and mhr.active = 1
	left outer join [database].shorthorn.dbo.cit_sh_sites shr ON c.contactID = shr.secContactPEL and shr.active = 1
	left outer join [database].shorthorn.dbo.cit_sh_sites cts ON c.contactID = cts.citManSuper and cts.active = 1

	GROUP BY
	contactId,
	case when gc.genContact is not null then 1 else 0 end,
	case when sc.secContact is not null then 1 else 0 end,
	case when mhs.mainContactHS is not null then 1 else 0 end,
	case when shs.secContactHS is not null then 1 else 0 end,
	case when mhr.mainContactPEL is not null then 1 else 0 end,
	case when shr.secContactPEL is not null then 1 else 0 end,
	case when cts.citManSuper is not null then 1 else 0 end
) detail

SELECT
*
INTO
#Updates_SH_MainSite
FROM
(
	SELECT
	sj.Id,
	a.Shorthorn_Id__c,
	a.Name,
	s.SHsiteID__c,
	shc.contactId genContact,
	r.ExistingRoles,
	ROW_NUMBER () OVER (PARTITION BY s.SHsiteID__c ORDER BY ExistingRoles desc, shc.contactId) rn

	FROM
	Salesforce..Site_Junction__c sj
	left outer  join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
	left outer  join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
	left outer  join Salesforce..Account a ON s.Account__c = a.Id
										and c.AccountId = a.Id
	left outer  join [database].shorthorn.dbo.cit_sh_contacts shc ON REPLACE(c.FirstName + c.LastName,' ','') 
																= REPLACE(shc.fName + shc.sName,' ','')
	left outer  join [database].shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteId
															and s.SHsiteID__c = shs.siteID
															and shs.clientID = a.Shorthorn_Id__c
	left outer join #Roles r ON shc.contactId = r.contactId
	WHERE
	c.Active__c = 'true'
	and
	shc.enabled = 1
	and
	shs.active = 1
	and
	sj.Main_Site_Contact__c = 'true'
	and
	ISNULL(shs.genContact,0) = 0
) detail
WHERE rn = 1

SELECT
*
INTO
#Updates_SH_SecSite
FROM
(
	SELECT
	sj.Id,
	a.Shorthorn_Id__c,
	a.Name,
	s.SHsiteID__c,
	shc.contactId secContact,
	r.ExistingRoles,
	ROW_NUMBER () OVER (PARTITION BY s.SHsiteID__c ORDER BY ExistingRoles desc, shc.contactId) rn

	FROM
	Salesforce..Site_Junction__c sj
	left outer  join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
	left outer  join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
	left outer  join Salesforce..Account a ON s.Account__c = a.Id
										and c.AccountId = a.Id
	left outer  join [database].shorthorn.dbo.cit_sh_contacts shc ON REPLACE(c.FirstName + c.LastName,' ','') 
																= REPLACE(shc.fName + shc.sName,' ','')
	left outer  join [database].shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteId
															and s.SHsiteID__c = shs.siteID
															and shs.clientID = a.Shorthorn_Id__c
	left outer join #Roles r ON shc.contactId = r.contactId
	WHERE
	c.Active__c = 'true'
	and
	shc.enabled = 1
	and
	shs.active = 1
	and
	sj.Secondary_Site_Contact__c = 'true'
	and
	ISNULL(shs.secContact,0) = 0
) detail
WHERE rn = 1


SELECT
*
INTO
#Updates_SH_MainHS
FROM
(
	SELECT
	sj.Id,
	a.Shorthorn_Id__c,
	a.Name,
	s.SHsiteID__c,
	shc.contactId mainContactHS,
	r.ExistingRoles,
	ROW_NUMBER () OVER (PARTITION BY s.SHsiteID__c ORDER BY ExistingRoles desc, shc.contactId) rn

	FROM
	Salesforce..Site_Junction__c sj
	left outer  join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
	left outer  join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
	left outer  join Salesforce..Account a ON s.Account__c = a.Id
										and c.AccountId = a.Id
	left outer  join [database].shorthorn.dbo.cit_sh_contacts shc ON REPLACE(c.FirstName + c.LastName,' ','') 
																= REPLACE(shc.fName + shc.sName,' ','')
	left outer  join [database].shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteId
															and s.SHsiteID__c = shs.siteID
															and shs.clientID = a.Shorthorn_Id__c
	left outer join #Roles r ON shc.contactId = r.contactId
	WHERE
	c.Active__c = 'true'
	and
	shc.enabled = 1
	and
	shs.active = 1
	and
	sj.Main_H_S_Contact__c = 'true'
	and
	ISNULL(shs.mainContactHS,0) = 0
) detail
WHERE rn = 1


SELECT
*
INTO
#Updates_SH_SecHS
FROM
(
	SELECT
	sj.Id,
	a.Shorthorn_Id__c,
	a.Name,
	s.SHsiteID__c,
	shc.contactId secContactHS,
	r.ExistingRoles,
	ROW_NUMBER () OVER (PARTITION BY s.SHsiteID__c ORDER BY ExistingRoles desc, shc.contactId) rn

	FROM
	Salesforce..Site_Junction__c sj
	left outer  join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
	left outer  join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
	left outer  join Salesforce..Account a ON s.Account__c = a.Id
										and c.AccountId = a.Id
	left outer  join [database].shorthorn.dbo.cit_sh_contacts shc ON REPLACE(c.FirstName + c.LastName,' ','') 
																= REPLACE(shc.fName + shc.sName,' ','')
	left outer  join [database].shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteId
															and s.SHsiteID__c = shs.siteID
															and shs.clientID = a.Shorthorn_Id__c
	left outer join #Roles r ON shc.contactId = r.contactId
	WHERE
	c.Active__c = 'true'
	and
	shc.enabled = 1
	and
	shs.active = 1
	and
	sj.Secondary_H_S_Contact__c = 'true'
	and
	ISNULL(shs.secContactHS,0) = 0
) detail
WHERE rn = 1


SELECT
*
INTO
#Updates_SH_MainHR
FROM
(
	SELECT
	sj.Id,
	a.Shorthorn_Id__c,
	a.Name,
	s.SHsiteID__c,
	shc.contactId mainContactPEL,
	r.ExistingRoles,
	ROW_NUMBER () OVER (PARTITION BY s.SHsiteID__c ORDER BY ExistingRoles desc, shc.contactId) rn

	FROM
	Salesforce..Site_Junction__c sj
	left outer  join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
	left outer  join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
	left outer  join Salesforce..Account a ON s.Account__c = a.Id
										and c.AccountId = a.Id
	left outer  join [database].shorthorn.dbo.cit_sh_contacts shc ON REPLACE(c.FirstName + c.LastName,' ','') 
																= REPLACE(shc.fName + shc.sName,' ','')
	left outer  join [database].shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteId
															and s.SHsiteID__c = shs.siteID
															and shs.clientID = a.Shorthorn_Id__c
	left outer join #Roles r ON shc.contactId = r.contactId
	WHERE
	c.Active__c = 'true'
	and
	shc.enabled = 1
	and
	shs.active = 1
	and
	sj.Main_PEL_Contact__c = 'true'
	and
	ISNULL(shs.mainContactPEL,0) = 0
) detail
WHERE rn = 1


SELECT
*
INTO
#Updates_SH_SecHR
FROM
(
	SELECT
	sj.Id,
	a.Shorthorn_Id__c,
	a.Name,
	s.SHsiteID__c,
	shc.contactId secContactPEL,
	r.ExistingRoles,
	ROW_NUMBER () OVER (PARTITION BY s.SHsiteID__c ORDER BY ExistingRoles desc, shc.contactId) rn

	FROM
	Salesforce..Site_Junction__c sj
	left outer  join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
	left outer  join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
	left outer  join Salesforce..Account a ON s.Account__c = a.Id
										and c.AccountId = a.Id
	left outer  join [database].shorthorn.dbo.cit_sh_contacts shc ON REPLACE(c.FirstName + c.LastName,' ','') 
																= REPLACE(shc.fName + shc.sName,' ','')
	left outer  join [database].shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteId
															and s.SHsiteID__c = shs.siteID
															and shs.clientID = a.Shorthorn_Id__c
	left outer join #Roles r ON shc.contactId = r.contactId
	WHERE
	c.Active__c = 'true'
	and
	shc.enabled = 1
	and
	shs.active = 1
	and
	sj.Secondary_PEL_Contact__c = 'true'
	and
	ISNULL(shs.secContactPEL,0) = 0
) detail
WHERE rn = 1


SELECT
*
INTO
#Updates_SH_SuperUser
FROM
(
	SELECT
	sj.Id,
	a.Shorthorn_Id__c,
	a.Name,
	s.SHsiteID__c,
	shc.contactId citManSuper,
	r.ExistingRoles,
	ROW_NUMBER () OVER (PARTITION BY s.SHsiteID__c ORDER BY ExistingRoles desc, shc.contactId) rn

	FROM
	Salesforce..Site_Junction__c sj
	left outer  join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
	left outer  join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
	left outer  join Salesforce..Account a ON s.Account__c = a.Id
										and c.AccountId = a.Id
	left outer  join [database].shorthorn.dbo.cit_sh_contacts shc ON REPLACE(c.FirstName + c.LastName,' ','') 
																= REPLACE(shc.fName + shc.sName,' ','')
	left outer  join [database].shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteId
															and s.SHsiteID__c = shs.siteID
															and shs.clientID = a.Shorthorn_Id__c
	left outer join #Roles r ON shc.contactId = r.contactId
	WHERE
	c.Active__c = 'true'
	and
	shc.enabled = 1
	and
	shs.active = 1
	and
	sj.Citweb_Super_User__c = 'true'
	and
	ISNULL(shs.citManSuper,0) = 0
) detail
WHERE rn = 1

IF OBJECT_ID('tempdb..#ShorthornSiteContacts') IS NOT NULL
	BEGIN
		DROP TABLE #ShorthornSiteContacts
	END

SELECT
sj.Id,
a.Shorthorn_Id__c,
a.Name,
s.SHSiteID__c,
MAX(genContact) genContact,
MAX(secContact) secContact,
MAX(mainContactHS) mainContactHS,
MAX(secContactHS) secContactHS,
MAX(mainContactPEL) mainContactPEL,
MAX(secContactPEL) secContactPEL,
MAX(citManSuper) citManSuper
INTO
#ShorthornSiteContacts
FROM
Salesforce..Site_Junction__c sj
left outer join Salesforce..Account a ON sj.Account__c = a.Id
left outer join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
left outer join #Updates_SH_MainSite ms ON sj.Id = ms.Id
left outer join #Updates_SH_SecSite ss ON sj.Id = ss.Id
left outer join #Updates_SH_MainHS mhs ON sj.Id = mhs.Id
left outer join #Updates_SH_SecHS shs ON sj.Id = shs.Id
left outer join #Updates_SH_MainHR mhr ON sj.Id = mhr.Id
left outer join #Updates_SH_SecHR shr ON sj.Id = shr.Id
left outer join #Updates_SH_SuperUser su ON sj.Id = su.Id
WHERE
ms.Id is not null or ss.Id is not null or mhs.Id is not null or shs.Id is not null or mhr.Id is not null or shr.Id is not null or su.Id is not null
GROUP BY
sj.Id,
a.Shorthorn_Id__c,
a.Name,
s.SHSiteID__c

UPDATE oq 
SET    genContact = case when p.genContact is null then oq.genContact else p.genContact end
	   ,secContact = case when p.secContact is null then oq.secContact else p.secContact end
	   ,mainContactHS = case when p.mainContactHS is null then oq.mainContactHS else p.mainContactHS end
	   ,secContactHS = case when p.secContactHS is null then oq.secContactHS else p.secContactHS end
	   ,mainContactPEL = case when p.mainContactPEL is null then oq.mainContactPEL else p.mainContactPEL end
	   ,secContactPEL = case when p.secContactPEL is null then oq.secContactPEL else p.secContactPEL end
	   ,citManSuper = case when p.citManSuper is null then oq.citManSuper else p.citManSuper end
FROM   OPENQUERY([DATABASE],
'SELECT siteId, genContact, secContact, mainContactHS, secContactHS, mainContactPEL, secContactPEL, citManSuper 
FROM Shorthorn.dbo.cit_sh_sites') oq 
INNER JOIN #ShorthornSiteContacts p ON oq.siteId = p.SHsiteID__c