	SELECT
	CallDate,
	Agent,
	[Description],
	SUM(Calls) Calls,
	SUM(TalkTime) TalkTime

	INTO 
	#Calls
	
	FROM
	(
	SELECT 
	CONVERT(date,ch.act_date) CallDate,
	case when tsr = 'ATLA' then 'Fasil Altaf' else ISNULL(u.Name, tsr) end Agent,
	ISNULL(s2.[Description],'No Sector') [Description],
	COUNT(seqno) Calls,
	SUM(ch.time_connect) TalkTime

	FROM Enterprise..call_history ch
	left outer join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	left outer join Salesforce..[User] u on ch.tsr = u.DiallerFK__c
	left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

	WHERE 
	ch.call_type in (0,2,4)
	and 
	CONVERT(date,ch.act_date) >= '2014-01-01'
	and
	(
	u.Department = 'Telemarketing' 
	or 
	(u.Name = 'Harry Saunders' and act_date < '2014-07-01') 
	or 
	(u.Name = 'Steven Gibbs' and act_date < '2014-07-21')
	or
	tsr = 'ATLA'
	)

	GROUP BY
	CONVERT(date,ch.act_date),
	case when tsr = 'ATLA' then 'Fasil Altaf' else ISNULL(u.Name, tsr) end,
	ISNULL(s2.[description],'No Sector')
		
	UNION ALL
		
	SELECT
	CONVERT(date,ch.act_date) CallDate,
	case when tsr = 'ATLA' then 'Fasil Altaf' else ISNULL(u.Name, tsr) end Agent,
	ISNULL(s2.[Description],'No Sector') [Description],
	COUNT(seqno) Calls,
	SUM(ch.time_connect) TalkTime

	FROM SalesforceReporting..call_history ch
	left outer join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
	left outer join Salesforce..[User] u on ch.tsr = u.DiallerFK__c
	left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

	WHERE 
	ch.call_type in (0,2,4)
	and 
	CONVERT(date,ch.act_date) >= '2014-01-01'
	and
	(
	u.Department = 'Telemarketing' 
	or 
	(u.Name = 'Harry Saunders' and act_date < '2014-07-01') 
	or 
	(u.Name = 'Steven Gibbs' and act_date < '2014-07-21')
	or
	tsr = 'ATLA'
	)

	GROUP BY
	CONVERT(date,ch.act_date),
	case when tsr = 'ATLA' then 'Fasil Altaf' else ISNULL(u.Name, tsr) end,
	ISNULL(s2.[description],'No Sector') 
	) detail
	
	GROUP BY
	CallDate,
	Agent,
	[Description]
	
	-- Collate Appointment Data
    
	SELECT 
	CONVERT(date,l.Date_Made__c) CallDate,
	u.Name Agent,
	ISNULL(s2.[description], 'No Sector') [Description],
	COUNT(l.Id) Appts

	INTO 
	#Apps

	FROM 
	Salesforce..Lead l
	left outer join Salesforce..[User] u on l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
	left outer join Salesforce..[Profile] p on u.ProfileId collate latin1_general_CS_AS = p.Id collate latin1_general_CS_AS
	left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

	WHERE 
	
	(l.LeadSource not like '%tele_BCAS%' or l.LeadSource is null)
	and
	l.MADE_Criteria__c in ('Outbound - 1','Outbound - 2')
	and
	l.Date_Made__c >= '2014-01-01'

	GROUP BY
	l.Date_Made__c,
	u.Name,
	ISNULL(s2.[description], 'No Sector')
		
	-- Output

	SELECT 
	c.CallDate,
	c.Agent,
	c.[Description],
	ISNULL(c.TalkTime,0) TalkTime,
	ISNULL(ap.Appts,0) Appts,
	ISNULL(c.Calls,0) Calls

	FROM
	#Calls c
	
	left outer join #Apps ap on c.CallDate = ap.CallDate
	and 
	c.Agent = ap.Agent
	and 
	c.[Description] = ap.[Description]

	ORDER BY
	c.CallDate,
	c.Agent,
	c.[Description]

	DROP TABLE #Apps
	DROP TABLE #Calls