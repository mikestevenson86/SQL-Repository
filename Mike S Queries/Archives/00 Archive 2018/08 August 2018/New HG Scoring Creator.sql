USE [HGLeadScoring]
GO
/****** Object:  StoredProcedure [dbo].[tsk_CreateHGList]    Script Date: 08/05/2018 14:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[tsk_CreateHGList]
AS
BEGIN

DECLARE @BDMId int = 1
DECLARE @ListId int = 1

IF (SELECT COUNT(1) FROM HGLeadScoring..Scores) > 0
	BEGIN
		IF OBJECT_ID('HGLeadScoring..Scored') IS NOT NULL DROP TABLE HGLeadScoring..Scored
		
		SELECT
		l.Id Lead_Id,
		u.Name,
		sc.ELTV HG_Score__c,
		0 Updated
		
		INTO
		HGLeadScoring..Scored

		FROM
		Salesforce..Lead l
		inner join Salesforce..[User] u ON l.OwnerId = u.Id
		inner join HGLeadScoring..Scores sc ON l.Id = CONVERT(VarChar, sc.Lead_Id)
		inner join HGLeadScoring..BDMGroups bdm ON u.Name = bdm.BDM

		WHERE
		Status = 'Open'
		and
		IsConverted = 'false'
		and
		IsTPS__c <> 'Yes'
		and
		RecordTypeId = '012D0000000NbJsIAK'
		and
		ISNULL(l.Phone,'') <> ''
		and
		Toxic_SIC__c <> 'TRUE'
		and
		BDC__c is null
		and
		(
			--CitationSector__c = 'Care'
			--or
			(
				(
					FT_Employees__c between 6 and 225 
					or 
					(
						FT_Employees__c = 5 and TEXT_BDM__c in ('William McFaulds','Scott Roberts','Dominic Miller','Angela Prior','Cormac McGreevey')
					)
				)
				or
				(
					CitationSector__c = 'CLEANING' and FT_Employees__c between 4 and 225
				)
				or
				(
					CitationSector__c = 'DENTAL PRACTICE' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c = 'HORTICULTURE' and FT_Employees__c between 4 and 225
				)
				or
				(
					CitationSector__c = 'DAY NURSERY' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c like '%FUNERAL%' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c = 'CARE' and FT_Employees__c between 6 and 225
				)
			)
		)
		and 
		CitationSector__c not in ('EDUCATION','Dental practice')
		and
		ISNULL(CitationSector__c, '') <> ''
		and
		ISNULL(Source__c, '') not like '%Closed Lost%'
		and
		ISNULL(Source__c, '') not like '%Marketing Lost%'
		and NOT
		(
			ISNULL(Data_Supplier__c, '') like '%KeySector%' and CitationSector__c = 'DAY NURSERY'
		)
		and
		ISNULL(Data_Supplier__c, '') not like '%Creditsafe_Nursery%'
		 and
		ISNULL(Data_Supplier__c, '') not like '%SMAS%'
		and
		ISNULL(Data_Supplier__c, '') not like '%scotlandhome%'
	END
ELSE
	BEGIN
		IF OBJECT_ID('HGLeadScoring..Scored') IS NOT NULL DROP TABLE HGLeadScoring..Scored
	
		SELECT
		l.Id Lead_Id,
		u.Name,
		sc.ELTV HG_Score__c,
		0 Updated
		
		INTO
		HGLeadScoring..Scored

		FROM
		Salesforce..Lead l
		inner join Salesforce..[User] u ON l.OwnerId = u.Id
		inner join HGLeadScoring..Scores_Backup sc ON l.Id = CONVERT(VarChar, sc.Lead_Id)
		inner join HGLeadScoring..BDMGroups bdm ON u.Name = bdm.BDM

		WHERE
		Status = 'Open'
		and
		IsConverted = 'false'
		and
		IsTPS__c <> 'Yes'
		and
		RecordTypeId = '012D0000000NbJsIAK'
		and
		ISNULL(l.Phone,'') <> ''
		and
		Toxic_SIC__c <> 'TRUE'
		and
		BDC__c is null
		and
		(
			--CitationSector__c = 'Care'
			--or
			(
				(
					FT_Employees__c between 6 and 225 
					or 
					(
						FT_Employees__c = 5 and TEXT_BDM__c in ('William McFaulds','Scott Roberts','Dominic Miller','Angela Prior','Cormac McGreevey')
					)
				)
				or
				(
					CitationSector__c = 'CLEANING' and FT_Employees__c between 4 and 225
				)
				or
				(
					CitationSector__c = 'DENTAL PRACTICE' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c = 'HORTICULTURE' and FT_Employees__c between 4 and 225
				)
				or
				(
					CitationSector__c = 'DAY NURSERY' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c like '%FUNERAL%' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c = 'CARE' and FT_Employees__c between 6 and 225
				)
			)
		)
		and 
		CitationSector__c not in ('EDUCATION','Dental practice')
		and
		ISNULL(CitationSector__c, '') <> ''
		and
		ISNULL(Source__c, '') not like '%Closed Lost%'
		and
		ISNULL(Source__c, '') not like '%Marketing Lost%'
		and NOT
		(
			ISNULL(Data_Supplier__c, '') like '%KeySector%' and CitationSector__c = 'DAY NURSERY'
		)
		and
		ISNULL(Data_Supplier__c, '') not like '%Creditsafe_Nursery%'
		 and
		ISNULL(Data_Supplier__c, '') not like '%SMAS%'
		and
		ISNULL(Data_Supplier__c, '') not like '%scotlandhome%'
	END
	
IF OBJECT_ID('HGLeadScoring..HGList_NEW') IS NOT NULL DROP TABLE HGLeadScoring..HGList_NEW
		
		CREATE TABLE HGLeadScoring..HGList_NEW
		(
		Id NCHAR(18),
		BDM VarChar(255),
		HG_List_Id__c int,
		HG_Score__c float
		)

		WHILE (SELECT COUNT(1) FROM HGLeadScoring..Scored WHERE Updated = 0) > 0
			BEGIN
			
				INSERT INTO HGLeadScoring..HGList_NEW 
				SELECT TOP 1 Lead_Id, Name, @ListId, HG_Score__c 
				FROM HGLeadScoring..Scored 
				WHERE Name = (SELECT BDM FROM HGLeadScoring..BDMGroups WHERE Id = @BDMId) and Updated = 0
				ORDER BY HG_Score__c desc
				
				UPDATE HGLeadScoring..Scored SET Updated = 1 WHERE Lead_Id = (SELECT TOP 1 Lead_Id FROM HGLeadScoring..Scored WHERE Name = (SELECT BDM FROM HGLeadScoring..BDMGroups WHERE Id = @BDMId) and Updated = 0 ORDER BY HG_Score__c desc)
				
				IF @BDMId = 19 SET @BDMId = 1 ELSE SET @BDMId = @BDMId + 1
				SET @ListId = @ListId + 1
			
			END

DROP TABLE Salesforce..Lead_Update
		
END