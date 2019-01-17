SELECT 
LeadID, 
MAX(CreatedDate) CloseDate

INTO 
#CDates

FROM 
Salesforce..LeadHistory

WHERE 
Field = 'Status' 
and 
NewValue = 'closed'

GROUP BY 
LeadId

SELECT 
l.Id SFDC_ID, 
l.Company CompanyName, 
ISNULL(CONVERT(date, cd.CloseDate),CONVERT(date,GETDATE())) date_imported, 
ISNULL(l.Suspended_Closed_Reason__c, 'Unknown') Reason

FROM 
Salesforce..Lead l

left outer join #CDates cd 
ON l.Id collate latin1_general_CS_AS = cd.LeadID collate latin1_general_CS_AS
left outer join SalesforceReporting..[New Noble Suppresion List - 23-07-2014] nn
ON l.Id collate latin1_general_CS_AS = nn.sfdc_id collate latin1_general_CS_AS

WHERE 
[Status] = 'closed'
and
nn.sfdc_id is null

DROP TABLE #CDates