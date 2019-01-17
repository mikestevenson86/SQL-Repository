--DROP TABLE TempLead

--SELECT ROW_NUMBER () OVER (ORDER BY Id), *
--INTO TempLead
--FROM Salesforce..Lead

SELECT 
REPLACE(Id,',','') Id,
REPLACE(Company,',','') Company,
REPLACE(REPLACE(REPLACE(REPLACE(Street, ',', ' '), CHAR(10)+CHAR(13), ''), CHAR(10), ''), CHAR(13), '') Street,
REPLACE(City,',',' ') City,
REPLACE(PostalCode,',','') PostalCode,
REPLACE(Name,',','') Contact,
REPLACE(Position__c,',','') Position,
REPLACE(Phone,' ','') Phone,
REPLACE(MobilePhone,' ','') Mobile,
REPLACE(Other_Phone__c,' ','') OtherPhone,
REPLACE(Email,',','') Email,
REPLACE(SIC2007_Code__c,',','') SIC1,
REPLACE(SIC2007_Code2__c,',','') SIC2,
REPLACE(SIC2007_Code3__c,',','') SIC3,
REPLACE(Website,',','') Website,
REPLACE(FT_Employees__c,',','') FT_Employees,
REPLACE(PT_Employees__c,',','') PT_Employees,
REPLACE(Total_Employees__c,',','') Total_Employees
FROM TempLead
WHERE RowN between 500001 and 600000