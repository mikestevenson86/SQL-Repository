SELECT 
case when c.Name like '%Manchester%' then 'SEM1 - Manchester'
when c.Name like '%Bristol%' then 'SEM1 - Bristol'
when c.Name like '%York%' then 'SEM1 - York'
when c.Name like '%Milton%Keynes%' then 'SEM1 - Milton Keynes'
when c.Name like '%Glasgow%' then 'SEM1 - Glasgow'
when c.Name like '%Guildford%' then 'SEM1 - Guildford' end Seminar,
case when LEN(REPLACE(lm_filler2,' ','')) = 18 then REPLACE(lm_filler2,' ','') else l.Id end Id,
MIN(act_date)FirstCall,
MAX(act_date)LastCall
INTO #SemLeads
FROM
SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Salesforce_Id__c
left outer join Salesforce..CampaignMember cm ON case when LEN(REPLACE(lm_filler2,' ','')) = 18 then REPLACE(lm_filler2,' ','') else l.Id end = cm.LeadId
left outer join Salesforce..Campaign c ON cm.CampaignId = c.Id and c.Name like '%SEM%' and c.Type = 'Telemarketing'
WHERE appl = 'SEM1' and call_type in (0,2,4) and 
(
c.Name like '%Manchester%01%' or
c.Name like '%Bristol%01%' or
c.Name like '%Manchester%Dec%' or
c.Name like '%Bristol%Dec%' or
c.Name like '%York%01%' or
c.Name like '%Milton%Keynes%01%' or
c.Name like '%Glasgow%01%' or
c.Name like '%Guildford%01%'
)
GROUP BY 
case when c.Name like '%Manchester%' then 'SEM1 - Manchester'
when c.Name like '%Bristol%' then 'SEM1 - Bristol'
when c.Name like '%York%' then 'SEM1 - York'
when c.Name like '%Milton%Keynes%' then 'SEM1 - Milton Keynes'
when c.Name like '%Glasgow%' then 'SEM1 - Glasgow'
when c.Name like '%Guildford%' then 'SEM1 - Guildford' end,
case when LEN(REPLACE(lm_filler2,' ','')) = 18 then REPLACE(lm_filler2,' ','') else l.Id end

SELECT
sl.Seminar,
SUM(case when call_type in (0,2) then 1 else 0 end) ColdCalls,
SUM(case when call_type = 4 then 1 else 0 end) Callbacks,
SUM(case when l.Date_Made__c between sl.FirstCall and sl.LastCall and l.Date_Made__c >= '2014-12-01' then 1 else 0 end) Appointments
FROM
#SemLeads sl
inner join SalesforceReporting..call_history ch ON sl.Id = ch.lm_filler2 and ch.appl = 'SEM1'
inner join Salesforce..Lead l ON sl.Id = l.Id
WHERE call_type in (0,2,4) and act_date >= '2014-12-01'
GROUP BY sl.Seminar

DROP TABLE #SemLeads