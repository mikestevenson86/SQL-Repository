BEGIN
	exec Salesforce..SF_Refresh 'Salesforce','Site_Junction__c'
END

IF OBJECT_ID('Salesforce..Site_Junction__c_Update') IS NOT NULL 
	BEGIN
		DROP TABLE Salesforce..Site_Junction__c_Update
	END

IF OBJECT_ID('Salesforce..SiteJunction_Update') IS NOT NULL 
	BEGIN
		DROP TABLE Salesforce..SiteJunction_Update
	END

	-- Main H&S Contact
	
	SELECT
	CAST(sj.Id as NChar(18)) Id,
	CAST('TRUE' as NVarChar(10)) [Main_H_S_Contact__c],
	CAST('FALSE' as NVarChar(10)) [Main_PEL_Contact__c],
    CAST('FALSE' as NVarChar(10)) [Main_Site_Contact__c],
    CAST('FALSE' as NVarChar(10)) [Secondary_H_S_Contact__c],
    CAST('FALSE' as NVarChar(10)) [Secondary_PEL_Contact__c],
    CAST('FALSE' as NVarChar(10)) [Secondary_Site_Contact__c],
    CAST('FALSE' as NVarChar(10)) [Citweb_Super_User__c],
    CAST(case when c.[enabled] = 1 then 'TRUE' else 'FALSE' end as NVarChar(10)) IsActive__c,
	CAST('' as NVarChar(255)) Error
	
	INTO
	Salesforce..SiteJunction_Update
	
	FROM [database].Shorthorn.dbo.cit_sh_contacts c
	inner join [database].Shorthorn.dbo.cit_sh_sites mhs ON c.contactID = mhs.mainContactHS
	inner join Salesforce..Contact sfc ON c.contactID = sfc.Shorthorn_Id__c
	inner join Salesforce..Site__c sfs ON mhs.siteID = sfs.SHSiteId__c 
	inner join Salesforce..Site_Junction__c sj ON sfc.ID = sj.Contact_Junction__c
															and sfs.ID = sj.Site_Junction__c
	WHERE sj.Main_H_S_Contact__c = 'false'
	
	-- Secondary H&S Contact
	
	INSERT INTO
	Salesforce..SiteJunction_Update
	
	SELECT
	CAST(sj.Id as NChar(18)) Id,
	'FALSE' [Main_H_S_Contact__c],
	'FALSE' [Main_PEL_Contact__c],
    'FALSE' [Main_Site_Contact__c],
    'TRUE' [Secondary_H_S_Contact__c],
    'FALSE' [Secondary_PEL_Contact__c],
    'FALSE' [Secondary_Site_Contact__c],
    'FALSE' [Citweb_Super_User__c],
    case when c.[enabled] = 1 then 'TRUE' else 'FALSE' end IsActive__c,
	CAST('' as NVarChar(255)) Error
	
	FROM [database].Shorthorn.dbo.cit_sh_contacts c
	inner join [database].Shorthorn.dbo.cit_sh_sites shs ON c.contactID = shs.secContactHS
	inner join Salesforce..Contact sfc ON c.contactID = sfc.Shorthorn_Id__c
	inner join Salesforce..Site__c sfs ON shs.siteID = sfs.SHSiteId__c 
	inner join Salesforce..Site_Junction__c sj ON sfc.ID = sj.Contact_Junction__c
															and sfs.ID = sj.Site_Junction__c
	WHERE sj.Secondary_H_S_Contact__c = 'false'
	
	-- Main PEL Contact
	
	INSERT INTO
	Salesforce..SiteJunction_Update
	
	SELECT
	CAST(sj.Id as NChar(18)) Id,
	'FALSE' [Main_H_S_Contact__c],
	'TRUE' [Main_PEL_Contact__c],
    'FALSE' [Main_Site_Contact__c],
    'FALSE' [Secondary_H_S_Contact__c],
    'FALSE' [Secondary_PEL_Contact__c],
    'FALSE' [Secondary_Site_Contact__c],
    'FALSE' [Citweb_Super_User__c],
    case when c.[enabled] = 1 then 'TRUE' else 'FALSE' end IsActive__c,
	CAST('' as NVarChar(255)) Error
	
	FROM [database].Shorthorn.dbo.cit_sh_contacts c
	inner join [database].Shorthorn.dbo.cit_sh_sites mhr ON c.contactID = mhr.mainContactPEL
	inner join Salesforce..Contact sfc ON c.contactID = sfc.Shorthorn_Id__c
	inner join Salesforce..Site__c sfs ON mhr.siteID = sfs.SHSiteId__c 
	inner join Salesforce..Site_Junction__c sj ON sfc.ID = sj.Contact_Junction__c
															and sfs.ID = sj.Site_Junction__c
	WHERE sj.[Main_PEL_Contact__c] = 'false'

	-- Secondary PEL Contact
	
	INSERT INTO
	Salesforce..SiteJunction_Update
	
	SELECT
	CAST(sj.Id as NChar(18)) Id,
	'FALSE' [Main_H_S_Contact__c],
	'FALSE' [Main_PEL_Contact__c],
    'FALSE' [Main_Site_Contact__c],
    'FALSE' [Secondary_H_S_Contact__c],
    'TRUE' [Secondary_PEL_Contact__c],
    'FALSE' [Secondary_Site_Contact__c],
    'FALSE' [Citweb_Super_User__c],
    case when c.[enabled] = 1 then 'TRUE' else 'FALSE' end IsActive__c,
	CAST('' as NVarChar(255)) Error
	
	FROM [database].Shorthorn.dbo.cit_sh_contacts c
	inner join [database].Shorthorn.dbo.cit_sh_sites shr ON c.contactID = shr.secContactPEL
	inner join Salesforce..Contact sfc ON c.contactID = sfc.Shorthorn_Id__c
	inner join Salesforce..Site__c sfs ON shr.siteID = sfs.SHSiteId__c 
	inner join Salesforce..Site_Junction__c sj ON sfc.ID = sj.Contact_Junction__c
															and sfs.ID = sj.Site_Junction__c
	WHERE sj.[Secondary_PEL_Contact__c] = 'false'
	
	-- Main Site Contact
	
	INSERT INTO
	Salesforce..SiteJunction_Update
	
	SELECT
	CAST(sj.Id as NChar(18)) Id,
	'FALSE' [Main_H_S_Contact__c],
	'FALSE' [Main_PEL_Contact__c],
    'TRUE' [Main_Site_Contact__c],
    'FALSE' [Secondary_H_S_Contact__c],
    'FALSE' [Secondary_PEL_Contact__c],
    'FALSE' [Secondary_Site_Contact__c],
    'FALSE' [Citweb_Super_User__c],
    case when c.[enabled] = 1 then 'TRUE' else 'FALSE' end IsActive__c,
	CAST('' as NVarChar(255)) Error
	
	FROM [database].Shorthorn.dbo.cit_sh_contacts c
	inner join [database].Shorthorn.dbo.cit_sh_sites mu ON c.contactID = mu.genContact
	inner join Salesforce..Contact sfc ON c.contactID = sfc.Shorthorn_Id__c
	inner join Salesforce..Site__c sfs ON mu.siteID = sfs.SHSiteId__c 
	inner join Salesforce..Site_Junction__c sj ON sfc.ID = sj.Contact_Junction__c
															and sfs.ID = sj.Site_Junction__c
	WHERE sj.[Main_Site_Contact__c] = 'false'

	-- Secondary Site Contact
	
	INSERT INTO
	Salesforce..SiteJunction_Update
	
	SELECT
	CAST(sj.Id as NChar(18)) Id,
	'FALSE' [Main_H_S_Contact__c],
	'FALSE' [Main_PEL_Contact__c],
    'FALSE' [Main_Site_Contact__c],
    'FALSE' [Secondary_H_S_Contact__c],
    'FALSE' [Secondary_PEL_Contact__c],
    'TRUE' [Secondary_Site_Contact__c],
    'FALSE' [Citweb_Super_User__c],
    case when c.[enabled] = 1 then 'TRUE' else 'FALSE' end IsActive__c,
	CAST('' as NVarChar(255)) Error
	
	FROM [database].Shorthorn.dbo.cit_sh_contacts c
	inner join [database].Shorthorn.dbo.cit_sh_sites su ON c.contactID = su.secContact
	inner join Salesforce..Contact sfc ON c.contactID = sfc.Shorthorn_Id__c
	inner join Salesforce..Site__c sfs ON su.siteID = sfs.SHSiteId__c 
	inner join Salesforce..Site_Junction__c sj ON sfc.ID = sj.Contact_Junction__c
															and sfs.ID = sj.Site_Junction__c
	WHERE sj.[Secondary_Site_Contact__c] = 'false'
	
	-- CitWeb Super User
	
	INSERT INTO
	Salesforce..SiteJunction_Update
	
	SELECT
	CAST(sj.Id as NChar(18)) Id,
	'FALSE' [Main_H_S_Contact__c],
	'FALSE' [Main_PEL_Contact__c],
    'FALSE' [Main_Site_Contact__c],
    'FALSE' [Secondary_H_S_Contact__c],
    'FALSE' [Secondary_PEL_Contact__c],
    'FALSE' [Secondary_Site_Contact__c],
    'TRUE' [Citweb_Super_User__c],
    case when c.[enabled] = 1 then 'TRUE' else 'FALSE' end IsActive__c,
	CAST('' as NVarChar(255)) Error
	
	FROM [database].Shorthorn.dbo.cit_sh_contacts c
	inner join [database].Shorthorn.dbo.cit_sh_sites cws ON c.contactID = cws.citManSuper
	inner join Salesforce..Contact sfc ON c.contactID = sfc.Shorthorn_Id__c
	inner join Salesforce..Site__c sfs ON cws.siteID = sfs.SHSiteId__c 
	inner join Salesforce..Site_Junction__c sj ON sfc.ID = sj.Contact_Junction__c
															and sfs.ID = sj.Site_Junction__c
	WHERE sj.[Citweb_Super_User__c] = 'false'
	
	SELECT 
	CAST(Id as NCHAR(18)) Id,
	MAX([Main_H_S_Contact__c]) [Main_H_S_Contact__c],
	MAX([Main_PEL_Contact__c]) [Main_PEL_Contact__c],
    MAX([Main_Site_Contact__c]) [Main_Site_Contact__c],
    MAX([Secondary_H_S_Contact__c]) [Secondary_H_S_Contact__c],
    MAX([Secondary_PEL_Contact__c]) [Secondary_PEL_Contact__c],
	MAX([Secondary_Site_Contact__c]) [Secondary_Site_Contact__c],
    MAX([Citweb_Super_User__c]) [Citweb_Super_User__c],
    MAX(IsActive__c) IsActive__c,
    CAST('' as NVarChar(255)) Error
    
    INTO
    Salesforce..Site_Junction__c_Update
    
    FROM
    Salesforce..SiteJunction_Update
	
	GROUP BY
	Id
	
	exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Site_Junction__c_Update'