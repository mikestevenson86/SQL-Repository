SELECT 
case when LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR') then LEFT(PostalCode, 2)
when LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9') then LEFT(PostalCode, 3)
when LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71') then LEFT(PostalCode, 4) end AreaCode,
COUNT(Id) Prospects
INTO #Leads
FROM Salesforce..Lead
WHERE (RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null) and
(
LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR')
or LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9')
or LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71')
)
GROUP BY
case when LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR') then LEFT(PostalCode, 2)
when LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9') then LEFT(PostalCode, 3)
when LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71') then LEFT(PostalCode, 4) end

SELECT
case when LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR') then LEFT(PostalCode, 2)
when LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9') then LEFT(PostalCode, 3)
when LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71') then LEFT(PostalCode, 4) end AreaCode,
COUNT(seqno) Dials,
SUM(Case when call_type in (0,2,4) then 1 else 0 end) Connects
INTO #Calls
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
WHERE (RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null) and act_date between '2015-01-01' and '2015-03-31' and
(
LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR')
or LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9')
or LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71')
)
GROUP BY
case when LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR') then LEFT(PostalCode, 2)
when LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9') then LEFT(PostalCode, 3)
when LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71') then LEFT(PostalCode, 4) end

SELECT 
case when LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR') then LEFT(PostalCode, 2)
when LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9') then LEFT(PostalCode, 3)
when LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71') then LEFT(PostalCode, 4) end AreaCode,
COUNT(Id) Appts
INTO #Appts
FROM Salesforce..Lead
WHERE (RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null) and Date_Made__c between '2015-01-01' and '2015-03-31' and
(
LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR')
or LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9')
or LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71')
)
GROUP BY
case when LEFT(PostalCode, 2) in ('BS','BA','TA','NP','SN','HR') then LEFT(PostalCode, 2)
when LEFT(PostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9','CF3','CF4','CF5','CF6','CF7','CF8','CF9','SA1','SA2','SA3'
,'SA4','SA5','SA6','SA7','SA8','SA9') then LEFT(PostalCode, 3)
when LEFT(PostalCode, 4) in ('SA10','SA11','SA12','SA13','SA14','SA15','GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19','CF10','CF11','CF12','CF13','CF14','CF15','CF16','CF17','CF18','CF19','CF20'
,'CF21','CF22','CF23','CF24','CF71') then LEFT(PostalCode, 4) end

SELECT 
p.AreaCode,
p.Prospects,
ISNULL(c.Dials, 0) Dials,
ISNULL(c.Connects, 0) Connects,
ISNULL(a.Appts, 0) Appointments
FROM
#Leads p
left outer join #Calls c ON p.AreaCode = c.AreaCode
left outer join #Appts a ON p.AreaCode = a.AreaCode
ORDER BY p.AreaCode

DROP TABLE #Leads
DROP TABLE #Calls
DROP TABLE #Appts