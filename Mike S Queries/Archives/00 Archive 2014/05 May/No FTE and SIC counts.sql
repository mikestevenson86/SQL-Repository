SELECT COUNT(*) [No FTE]
FROM Salesforce..Lead
WHERE Total_Employees__c = 0

SELECT COUNT(*) [No SIC Codes]
FROM Salesforce..Lead
WHERE SIC2007_Code2__c is null or SIC2007_Code3__c is null or SIC2007_Code__c is null