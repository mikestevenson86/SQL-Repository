
	IF OBJECT_ID('tempdb..#SH') IS NOT NULL
		BEGIN
			DROP TABLE #SH
		END
/*		
	IF OBJECT_ID('tempdb..#Updates') IS NOT NULL
		BEGIN
			DROP TABLE #Updates
		END
*/
		-- Get Shorthorn IDs from Todays Updates by SFDC_AccountID + FirstName + LastName

		SELECT	REPLACE(CONVERT(VarChar, clientID)+ISNULL(fName,'')+ISNULL(sName,''),' ','') ContactString, contactId
		INTO	#SH
		FROM	[database].shorthorn.dbo.cit_sh_contacts c
		inner join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
		WHERE	REPLACE(CONVERT(VarChar, clientID)+ISNULL(fName,'')+ISNULL(sName,''),' ','') in
		(
			SELECT 
			REPLACE(CONVERT(VarChar, a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','')
			FROM 
			Salesforce..Contact c
			inner join Salesforce..Account a ON c.AccountId = a.Id
			inner join Salesforce..ContactHistory ch ON c.Id = ch.ContactId
			inner join Salesforce..[User] u ON ch.CreatedById = u.Id
			WHERE 
			CONVERT(date, ch.CreatedDate) >= '2018-04-01'
			and 
			a.Shorthorn_Id__c is not null
			and
			u.Name in ('Melanie Johnston','Tom King','Carl Lord','Rebecca McCourt','Catherine Squires','Rachel Dixon','Nathan Ormiston',
			'Falguni Sheth','Natasha Brown','Jeremy Sumner','Ollie Pumphrey','Yuan Hui','Roisin Wallace')
			GROUP BY 
			REPLACE(CONVERT(VarChar, a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','')
		)

		-- Build temporary table for Today's Contact Update Delta

		SELECT contactID, ContactString, fName, sName, email, tel, mob, position, SFDC_ContactId, title, [enabled], adviceCardStatusContact, notes
		--INTO #Updates
		FROM
		(
			SELECT
			--ROW_NUMBER () OVER (PARTITION BY ISNULL(c.Shorthorn_Id__c, shc.contactId) ORDER BY (SELECT NULL)) rn,
			ROW_NUMBER () OVER (PARTITION BY shc.contactId ORDER BY (SELECT NULL)) rn,
			REPLACE(CONVERT(VarChar,a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','') ContactString,
			ISNULL(shc.ContactId, 0) contactId,
			ISNULL(c.FirstName, '') fName,
			ISNULL(c.LastName, '') sName,
			ISNULL(c.Email, '') email,
			ISNULL(c.Phone, '') Tel,
			ISNULL(c.MobilePhone, '') mob,
			ISNULL(c.Position__c, '') position,
			c.Id SFDC_ContactId,
			ISNULL(case 
			when c.Salutation like '%mr%' and c.Salutation not like '%mrs%' then 1
			when c.Salutation like '%mrs%' then 2
			when c.Salutation like '%miss%' then 3
			when c.Salutation like '%ms%' then 4
			when c.Salutation like '%dr%' then 5 
			end, '') title,
			ISNULL(case when c.Active__c <> 'true' then 0 else 1 end, shc.[enabled]) [enabled],
			ISNULL(case when c.Active__c <> 'true' then 2 else shc.adviceCardStatusContact end, shc.adviceCardStatusContact) adviceCardStatusContact,
			ISNULL(case 
			when shc.notes is null then CONVERT(NVarChar, c.[Description])
			when shc.notes like '%'+CONVERT(NVarChar, c.[Description])+'%' then shc.notes 
			when shc.notes != CONVERT(NVarChar, c.[Description]) THEN shc.notes + CONVERT(NVarChar, c.[Description]) ELSE shc.notes 
			end, '') notes

			FROM
			Salesforce..ContactHistory ch
			left outer join Salesforce..Contact c ON ch.ContactId = c.Id
			left outer join Salesforce..[User] u ON ch.CreatedById = u.Id
			left outer join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
			left outer join Salesforce..Account a ON c.AccountId = a.Id
			left outer join #SH sh ON REPLACE(CONVERT(VarChar,a.Shorthorn_Id__c)+ISNULL(c.FirstName,'')+ISNULL(c.LastName,''),' ','') = sh.ContactString
			--left outer join [database].shorthorn.dbo.cit_sh_contacts shc ON ISNULL(c.Shorthorn_id__c, sh.contactId) = shc.contactId
			left outer join [database].shorthorn.dbo.cit_sh_contacts shc ON sh.contactId = shc.contactId

			WHERE 
			CONVERT(date, ch.CreatedDate) >= '2018-04-01'
			and 						-- or
			u.Name in  ('Melanie Johnston','Tom King','Carl Lord','Rebecca McCourt','Catherine Squires','Rachel Dixon','Nathan Ormiston',
			'Falguni Sheth','Natasha Brown','Jeremy Sumner','Ollie Pumphrey','Yuan Hui','Roisin Wallace')
			/*
			and 
			(
				-- Only update where there is a difference between SFDC and SH
				
				ISNULL(c.FirstName, shc.fName) <> shc.fName or
				ISNULL(c.LastName, shc.sName) <> shc.sName or
				ISNULL(c.Email, '') <> shc.email or
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
			)*/
		) detail

		WHERE rn = 1 -- Removes duplicates from temporary table

		-- Update Shorthorn
/*
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
		ON p.ContactId = oq.ContactId*/