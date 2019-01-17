SELECT 
l.Id SFDC_ID, 
l.Company CompanyName, 
CONVERT(date,GETDATE()) date_imported, 
'CTPS' Reason

FROM 
Salesforce..Lead l

left outer join SalesforceReporting..[New Noble Suppresion List - 23-07-2014] nn
ON l.Id collate latin1_general_CS_AS = nn.sfdc_id collate latin1_general_CS_AS

WHERE 
IsTPS__c = 'Yes'
and
[Status] not in ('suspended','closed')
and
nn.sfdc_id is null