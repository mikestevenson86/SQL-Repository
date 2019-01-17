/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [URN] Prospect_External_Id__c
      ,[Business Name] Company
      ,[Address Line 1] + ' ' + [Address Line 2] + ' ' + [Locality] Street
      ,[Town] City
      ,[County] State
      ,[Postcode] PostalCode
      ,[Telephone Number] Phone
      ,case when [tps] = 'Y' then 'Yes' when [ctps] = 'Y' then 'Yes' else 'No' end IsTPS__c
      ,[Contact title] Title
      ,[Contact forename] FirstName
      ,[Contact surname] LastName
      ,[Contact position] Position__c
      ,[web address] Website
      --,[location_type]
      --,[employees]
      --,[employees_band_desc]
      ,[Nat Employees] FT_Employees__c
      --,[Nat Emp Band Desc]
      --,[Nat No Of Sites]
      --,[Nat Site Band Desc]
      --,[Easy Sector Desc]
      --,[UK 03 SIC Code 2 digit]
      --,[UK 03 SIC Code 2 digit desc]
      --,[UK 03 Sic Code]
      --,[UK 03 Sic Desc]
      ,[UK 07 SIC Code 2 digit] SIC2007_Code2__c
      ,[UK 07 SIC Code 2 digit desc] SIC2007_Description2__c
      ,[UK 07 Sic Code] SIC2007_Code3__c
      ,[UK 07 Sic Desc] SIC2007_Description3__c
      --,[T O (COHO Recorded)]
      --,[T O (Modelled)]
      , case when [Contact email address] <> '' then [Contact email address] else [company email address] end Email
      --,[update_band]
      --,[record_type]
      ,sc.SIC_Code SIC2007_Code__c
      ,sc.SIC_Description SIC2007_Description__c
      ,sc.CitationSector CitationSector__c
      ,af.AffinitySector Sector__c
      ,case when af.AffinitySector is not null then 'Affinity - Key' else 'Cold' end Affinity_Cold__c
      ,'ML Database' Source__c
      ,CONVERT(date, GETDATE()) Completed_Date__c
  FROM [MarketLocation].[dbo].[citation_full_data_032016] ml
  left outer join SalesforceReporting..AffinitySICCodes af ON ml.[UK 07 Sic Code] = af.SICCode3
  left outer join SalesforceReporting..SIC2007Codes sc ON ml.[UK 07 Sic Code] = sc.SIC3_Code