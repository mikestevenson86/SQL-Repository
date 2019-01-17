SELECT 
case when idg.[IDG_FK__c] <> 0 then idg.[IDG_FK__c] else old.[IDG_FK__c] end [IDG_FK__c]
,case when idg.[Id] <> '' then idg.[Id] else old.[Id] end [Id]
,case when idg.[MobilePhone] <> '' then idg.[MobilePhone] else old.[MobilePhone] end [MobilePhone]
,case when idg.[Other_Phone__c] <> '' then idg.[Other_Phone__c] else old.[Other_Phone__c] end [Other_Phone__c]
,case when idg.[Email] <> '' then idg.[Email] else old.[Email] end [Email]
,case when idg.[Website] <> '' then idg.[Website] else old.[Website] end [Website]
,case when idg.[FT_Employees__c] <> 0 then idg.[FT_Employees__c] else old.[FT_Employees__c] end [FT_Employees__c]
,case when idg.[PT_Employees__c] <> 0 then idg.[PT_Employees__c] else old.[PT_Employees__c] end [PT_Employees__c]
,case when idg.[Prospect_External_Id__c] <> '' then idg.[Prospect_External_Id__c] else old.[Prospect_External_Id__c] end [Prospect_External_Id__c]
,case when idg.[Company] <> '' then idg.[Company] else old.[Company] end [Company]
,case when idg.[Street] <> '' then idg.[Street] else old.[Street] end [Street]
,case when idg.[City] <> '' then idg.[City] else old.[City] end [City]
,case when idg.[PostalCode] <> '' then idg.[PostalCode] else old.[PostalCode] end [PostalCode]
,case when idg.[Phone] <> '' then idg.[Phone] else old.[Phone] end [Phone]
,case when idg.[IsTPS__c] <> '' then idg.[IsTPS__c] else old.[IsTPS__c] end [IsTPS__c]
,case when idg.[Total_Employees__c] <> 0 then idg.[Total_Employees__c] else old.[Total_Employees__c] end [Total_Employees__c]
,case when idg.[Title] <> '' then idg.[Title] else old.[Title] end [Title]
,case when idg.[FirstName] <> '' then idg.[FirstName] else old.[FirstName] end [FirstName]
,case when idg.[LastName] <> '' then idg.[LastName] else old.[LastName] end [LastName]
,case when idg.[Position__c] <> '' then idg.[Position__c] else old.[Position__c] end [Position__c]
,case when idg.[SIC2007_Code__c] <> '' then idg.[SIC2007_Code__c] else old.[SIC2007_Code__c] end [SIC2007_Code__c]
,case when idg.[SIC2007_Description__c] <> '' then idg.[SIC2007_Description__c] else old.[SIC2007_Description__c] end [SIC2007_Description__c]
,case when idg.[SIC2007_Code2__c] <> 0 then idg.[SIC2007_Code2__c] else old.[SIC2007_Code2__c] end [SIC2007_Code2__c]
,case when idg.[SIC2007_Description2__c] <> '' then idg.[SIC2007_Description2__c] else old.[SIC2007_Description2__c] end [SIC2007_Description2__c]
,case when idg.[SIC2007_Code3__c] <> 0 then idg.[SIC2007_Code3__c] else old.[SIC2007_Code3__c] end [SIC2007_Code3__c]
,case when idg.[SIC2007_Description3__c] <> '' then idg.[SIC2007_Description3__c] else old.[SIC2007_Description3__c] end [SIC2007_Description3__c]

FROM
SalesforceReporting..[IDG - Update - 26-08-2014] idg
inner join SalesforceReporting..LeadIDGUpdateTest old ON idg.Id collate latin1_general_CS_AS = old.Id collate latin1_general_CS_AS
inner join Salesforce..Lead l ON idg.Id collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS

WHERE
l.[Status] <> 'Callback Requested'