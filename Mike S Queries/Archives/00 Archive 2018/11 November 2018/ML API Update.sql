SELECT
l.Id AS Id
,sv.id SVID
,sv.[ML_URN] AS [Market_Location_URN__c]
,CASE WHEN sv.[ML_BUSINESS NAME] IS NULL THEN l.[Company] ELSE sv.[ML_BUSINESS NAME] END AS [Company]
,CASE WHEN ISNULL(sv.[ML_ADDRESS LINE 1],'') + ISNULL(sv.[ML_ADDRESS LINE 2],'') + ISNULL(sv.[ML_LOCALITY],'') = '' 
THEN 
l.[Street] 
ELSE 
ISNULL(sv.[ML_ADDRESS LINE 1],'') + ISNULL(sv.[ML_ADDRESS LINE 2],'') + ISNULL(sv.[ML_LOCALITY],'') 
END AS [Street]
,CASE WHEN sv.[ML_TOWN]						IS NULL OR sv.[ML_TOWN] = '' THEN l.[City] ELSE sv.[ML_TOWN] END AS [City]
,CASE WHEN sv.[ML_COUNTY]					IS NULL OR sv.[ML_COUNTY] = '' THEN l.[State] ELSE sv.[ML_COUNTY] END AS [State]
,CASE WHEN sv.[ML_POSTCODE]					IS NULL OR sv.[ML_POSTCODE] = '' THEN l.[PostalCode] ELSE sv.[ML_POSTCODE] END AS [PostalCode]
,CASE WHEN sv.[ML_TELEPHONE NUMBER]			IS NULL OR sv.[ML_TELEPHONE NUMBER] = '' OR l.Id collate latin1_general_CI_AS in 
(
	SELECT ID FROM SalesforceReporting..Fallow_TPS
) 
OR l.Id collate latin1_general_CI_AS in 
(
	SELECT ID FROM SalesforceReporting..Fallow_Disconnect
)
THEN
REPLACE(CASE WHEN l.[Phone] like '0%' THEN l.[Phone] ELSE '0'+l.[Phone] END,' ','') 
ELSE 
REPLACE(CASE WHEN sv.[ML_TELEPHONE NUMBER] like '0%' THEN sv.[ML_TELEPHONE NUMBER] ELSE '0'+sv.[ML_TELEPHONE NUMBER] END,' ','') 
END AS [Phone]
,CASE WHEN sv.[ML_CTPS]						IS NULL OR sv.[ML_CTPS] = '' THEN l.[IsTPS__c] ELSE sv.[ML_CTPS] END AS [IsTPS__c]
,CASE WHEN sv.[ML_CONTACT TITLE]			IS NULL OR sv.[ML_CONTACT TITLE] = '' THEN l.[Salutation] ELSE sv.[ML_CONTACT TITLE] END AS [Salutation]
,CASE WHEN sv.[ML_CONTACT FORENAME]			IS NULL OR sv.[ML_CONTACT FORENAME] = '' THEN l.[FirstName] ELSE sv.[ML_CONTACT FORENAME] END AS [FirstName]
,CASE WHEN sv.[ML_CONTACT SURNAME]			IS NULL OR sv.[ML_CONTACT SURNAME] = ''  THEN 
CASE WHEN l.[LastName] IS NULL THEN '_BLANK' ELSE l.[LastName] END  
ELSE 
sv.[ML_CONTACT SURNAME] 
END AS [LastName]
,CASE WHEN sv.[ML_CONTACT POSITION]			IS NULL OR sv.[ML_CONTACT POSITION] = '' THEN l.[Position__c] ELSE sv.[ML_CONTACT POSITION] END AS [Position__c]
,CASE WHEN sv.[ML_WEB ADDRESS]				IS NULL OR sv.[ML_WEB ADDRESS] = '' THEN l.[Website] ELSE sv.[ML_WEB ADDRESS] END AS [Website]
,CASE WHEN sv.[ML_NAT EMPLOYEES]			IS NULL OR sv.[ML_NAT EMPLOYEES] = '' THEN l.[FT_Employees__c] ELSE sv.[ML_NAT EMPLOYEES] END AS [FT_Employees__c]
,CASE WHEN ISNULL(CONVERT(VarChar, ras.SIC2007_Code3__c), sv.[ML_UK 07 SIC CODE]) IS NULL OR ISNULL(CONVERT(VarChar, ras.SIC2007_Code3__c), sv.[ML_UK 07 SIC CODE]) = '' 
THEN 
l.[SIC2007_Code3__c] 
ELSE 
ISNULL(CONVERT(VarChar, ras.SIC2007_Code3__c), sv.[ML_UK 07 SIC CODE]) 
END AS [SIC2007_Code3__c]
,CONVERT(NVarChar, ISNULL(ras.SIC2007_Description3__c, sv.[ML_UK 07 SIC DESC])) SIC2007_Description3__c 
,CASE WHEN (sv.[ML_CONTACT EMAIL ADDRESS]	IS NULL OR sv.[ML_CONTACT EMAIL ADDRESS] = '') AND (sv.[ML_COMPANY EMAIL ADDRESS] IS NULL OR sv.[ML_COMPANY EMAIL ADDRESS] = '') 
THEN 
l.[Email]
WHEN (sv.[ML_CONTACT EMAIL ADDRESS]	IS NULL OR sv.[ML_CONTACT EMAIL ADDRESS] = '' ) AND (sv.[ML_COMPANY EMAIL ADDRESS] IS NOT NULL AND sv.[ML_COMPANY EMAIL ADDRESS] <> '' ) 
THEN 
sv.[ML_COMPANY EMAIL ADDRESS] 
ELSE 
sv.[ML_CONTACT EMAIL ADDRESS] 
END AS [Email]
,CASE WHEN sv.[ML_CRO_NUMBER] IS NULL OR sv.[ML_CRO_NUMBER] = '' THEN l.[Co_Reg__c] ELSE sv.[ML_CRO_NUMBER] END AS [Co_Reg__c]
,CONVERT(NVARCHAR(50),'ML_Updates_'+UPPER(CONVERT(CHAR(3),DATENAME(mm,GETDATE())))+ CONVERT(CHAR(2),RIGHT(YEAR(GETDATE()),2))) AS [Source__c]
,CASE WHEN sv.[ML_ACTUAL_TURNOVER_BAND] IS NULL OR sv.[ML_ACTUAL_TURNOVER_BAND] = '' THEN l.[Actual_turnover_band__c] ELSE sv.[ML_ACTUAL_TURNOVER_BAND] END AS [Actual_turnover_band__c]
,CASE WHEN sv.[ML_EASY_SECTOR_CODE] IS NULL OR sv.[ML_EASY_SECTOR_CODE] = '' THEN l.[Easy_sector_code__c] ELSE sv.[ML_EASY_SECTOR_CODE] END AS [Easy_sector_code__c]
,CASE WHEN sv.[ML_EASY SECTOR DESC] IS NULL OR sv.[ML_EASY SECTOR DESC] = '' THEN l.ML_Business_Type__c ELSE sv.[ML_EASY SECTOR DESC] END AS ML_Business_Type__c
,CASE WHEN sv.[ML_IMMEDIATE_PARENT_CRO] IS NULL OR sv.[ML_IMMEDIATE_PARENT_CRO] = '' THEN l.[immediate_parent_cro__c] ELSE sv.[ML_IMMEDIATE_PARENT_CRO] END AS [immediate_parent_cro__c]
,CASE WHEN sv.[ML_IMMEDIATE_PARENT_NAME] IS NULL OR sv.[ML_IMMEDIATE_PARENT_NAME] = '' THEN l.[immediate_parent_name__c] ELSE sv.[ML_IMMEDIATE_PARENT_NAME] END AS [immediate_parent_name__c]
,CASE WHEN sv.[ML_MAJOR_SECTOR_CODE] IS NULL OR sv.[ML_MAJOR_SECTOR_CODE] = '' THEN l.[Major_sector_code__c] ELSE sv.[ML_MAJOR_SECTOR_CODE] END AS [Major_sector_code__c]
,CASE WHEN sv.[ML_MAJOR_SECTOR_DESCRIPTION] IS NULL OR sv.[ML_MAJOR_SECTOR_DESCRIPTION] = '' THEN l.[Major_sector_description__c] ELSE sv.[ML_MAJOR_SECTOR_DESCRIPTION] END AS [Major_sector_description__c]
,CASE WHEN sv.[ML_MODELLED_TURNOVER_BAND] IS NULL OR sv.[ML_MODELLED_TURNOVER_BAND] = '' THEN l.[Modelled_turnover_band__c] ELSE sv.[ML_MODELLED_TURNOVER_BAND] END AS [Modelled_turnover_band__c]
,CASE WHEN sv.[ML_SUB_SECTOR_CODE] IS NULL OR sv.[ML_SUB_SECTOR_CODE] = '' THEN l.[Sub_sector_code__c] ELSE sv.[ML_SUB_SECTOR_CODE] END AS [Sub_sector_code__c]
,CASE WHEN sv.[ML_SUB_SECTOR_DESCRIPTION] IS NULL OR sv.[ML_SUB_SECTOR_DESCRIPTION] = '' THEN l.[Sub_sector_description__c] ELSE sv.[ML_SUB_SECTOR_DESCRIPTION] END AS [Sub_sector_description__c]
,CASE WHEN sv.[ML_ULTIMATE_PARENT_CRO] IS NULL OR sv.[ML_ULTIMATE_PARENT_CRO] = '' THEN l.[Ultimate_parent_cro__c] ELSE sv.[ML_ULTIMATE_PARENT_CRO] END AS [Ultimate_parent_cro__c]
,CASE WHEN sv.[ML_ULTIMATE_PARENT_NAME] IS NULL OR sv.[ML_ULTIMATE_PARENT_NAME] = '' THEN l.[Ultimate_parent_name__c] ELSE sv.[ML_ULTIMATE_PARENT_NAME] END AS [Ultimate_parent_name__c]
,CASE WHEN sv.[ML_YEAR_ESTABLISHED] IS NULL OR sv.[ML_YEAR_ESTABLISHED] = '' THEN l.[Year_established__c] ELSE sv.[ML_YEAR_ESTABLISHED] END AS [Year_established__c]
,CASE WHEN sv.[Recency_date] IS NULL OR sv.[Recency_date] = '' THEN l.ML_Last_Update_Date__c ELSE sv.[Recency_date] END AS ML_Last_Update_Date__c
,'Update' Record_Insert_Type
,GETDATE() Record_Insert_Timestamp
,'ML-API' AS Source

FROM 
[dbo].[Temp_LeadsSingleViewAuto] temp  WITH (NOLOCK)
INNER JOIN [dbo].[LeadsSingleViewAuto] sv  WITH (NOLOCK) ON sv.ML_URN = temp.ML_URN
LEFT JOIN SalesforceReporting..ReAssignedSectors ras ON temp.ML_URN = ras.Market_Location_URN__c
LEFT JOIN	( 
				SELECT * 
				FROM 
				(
					SELECT ROW_NUMBER() OVER(PARTITION BY Market_Location_URN__c ORDER BY [Company] DESC,[Street] DESC,[City] DESC,[State] DESC,
					[PostalCode] DESC,[Phone] DESC,[IsTPS__c] DESC,[Salutation] DESC,[FirstName] DESC,[LastName] DESC,[Position__c] DESC,
					[Website] DESC,[FT_Employees__c] DESC,[SIC2007_Code3__c] DESC) rn,*
					FROM [dbo].[SFDC_Lead_Dump]  WITH (NOLOCK) 
					WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) 
					AND (LeadSource not like '%cross%sell%' or LeadSource is null)
					AND Company <> '' and PostalCode <> ''
					AND [Status] not in ('Approved','Data Quality','Pended','Callback Requested')  
                    AND (Source__c not like '%Closed%Lost%' or Source__c is null) and (Data_Supplier__c not like '%Closed%Lost%' or Data_Supplier__c is null)
					AND (Data_Supplier__c not in ('MS_API','MS_All','MS_Phone','CO_API','CO_All','CO_Phone','DB_API','DB_All','DB_Phone') or Data_Supplier__c is null)						
				) a 
				WHERE rn=1
			)l ON sv.ML_URN = l.Market_Location_URN__c
			
WHERE 
sv.Manual_Exclusion = 0 
AND 
CONVERT(INT, ISNULL(sv.Exc_ContactCentre,0)) + CONVERT(INT, ISNULL(sv.Exc_Events,0))<2
AND  
l.Market_Location_URN__c IS NOT NULL
AND 
ISNULL(sv.OnHold,0) = 0
AND 
l.Company <> '' and ISNULL(l.PostalCode,'') <> '' and ISNULL(l.Phone,'') <> '' and l.Phone <> '0'
AND 
[Status] not in ('Approved','Data Quality','Pended','Callback Requested')  
AND 
(
	RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null
) 
AND 
(
	LeadSource not like '%cross%sell%' or LeadSource is null
)