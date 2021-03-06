/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Prospect_External_Id__c]
      ,[Company]
      ,[Street]
      ,[City]
      ,[State]
      ,[PostalCode]
      ,[Phone]
      ,[IsTPS__c]
      ,[Salutation]
      ,case when [FirstName] is null or [FirstName] = '' then 'BLANK' else [FirstName] end FirstName
      ,case when [LastName] is null or [LastName] = '' then 'BLANK' else [LastName] end LastName
      ,[Position__c]
      ,[Website]
      ,[FT_Employees__c]
      ,[Sector__c]
      ,[SIC Code 1] SIC2007_Code__c
      ,[Description] SIC2007_Description__c
      ,[SIC2007_Code2__c]
      ,[SIC2007_Description2__c]
      ,[SIC2007_Code3__c]
      ,[SIC2007_Description3__c]
      ,[Email]
      ,'Affinity - Key' Affinity_Cold__c
      ,'Care' Affinity_Industry_type__c
      ,'ML August 2015' Source__c
      ,'2015-08-12' Completed_Date__c
  FROM [SalesforceReporting].[dbo].[Citation Care 310715] p
  left outer join SalesforceReporting..SICCodes2007 sc ON p.SIC2007_Code3__c = sc.[SIC Code 3]
  WHERE PExists is null