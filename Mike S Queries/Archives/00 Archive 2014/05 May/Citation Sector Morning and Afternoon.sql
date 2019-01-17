-- All Calls that have been passed to an Agent (cold and callback)

SELECT 
DATENAME(m, act_date) [Month],
DATENAME(dw, act_date) [Weekday],
CONVERT(varchar(10),act_date,103) [Call Date],
case when act_time < 120000 then 'AM' Else 'PM' end [Day Half],
ISNULL(l.CitationSector__c, 'No Sector') [Citation Sector],
COUNT(ch.lm_filler2) 'Prospects'

FROM 
Enterprise..call_history ch
inner join salesforce..lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS

WHERE 
ch.call_type in (0,2,4)

GROUP BY 
act_date, 
case when act_time < 120000 then 'AM' Else 'PM' end,
l.CitationSector__c

ORDER BY 
act_date, 
case when act_time < 120000 then 'AM' Else 'PM' end,
l.CitationSector__c