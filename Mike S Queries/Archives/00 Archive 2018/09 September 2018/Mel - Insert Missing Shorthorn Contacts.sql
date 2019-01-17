		IF OBJECT_ID('tempdb..#Sites') IS NOT NULL DROP TABLE #Sites
		IF OBJECT_ID('tempdb..#Contacts') IS NOT NULL DROP TABLE #Contacts
		IF OBJECT_ID('tempdb..#SHCons') IS NOT NULL DROP TABLE #SHCons
		IF OBJECT_ID('tempdb..#NewCons') IS NOT NULL DROP TABLE #NewCons

		SELECT c.Id, REPLACE(CONVERT(VarChar, a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','') ContactString
		INTO #Contacts
		FROM Salesforce..Contact c
		inner join Salesforce..Account a ON c.AccountId = a.Id
		WHERE CONVERT(VarChar, a.Shorthorn_Id__c) is not null

		SELECT REPLACE(CONVERT(VarChar, clientId)+ISNULL(fName, '')+ISNULL(sName, ''),' ','') ContactString
		INTO #SHCons
		FROM [database].shorthorn.dbo.cit_sh_contacts c
		inner join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
		WHERE s.clientId is not null and (fName is not null or sName is not null)
		GROUP BY CONVERT(VarChar, clientId)+ISNULL(fName, '')+ISNULL(sName, '')
		
		SELECT c.Id
		INTO #NewCons
		FROM #Contacts c
		left outer join #SHCons shc ON c.ContactString = shc.ContactString
		WHERE shc.ContactString is null
		/*
		SELECT siteId, 1 rn
		INTO #Sites
		FROM [database].shorthorn.dbo.cit_sh_sites
		WHERE active = 1 and HeadOffice = 1
		UNION
		SELECT siteId, ROW_NUMBER () OVER (PARTITION BY clientId ORDER BY siteId) rn
		FROM [database].shorthorn.dbo.cit_sh_sites
		WHERE active = 1 and HeadOffice = 0 and clientID not in (SELECT ClientID FROM [database].shorthorn.dbo.cit_sh_sites WHERE HeadOffice = 1)
		*/
/*
		INSERT INTO 
		[database].shorthorn.dbo.cit_sh_contacts
		(siteId, fName, sName, email, tel, mob, position, SFDC_ContactId, title, [enabled])
*/
		SELECT 
		s.SHsiteID__c siteId,
		c.FirstName , 
		c.LastName , 
		c.Email , 
		c.Phone , 
		c.MobilePhone , 
		Position__c , 
		c.Id , 
		case 
		when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
		when c.Salutation like '%mrs%' then 2
		when c.Salutation like '%miss%' then 3
		when c.Salutation like '%ms%' then 4
		when c.Salutation like '%dr%' then 5 
		end , 
		1
				
		FROM
		Salesforce..Contact c
		inner join Salesforce..Account a ON c.AccountId = a.Id
		--inner join [database].shorthorn.dbo.cit_sh_sites s ON a.Shorthorn_Id__c = s.clientID and siteID in (SELECT siteID FROM #Sites WHERE rn = 1)
		inner join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
		inner join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
		inner join #NewCons con ON c.Id = con.Id
		
		WHERE
		c.Id not in
		(
			SELECT ISNULL(SFDC_ContactId, '')
			FROM [database].shorthorn.dbo.cit_sh_contacts
		)
		and ISNULL(s.SHsiteID__c, 0) <> 0
		
		GROUP BY
		s.SHsiteID__c,
		c.FirstName , 
		c.LastName , 
		c.Email , 
		c.Phone , 
		c.MobilePhone , 
		Position__c , 
		c.Id , 
		case 
		when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
		when c.Salutation like '%mrs%' then 2
		when c.Salutation like '%miss%' then 3
		when c.Salutation like '%ms%' then 4
		when c.Salutation like '%dr%' then 5 
		end