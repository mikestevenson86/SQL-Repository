SELECT REPLACE(Id,' ','') Id, MIN(First_Call_Date__c) First_Call_Date__c
FROM
(
SELECT case when LEN(REPLACE(lm_filler2,' ','')) = 15 then l.Id else lm_filler2 end Id, MIN(act_date)First_Call_Date__c
FROM Enterprise..call_history ch
left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Salesforce_Id__c collate latin1_general_CS_AS
WHERE call_type in (0,2,4) and lm_filler2 like '00QD%'
GROUP BY case when LEN(REPLACE(lm_filler2,' ','')) = 15 then l.Id else lm_filler2 end
UNION
SELECT case when LEN(REPLACE(lm_filler2,' ','')) = 15 then l.Id else lm_filler2 end Id, MIN(act_date)First_Call_Date__c
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Salesforce_Id__c collate latin1_general_CS_AS
WHERE call_type in (0,2,4) and lm_filler2 like '00QD%'
GROUP BY case when LEN(REPLACE(lm_filler2,' ','')) = 15 then l.Id else lm_filler2 end 
) detail
GROUP BY detail.Id
