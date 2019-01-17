-- Create temporary table showing last time each BDC took a lead

SELECT
LeadId,
NewValue BDC,
MAX(lh.CreatedDate) LastChange

INTO
#BDCChanges

FROM
Salesforce..LeadHistory lh
inner join Salesforce..Lead l ON lh.LeadId = l.Id

WHERE
-- only records where BDC field has changed
Field = 'BDC__c'
and
-- only records where value being changed to (BDC) is existing BDC on record
l.BDC__c = lh.NewValue
and
-- only records where lead is callback
l.Status = 'Callback Requested'

GROUP BY
LeadId,
NewValue

-- Create temporary table showing first time BDC took lead (since last time if they had it before)

SELECT 
u.Name, 
l.Id, 
MIN(lh.CreatedDate) FirstDate

INTO 
#Temp

FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
inner join Salesforce..LeadHistory lh ON l.Id = lh.LeadId
inner join #BDCChanges bdc ON l.Id = bdc.LeadId

WHERE 
-- only history record where value being changed is in BDC field
lh.Field = 'BDC__c' 
and 
-- only history records where value being changed to (BDC) is existing BDC on prospect
lh.NewValue = u.Id 
and 
-- only prospects that are in callback state
l.Status = 'Callback Requested' 
and
-- only BST owned records 
u.ProfileId = '00eD0000001Iz3LIAS'
and
-- only history records from last date BDC started pipeline
bdc.LastChange <= lh.CreatedDate

GROUP BY 
u.Name, 
l.Id

SELECT 
u.Name BDC, 
t.Id [Lead ID],
t.FirstDate [First Callback Set]

FROM 
Salesforce..[User] u
inner join #Temp t ON u.Name = t.Name

WHERE 
CONVERT(date, t.FirstDate) <= '2014-06-01' 
and 
u.IsActive = 'true'

SELECT 
u.Name BDC, 
t.Id [Lead ID],
t.FirstDate [First Callback Set]
 
FROM 
Salesforce..[User] u
inner join #Temp t ON u.Name = t.Name

WHERE 
CONVERT(date, t.FirstDate) <= '2014-10-01' 
and 
u.IsActive = 'true'

DROP TABLE #Temp
DROP TABLE #BDCChanges