SELECT 
l.id SFDC_Id, 
l.Company CompanyName, 
CONVERT(VARCHAR, GETDATE(), 103) date_imported, 
case when l.Suspended_Closed_Reason__c is null and IsTPS__c = 'Yes' then 'TPS' 
when l.Suspended_Closed_Reason__c is not null then Suspended_Closed_Reason__c
else 'No Reason Given' end Reason
FROM Salesforce..Lead l

left outer join SalesforceReporting..[New Noble Suppresion List - 23-07-2014] n
ON l.Id collate latin1_general_CS_AS = n.sfdc_id collate latin1_general_CS_AS
left outer join SalesforceReporting..[New Noble Suppresion List - 23-07-2014] n2
ON LEFT(l.id, 15) collate latin1_general_CS_AS = n2.sfdc_id collate latin1_general_CS_AS

WHERE 
(l.[Status] in ('Closed','Suspended') or l.IsTPS__c = 'Yes')
and
n.sfdc_id is null
and
n2.sfdc_id is null