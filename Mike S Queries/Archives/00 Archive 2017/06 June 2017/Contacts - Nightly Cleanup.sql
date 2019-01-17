IF OBJECT_ID('tempdb..#Creations') IS NOT NULL
	BEGIN
		DROP TABLE #Creations
	END
	
IF OBJECT_ID('tempdb..#SFContactSites') IS NOT NULL
	BEGIN
		DROP TABLE #SFContactSites
	END

IF OBJECT_ID('tempdb..#SHContactSites') IS NOT NULL
	BEGIN
		DROP TABLE #SHContactSites
	END

CREATE TABLE #Creations
(
ContactString VarChar(255),
SiteJunction NCHAR(18),
[Type] VarChar(10)
)

-- Most Recent Contact Additions

SELECT TOP 10 ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY REPLACE(c.FirstName + c.LastName + a.Id,' ',''), sj.Site_Junction__c) Id, REPLACE(c.FirstName + c.LastName + a.Id,' ','') ContactString, sj.Site_Junction__c
INTO #SFContactSites
FROM Salesforce..Contact c
left outer join Salesforce..Account a ON c.AccountId = a.Id
left outer join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
WHERE a.Citation_Client__c = 'true' and sj.Site_Junction__c is not null and c.FirstName like 'A%' and sj.IsActive__c = 'true'
GROUP BY REPLACE(c.FirstName + c.LastName + a.Id,' ',''), sj.Site_Junction__c
ORDER BY ContactString, Site_Junction__c

-- Most Recent Contact Additions - Deleted Sites

SELECT TOP 10 ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY REPLACE(c.FirstName + c.LastName + a.Id,' ',''), sj.Site_Junction__c) Id, REPLACE(c.FirstName + c.LastName + a.Id,' ','') ContactString, sj.Site_Junction__c
INTO #SFDeleteSites
FROM Salesforce..Contact c
left outer join Salesforce..Account a ON c.AccountId = a.Id
left outer join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
WHERE a.Citation_Client__c = 'true' and sj.Site_Junction__c is not null and c.FirstName like 'A%' and sj.IsActive__c = 'false'
GROUP BY REPLACE(c.FirstName + c.LastName + a.Id,' ',''), sj.Site_Junction__c
ORDER BY ContactString, Site_Junction__c

-- All contacts and sites in shorthorn

SELECT ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY REPLACE(c.fName + c.sName + ISNULL(a.Id, cl.SFDC_AccountId),' ',''), ISNULL(s.SFDC_SiteId, sfs.Id)) Id, REPLACE(c.fName + c.sName + ISNULL(a.Id, cl.SFDC_AccountId),' ','') ContactString, ISNULL(s.SFDC_SiteId, sfs.Id) SiteJunction
INTO #SHContactSites
FROM [database].Shorthorn.dbo.cit_sh_contacts c
left outer join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
left outer join Salesforce..Site__c sfs ON s.siteId = sfs.SHsiteID__c
left outer join [database].shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Salesforce..Account a ON cl.clientID = a.Shorthorn_Id__c
GROUP BY REPLACE(c.fName + c.sName + ISNULL(a.Id, cl.SFDC_AccountId),' ',''), ISNULL(s.SFDC_SiteId, sfs.Id)
ORDER BY ContactString, SiteJunction

-- Begin Loop through New / Updated Salesforce contacts

DECLARE @Counter as int
SET @Counter = 1

WHILE @Counter <= (SELECT MAX(Id) FROM #SFContactSites)
BEGIN

	DECLARE @Contact as VarChar(255)
	DECLARE @Site as NCHAR(18)
	SET @Contact = (SELECT ContactString FROM #SFContactSites WHERE Id = @Counter)
	SET @Site = (SELECT Site_Junction__c FROM #SFContactSites WHERE Id = @Counter)
	
	IF @Contact not in (SELECT ISNULL(ContactString,'') FROM #SHContactSites)
		BEGIN
			INSERT INTO #Creations (ContactString, SiteJunction, [Type])
			SELECT @Contact, @Site, 'Insert'
		END	
	ELSE
		BEGIN
			DECLARE @SHCounter as int
			SET @SHCounter = (SELECT MIN(Id) FROM #SHContactSites WHERE ContactString = @Contact)
				
			WHILE @SHCounter <= (SELECT MAX(Id) FROM #SHContactSites WHERE ContactString = @Contact)
			BEGIN
				IF @Site = (SELECT SiteJunction FROM #SHContactSites WHERE Id = @SHCounter) 
					BEGIN
						INSERT INTO #Creations (ContactString, SiteJunction, [Type])
						SELECT ContactString, SiteJunction, 'Update'
						FROM #SHContactSites
						WHERE ContactString = @Contact and SiteJunction = @Site
					END
				ELSE
					BEGIN
						INSERT INTO #Creations (ContactString, SiteJunction, [Type])
						SELECT @Contact, SiteJunction, 'Update'
						FROM #SHContactSites
						WHERE Id = @SHCounter
					END
					
			SET @SHCounter = @SHCounter + 1
			
			END
		END	
		
	SET @Counter = @Counter + 1

END

SELECT * FROM #Creations

SELECT c.contactId Deletes
FROM #SFDeleteSites sfd
left outer join [database].Shorthorn.dbo.cit_sh_sites s ON sfd.Site_Junction__c = s.SFDC_SiteId
left outer join [database].shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Salesforce..Account a ON cl.clientID = a.Shorthorn_Id__c
left outer join [database].Shorthorn.dbo.cit_sh_contacts c ON s.siteID = c.siteID and sfd.ContactString = REPLACE(c.fName + c.sName + ISNULL(a.Id, cl.SFDC_AccountId),' ','')