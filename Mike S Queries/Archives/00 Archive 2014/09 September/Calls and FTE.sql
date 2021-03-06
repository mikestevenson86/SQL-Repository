		SELECT 
		call_date,
		tsr
		
		INTO 
		#Agents
		
		FROM
		(
		SELECT 
		call_date, 
		tsr
		
		FROM 
		SalesforceReporting..tsktsrday tsr
		
			inner join Salesforce..[User] u ON tsr.tsr = u.DiallerFK__c 
			and 
			u.Department = 'Telemarketing'
			
			inner join Salesforce..[User] u2 ON u.ManagerId collate latin1_general_CS_AS = u2.Id collate latin1_general_CS_AS
			
		WHERE 
		call_date >= '2014-06-01'
		and
		u2.Name <> 'Jo Wood'
		
		GROUP BY 
		call_date,
		tsr
		
		UNION
		
		SELECT 
		call_date, 
		tsr
		
		FROM 
		enterprise.[dbo].[tsktsrday] tsr
		
			inner join Salesforce..[User] u ON tsr.tsr = u.DiallerFK__c 
			and 
			u.Department = 'Telemarketing'
			
			inner join Salesforce..[User] u2 ON u.ManagerId collate latin1_general_CS_AS = u2.Id collate latin1_general_CS_AS
		
		WHERE 
		call_date >= '2014-06-01'
		and
		u2.Name <> 'Jo Wood'
		
		GROUP BY 
		call_date,
		tsr) detail
		
		GROUP BY 
		call_date,
		tsr
		
		SELECT 
		call_date CallDate, 
		COUNT(*) Agents
		
		INTO 
		#AgentCounts
		
		FROM 
		#Agents
		
		GROUP BY 
		call_date
		
		SELECT 
		act_date CallDate, 
		SUM(Calls) Calls
		
		INTO 
		#CallCounts
		
		FROM
		(
		SELECT 
		act_date, 
		COUNT(seqno) Calls
		
		FROM SalesforceReporting..call_history ch
		
			inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c 
			and 
			u.Department = 'Telemarketing' 
			
			inner join Salesforce..[User] u2 ON u.ManagerId collate latin1_general_CS_AS = u2.Id collate latin1_general_CS_AS
		
		WHERE 
		call_type in (0,2,4) 
		and 
		act_date >= '2014-06-01'
		and
		u2.Name <> 'Jo Wood'
		
		GROUP BY 
		act_date
		
		UNION
		
		SELECT 
		act_date, 
		COUNT(seqno) Calls
		
		FROM 
		Enterprise..call_history ch
		
			inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c 
			and 
			u.Department = 'Telemarketing' 
			
			inner join Salesforce..[User] u2 ON u.ManagerId collate latin1_general_CS_AS = u2.Id collate latin1_general_CS_AS
		
		WHERE 
		call_type in (0,2,4) 
		and 
		act_date >= '2014-06-01'
		and
		u2.Name <> 'Jo Wood'
		
		GROUP BY 
		act_date) detail
		
		GROUP BY
		act_date
		
		SELECT 
		date_made__c DateMade, 
		SUM(case when Made_Criteria__c in ('Outbound - 1','Outbound - 2') then 1 else 0 end) Crit,
		SUM(case when Made_Criteria__c = 'Outbound - 4' then 1 else 0 end) NonCrit
		
		INTO
		#Appts
		
		FROM 
		Salesforce..Lead l
			inner join Salesforce..[User] u ON l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS 
			and 
			u.Department = 'Telemarketing' 
			
			inner join Salesforce..[User] u2 ON u.ManagerId collate latin1_general_CS_AS = u2.Id collate latin1_general_CS_AS
		
		WHERE 
		Date_Made__c >= '2014-06-01' 
		and 
		MADE_Criteria__c in ('Outbound - 1','Outbound - 2','Outbound - 4')
		and
		u2.Name <> 'Jo Wood'
		
		GROUP BY 
		Date_Made__c
		
		SELECT 
		CONVERT(date, ac.Calldate) [Call Date], 
		ac.Agents, 
		cc.Calls, 
		ap.Crit, 
		ap.NonCrit [Non-Crit]
		
		FROM
		#AgentCounts ac
		left outer join #CallCounts cc ON ac.CallDate = cc.CallDate
		left outer join #Appts ap ON ac.CallDate = ap.DateMade
		
		ORDER BY
		[Call Date]
		
		DROP TABLE #Agents
		DROP TABLE #AgentCounts
		DROP TABLE #CallCounts
		DROP TABLE #Appts