DECLARE @Msg As Int
DECLARE @Rows AS Int

SET @Msg = 0

exec Salesforce..SF_Refresh 'Salesforce','ContactHistory'

SET @Msg = @Msg + @@ROWCOUNT

exec Salesforce..SF_Refresh 'Salesforce','Contact'

SET @Msg = @Msg + @@ROWCOUNT

exec Salesforce..SF_Refresh 'Salesforce','Account'

SET @Msg = @Msg + @@ROWCOUNT

IF @Msg = 3
	BEGIN

	IF OBJECT_ID('tempdb..#SH') IS NOT NULL
		BEGIN
			DROP TABLE #SH
		END
		
	IF OBJECT_ID('tempdb..#Updates') IS NOT NULL
		BEGIN
			DROP TABLE #Updates
		END
		
	IF OBJECT_ID('tempdb..#Multiple') IS NOT NULL
		BEGIN
			DROP TABLE #Multiple
		END

		-- Get Shorthorn IDs from Todays Updates by SFDC_AccountID + FirstName + LastName

		SELECT	REPLACE(CONVERT(VarChar, clientID)+ISNULL(fName,'')+ISNULL(sName,''),' ','') ContactString, contactId
		INTO	#SH
		FROM	[database].shorthorn.dbo.cit_sh_contacts c
		inner join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
		WHERE	REPLACE(CONVERT(VarChar, clientID)+ISNULL(fName,'')+ISNULL(sName,''),' ','') in
		(
			SELECT 
			REPLACE(CONVERT(VarChar, a.Shorthorn_Id__c)+ISNULL(FirstName,'')+ISNULL(LastName,''),' ','')
			FROM 
			Salesforce..Contact c
			inner join Salesforce..Account a ON c.AccountId = a.Id
			inner join Salesforce..ContactHistory ch ON c.Id = ch.ContactId
			WHERE 
			CONVERT(date, ch.CreatedDate) = CONVERT(date, GETDATE()) 
			and 
			a.Shorthorn_Id__c is not null
			GROUP BY 
			REPLACE(CONVERT(VarChar, a.Shorthorn_Id__c)+ISNULL(FirstName,'')+ISNULL(LastName,''),' ','')
		)

		-- Build temporary table for Today's Contact Update Delta

		SELECT contactID, ContactString, fName, sName, email, tel, mob, position, SFDC_ContactId, title, [enabled], adviceCardStatusContact, notes
		INTO #Updates
		FROM
		(
			SELECT
			ROW_NUMBER () OVER (PARTITION BY ISNULL(c.Shorthorn_Id__c, shc.contactId) ORDER BY (SELECT NULL)) rn,
			REPLACE(CONVERT(VarChar,a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','') ContactString,
			ISNULL(c.Shorthorn_Id__c, shc.contactId) contactId,
			ISNULL(c.FirstName, shc.fName) fName,
			ISNULL(c.LastName, shc.sName) sName,
			ISNULL(c.Email, shc.email) email,
			ISNULL(c.Phone, shc.Tel) Tel,
			ISNULL(c.MobilePhone, shc.mob) mob,
			ISNULL(c.Position__c, shc.position) position,
			ISNULL(c.Id, shc.SFDC_ContactId) SFDC_ContactId,
			ISNULL(case 
			when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
			when c.Salutation like '%mrs%' then 2
			when c.Salutation like '%miss%' then 3
			when c.Salutation like '%ms%' then 4
			when c.Salutation like '%dr%' then 5 
			end, shc.title) title,
			ISNULL(case when c.Active__c <> 'true' then 0 else 1 end, shc.[enabled]) [enabled],
			ISNULL(case when c.Active__c <> 'true' then 2 else shc.adviceCardStatusContact end, shc.adviceCardStatusContact) adviceCardStatusContact,
			ISNULL(case 
			when shc.notes is null then CONVERT(NVarChar, c.[Description])
			when shc.notes like '%'+CONVERT(NVarChar, c.[Description])+'%' then shc.notes 
			when shc.notes != CONVERT(NVarChar, c.[Description]) THEN shc.notes + CONVERT(NVarChar, c.[Description]) ELSE shc.notes 
			end, shc.notes) notes

			FROM
			Salesforce..ContactHistory ch
			left outer join Salesforce..Contact c ON ch.ContactId = c.Id
			left outer join Salesforce..[User] u ON ch.CreatedById = u.Id
			left outer join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
			left outer join Salesforce..Account a ON c.AccountId = a.Id
			left outer join #SH sh ON REPLACE(CONVERT(VarChar,a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','') = sh.ContactString
			left outer join [database].shorthorn.dbo.cit_sh_contacts shc ON ISNULL(c.Shorthorn_id__c, sh.contactId) = shc.contactId

			WHERE 
			CONVERT(date, ch.CreatedDate) = CONVERT(date, GETDATE())  -- Today's Contact History
			and 
			uMan.Name = 'Melanie Johnston' -- Only changes by Mel's team
			and 
			ISNULL(c.Shorthorn_Id__c, shc.contactId) is not null -- Only changes we can use to update Shorthorn
			and
			(
				-- Only update where there is a difference between SFDC and SH
				
				ISNULL(c.FirstName, shc.fName) <> shc.fName or
				ISNULL(c.LastName, shc.sName) <> shc.sName or
				ISNULL(c.Email, shc.email) <> shc.email or
				ISNULL(c.Phone, shc.Tel) <> shc.Tel or
				ISNULL(c.MobilePhone, shc.mob) <> shc.mob or
				ISNULL(c.Position__c, shc.position) <> shc.position or
				ISNULL(c.Id, shc.SFDC_ContactId) <> shc.SFDC_ContactId or
				ISNULL(case 
				when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
				when c.Salutation like '%mrs%' then 2
				when c.Salutation like '%miss%' then 3
				when c.Salutation like '%ms%' then 4
				when c.Salutation like '%dr%' then 5 
				end, shc.title) <> shc.title or
				ISNULL(case when c.Active__c <> 'true' then 0 else 1 end, shc.[enabled]) <> shc.[enabled] or
				ISNULL(case when c.Active__c <> 'true' then 2 else shc.adviceCardStatusContact end, shc.adviceCardStatusContact) <> shc.adviceCardStatusContact or
				ISNULL(case 
				when shc.notes is null then CONVERT(NVarChar, c.[Description])
				when shc.notes like '%'+CONVERT(NVarChar, c.[Description])+'%' then shc.notes 
				when shc.notes != CONVERT(NVarChar, c.[Description]) THEN shc.notes + CONVERT(NVarChar, c.[Description]) ELSE shc.notes 
				end, shc.notes) <> shc.notes
			)
		) detail

		WHERE rn = 1 -- Removes duplicates from temporary table
/*
		SELECT
		p.fName,
		p.sName,
		p.email,
		p.tel,
		p.mob,
		p.position,
		p.SFDC_ContactId,
		p.title,
		p.[enabled] ,
		p.notes,
		p.adviceCardStatusContact
		FROM   OPENQUERY([DATABASE],
		'SELECT contactId, fName, sName, email, tel, mob, position, SFDC_ContactId, title, enabled, notes, adviceCardStatusContact
		FROM Shorthorn.dbo.cit_sh_contacts') oq 
		INNER JOIN #Updates p 
		ON p.ContactId = oq.ContactId
*/
		-- Update Shorthorn

		UPDATE	oq 
		SET		fName = p.fName
				,sName = p.sName
				,email = p.email
				,tel = p.tel
				,mob = p.mob
				,position = p.position
				,SFDC_ContactId = p.SFDC_ContactId
				,title = p.title
				,[enabled] = p.[enabled] 
				,notes = p.notes
				,adviceCardStatusContact = p.adviceCardStatusContact
		FROM   OPENQUERY([DATABASE],
		'SELECT contactId, fName, sName, email, tel, mob, position, SFDC_ContactId, title, enabled, notes, adviceCardStatusContact
		FROM Shorthorn.dbo.cit_sh_contacts') oq 
		INNER JOIN #Updates p 
		ON p.ContactId = oq.ContactId
	
		-- Check to see if update was successful
		
		SELECT @Rows = COUNT(*)
		FROM
		(
			SELECT
			ROW_NUMBER () OVER (PARTITION BY ISNULL(c.Shorthorn_Id__c, shc.contactId) ORDER BY (SELECT NULL)) rn,
			ISNULL(c.Shorthorn_Id__c, shc.contactId) contactId,
			ISNULL(c.FirstName, shc.fName) fName,
			ISNULL(c.LastName, shc.sName) sName,
			ISNULL(c.Email, shc.email) email,
			ISNULL(c.Phone, shc.Tel) Tel,
			ISNULL(c.MobilePhone, shc.mob) mob,
			ISNULL(c.Position__c, shc.position) position,
			ISNULL(c.Id, shc.SFDC_ContactId) SFDC_ContactId,
			ISNULL(case 
			when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
			when c.Salutation like '%mrs%' then 2
			when c.Salutation like '%miss%' then 3
			when c.Salutation like '%ms%' then 4
			when c.Salutation like '%dr%' then 5 
			end, shc.title) title,
			ISNULL(case when c.Active__c <> 'true' then 0 else 1 end, shc.[enabled]) [enabled],
			ISNULL(case when c.Active__c <> 'true' then 2 else shc.adviceCardStatusContact end, shc.adviceCardStatusContact) adviceCardStatusContact,
			ISNULL(case 
			when shc.notes is null then CONVERT(NVarChar, c.[Description])
			when shc.notes like '%'+CONVERT(NVarChar, c.[Description])+'%' then shc.notes 
			when shc.notes != CONVERT(NVarChar, c.[Description]) THEN shc.notes + CONVERT(NVarChar, c.[Description]) ELSE shc.notes 
			end, shc.notes) notes

			FROM
			Salesforce..ContactHistory ch
			left outer join Salesforce..Contact c ON ch.ContactId = c.Id
			left outer join Salesforce..[User] u ON ch.CreatedById = u.Id
			left outer join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
			left outer join Salesforce..Account a ON c.AccountId = a.Id
			left outer join #SH sh ON REPLACE(CONVERT(VarChar,a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','') = sh.ContactString
			left outer join [database].shorthorn.dbo.cit_sh_contacts shc ON ISNULL(c.Shorthorn_id__c, sh.contactId) = shc.contactId

			WHERE 
			CONVERT(date, ch.CreatedDate) = CONVERT(date, GETDATE()) 
			and 
			uMan.Name = 'Melanie Johnston' 
			and 
			ISNULL(c.Shorthorn_Id__c,shc.contactId) is not null
			and
			(
				ISNULL(c.FirstName, shc.fName) <> shc.fName or
				ISNULL(c.LastName, shc.sName) <> shc.sName or
				ISNULL(c.Email, shc.email) <> shc.email or
				ISNULL(c.Phone, shc.Tel) <> shc.Tel or
				ISNULL(c.MobilePhone, shc.mob) <> shc.mob or
				ISNULL(c.Position__c, shc.position) <> shc.position or
				ISNULL(c.Id, shc.SFDC_ContactId) <> shc.SFDC_ContactId or
				ISNULL(case 
				when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
				when c.Salutation like '%mrs%' then 2
				when c.Salutation like '%miss%' then 3
				when c.Salutation like '%ms%' then 4
				when c.Salutation like '%dr%' then 5 
				end, shc.title) <> shc.title or
				ISNULL(case when c.Active__c <> 'true' then 0 else 1 end, shc.[enabled]) <> shc.[enabled] or
				ISNULL(case when c.Active__c <> 'true' then 2 else shc.adviceCardStatusContact end, shc.adviceCardStatusContact) <> shc.adviceCardStatusContact or
				ISNULL(case 
				when shc.notes is null then CONVERT(NVarChar, c.[Description])
				when shc.notes like '%'+CONVERT(NVarChar, c.[Description])+'%' then shc.notes 
				when shc.notes != CONVERT(NVarChar, c.[Description]) THEN shc.notes + CONVERT(NVarChar, c.[Description]) ELSE shc.notes 
				end, shc.notes) <> shc.notes
			)
		) detail

		WHERE rn = 1

		-- Record results of process

		INSERT INTO SalesforceReporting..SFDC_SH_Updates (Process, Updates, Completed, RunDate)
		VALUES ('InitialUpdate',(SELECT COUNT(*) FROM #Updates), case when @Rows = 0 then 'Yes' else 'No' end, GETDATE())

		-- Re-Run for Multiple Contacts Updates
		
		SELECT 
		sh.ContactId, 
		u.ContactString, u.fName, u.sName, u.email, u.tel, u.mob,u.position, u.SFDC_ContactId, u.title, u.[enabled], u.adviceCardStatusContact, u.notes
		INTO #Multiple
		FROM #Updates u
		inner join #SH sh ON u.ContactString = sh.ContactString 
								and u.contactId <> sh.contactId
		/*
		SELECT
		p.ContactId,
		p.fName,
		p.sName,
		p.email,
		p.tel,
		p.mob,
		p.position,
		p.SFDC_ContactId,
		p.title,
		oq.notes + CHAR(13) + CHAR(13) + 'Updated from Contact: ' + p.SFDC_ContactId
				--p.[enabled]
				--p.adviceCardStatusContact
		FROM   OPENQUERY([DATABASE],
		'SELECT contactId, fName, sName, email, tel, mob, position, SFDC_ContactId, title, enabled, notes, adviceCardStatusContact
		FROM Shorthorn.dbo.cit_sh_contacts') oq 
		INNER JOIN #Multiple p 
		ON p.ContactId = oq.ContactId
		
		SET @Rows = @@ROWCOUNT
		*/

		UPDATE	oq 
		SET		fName = p.fName
				,sName = p.sName
				,email = p.email
				,tel = p.tel
				,mob = p.mob
				,position = p.position
				,SFDC_ContactId = p.SFDC_ContactId
				,title = p.title
				,notes = oq.notes + CHAR(13) + CHAR(13) + 'Updated from Contact: ' + p.SFDC_ContactId
				--p.[enabled]
				--p.adviceCardStatusContact
		FROM   OPENQUERY([DATABASE],
		'SELECT contactId, fName, sName, email, tel, mob, position, SFDC_ContactId, title, enabled, notes, adviceCardStatusContact
		FROM Shorthorn.dbo.cit_sh_contacts') oq 
		INNER JOIN #Multiple p 
		ON p.ContactId = oq.ContactId
		
		SET @Rows = @@ROWCOUNT
				
		-- Record results of process

		INSERT INTO SalesforceReporting..SFDC_SH_Updates (Process, Updates, Completed, RunDate)
		VALUES ('MultiUpdate',(SELECT COUNT(*) FROM #Multiple), case when @Rows > 0 then 'Yes' else 'No' end, GETDATE())
		
		-- Insert New Contacts

		INSERT INTO 
		[database].shorthorn.dbo.cit_sh_contacts
		(fName, sName, email, tel, mob, position, SFDC_ContactId, title, [enabled])

		SELECT 
		c.FirstName fName, 
		c.LastName sName, 
		c.Email email, 
		c.Phone tel, 
		c.MobilePhone mob, 
		Position__c position, 
		c.Id SFDC_ContactId, 
		case 
		when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
		when c.Salutation like '%mrs%' then 2
		when c.Salutation like '%miss%' then 3
		when c.Salutation like '%ms%' then 4
		when c.Salutation like '%dr%' then 5 
		end title, 
		1 [enabled]
		
		FROM
		Salesforce..Contact c
		inner join Salesforce..Account a ON c.AccountId = a.Id
		inner join Salesforce..[User] u ON c.CreatedById = u.Id
		inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
		
		WHERE
		CONVERT(date, c.CreatedDate) = CONVERT(date, GETDATE())
		and
		uMan.Name = 'Melanie Johnston'
		and
		CONVERT(VarChar, a.Shorthorn_Id__c)+c.FirstName+c.LastName not in
		(
			SELECT CONVERT(VarChar, clientId)+fName+sName
			FROM [database].shorthorn.dbo.cit_sh_contacts c
			inner join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
			GROUP BY CONVERT(VarChar, clientId)+fName+sName
		)

		SET @Rows = @@ROWCOUNT
		
		--SELECT @Rows

		-- Record results of process

		INSERT INTO SalesforceReporting..SFDC_SH_Updates (Process, Updates, Completed, RunDate)
		VALUES ('Inserts',@Rows, case when @Rows > 0 then 'Yes' else 'No' end, GETDATE())

	END