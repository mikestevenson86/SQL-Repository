SELECT *,
(case when IDG_FK__c is null OR IDG_FK__c = 0 then 0 else 1 end+
case when Id is null OR Id = '' then 0 else 1 end+
case when Company is null OR Company = '' then 0 else 1 end+
case when Street is null OR Street = '' then 0 else 1 end+
case when City is null OR City = '' then 0 else 1 end+
case when PostalCode is null OR PostalCode = '' then 0 else 1 end+
case when Name is null OR Name = '' then 0 else 1 end+
case when Position__c is null OR Position__c = '' then 0 else 1 end+
case when Phone is null OR Phone = '' then 0 else 1 end+
case when MobilePhone is null OR MobilePhone = '' then 0 else 1 end+
case when Other_Phone__c is null OR Other_Phone__c = '' then 0 else 1 end+
case when Email is null OR Email = '' then 0 else 1 end+
case when Website is null OR Website = '' then 0 else 1 end+
case when FT_Employees__c is null OR FT_Employees__c = 0 then 0 else 1 end+
case when PT_Employees__c is null OR PT_Employees__c = 0 then 0 else 1 end+
case when Total_Employees__c is null OR Total_Employees__c = 0 then 0 else 1 end+
case when Prospect_External_ID__c is null OR Prospect_External_ID__c = '' then 0 else 1 end+
case when IsTps__c is null OR IsTps__c = '' then 0 else 1 end+
case when Salutation is null OR Salutation = '' then 0 else 1 end+
case when FirstName is null OR FirstName = '' then 0 else 1 end+
case when LastName is null OR LastName = '' then 0 else 1 end+
case when SIC2007_Code__c is null OR SIC2007_Code__c = '' then 0 else 1 end+
case when SIC2007_Description__c is null OR SIC2007_Description__c = '' then 0 else 1 end+
case when SIC2007_Code2__c is null OR SIC2007_Code2__c = 0 then 0 else 1 end+
case when SIC2007_Description2__c is null OR SIC2007_Description2__c = '' then 0 else 1 end+
case when SIC2007_Code3__c is null OR SIC2007_Code3__c = 0 then 0 else 1 end+
case when SIC2007_Description3__c is null OR SIC2007_Description3__c = '' then 0 else 1 end) [Completed Columns],
FLOOR(((case when IDG_FK__c is null OR IDG_FK__c = 0 then 0 else 1 end+
case when Id is null OR Id = '' then 0 else 1 end+
case when Company is null OR Company = '' then 0 else 1 end+
case when Street is null OR Street = '' then 0 else 1 end+
case when City is null OR City = '' then 0 else 1 end+
case when PostalCode is null OR PostalCode = '' then 0 else 1 end+
case when Name is null OR Name = '' then 0 else 1 end+
case when Position__c is null OR Position__c = '' then 0 else 1 end+
case when Phone is null OR Phone = '' then 0 else 1 end+
case when MobilePhone is null OR MobilePhone = '' then 0 else 1 end+
case when Other_Phone__c is null OR Other_Phone__c = '' then 0 else 1 end+
case when Email is null OR Email = '' then 0 else 1 end+
case when Website is null OR Website = '' then 0 else 1 end+
case when FT_Employees__c is null OR FT_Employees__c = 0 then 0 else 1 end+
case when PT_Employees__c is null OR PT_Employees__c = 0 then 0 else 1 end+
case when Total_Employees__c is null OR Total_Employees__c = 0 then 0 else 1 end+
case when Prospect_External_ID__c is null OR Prospect_External_ID__c = '' then 0 else 1 end+
case when IsTps__c is null OR IsTps__c = '' then 0 else 1 end+
case when Salutation is null OR Salutation = '' then 0 else 1 end+
case when FirstName is null OR FirstName = '' then 0 else 1 end+
case when LastName is null OR LastName = '' then 0 else 1 end+
case when SIC2007_Code__c is null OR SIC2007_Code__c = '' then 0 else 1 end+
case when SIC2007_Description__c is null OR SIC2007_Description__c = '' then 0 else 1 end+
case when SIC2007_Code2__c is null OR SIC2007_Code2__c = 0 then 0 else 1 end+
case when SIC2007_Description2__c is null OR SIC2007_Description2__c = '' then 0 else 1 end+
case when SIC2007_Code3__c is null OR SIC2007_Code3__c = 0 then 0 else 1 end+
case when SIC2007_Description3__c is null OR SIC2007_Description3__c = '' then 0 else 1 end)*1.0/27)*100) [Row Completion (%)]

FROM 
SalesforceReporting..[IDG-August]

WHERE 
(SIC2007_Code__c is not null or SIC2007_Code__c <> '')
and
(SIC2007_Code2__c is not null or SIC2007_Code2__c = 0)
and
(SIC2007_Code3__c is not null or SIC2007_Code3__c = 0)
and
FT_Employees__c between 6 and 225