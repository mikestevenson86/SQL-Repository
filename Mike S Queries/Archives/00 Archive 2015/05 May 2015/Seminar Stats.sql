SELECT listid, lm_filler2, MIN(act_date) calldate
INTO #SEM
FROM SalesforceReporting..call_history
WHERE listid in (2974,2975,2979)
GROUP BY listid, lm_filler2

SELECT sm.listid, SUM(case when call_type = 4 then 1 else 0 end) Callbacks
INTO #CB
FROM SalesforceReporting..call_history ch
inner join #SEM sm ON ch.lm_filler2 = sm.lm_filler2 and act_date >= calldate
WHERE ch.listid = 22227
GROUP BY sm.listid

SELECT sm.listid, COUNT(l.id) Appts
INTO #Appts
FROM Salesforce..Lead l
inner join #SEM sm ON l.Id = sm.lm_filler2
WHERE Date_Made__c >= calldate
GROUP BY sm.listid

SELECT ch.listid, COUNT(seqno) Dials, SUM(case when call_type in (0,2,4) then 1 else 0 end) Connects, cb.Callbacks, ap.Appts
FROM SalesforceReporting..call_history ch
left outer join #CB cb ON ch.listid = cb.listid
left outer join #Appts ap ON ch.listid = ap.listid
WHERE ch.listid in (2974,2975,2979)
GROUP BY ch.listid, cb.Callbacks, ap.Appts

DROP TABLE #SEM
DROP TABLE #CB
DROP TABLE #Appts