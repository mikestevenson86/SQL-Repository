
DECLARE	@SH_Id as int = 68205,
		@Salutation as NVarChar(50) ='Ms.',
		@FirstName as NVarChar(100) = 'Marian',
		@LastName as NVarChar(100) = 'Hilton',
		@Email as NVarChar(255) = 'bim@influencemanchester.co.uk',
		@Phone as NVarChar(50) = '0161 835 2064',
		@Mobile as NVarChar(50) = '07708 058648',
		@PostCode as NVarChar(20) = 'M8 8PZ',
		@Position as NVarChar(100) = 'Monitor',
		@Enabled as bit = 1,
		@SFDCId as NCHAR(18) = '003D000001tozMVIAY',
		@SynchContactId as int = 22
		
IF OBJECT_ID('tempdb..#TempUp') IS NOT NULL
	BEGIN
		DROP TABLE #TempUp
	END

CREATE TABLE #TempUp
(
ContactId NCHAR(18),
ShorthornId int
)

IF OBJECT_ID('LogicAppAudit..cit_sh_contacts') IS NOT NULL
	BEGIN
		DROP TABLE LogicAppAudit..cit_sh_contacts
	END

	SELECT *
	INTO LogicAppAudit..cit_sh_contacts
	FROM [database].shorthorn.dbo.cit_sh_contacts
	WHERE contactID = @SH_Id

	IF ISNULL(@SH_Id,'') <> ''
		BEGIN
			UPDATE 
				sc
			SET 
				fName = @FirstName
				,sName = @LastName
				,email = @Email
				,tel = @Phone
				,mob = @Mobile
				,position = @Position
				,SFDC_ContactId = @SFDCId
				,title =	case when @Salutation like '%mr%' and @Salutation not like '%mrs%' then 1
							when @Salutation like '%mrs%' then 2
							when @Salutation like '%miss%' then 3
							when @Salutation like '%ms%' then 4
							when @Salutation like '%dr%' then 5 end
				,enabled = @Enabled
				--,siteID = (SELECT top 1 SiteId from Shorthorn..cit_sh_sites where clientID = @SH_ClientId and postcode = @PostCode and @Street like address1+'%')
			OUTPUT
				inserted.SFDC_ContactId, inserted.contactID INTO #TempUp
			FROM 
				LogicAppAudit.dbo.cit_sh_contacts sc
				left outer join [database].Shorthorn.dbo.cit_sh_sites s ON sc.siteID = s.siteID
			WHERE
				sc.contactID = @SH_Id
				--REPLACE(sc.fName + sc.sName + CONVERT(VarChar, s.clientID),' ','') = REPLACE(@FirstName + @LastName + CONVERT(VarChar, @SH_ClientId),' ','')

			UPDATE cc SET Processed = 1, NewShorthornContactId = case when ISNULL(shorthornId,'') = '' then 
			(
			SELECT TOP 1 ShorthornId 
			FROM #TempUp
			) else 0 end 
			FROM LogicAppAudit..ContactChangesXML cc 
			inner join LogicAppAudit..UnProcessedContactChanges ucc ON cc.id = ucc.id 
			WHERE cc.Processed = 0 and cc.Id = @SynchContactId and ContactId in (SELECT contactID FROM #TempUp)
		END
		
		UPDATE oq 
		SET    fName = p.fName
				,sName = p.sName
				,email = p.email
				,tel = p.tel
				,mob = p.mob
				,position = p.position
				,SFDC_ContactId = p.SFDC_ContactId
				,title = p.title
				,[enabled] = p.[enabled] 
		FROM   OPENQUERY([DATABASE],
       'select ContactId, fName,sName,email,tel,mob,position,SFDC_ContactId,title,enabled from Shorthorn.dbo.cit_sh_contacts') oq 
       INNER JOIN LogicAppAudit..cit_sh_contacts p 
         ON p.ContactId = oq.ContactId 