SELECT LeadId, MAX(CreatedDate) LastCB
INTO #LastCB
FROM Salesforce..LeadHistory
WHERE Field = 'Callback_Date_Time__c' and NewValue is not null
GROUP BY LeadId

SELECT 
l.Id, 
Suspended_Closed_Reason__c, 
Company, 
l.Phone, 
l.Email, 
l.Street, 
l.City, 
l.PostalCode, 
FT_Employees__c, 
SIC2007_Code__c, 
SIC2007_Description__c, 
SIC2007_Code2__c, 
SIC2007_Description2__c, 
SIC2007_Code3__c, 
SIC2007_Description3__c,
Callback_Date_Time__c,
cb.LastCB [Callback Set],
u.Name
FROM 
Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007] and af.[Affinity Partner] = 'SPIVS'
left outer join Salesforce..[User] u ON l.BDC__c = u.Id
left outer join #LastCB cb ON l.Id = cb.LeadId
WHERE 
Status = 'Callback Requested'

DROP TABLE #LastCB