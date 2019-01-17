SELECT act_date, COUNT(seqno) NoOwner, SUM(case when l.Id is null then 1 else 0 end) NoSFDCLink, SUM(case when LeadSource like '%QMS%' then 1 else 0 end) QMS,
SUM(case when g.Name = 'Unassigned BDM' then 1 else 0 end) Unassigned, SUM(case when appl like '%INBO%' then 1 else 0 end) Inbounds
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(l.Id,15) collate latin1_general_CS_AS
left outer join Salesforce..[User] u ON l.OwnerId = u.Id
left outer join Salesforce..[Group] g ON l.OwnerId = g.Id
WHERE u.Id is null
GROUP BY act_date
ORDER BY act_date