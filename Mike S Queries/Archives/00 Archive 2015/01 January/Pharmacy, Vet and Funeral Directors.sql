SELECT
LeadId,
MAX(CONVERT(date, CreatedDate)) DateMade
INTO
#Temp
FROM
Salesforce..LeadHistory
WHERE
Field = 'Status' and NewValue = 'Callback Requested'
GROUP BY
LeadId

SELECT
case when SIC2007_Code3__c in (21100,46460,47730) then 'Pharmacies'
when SIC2007_Code3__c = 75000 then 'Vets' else 'Funeral Directors' end Sector,
t.DateMade,
Callback_Date_Time__c DateSet
FROM
Salesforce..Lead l
left outer join #Temp t ON l.Id = t.LeadId
WHERE
SIC2007_Code3__c in (21100,46460,47730,75000,96030) and Status = 'Callback Requested'

SELECT
LeadId,
MAX(CONVERT(date, CreatedDate)) ClosedDate
INTO
#Temp2
FROM
Salesforce..LeadHistory
WHERE
Field = 'Status' and NewValue = 'Closed'
GROUP BY
LeadId

SELECT
case when SIC2007_Code3__c in (21100,46460,47730) then 'Pharmacies'
when SIC2007_Code3__c = 75000 then 'Vets' else 'Funeral Directors' end Sector,
l.Suspended_Closed_Reason__c Reason,
t2.ClosedDate
FROM
Salesforce..Lead l
left outer join #Temp2 t2 ON l.Id = t2.LeadId
WHERE
Status = 'Closed' and SIC2007_Code3__c in (21100,46460,47730,75000,96030)

DROP TABLE #Temp
DROP TABLE #Temp2