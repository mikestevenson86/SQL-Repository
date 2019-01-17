SELECT u.Name, COUNT(l.Id) Appts
INTO #Appts
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE Date_Made__c between '2015-07-27' and '2015-07-31'
GROUP BY u.Name

SELECT u.Name, SUM(tp.pause_time) Paused
INTO #Pauses
FROM SalesforceReporting..tskpauday tp
inner join Salesforce..[User] u ON tp.tsr = u.DiallerFK__c
WHERE tp.call_date between '2015-07-27' and '2015-07-31'
GROUP BY u.Name

SELECT
u.Name,
ch.Status + ' - ' + ch.addi_status Disposition,
sc.[Description 3],
COUNT(seqno) TotalConnects,
COUNT(distinct RIGHT(lm_filler2, 15) collate latin1_general_CS_AS) DistinctProspects,
SUM(case when call_type in (0,2,4) then 1 else 0 end) LiveConnects,
SUM(case when call_type = 4 then 1 else 0 end) Callbacks,
SUM(case when a.CountAsDMC = 1 then 1 else 0 end) TotalDMC,
SUM(time_connect) TalkTime,
ap.Appts,
pau.Paused
FROM
SalesforceReporting..call_history ch
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.[SIC Code 3]
left outer join SalesforceReporting..addistats AS a ON ch.status = a.pstatus
                                                              AND ISNULL(ch.addi_status,
                                                              '') = ISNULL(a.addistatus,
                                                              '')
                                                              AND a.pappl = 'CLD1'
left outer join #Appts ap ON u.Name = ap.Name
left outer join #Pauses pau ON u.Name = pau.Name
WHERE
act_date between '2015-07-27' and '2015-07-31'
GROUP BY
u.Name,
ch.Status + ' - ' + ch.addi_status,
sc.[Description 3],
ap.Appts,
pau.Paused

DROP TABLE #Appts
DROP TABLE #Pauses