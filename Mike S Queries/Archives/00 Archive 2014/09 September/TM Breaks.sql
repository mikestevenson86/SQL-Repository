SELECT tsr, act_time, time_connect
INTO #Times
FROM SalesforceReporting..call_history
WHERE act_date = '2014-08-29' and call_type in (0,2,4)
order by tsr, act_time

SELECT
tsr,
MAX(act_time) maxtime
INTO #PreAM FROM #Times WHERE act_time < 105000
GROUP BY tsr
ORDER BY tsr

SELECT
tsr,
MIN(act_time) mintime
INTO #PostAM FROM #Times WHERE act_time > 105000
GROUP BY tsr
ORDER BY tsr

SELECT
tsr,
MAX(act_time) maxtime
INTO #PreL1 FROM #Times WHERE act_time < 120000
GROUP BY tsr
ORDER BY tsr

SELECT
tsr,
MIN(act_time) mintime
INTO #PostL1 FROM #Times WHERE act_time > 120000
GROUP BY tsr
ORDER BY tsr

SELECT
tsr,
MAX(act_time) maxtime
INTO #PreL2 FROM #Times WHERE act_time < 130000
GROUP BY tsr
ORDER BY tsr

SELECT
tsr,
MIN(act_time) mintime
INTO #PostL2 FROM #Times WHERE act_time > 130000
GROUP BY tsr
ORDER BY tsr

SELECT
tsr,
MAX(act_time) maxtime
INTO #PrePM FROM #Times WHERE act_time < 152000
GROUP BY tsr
ORDER BY tsr

SELECT
tsr,
MIN(act_time) mintime
INTO #PostPM FROM #Times WHERE act_time > 152000
GROUP BY tsr
ORDER BY tsr

SELECT
ch.tsr
INTO
#TSR
FROM 
SalesforceReporting..call_history ch
WHERE 
act_date = '2014-08-29'
GROUP BY tsr
ORDER BY tsr

SELECT 
u.Name Agent,
LEFT(pa.maxtime,2)+':'+RIGHT(LEFT(pa.maxtime,4),2)+':'+RIGHT(pa.maxtime,2) [Last Call Before 1st Break],
LEFT(poa.mintime,2)+':'+RIGHT(LEFT(poa.mintime,4),2)+':'+RIGHT(poa.mintime,2) [First Call After 1st Break],
LEFT(pl1.maxtime,2)+':'+RIGHT(LEFT(pl1.maxtime,4),2)+':'+RIGHT(pl1.maxtime,2) [Last Call Before 1st Lunch],
LEFT(pol1.mintime,2)+':'+RIGHT(LEFT(pol1.mintime,4),2)+':'+RIGHT(pol1.mintime,2) [First Call After 1st Lunch],
LEFT(pl2.maxtime,2)+':'+RIGHT(LEFT(pl2.maxtime,4),2)+':'+RIGHT(pl2.maxtime,2) [Last Call Before 2nd Lunch],
LEFT(pol2.mintime,2)+':'+RIGHT(LEFT(pol2.mintime,4),2)+':'+RIGHT(pol2.mintime,2) [First Call After 2nd Lunch],
LEFT(pp.maxtime,2)+':'+RIGHT(LEFT(pp.maxtime,4),2)+':'+RIGHT(pp.maxtime,2) [Last Call Before 1st Break],
LEFT(pop.mintime,2)+':'+RIGHT(LEFT(pop.mintime,4),2)+':'+RIGHT(pop.mintime,2) [First Call After 1st Break]
FROM
#TSR ch
left outer join #PreAM pa ON ch.tsr = pa.tsr
left outer join #PostAM poa ON ch.tsr = poa.tsr
left outer join #PreL1 pl1 ON ch.tsr = pl1.tsr
left outer join #PostL1 pol1 ON ch.tsr = pol1.tsr
left outer join #PreL2 pl2 ON ch.tsr = pl2.tsr
left outer join #PostL2 pol2 ON ch.tsr = pol2.tsr
left outer join #PrePM pp ON ch.tsr = pp.tsr
left outer join #PostPM pop ON ch.tsr = pop.tsr
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c

ORDER BY
Agent

DROP TABLE #TSR
DROP TABLE #times
DROP TABLE #PreAM
DROP TABLE #PostAM
DROP TABLE #PreL1
DROP TABLE #PostL1
DROP TABLE #PreL2
DROP TABLE #PostL2
DROP TABLE #PrePM
DROP TABLE #PostPM