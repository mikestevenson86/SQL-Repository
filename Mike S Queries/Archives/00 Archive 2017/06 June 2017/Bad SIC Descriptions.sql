SELECT l.Id, l.SIC2007_Code3__c [SIC Code], l.SIC2007_Description3__c [SFDC Description], sc.SIC3_Description [SIC Description]
FROM Salesforce..Lead l
inner join SalesforceReporting..SIC2007Codes sc ON l.SIC2007_Code3__c = sc.SIC3_Code
WHERE 
REPLACE(REPLACE(REPLACE(CONVERT(VarChar(MAX), l.SIC2007_Description3__c),',',''),';',''),'.','') 
<> 
REPLACE(REPLACE(REPLACE(CONVERT(VarChar(MAX), sc.SIC3_Description),',',''),';',''),'.','') 

SELECT l.Id, l.[UK 07 Sic Code] [SIC Code], l.[UK 07 Sic Desc] [SFDC Description], sc.SIC3_Description [SIC Description]
FROM MarketLocation..MainDataSet l
inner join SalesforceReporting..SIC2007Codes sc ON l.[UK 07 Sic Code] = sc.SIC3_Code
WHERE 
REPLACE(REPLACE(REPLACE(CONVERT(VarChar(MAX), l.[UK 07 Sic Desc]),',',''),';',''),'.','') 
<> 
REPLACE(REPLACE(REPLACE(CONVERT(VarChar(MAX), sc.SIC3_Description),',',''),';',''),'.','') 