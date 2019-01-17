	SELECT 

	ROW_NUMBER() OVER (PARTITION BY ch.lm_filler2 ORDER BY ch.act_date, ch.act_time) [Call Counter]
	, lm_filler2
	, act_date
	, act_time
	, ch.[status]

	INTO #CallCounts

	FROM Enterprise..call_history ch

	inner join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	
	WHERE DATEPART(MONTH, act_date) = DATEPART(Month, GETDATE())-1

	ORDER BY lm_filler2, act_date, act_time

	SELECT 

	case when [Call Counter] = 1 then 'Call 1 - Cold'
	when [Call Counter] = 2 then 'Call 2 - Callback 1' 
	when [Call Counter] = 3 then 'Call 3 - Callback 2'
	when [Call Counter] = 4 then 'Call 4 - Callback 3'
	when [Call Counter] = 5 then 'Call 5 - Callback 4'
	else 'Call 6+ - Callback 5+' end [Call Number]
	, COUNT(*) [Appts]

	FROM #CallCounts

	WHERE [status] = 'AP'

	GROUP BY case when [Call Counter] = 1 then 'Call 1 - Cold'
	when [Call Counter] = 2 then 'Call 2 - Callback 1' 
	when [Call Counter] = 3 then 'Call 3 - Callback 2'
	when [Call Counter] = 4 then 'Call 4 - Callback 3'
	when [Call Counter] = 5 then 'Call 5 - Callback 4'
	else 'Call 6+ - Callback 5+' end

	ORDER BY case when [Call Counter] = 1 then 'Call 1 - Cold'
	when [Call Counter] = 2 then 'Call 2 - Callback 1' 
	when [Call Counter] = 3 then 'Call 3 - Callback 2'
	when [Call Counter] = 4 then 'Call 4 - Callback 3'
	when [Call Counter] = 5 then 'Call 5 - Callback 4'
	else 'Call 6+ - Callback 5+' end

	DROP TABLE #CallCounts