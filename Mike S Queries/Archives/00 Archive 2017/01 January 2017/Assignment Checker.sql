SELECT 
pc1.[PostCode Area] ActualPostCode, pc1.BDM ActualBDM, pc1.AreaLength ActualLength, 
pc2.[PostCode Area] ConflictingPostCode, pc2.BDM ConflictingBDM, pc2.AreaLength ConflictingLength

INTO
#Conflicts

FROM 
SalesforceReporting..PostCodeAssignments pc1
inner join SalesforceReporting..PostCodeAssignments pc2 ON LEFT(pc1.[PostCode Area],2) = pc2.[PostCode Area] 
															and pc1.BDM <> pc2.BDM
UNION														
SELECT 
pc1.[PostCode Area] ActualPostCode, pc1.BDM ActualBDM, pc1.AreaLength ActualLength, 
pc2.[PostCode Area] ConflictingPostCode, pc2.BDM ConflictingBDM, pc2.AreaLength ConflictingLength

FROM 
SalesforceReporting..PostCodeAssignments pc1
inner join SalesforceReporting..PostCodeAssignments pc2 ON LEFT(pc1.[PostCode Area],3) = pc2.[PostCode Area] 
															and pc1.BDM <> pc2.BDM
ORDER BY ActualPostCode

SELECT *
INTO #Temp
FROM
(
SELECT 
l.Id,
l.PostalCode,
case when pc2.BDM = u.Name then pc2.[PostCode Area] end AreaCode2,
case when pc3.BDM = u.Name then pc3.[PostCode Area] end AreaCode3,
case when pc4.BDM = u.Name then pc4.[PostCode Area] end AreaCode4,
case when pc2.BDM = u.Name then pc4.AreaLength
when pc3.BDM = u.Name then pc3.AreaLength 
when pc4.BDM = u.Name then pc2.AreaLength end AreaLength,
SUM(case when pc2.BDM = u.Name then 1 else 0 end) +
SUM(case when pc3.BDM = u.Name then 1 else 0 end) +
SUM(case when pc4.BDM = u.Name then 1 else 0 end)  BDMCount,
SUM(case when pc2.[PostCode Area] = LEFT(l.PostalCode,2) then 1 else 0 end) +
SUM(case when pc3.[PostCode Area] = LEFT(l.PostalCode,3) then 1 else 0 end) +
SUM(case when pc4.[PostCode Area] = LEFT(l.PostalCode,4) then 1 else 0 end)  AreaCount,
u.Name LeadOwner,
pc2.BDM BDM2,
pc3.BDM BDM3,
pc4.BDM BDM4

FROM 
Salesforce..Lead l
left outer join Salesforce..[User] u ON l.OwnerId = u.Id
left outer join SalesforceReporting..PostCodeAssignments pc2 ON LEFT(l.PostalCode, 2) = pc2.[PostCode Area] and pc2.AreaLength = 2
left outer join SalesforceReporting..PostCodeAssignments pc3 ON LEFT(l.PostalCode, 3) = pc3.[PostCode Area] and pc3.AreaLength = 3
left outer join SalesforceReporting..PostCodeAssignments pc4 ON LEFT(l.PostalCode, 4) = pc4.[PostCode Area] and pc4.AreaLength = 4

WHERE 
Status <> 'Approved'
and
l.PostalCode <> ''
and
RecordTypeId not in ('012D0000000KKTvIAO','012D0000000NbJtIAK')

GROUP BY l.Id,
l.PostalCode,
case when pc2.BDM = u.Name then pc2.[PostCode Area] end ,
case when pc3.BDM = u.Name then pc3.[PostCode Area] end ,
case when pc4.BDM = u.Name then pc4.[PostCode Area] end ,
case when pc2.BDM = u.Name then pc4.AreaLength
when pc3.BDM = u.Name then pc3.AreaLength 
when pc4.BDM = u.Name then pc2.AreaLength end,
u.Name ,
pc2.BDM ,
pc3.BDM ,
pc4.BDM
) detail
WHERE 
AreaCount > 1

SELECT t.Id, t.PostalCode, t.LeadOwner, c.ActualBDM, c.ActualPostCode, c.ConflictingBDM, c.ConflictingPostCode
FROM #Conflicts c
inner join #Temp t ON c.ActualPostCode = LEFT(t.PostalCode, c.ActualLength)
inner join Salesforce..Lead l ON t.Id = l.Id
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
WHERE t.LeadOwner <> c.ActualBDM and rt.Name not in ('NBS Prospect Record Type','QMS Record Type')
ORDER BY PostalCode

DROP TABLE #Conflicts
DROP TABLE #Temp