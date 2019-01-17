SELECT 
CONVERT(date, lh.CreatedDate) DayLost,
OldValue BDC,
LeadId ProspectId

FROM 
Salesforce..LeadHistory lh
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
inner join Salesforce..[User] bdc ON lh.OldValue = bdc.Name
inner join Salesforce..[User] uMan ON bdc.ManagerId = uMan.Id

WHERE 
DATEPART(Month, lh.CreatedDate) = DATEPART(Month, GETDATE()) 
and 
lh.Field = 'BDC__c' 
and 
CONVERT(time, lh.CreatedDate) >= '19:00:00'
and 
NewValue = 'Jo Wood' 
and 
uMan.Name = 'Alison Schillaci'

ORDER BY
DayLost