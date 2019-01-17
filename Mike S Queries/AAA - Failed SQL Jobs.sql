	IF OBJECT_ID('tempdb..#LastStatuses') IS NOT NULL
		BEGIN
			DROP TABLE #LastStatuses
		END
	
	select 
		Name,      
		CASE jh.run_status
			WHEN 0 THEN 'Failed'
			WHEN 1 THEN 'Success'
			WHEN 2 THEN 'Retry'
			WHEN 3 THEN 'Cancelled'
		END AS Run_Status,
		MAX(
		CONVERT(datetime, 
		LEFT(jh.run_date, 4) + '-' + LEFT(RIGHT(jh.run_date, 4), 2) + '-' + RIGHT(jh.run_date, 2) + ' ' + 
		case when LEN(jh.run_time) = 5 then
		'0' + LEFT(jh.run_time, 1) + ':' + LEFT(RIGHT(jh.run_time, 4), 2) + ':' + RIGHT(jh.run_time, 2) + '.000'
		when LEN(jh.run_time) < 5 then
		'00:00:00.000'
		else
		LEFT(jh.run_time, 2) + ':' + LEFT(RIGHT(jh.run_time, 4), 2) + ':' + RIGHT(jh.run_time, 2) + '.000'
		end
		)
		) LastRun
	into
		#LastStatuses
	from 
		msdb.dbo.sysjobs j
	inner join 
		msdb.dbo.sysjobhistory jh on j.job_id = jh.job_id
	where
		name like '00%' and j.enabled = 1
	group by 
		j.name, jh.run_status
	order by
		j.name
		
	SELECT 
	ls.Name, 
	ls.Run_Status RunStatus,
	ls.LastRun,
	GETDATE() RunDate
	FROM 
	#LastStatuses ls
	left outer join (
					SELECT Name, MAX(LastRun) LastRun
					FROM #LastStatuses
					WHERE Run_Status = 'Success'
					GROUP BY Name
					) lr ON ls.Name = lr.Name
	WHERE 
	ls.Run_Status in ('Failed','Cancelled') and (lr.LastRun is null or lr.LastRun < ls.LastRun)