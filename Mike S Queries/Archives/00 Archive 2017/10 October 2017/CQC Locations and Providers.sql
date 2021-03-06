/*
INSERT INTO CQC.cqc.NEW_Locations
(
[LocationId]
,[CareHome]
,[Name]
,[AddressLine1]
,[AddressLine2]
,[City]
,[PostCode]
,[Region]
,[CareHomesBeds]
,[LocationType]
,[PrimaryInspectionCategory]
,[ProviderId]
--,[ServiceType]
,[RegisteredManager]
,[Telephone]
,[OverallRating]
,[LastReviewDate]
,[Location Start Date]
,[Record_Insert_Timestamp]
--,[Record_Update_Timestamp]
)
*/
      
SELECT 
[LocationId]
,[CareHome]
,[LocationName]
,[AddressLine1]
,[AddressLine2]
,[City]
,[PostCode]
,[Region]
,[CareHomeBeds]
,[LocationType]
,[PrimaryInspectionCategory]
,[ProviderId]
,[RegisteredManager]
,[Telephone]
,[Overall]
,[LastReviewData]
,[LocationStartDate]
,GETDATE()
FROM [CQC].[dbo].[CQC_October2017]

-----------------------------------------------------------------------------------------------------------------------------------------------

/*
INSERT INTO CQC.cqc.NEW_Providers
(
[ProviderID]
,[Name]
,[PrimaryInspectionCategory]
,[Telephone]
,[WebAddress]
,[StreetAddress]
,[AddressLine2]
,[City]
,[County]
,[PostCode]
,[IndividualName]
,[CRO]
,[CharityNumber]
,[Provider Start Date]
,[Record_Insert_Timestamp]
--,[Record_Update_Timestamp]
)
*/

SELECT
[ProviderId]
,[ProviderName]
,[ProviderPrimaryInspectionCategory]
,[ProviderTelephone]
,[ProviderWebAddress]
,[ProviderAddressLine1]
,[ProviderAddressLine2]
,[ProviderCity]
,[ProviderCounty]
,[ProviderPostCode]
,[ProviderIndividualName]
,[ProviderCRO]
,[ProviderCharityNo]
,[ProviderStartDate]
,GETDATE()
  FROM [CQC].[dbo].[CQC_October2017]