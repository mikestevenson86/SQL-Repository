SELECT temp.*, 
case when sv.Manual_Exclusion=0 then 1 else 0 end ManualExclusion,
case when (CONVERT(INT, ISNULL(sv.Exc_ContactCentre,0))+CONVERT(INT, ISNULL(sv.Exc_Events,0)))<2 then 1 else 0 end Exclusions,
case when Market_Location_URN__c IS NOT NULL then 1 else 0 end URN_Not_Null,
case when (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG', '012D0000000KKTvIAO') or RecordTypeId is null) then 1 else 0 end RecordType,
case when (LeadSource not like '%cross%sell%' or LeadSource is null) then 1 else 0 end LeadSource_CrossSell,
case when l.Company <> '' and l.PostalCode <> '' then 1 else 0 end CompanyAndPostCode_NotBlank,
case when [Status] not in ('Approved','Data Quality','Pended','Callback Requested') then 1 else 0 end OpenStatus,
case when (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null) then 1 else 0 end GrowthIntel,
case when (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null) then 1 else 0 end LB,
case when (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null) then 1 else 0 end New_MktWelcome,
case when (Source__c not like '%Closed%Lost%' or Source__c is null) and (Data_Supplier__c not like '%Closed%Lost%' or Data_Supplier__c is null) then 1 else 0 end ClosedLostCampaign,
case when (Data_Supplier__c not in ('MS_API','MS_All','MS_Phone','CO_API','CO_All','CO_Phone','DB_API','DB_All','DB_Phone') or Data_Supplier__c is null) then 1 else 0 end AllowedDataSuppliers,
case when ISNULL(sv.OnHold,0)=0 then 1 else 0 end OnHold
FROM [dbo].New57 temp  WITH (NOLOCK)
INNER JOIN [dbo].[LeadsSingleViewAuto] sv  WITH (NOLOCK) ON sv.ML_URN = temp.URN
LEFT JOIN ( SELECT * FROM (SELECT ROW_NUMBER() OVER(PARTITION BY Market_Location_URN__c ORDER BY [Company] DESC ,[Street] DESC ,[City] DESC ,[State] DESC ,[PostalCode] DESC ,[Phone] DESC 
																								,[IsTPS__c] DESC ,[Salutation] DESC ,[FirstName] DESC ,[LastName] DESC ,[Position__c] DESC 
																								,[Website] DESC ,[FT_Employees__c] DESC ,[SIC2007_Code3__c] DESC  ) rn,*
								FROM [dbo].[SFDC_Lead_Dump]  WITH (NOLOCK) 
							) a 
			WHERE rn=1
		)l ON sv.ML_URN = l.Market_Location_URN__c