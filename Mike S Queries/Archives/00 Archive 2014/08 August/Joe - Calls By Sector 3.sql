	-- Collate Call Data

	SELECT
	CallDate,
	[Description],
	SUM(Calls) Calls,
	SUM(CallsOverThree) CallsOverThree,
	SUM(CallsOverSeven) CallsOverSeven
	
	INTO 
	#CallCounts
	
	FROM
	(
	SELECT 
	CONVERT(date,ch.act_date) CallDate,
	ISNULL(s3.[Description],'No Sector') [Description],
	COUNT(seqno) Calls,
	SUM(case when time_connect >= 180 then 1 else 0 end) CallsOverThree,
	SUM(case when time_connect >= 420 then 1 else 0 end) CallsOverSeven

	FROM Enterprise..call_history ch
	inner join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	left outer join SalesforceReporting..SIC3 s3 on l.SIC2007_Code3__c = s3.[SIC Code 3]

	WHERE 
	ch.call_type in (0,2,4)
	and 
	CONVERT(date,ch.act_date) >= '2013-10-21'

	GROUP BY
	CONVERT(date,ch.act_date),
	ISNULL(s3.[description],'No Sector') 
	UNION
	SELECT
	CONVERT(date,ch.act_date) CallDate,
	ISNULL(s3.[Description],'No Sector') [Description],
	COUNT(seqno) Calls,
	SUM(case when time_connect >= 180 then 1 else 0 end) CallsOverThree,
	SUM(case when time_connect >= 420 then 1 else 0 end) CallsOverSeven

	FROM SalesforceReporting..call_history ch
	inner join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	left outer join SalesforceReporting..SIC3 s3 on l.SIC2007_Code3__c = s3.[SIC Code 3]
	
	WHERE
	ch.call_type in (0,2,4)
	and 
	CONVERT(date,ch.act_date) >= '2013-10-21'
	
	GROUP BY
	CONVERT(date,ch.act_date),
	ISNULL(s3.[description],'No Sector') 
	) detail
	
	GROUP BY
	CallDate,
	[Description]
	
	-- Collate Appointments
	
	SELECT 
	CONVERT(date,l.Date_Made__c) CallDate,
	ISNULL(s3.[description], 'No Sector') [Description],
	COUNT(l.Id) Appts

	INTO 
	#Apps

	FROM 
	Salesforce..Lead l
	left outer join SalesforceReporting..SIC3 s3 on l.SIC2007_Code3__c = s3.[SIC Code 3]

	WHERE 
	
	(l.LeadSource not like '%tele_BCAS%' or l.LeadSource is null)
	and
	l.MADE_Criteria__c in ('Outbound - 1','Outbound - 2')
	and
	CONVERT(date,l.Date_Made__c) >= '2013-10-21'

	GROUP BY
	CONVERT(date,l.Date_Made__c),
	ISNULL(s3.[description],'No Sector') 

	-- Output

	SELECT 
	t.CallDate,
	t.[Description],
	ISNULL(CallsOverThree,0)CallsOverThreeMinutes,
	ISNULL(CallsOverSeven,0) CallsOverSevenMinutes,
	ISNULL(ap.Appts,0) Appts,
	ISNULL(Calls,0) Calls

	FROM
	#CallCounts t

	left outer join #Apps ap on t.CallDate = ap.CallDate
	and
	t.[Description] = ap.[Description]

	ORDER BY
	t.CallDate,
	t.[Description]

	DROP TABLE #Apps
	DROP TABLE #CallCounts