IF OBJECT_ID('SalesforceReporting..ML_Daily') IS NOT NULL 
	BEGIN
		DROP TABLE SalesforceReporting..ML_Daily
	END

SELECT [URN] as Market_Location_URN__c
      ,[Business Name] as Company
      ,[Address Line 1] + ' ' + [Address Line 2] + ' ' + [Locality] Street
      ,[Town] as City
      ,[County] as [State]
      ,[Postcode] as Postalcode
      ,REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') as Phone
      ,case when REPLACE([ctps],'Y','Yes') <> 'Yes' then 'No' else 'Yes' end as IsTPS__c
      ,[Contact title] as Salutation
      ,[Contact forename] as FirstName
      ,[Contact surname] as LastName
      ,[Contact position] as Position__c
      ,[web address] as Website
      ,[Easy Sector Desc] as Sector
      ,[Nat Employees] as FT_Employees__c
      ,[UK 07 Sic Code] as SIC2007_Code3__c
      ,[UK 07 Sic Desc] as SIC2007_Description3__c
      ,case when [Contact email address] = '' then [company email address] else [company email address] end Email
      ,[cro_number] as Co_Reg__c
      ,CAST(NULL as bit) as Dupe_Lead
      ,CAST(NULL as bit) as Dupe_Toxic
      ,CAST(NULL as bit) as Dupe_Account
      ,CAST(NULL as bit) as Dupe_Site
      ,CAST(NULL as bit) as ToxicSIC
      ,CAST(NULL as bit) as ToxicSIC_Events
      ,CAST(NULL as bit) as BadCompany_Exact
      ,CAST(NULL as bit) as BadCompany_Near
      ,CAST(NULL as bit) as BadCompany_Events
      ,CAST(NULL as bit) as BadDomain
      ,CAST(NULL as bit) as BadDomain_NHS
      ,CAST(NULL as bit) as BadPosition_Events
      ,CAST(NULL as bit) as BadSector_Events
      
INTO SalesforceReporting..ML_Daily
FROM [MarketLocation].[dbo].[Citation_MLDB_Extract]
WHERE location_type <> 'B'