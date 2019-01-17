SELECT
lm_filler2, 
case when listid = '2718' then 'Liverpool'
when listid = '2721' then 'Heathrow'
when listid = '2722' then 'Maidstone'
when listid = '2667' then 'Southampton' end Seminar
INTO
#Temp
FROM
SalesforceReporting..call_history ch
WHERE
listid in ('2718','2721','2722','2667')

SELECT
t.Seminar,
SUM(case when call_type = 4 then 1 else 0 end) Callbacks
INTO
#Callbacks
FROM
SalesforceReporting..call_history ch
inner join #Temp t ON t.lm_filler2 = ch.lm_filler2
GROUP BY
t.Seminar

SELECT
case when listid = '2718' then 'Liverpool'
when listid = '2721' then 'Heathrow'
when listid = '2722' then 'Maidstone'
when listid = '2667' then 'Southampton' end Seminar,
COUNT(seqno) Dials,
SUM(case when call_type in (0,2,4) then 1 else 0 end) LiveConnects,
cb.Callbacks,
SUM(case when date_made__c is not null and MADE_criteria__c like '%seminar%' then 1 else 0 end) Appointments
FROM
SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON ch.lm_filler2 = l.Id
left outer join #Callbacks cb ON case when listid = '2718' then 'Liverpool'
when listid = '2721' then 'Heathrow'
when listid = '2722' then 'Maidstone'
when listid = '2667' then 'Southampton' end = cb.Seminar
WHERE
listid in ('2718','2721','2722','2667') and ch.appl = 'SEM1'
GROUP BY
case when listid = '2718' then 'Liverpool'
when listid = '2721' then 'Heathrow'
when listid = '2722' then 'Maidstone'
when listid = '2667' then 'Southampton' end
, cb.Callbacks

DROP TABLE #Callbacks
DROP TABLE #Temp