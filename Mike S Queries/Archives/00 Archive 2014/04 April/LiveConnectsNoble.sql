SELECT act_date, COUNT(seqno)
--INTO #LiveConnects
FROM Enterprise..call_history ch
WHERE act_date > GETDATE()-30 and time_connect > 0
GROUP BY act_date