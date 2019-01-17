SELECT l.Id, l.[Prospect_External_Id__c]
      ,l.[Company]
      ,l.[Street]
      ,l.[City]
      ,l.[State]
      ,l.[PostalCode]
      ,l.[Phone]
      ,l.[IsTPS__c]
      ,l.[Title]
      ,l.[FirstName]
      ,l.[LastName]
      ,l.[Position__c]
      ,l.[Website]
      ,l.[FT_Employees__c]
      ,l.[SIC2007_Code2__c]
      ,l.[SIC2007_Description2__c]
      ,l.[SIC2007_Code3__c]
      ,l.[SIC2007_Description3__c]
      ,l.[Email]
      ,l.[SIC2007_Code__c]
      ,l.[SIC2007_Description__c]
      ,l.[CitationSector__c]
      ,l.[Affinity_Cold__c]
      ,l.[Sector__c]
--INTO MarketLocation..CompanyPostCode_BackUp
FROM MarketLocation..MLAffinity_May2016 ml
inner join Salesforce..Lead l ON LTRIM(RTRIM(REPLACE(REPLACE(l.Company,'Ltd',''),'Limited',''))) = LTRIM(RTRIM(REPLACE(REPLACE(ml.Company,'Ltd',''),'Limited','')))
							and		REPLACE(l.PostalCode,' ','') = REPLACE(ml.PostalCode,' ','')
WHERE ml.Company <> '' and ml.PostalCode <> '' and l.Status not in ('Approved','Callback Requested') and
(
	  --ml.[Prospect_External_Id__c] <> l.Prospect_External_Id__c or
      --ml.[Company] <> l.Company or
      ml.[Street] <> l.Street or
      ml.[City] <> l.City or
      ml.[State] <> l.[State] or
      --ml.[PostalCode] <> l.PostalCode or
      ml.[Phone] <> l.Phone and
      --ml.[IsTPS__c] <> l.IsTPS__c or
      ml.[Title] <> l.Title or
      ml.[FirstName] <> l.FirstName or
      ml.[LastName] <> l.LastName or
      ml.[Position__c] <> l.Position__c or
      ml.[Website] <> l.Website or
      CONVERT(varchar, ml.[FT_Employees__c]) <> CONVERT(varchar, l.FT_Employees__c) or
      CONVERT(varchar, ml.[SIC2007_Code2__c]) <> CONVERT(varchar, l.SIC2007_Code2__c) or
      CONVERT(varchar, ml.[SIC2007_Description2__c]) <> CONVERT(varchar, l.SIC2007_Description2__c) or
      CONVERT(varchar, ml.[SIC2007_Code3__c]) <> CONVERT(varchar, l.SIC2007_Code3__c) or
      CONVERT(varchar, ml.[SIC2007_Description3__c]) <> CONVERT(varchar, l.SIC2007_Description3__c) or
      ml.[Email] <> l.Email or
      ml.[SIC2007_Code__c] <> l.SIC2007_Code__c or
      CONVERT(varchar, ml.[SIC2007_Description__c]) <> CONVERT(varchar, l.SIC2007_Description__c) or
      ml.[CitationSector__c] <> l.CitationSector__c or
      ml.[Affinity_Cold__c] <> l.Affinity_Cold__c or
      ml.[Sector__c] <> l.Sector__c
)