-- ML Email Inserts

SELECT 
Id
,[Market_Location_URN__c]
,[Company]
,[Street]
,[City]
,[State]
,[PostalCode]
,[Phone]
,[IsTPS__c]
,[Salutation]
,[FirstName]
,[LastName]
,[Position__c]
,[Website]
,[FT_Employees__c]
,[SIC2007_Code3__c]
,[SIC2007_Description3__c]
,[Email]
,[Co_Reg__c]
,[Source__c]
,[Data_Supplier__c]
,[Actual_turnover_band__c]
,[Easy_sector_code__c]
,[immediate_parent_cro__c]
,[immediate_parent_name__c]
,[Major_sector_code__c]
,[Major_sector_description__c]
,[Modelled_turnover_band__c]
,[Sub_sector_code__c]
,[Sub_sector_description__c]
,[Ultimate_parent_cro__c]
,[Ultimate_parent_name__c]
,[Year_established__c]
,ML_Last_Update_Date__c

FROM 
Salesforce..Lead

-- ML Email Updates

SELECT 
Id
,[Market_Location_URN__c]
,[Company]
,[Street]
,[City]
,[State]
,[PostalCode]
,[Phone]
,[IsTPS__c]
,[Salutation]
,[FirstName]
,[LastName]
,[Position__c]
,[Website]
,[FT_Employees__c]
,[SIC2007_Code3__c]
,[SIC2007_Description3__c]
,[Email]
,[Co_Reg__c]
,[Source__c]
,[Actual_turnover_band__c]
,[immediate_parent_cro__c]
,[immediate_parent_name__c]
,[Easy_sector_code__c]
,ML_Business_Type__c
,[Major_sector_code__c]
,[Major_sector_description__c]
,[Modelled_turnover_band__c]
,[Sub_sector_code__c]
,[Sub_sector_description__c]
,[Ultimate_parent_name__c]
,[Year_established__c]
,ML_Last_Update_Date__c

FROM 
Salesforce..Lead

-- ML API Inserts

SELECT 

Id
,[Market_Location_URN__c]
,[Company]
,[Street]
,[City]
,[State]
,[PostalCode]
,[Phone]
,[IsTPS__c]
,[Salutation]
,[FirstName]
,[LastName]
,[Position__c]
,[Website]
,[FT_Employees__c]
,[SIC2007_Code3__c]
,[SIC2007_Description3__c]
,[Email]
,[Co_Reg__c]
,[Source__c]
,Data_Supplier__c
,[Actual_turnover_band__c]
,[Easy_sector_code__c]
,[ML_Business_Type__c]
,[immediate_parent_cro__c]
,[immediate_parent_name__c]
,[Major_sector_code__c]
,[Major_sector_description__c]
,[Modelled_turnover_band__c]
,[Sub_sector_code__c]
,[Sub_sector_description__c]
,[Ultimate_parent_cro__c]
,[Ultimate_parent_name__c]
,[Year_established__c]
,ML_Last_Update_Date__c

FROM 
Salesforce..Lead

--ML API Updates

SELECT 
Id
,[Market_Location_URN__c]
,[Company]
,[Street]
,[City]
,[State]
,[PostalCode]
,[Phone]
,[IsTPS__c]
,[Salutation]
,[FirstName]
,[LastName]
,[Position__c]
,[Website]
,[FT_Employees__c]
,[SIC2007_Code3__c]
,[SIC2007_Description3__c]
,[Email]
,[Co_Reg__c]
,[Source__c]
,[Actual_turnover_band__c]
,[Easy_sector_code__c]
,ML_Business_Type__c
,[immediate_parent_cro__c]
,[immediate_parent_name__c]
,[Major_sector_code__c]
,[Major_sector_description__c]
,[Modelled_turnover_band__c]
,[Sub_sector_code__c]
,[Sub_sector_description__c]
,[Ultimate_parent_cro__c]
,[Ultimate_parent_name__c]
,[Year_established__c]
,ML_Last_Update_Date__c

FROM 
Salesforce..Lead