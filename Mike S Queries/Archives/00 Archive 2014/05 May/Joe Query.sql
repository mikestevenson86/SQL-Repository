SELECT 
CONVERT(char,lh.createddate,103)[Call Date],
u.Name [Agent], 
s2.[Description], 
SUM(case when ch.[status] not in ('AM','A','D') then ch.time_connect else 0 end) TalkTime,
SUM(case when lh.NewValue = 'Data Quality' then 1 else 0 end) Appointments,
SUM(case when ch.seqno is null then (case when lh.id is not null then 1 else 0 end) else (case when ch.seqno is not null then 1 else 0 end) end) [Call Count],
Case when ch.seqno is null then 'Salesforce ONLY' else 'Noble' end [Source]

FROM 
Salesforce..LeadHistory lh 
left outer join Enterprise..call_history ch on lh.LeadId collate latin1_general_CS_AS = ch.lm_filler2 collate latin1_general_CS_AS 
and CONVERT(char,lh.createddate,103) = CONVERT(char,ch.act_date,103)
and ch.time_connect>0 
and ch.call_type in (0,2,4)
inner join Salesforce..[User] u on lh.CreatedById collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
left outer join Enterprise..tsrmaster tsr on ch.tsr = tsr.tsr
inner join Salesforce..Lead l on lh.LeadId collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

WHERE 
lh.CreatedDate >= '2014-01-01' 
and u.Title like '%BDC%'

GROUP BY 
CONVERT(char,lh.createddate,103), 
u.Name, 
s2.[Description], 
Case when ch.seqno is null then 'Salesforce ONLY' else 'Noble' end
ORDER BY 
CONVERT(char,lh.createddate,103), 
u.Name, 
s2.[Description]