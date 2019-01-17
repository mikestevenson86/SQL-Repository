SELECT COUNT(l.ID)

FROM 
Salesforce..Lead l
inner join SalesforceReporting..Citation_030214_1_import t on l.THL_FK__c = t.THL_id

SELECT COUNT(l.id)
FROM
Salesforce..Lead l
inner join SalesforceReporting..Citation_030214_1_import t on l.THL_FK__c = t.THL_id
WHERE FT_Employees__c = 0 and t.FullTimeEmployees = 0