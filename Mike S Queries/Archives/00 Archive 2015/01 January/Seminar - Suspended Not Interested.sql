SELECT case when LEN(REPLACE(lm_filler2,' ','')) = 18 then REPLACE(lm_filler2,' ','') else l.Id end Id, act_date
INTO #temp
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Salesforce_Id__c collate latin1_general_CS_AS
WHERE appl = 'SEM1' and addi_status = 'NI' and listid <> '2979'

SELECT L.Id
FROM Salesforce..Lead l
inner join #temp t ON l.Id = t.Id and l.Status_Changed_Date__c = t.act_date
WHERE l.Status = 'Suspended' and Suspended_Closed_Reason__c = 'Not Interested'

DROP TABLE #Temp