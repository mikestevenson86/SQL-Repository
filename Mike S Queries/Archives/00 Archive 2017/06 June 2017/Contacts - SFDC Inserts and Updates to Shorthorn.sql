USE [LogicAppAudit]
GO
/****** Object:  StoredProcedure [dbo].[SynchContactChanges]    Script Date: 06/28/2017 21:33:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[SynchContactChanges]

	@SynchContactId int

AS
BEGIN

--Start Update Process

IF EXISTS(SELECT 1 FROM UnProcessedContactChanges where Processed = 0 and Id = @SynchContactId)
BEGIN

-- Populate temporary record with Contact details

DECLARE	@SH_Id as int,
		@SH_ClientId as int,
		@FirstName as NVarChar(100),
		@LastName as NVarChar(100),
		@Email as NVarChar(255),
		@Phone as NVarChar(20),
		@Street as NVarChar(200),
		@City as NVarChar(100),
		@PostCode as NVarChar(20),
		@Position as NVarChar(100),
		@HelplineHS as bit,
		@HelplinePEL as bit,
		@SuperUser as bit,
		@MainUser as bit,
		@SFDCId as NCHAR(18)
		
SELECT TOP 1	 @SH_Id = ShorthornId
				,@SH_ClientId = clientid
				,@FirstName = FirstName
				,@LastName = LastName
				,@Email = Email
				,@Phone = Phone
				,@Street = street
				,@City = city
				,@PostCode = postcode
				,@HelplineHS = case when ISNULL(helplinehs,'') = 'Yes' then 1 else 0 end
				,@HelplinePEL = case when ISNULL(helplinepel,'') = 'Yes' then 1 else 0 end
				,@SuperUser = case when ISNULL(onlinesuperuser,'') = 'Yes' then 1 else 0 end
				,@MainUser = case when ISNULL(mainuser,'') = 'Yes' then 1 else 0 end
				,@Position = Position
				,@SFDCId = SFId
FROM
	UnProcessedContactChanges
WHERE
	Id = @SynchContactId and Processed = 0

-- Populate ShorthornId if missing: Problematic as any of these variations can be associated to more than one contact

-- Check if there is ShorthornId
IF LEN(ISNULL(@SH_Id,'')) = 0
	BEGIN
		-- Check if there is SFDCId
		IF LEN(ISNULL(@SFDCId,'')) > 0
			BEGIN
				SELECT @SH_Id = c.contactID
				FROM LogicAppAudit..UnProcessedContactChanges cs
				inner join Shorthorn..cit_sh_contacts c ON cs.SFId = c.SFDC_ContactId
				WHERE cs.Id = @SynchContactId
			END
				
		-- Check if there is Email
		ELSE IF LEN(ISNULL(@Email,'')) > 0
			BEGIN
				SELECT @SH_Id = c.contactID
				FROM LogicAppAudit..UnProcessedContactChanges cs
				inner join Shorthorn..cit_sh_contacts c ON cs.firstname = c.fName and cs.lastname = c.sName and cs.Email = c.email
				WHERE cs.Id = @SynchContactId
			END
		
		-- Check if there is Phone
		ELSE IF LEN(ISNULL(@Phone,'')) > 0
			BEGIN
				SELECT @SH_Id = c.contactID
				FROM LogicAppAudit..UnProcessedContactChanges cs
				inner join Shorthorn..cit_sh_contacts c ON cs.firstname = c.fName and cs.lastname = c.sName and 
													REPLACE(case when cs.Phone like '0%' then cs.Phone else '0'+cs.Phone end,' ','')
													= REPLACE(case when c.tel like '0%' then c.tel else '0'+c.tel end,' ','')
				WHERE cs.Id = @SynchContactId
			END
			
		IF LEN(ISNULL(@SH_Id,'')) > 0 UPDATE LogicAppAudit..UnProcessedContactChanges SET shorthornid = @SH_Id WHERE Id = @SynchContactId
		
	END

-- Begin update and Populate siteId based on address information

IF OBJECT_ID('tempdb..#TempUp') IS NOT NULL
	BEGIN
		DROP TABLE #TempUp
	END

CREATE TABLE #TempUp
(
ContactId int
)

IF (SELECT COUNT(siteId) FROM Shorthorn..cit_sh_sites WHERE clientID = @SH_ClientId and postcode = @PostCode and @Street like address1+'%') > 0
	BEGIN
		UPDATE 
			sc
		SET 
			fName = @FirstName
			,sName = @LastName
			,email = @Email
			,tel = @Phone
			,position = @Position
			,SFDC_ContactId = @SFDCId
			,siteID = (SELECT top 1 SiteId from Shorthorn..cit_sh_sites where clientID = @SH_ClientId and postcode = @PostCode and @Street like address1+'%')
		OUTPUT
			inserted.contactID INTO #TempUp
		FROM 
			Shorthorn..cit_sh_contacts sc
		WHERE
			sc.contactID = @SH_Id

		UPDATE cc SET Processed = 1	FROM UnProcessedContactChanges cc WHERE	Processed = 0 and Id = @SynchContactId and shorthornid in (SELECT contactID FROM #TempUp)
	
	END
	
ELSE

	BEGIN
		UPDATE 
			sc
		SET 
			fName = @FirstName
			,sName = @LastName
			,email = @Email
			,tel = @Phone
			,position = @Position
			,SFDC_ContactId = @SFDCId
			,siteID = (SELECT top 1 SiteId from Shorthorn..cit_sh_sites where clientID = @SH_ClientId and HeadOffice = 1)
		OUTPUT
			inserted.contactID INTO #TempUp
		FROM 
			Shorthorn..cit_sh_contacts sc
		WHERE
			sc.contactID = @SH_Id

		UPDATE cc SET Processed = 1	FROM UnProcessedContactChanges cc WHERE	Processed = 0 and Id = @SynchContactId and shorthornid in (SELECT contactID FROM #TempUp)
	
	END
END

-- Start Insert Process

IF EXISTS(SELECT 1 FROM UnProcessedContactChanges where Processed = 0 and LEN(ISNULL(ClientId, '')) > 0)
BEGIN

IF OBJECT_ID ('tempdb..#TempIn') IS NOT NULL
	BEGIN
		DROP TABLE #TempIn
	END

CREATE TABLE #TempIn
(
ContactID int,
SiteID int
)

	IF (SELECT COUNT(siteId) FROM Shorthorn..cit_sh_sites WHERE clientID = @SH_ClientId and postcode = @PostCode and @Street like address1+'%') > 0
		BEGIN
			INSERT INTO Shorthorn..cit_sh_contacts (siteID, SFDC_ContactId, fName, sName, email, tel, position)
			OUTPUT INSERTED.contactID, inserted.siteID INTO #TempIn
			SELECT
				(SELECT top 1 SiteId from Shorthorn..cit_sh_sites where clientID = @SH_ClientId and postcode = @PostCode and @Street like address1+'%') siteId,
				@SFDCId SFDC_ContactId,
				@FirstName fName,
				@LastName sName,
				@Email email,
				@Phone tel,
				@Position position	
			FROM 
				UnProcessedContactChanges cc
			WHERE 
				Id = @SynchContactId and Processed = 0
					
			--Update UnProcessedContactChanges set shorthornid = (SELECT TOP 1 ContactId FROM #TempIn) where Id = @SynchContactId and Processed = 0
			Update UnProcessedContactChanges set Processed = 1 where Id = @SynchContactId and Processed = 0
		END
	ELSE
		BEGIN
			INSERT INTO Shorthorn..cit_sh_contacts (siteID, SFDC_ContactId, fName, sName, email, tel, position)
			OUTPUT INSERTED.contactID, inserted.siteID INTO #TempIn
			SELECT
				(SELECT top 1 SiteId from Shorthorn..cit_sh_sites where clientID = @SH_ClientId and HeadOffice = 1) siteId,
				@SFDCId SFDC_ContactId,
				@FirstName fName,
				@LastName sName,
				@Email email,
				@Phone tel,
				@Position position	
			FROM 
				UnProcessedContactChanges cc
			WHERE 
				Id = @SynchContactId and Processed = 0
					
			--Update UnProcessedContactChanges set shorthornid = (SELECT TOP 1 ContactId FROM #TempIn) where Id = @SynchContactId and Processed = 0
			Update UnProcessedContactChanges set Processed = 1 where Id = @SynchContactId and Processed = 0
		END		
			-- Site Changes - Inserts
				
			UPDATE Shorthorn..cit_sh_sites
			SET mainContactHS = @SH_Id
			WHERE siteID = (SELECT TOP 1 siteID FROM #TempIn) and @HelplineHS = 1
				
			UPDATE Shorthorn..cit_sh_sites
			SET mainContactPEL = @SH_Id
			WHERE siteID = (SELECT TOP 1 siteID FROM #TempIn) and @HelplinePEL = 1
				
			UPDATE Shorthorn..cit_sh_sites
			SET citManSuper = @SH_Id
			WHERE siteID = (SELECT TOP 1 siteID FROM #TempIn) and @SuperUser = 1
				
			UPDATE Shorthorn..cit_sh_sites
			SET genContact = @SH_Id
			WHERE siteID = (SELECT TOP 1 siteID FROM #TempIn) and @MainUser = 1
				
END

END