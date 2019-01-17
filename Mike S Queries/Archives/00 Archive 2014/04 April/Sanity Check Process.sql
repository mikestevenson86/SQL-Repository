SELECT l.THL_FK__c [Thompsons ID], l.FT_Employees__c [Salesforce FTE], l2.FullTimeEmployees [Thompsons FTE]
FROM Salesforce..Lead l
inner join SalesforceReporting..Citation_030214_1_import l2 on l.THL_FK__c = l2.THL_id
WHERE l.FT_Employees__c = 0

SELECT l.THL_FK__c [Thompsons ID], l.SIC2007_Code__c [Salesforce SIC1], l2.SIC2007_Level1 [Thompsons SIC1]
FROM Salesforce..Lead l
inner join SalesforceReporting..Citation_030214_1_import l2 on l.THL_FK__c = l2.THL_id
WHERE l.SIC2007_Code__c = '0' or  l.SIC2007_Code__c is null

SELECT l.THL_FK__c [Thompsons ID], l.SIC2007_Code2__c [Salesforce SIC2], l2.SIC2007_Level2 [Thompsons SIC2]
FROM Salesforce..Lead l
inner join SalesforceReporting..Citation_030214_1_import l2 on l.THL_FK__c = l2.THL_id
WHERE l.SIC2007_Code2__c = '0' or l.SIC2007_Code2__c is null

SELECT l.THL_FK__c [Thompsons ID], l.SIC2007_Code3__c [Salesforce SIC3], l2.SIC2007_Level3 [Thompsons SIC3]
FROM Salesforce..Lead l
inner join SalesforceReporting..Citation_030214_1_import l2 on l.THL_FK__c = l2.THL_id
WHERE l.SIC2007_Code3__c = '0' or l.SIC2007_Code3__c is null