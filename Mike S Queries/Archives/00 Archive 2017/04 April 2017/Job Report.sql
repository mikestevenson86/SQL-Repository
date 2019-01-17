SELECT
CONVERT(date, msdb.dbo.agent_datetime(T1.run_date, T1.run_time)) RunDate,
LEFT(CONVERT(VarChar, CONVERT(time, msdb.dbo.agent_datetime(T1.run_date, T1.run_time))),8) RunTime,
SUBSTRING(T2.name,1,140) AS [SQL Job Name],
T1.step_name AS [Step Name],
T1.run_duration,
LEFT(CONVERT(VarChar,
CONVERT(time,
CONVERT(VarChar, FLOOR(FLOOR(T1.run_duration/60)/60))
+
':'
+
CONVERT(VarChar, FLOOR(T1.run_duration/60)-(FLOOR(FLOOR(T1.run_duration/60)/60)*60))
+
':'
+
CONVERT(VarChar, T1.run_duration-(FLOOR(T1.run_duration/60)*60))
)),8)
StepDuration,

CASE T1.run_status
WHEN 0 THEN 'Failed'
WHEN 1 THEN 'Succeeded'
WHEN 2 THEN 'Retry'
WHEN 3 THEN 'Cancelled'
WHEN 4 THEN 'In Progress'
END AS ExecutionStatus,
T1.message AS [Error Message]

FROM
msdb..sysjobhistory T1 
INNER JOIN msdb..sysjobs T2 ON T1.job_id = T2.job_id

WHERE
T1.run_status NOT IN (1, 4)
AND T1.step_id != 0
AND run_date >= CONVERT(CHAR(8), (SELECT DATEADD (DAY,(-1), GETDATE())), 112)

ORDER BY
ExecutionStatus, msdb.dbo.agent_datetime(T1.run_date, T1.run_time)