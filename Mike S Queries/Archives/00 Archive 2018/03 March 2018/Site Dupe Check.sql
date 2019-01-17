	--Fill in Shorthorn ID from SFDC join
	SELECT a.Id, cl.clientId, cl.companyName, a.Name, dbo.LEVENSHTEIN(cl.companyName, a.Name)
	FROM Salesforce..Account a
	inner join [database].shorthorn.dbo.cit_sh_clients cl ON LEFT(a.Id, 15) collate latin1_general_CS_AS = LEFT(cl.SFDC_AccountID, 15) collate latin1_general_CS_AS
	WHERE ISNULL(a.Shorthorn_Id__c, 0) = 0

	SELECT sfs.Id, shs.clientId, sfs.Name, shs.siteName, dbo.LEVENSHTEIN(sfs.Name, shs.siteName)
	FROM Salesforce..Site__c sfs
	inner join [database].shorthorn.dbo.cit_sh_sites shs ON LEFT(sfs.Id, 15) collate latin1_general_CS_AS = LEFT(shs.SFDC_SiteID, 15) collate latin1_general_CS_AS
	WHERE ISNULL(sfs.SHsiteID__c, 0) = 0

	SELECT sfc.Id, shc.siteId, sfc.Name, shc.fName + ' ' + shc.sName, dbo.LEVENSHTEIN(sfc.Name, shc.fName + ' ' + shc.sName)
	FROM Salesforce..Contact sfc
	inner join [database].shorthorn.dbo.cit_sh_contacts shc ON LEFT(sfc.Id, 15) collate latin1_general_CS_AS = LEFT(shc.SFDC_ContactID, 15) collate latin1_general_CS_AS
	WHERE ISNULL(sfc.Shorthorn_Id__c, 0) = 0
	
	--Fill in Shorthorn ID from Company Name + Postcode
	SELECT
	CAST(a.Id as NCHAR(18)) Id,
	cl.clientId Shorthorn_Id__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	[database].shorthorn.dbo.cit_sh_clients cl
	left outer join [database].shorthorn.dbo.cit_sh_sites s ON cl.clientID = s.clientId
	left outer join Salesforce..Account a ON cl.companyName = a.Name
										and s.Postcode = a.BillingPostalCode
										
	WHERE
	ISNULL(a.Shorthorn_Id__c, 0) = 0
	and
	a.Id is not null
	and
	ISNULL(s.Postcode, '') <> ''
	and
	ISNULL(cl.companyName, '') <> ''
	
	GROUP BY
	CAST(a.Id as NCHAR(18)),
	cl.clientId
	
	--Fill in Shorthorn ID from Site Telephone
	SELECT
	CAST(a.Id as NCHAR(18)) Id,
	cl.clientId Shorthorn_Id__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	[database].shorthorn.dbo.cit_sh_clients cl
	left outer join [database].shorthorn.dbo.cit_sh_sites s ON cl.clientID = s.clientId
	left outer join Salesforce..Account a ON REPLACE(case when s.genTel like '0%' then s.genTel else '0'+s.genTel end,' ','') = REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
	
	WHERE
	ISNULL(a.Shorthorn_Id__c, 0) = 0
	and
	a.Id is not null
	and
	ISNULL(s.genTel, '') <> ''
	
	GROUP BY
	CAST(a.Id as NCHAR(18)),
	cl.clientId
	
	--Fill in Shorthorn ID from	Contact Telephone
	SELECT
	CAST(a.Id as NCHAR(18)) Id,
	cl.clientId Shorthorn_Id__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	[database].shorthorn.dbo.cit_sh_clients cl
	left outer join [database].shorthorn.dbo.cit_sh_sites s ON cl.clientID = s.clientId
	left outer join [database].shorthorn.dbo.cit_sh_contacts c ON s.siteId = c.siteId
	left outer join Salesforce..Account a ON REPLACE(case when c.tel like '0%' then c.tel else '0'+c.tel end,' ','') = REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
	
	WHERE
	ISNULL(a.Shorthorn_Id__c, 0) = 0
	and
	a.Id is not null
	and
	ISNULL(c.tel, '') <> ''
	
	GROUP BY
	CAST(a.Id as NCHAR(18)),
	cl.clientId
	
	--Fill in Shorthorn ID from Contact Mobile
	SELECT
	CAST(a.Id as NCHAR(18)) Id,
	cl.clientId Shorthorn_Id__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	[database].shorthorn.dbo.cit_sh_clients cl
	left outer join [database].shorthorn.dbo.cit_sh_sites s ON cl.clientID = s.clientId
	left outer join [database].shorthorn.dbo.cit_sh_contacts c ON s.siteId = c.siteId
	left outer join Salesforce..Account a ON REPLACE(case when c.mob like '0%' then c.mob else '0'+c.mob end,' ','') = REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
	
	WHERE
	ISNULL(a.Shorthorn_Id__c, 0) = 0
	and
	a.Id is not null
	and
	ISNULL(c.mob, '') <> ''
	
	GROUP BY
	CAST(a.Id as NCHAR(18)),
	cl.clientId
	
	--Fill in Site ID from Shorthorn ID and site postcode	
	SELECT
	CAST(sc.Id as NCHAR(18)) Id,
	siteID SHSiteId__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	[database].[Shorthorn].[dbo].[cit_sh_sites] s
	inner join [database].shorthorn.dbo.cit_sh_clients cl ON s.clientId = cl.clientId
	inner join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
	inner join Salesforce..Site__c sc ON REPLACE(s.postcode,' ','') = REPLACE(sc.PostCode__c,' ','') AND
										a.Id = sc.Account__c
	WHERE 
	sc.SHsiteID__c is null and siteID not in (95587,107257,109229,109230)

	--Fill in Site ID from Shorthorn ID and site phone	
	SELECT
	CAST(sc.Id as NCHAR(18)) Id,
	siteID SHSiteId__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	[database].[Shorthorn].[dbo].[cit_sh_sites] s
	inner join [database].shorthorn.dbo.cit_sh_clients cl ON s.clientId = cl.clientId
	inner join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
	inner join Salesforce..Site__c sc ON REPLACE(case when s.genTel like '0%' then s.genTel else '0'+s.genTel end,' ','') 
											= REPLACE(case when sc.Phone__c like '0%' then sc.Phone__c else '0'+sc.Phone__c end,' ','') AND
											a.Id = sc.Account__c
	WHERE 
	sc.SHsiteID__c is null and siteID not in (95587,107257,109229,109230)
	
	--Fill in Contact ID from Shorthorn ID and Contact Name	
	SELECT
	CAST(c.Id as NCHAR(18)) Id,
	shc.contactID Shorthorn_Id__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	[database].shorthorn.dbo.cit_sh_contacts shc
	inner join [database].[Shorthorn].[dbo].[cit_sh_sites] s ON shc.siteId = s.siteId
	inner join [database].shorthorn.dbo.cit_sh_clients cl ON s.clientId = cl.clientId
	inner join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
	inner join Salesforce..Contact c ON shc.fName + ' ' + shc.sName = c.FirstName + ' ' + c.LastName AND
											a.Id = c.AccountId
	WHERE 
	c.Shorthorn_Id__c is null