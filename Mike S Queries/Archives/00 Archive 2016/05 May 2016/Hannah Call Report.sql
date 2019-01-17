SELECT 
act_date [Call Date], 
act_time [Call Time], 
u.Name Agent, 
uMan.Name Manager, 
l.Company, 
l.CitationSector__c [Citation Sector], 
ch.time_connect [Call Length (secs)], 
ch.Status, 
ch.addi_status [Addi Status],
CASE WHEN call_type = 0 THEN 'Outbound call passed to an agent'
WHEN call_type = 1 THEN 'Outbound call which was not passed to an agent (e.g. Busy, No Answer and so on)'
WHEN call_type = 2 THEN 'A transferred call which was successfully connected'
WHEN call_type = 3 THEN 'A transferred call which failed'
WHEN call_type = 4 THEN 'A callback which was passed to an agent'
WHEN call_type = 5 THEN 'A callback that was not passed to an agent (E.g. Busy, No Answer etc.)'
WHEN call_type = 6 THEN 'A dropped outbound call' end [Call Type]
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
left outer join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
left outer join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
WHERE DATEPART(Year, act_Date) = 2015 and DATEPART(Month, act_Date) = 1
ORDER BY act_date, act_time