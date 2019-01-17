		-- Clearance
/*
		IF OBJECT_ID('Salesforce..Contact_Load') IS NOT NULL
		BEGIN
			DROP TABLE Salesforce..Contact_Load
		END

		IF OBJECT_ID('Salesforce..ATLAS_User__c_Update') IS NOT NULL
		BEGIN
			DROP TABLE Salesforce..ATLAS_User__c_Update
		END
*/
		IF OBJECT_ID('tempdb..#Missing') IS NOT NULL
		BEGIN
			DROP TABLE #Missing
		END

		IF OBJECT_ID('SalesforceReporting..AtlasUserContacts') IS NOT NULL
		BEGIN
			DROP TABLE SalesforceReporting..AtlasUserContacts
		END

		-- Missing Contact

		SELECT au.Id,
		STUFF
			   (
					  (
							 SELECT ', ' + up.Name
							 FROM 
								   [AtlasStaging]..UserProfilesMap upm left outer join 
								   [AtlasStaging]..UserProfiles up ON upm.UserProfileId = up.Id
							 WHERE
								   CAST(au.Id as NCHAR(36)) = CAST(upm.UserId as NCHAR(36))
							 ORDER BY up.Name
							 FOR XML PATH ('')
					  ), 1, 1, ''
			   ) Profile__c
		INTO #Missing
		FROM Salesforce..Atlas_User__c au
		left outer join Salesforce..Contact con ON LEFT(CONVERT(VarChar,au.Contact__c), 15) collate latin1_general_CS_AS = LEFT(con.Id, 15) collate latin1_general_CS_AS
		WHERE con.Id is null and (Profile__c like '%manager%' or Profile__c like '%service owner%')

		-- Create Temporary Table

		CREATE TABLE SalesforceReporting..AtlasUserContacts
		(
		Id int identity,
		AtlasUserId VarChar(20),
		ContactId VarChar(20)
		)

		-- Gap Tables
/*
		INSERT INTO SalesforceReporting..AtlasUserContacts
		SELECT au.Id, c.Id Contact
		FROM Salesforce..Atlas_User__c au
		inner join #Missing m ON au.Id = m.Id
		left outer join Salesforce..Contact c ON LEFT(au.Account__c, 15) collate latin1_general_CS_AS = LEFT(c.AccountId, 15) collate latin1_general_CS_AS
												and CONVERT(VarChar, au.FirstName__c) = c.FirstName
												and CONVERT(VarChar, au.SecondName__c) = c.LastName
		WHERE c.Id is not null

		INSERT INTO SalesforceReporting..AtlasUserContacts
		SELECT au.Id, c.Id Contact
		FROM Salesforce..Atlas_User__c au
		inner join #Missing m ON au.Id = m.Id
		left outer join Salesforce..Contact c ON LEFT(au.Account__c, 15) collate latin1_general_CS_AS = LEFT(c.AccountId, 15) collate latin1_general_CS_AS
												and REPLACE(CONVERT(VarChar, au.FirstName__c) + CONVERT(VarChar, au.SecondName__c),' ','') = REPLACE(c.FirstName + c.LastName,' ','')
		WHERE c.Id is not null
*/
		INSERT INTO SalesforceReporting..AtlasUserContacts
		SELECT au.Id, c.Id Contact
		FROM Salesforce..Atlas_User__c au
		inner join #Missing m ON au.Id = m.Id
		left outer join Salesforce..Contact c ON LEFT(au.Account__c, 15) collate latin1_general_CS_AS = LEFT(c.AccountId, 15) collate latin1_general_CS_AS
												and CONVERT(VarChar, au.Email__c) = c.Email
		WHERE c.Id is not null

		DELETE FROM SalesforceReporting..AtlasUserContacts
		WHERE Id in
		(
			SELECT Id
			FROM
			(
				SELECT Id, AtlasUserId, ContactId, ROW_NUMBER () OVER (PARTITION BY AtlasUserId, ContactId ORDER BY (SELECT NULL)) rn
				FROM SalesforceReporting..AtlasUserContacts
			) detail
			WHERE rn > 1
		)

		-- Last Results

		-- Update File

		SELECT 
		CAST(au.Id as NCHAR(18)) Id, 
		c.ContactId,
		CONVERT(VarChar, au.FirstName__c) + ' ' + CONVERT(VarChar, au.SecondName__c) [Atlas User Name],
		CONVERT(VarChar, au.FirstName__c) [Atlas First Name],
		CONVERT(VarChar, au.SecondName__c) [Atlas Last Name],
		con.FirstName + ' ' + con.LastName [Contact Name],
		con.FirstName [SFDC First Name],
		con.LastName [SFDC Last Name],
		con.Shorthorn_Id__c [Shorthorn ID],
		sc.fName [SH First Name],
		sc.sName [SH Last Name],
		au.Email__c,
		con.Email,
		CAST('' as NVARCHAR(255)) Error

		--INTO 
		--Salesforce..Atlas_User__c_Update

		FROM 
		Salesforce..Atlas_User__c au
		left outer join SalesforceReporting..AtlasUserContacts c ON au.Id = c.AtlasUserId
		left outer join Salesforce..Contact con ON c.ContactId = con.Id
		left outer join [database].shorthorn.dbo.cit_sh_contacts sc ON con.Shorthorn_Id__c = sc.ContactID
		
		WHERE
		c.Id is not null and con.Id is not null

		-- Net New File

		SELECT
		CAST('' as NCHAR(18)) Id, 
		cc.FullName,
		au.ID AtlasUserId, 
		atl.Account__c AccountId, 
		CONVERT(VarChar, FirstName__c) FirstName, 
		CONVERT(VarChar(255), SecondName__c) LastName,
		CONVERT(VarChar(255), Email__c) Email,
		CAST('' as NVARCHAR(255)) Error

		--INTO 
		--Salesforce..Contact_Load

		FROM #Missing au
		left outer join SalesforceReporting..AtlasUserContacts c ON au.Id = c.AtlasUserId
		left outer join Salesforce..ATLAS_User__c atl ON CAST(au.Id as NCHAR(36)) = CAST(atl.Id as NCHAR(36))
		left outer join AtlasStaging.Shared.Users u ON CAST(atl.UserID__c as NCHAR(36)) = CAST(u.Id as NCHAR(36))
		left outer join AtlasStaging.Citation.Companies cc ON u.CompanyId = cc.Id

		WHERE 
		c.AtlasUserId is null
		and 
		CONVERT(VarChar, ISNULL(FirstName__c,'')) <> 'Admin'
		and
		CONVERT(VarChar(255), ISNULL(SecondName__c,'')) <> RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cc.FullName, ' ', ''), '/', ''), '&', ''), '(', ''), ')', ''))) 
		and
		CONVERT(VarChar(255), ISNULL(Email__c,'')) <> 'admin@' + RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cc.FullName, ' ', ''), '/', ''), '&', ''), '(', ''), ')', '')))  + '.co.uk'

		DROP TABLE #Missing
		DROP TABLE SalesforceReporting..AtlasUserContacts