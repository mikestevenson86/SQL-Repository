SELECT
	CallDate,
	[Description],
	SUM(CallsConnected) [Calls Connected],
	SUM(CallsAttempted) [Calls Attempted],
	SUM(threemincalls) [Calls Over Three Minutes],
	SUM(sevenmincalls) [Calls Over Seven Minutes]

	INTO 
	#Calls
	
	FROM
	(
	SELECT 
	CONVERT(date,ch.act_date) CallDate,
	case when s3.[Description] is null then 'No Sector' else s3.[Description] end [Description],
	SUM(case when call_type in (0,2,4) then 1 else 0 end) CallsConnected,
	SUM(case when call_type in (1,3,5,6) then 1 else 0 end) CallsAttempted,
	SUM(case when call_type in (0,2,4) and time_connect >= 180 then 1 else 0 end) threemincalls,
	SUM(case when call_type in (0,2,4) and time_connect >= 420 then 1 else 0 end) sevenmincalls

	FROM Enterprise..call_history ch
	left outer join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	inner join Salesforce..[User] u on ch.tsr = u.DiallerFK__c and u.Department = 'Telemarketing'
	left outer join SalesforceReporting..SIC3 s3 on l.SIC2007_Code3__c = s3.[SIC Code 3]

	WHERE  
	ch.act_date >= '2013-10-01'

	GROUP BY
	ch.act_date,
	case when s3.[Description] is null then 'No Sector' else s3.[Description] end
	
	UNION ALL
	
	SELECT 
	CONVERT(date,ch.act_date) CallDate,
	case when s3.[Description] is null then 'No Sector' else s3.[Description] end [Description],
	SUM(case when call_type in (0,2,4) then 1 else 0 end) CallsConnected,
	SUM(case when call_type in (1,3,5,6) then 1 else 0 end) CallsAttempted,
	SUM(case when call_type in (0,2,4) and time_connect >= 180 then 1 else 0 end) threemincalls,
	SUM(case when call_type in (0,2,4) and time_connect >= 420 then 1 else 0 end) sevenmincalls

	FROM SalesforceReporting..call_history ch
	left outer join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	inner join Salesforce..[User] u on ch.tsr = u.DiallerFK__c and u.Department = 'Telemarketing'
	left outer join SalesforceReporting..SIC3 s3 on l.SIC2007_Code3__c = s3.[SIC Code 3]
	
	WHERE  
	ch.act_date >= '2013-10-01'

	GROUP BY
	ch.act_date,
	case when s3.[Description] is null then 'No Sector' else s3.[Description] end
	) detail
	
	GROUP BY
	CallDate,
	[Description]

	-- Collate Appointment Data
    
	SELECT 
	CONVERT(date,l.Date_Made__c) CallDate,
	case when s3.[Description] is null then 'No Sector' else s3.[Description] end [Description],
	COUNT(l.Id) Appts

	INTO 
	#Apps

	FROM 
	Salesforce..Lead l
	inner join Salesforce..[User] u on l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
	inner join Salesforce..[Profile] p on u.ProfileId collate latin1_general_CS_AS = p.Id collate latin1_general_CS_AS
	left outer join SalesforceReporting..SIC3 s3 on l.SIC2007_Code3__c = s3.[SIC Code 3]

	WHERE 
	
	(l.LeadSource not like '%tele_BCAS%' or l.LeadSource is null)
	and
	l.MADE_Criteria__c in ('Outbound - 1','Outbound - 2')
	and
	CONVERT(date,l.Date_Made__c) >= '2013-10-01'

	GROUP BY
	CONVERT(date,l.Date_Made__c),
	case when s3.[Description] is null then 'No Sector' else s3.[Description] end

	-- Output

	SELECT 
	t.CallDate,
	t.[Description],
	ISNULL(ap.Appts,0) Appts,
	ISNULL(t.[Calls Connected],0) [Calls Connected],
	ISNULL(t.[Calls Attempted],0) [Calls Attempted],
	ISNULL(t.[Calls Over Three Minutes],0) [Calls Over Three Minutes],
	ISNULL(t.[Calls Over Seven Minutes],0) [Calls Over Seven Minutes]

	FROM
	#Calls t

	left outer join #Apps ap on t.CallDate = ap.CallDate
	and 
	t.[Description] = ap.[Description]

	ORDER BY
	t.CallDate,
	t.[Description]

	DROP TABLE #Apps
	DROP TABLE #Calls