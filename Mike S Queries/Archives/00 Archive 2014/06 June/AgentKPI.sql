		SELECT
        tsr AS AgentID ,
        ISNULL(SUM(time_connect), 0) AS TalkTime ,
        ISNULL(SUM(time_acw), 0) AS WrapTime ,
        ISNULL(SUM(time_waiting + time_deassigned), 0) AS DNDTime ,
        ISNULL(SUM(time_connect + time_waiting + time_deassigned + time_acw + time_paused), 0) AS TotalTime
        
        INTO
        #CallStats
        
        FROM    
        [Enterprise].[dbo].tsktsrday AS t
        
        WHERE   
        CONVERT(date,t.call_date) = '2014-05-30'
        
        GROUP BY 
        call_date, tsr
                
        SELECT 
        ch.tsr AgentID,
        SUM(case when time_connect < 30 and call_type in (0,2,4) then 1 else 0 end) [Less Than 30s],
        SUM(case when time_connect between 30 and 179 and call_type in (0,2,4) then 1 else 0 end) [Between 30s and 3m],
        SUM(case when time_connect between 180 and 420 and call_type in (0,2,4) then 1 else 0 end) [Between 3m and 7m],
        SUM(case when time_connect > 420 and call_type in (0,2,4) then 1 else 0 end) [Greater Than 7m],
        SUM(case when call_type in (0,2) then 1 else 0 end) Cold,
        SUM(case when call_type = 4 then 1 else 0 end) Callback,
        SUM(Case when call_type in (0,2,4) then 1 else 0 end) Total
        
        INTO
        #TimeStats
        
        FROM 
        Enterprise..call_history ch
        
        WHERE 
        CONVERT(date,act_date) = '2014-05-30'
        
        GROUP BY 
        ch.act_date,tsr
        
        SELECT 
		u.Name Agent,
		SUM(case when l.MADE_Criteria__c in ('Outbound - 1','Outbound - 2') then 1 else 0 end) Crit,
		SUM(case when l.MADE_Criteria__c = 'Outbound - 4' then 1 else 0 end) NonCrit
		
		INTO
		#Appts

		FROM 
		Salesforce..Lead l
		inner join Salesforce..[User] u on l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
		inner join Salesforce..[Profile] p on u.ProfileId collate latin1_general_CS_AS = p.Id collate latin1_general_CS_AS

		WHERE 
		
		l.MADE_Criteria__c in ('Outbound - 1','Outbound - 2','Outbound - 4')
		and
		CONVERT(date,l.Date_Made__c) = '2014-05-30'

		GROUP BY
		u.Name
        
        SELECT 
        u.Name Agent, 
        u2.Name Manager,
        ISNULL(ts.Cold,0) Cold,
        ISNULL(ts.Callback,0) Callback,
        ISNULL(ts.Total,0) Total,
        ISNULL(ts.[Less Than 30s],0) [Less Than 30s],
        ISNULL(ts.[Between 30s and 3m],0) [Between 30s and 3],
        ISNULL(ts.[Between 3m and 7m],0) [Between 3m and 7m],
        ISNULL(ts.[Greater Than 7m],0) [Greater Than 7m],
        LEFT(ISNULL(ROUND((CONVERT(decimal(10,2),cs.TalkTime)/CONVERT(decimal(10,2),cs.TotalTime))*100,2),0),5) [Talk Time],
        LEFT(ISNULL(ROUND((CONVERT(decimal(10,2),cs.WrapTime)/CONVERT(decimal(10,2),cs.TotalTime))*100,2),0),5) [Wrap Time],
        LEFT(ISNULL(ROUND((CONVERT(decimal(10,2),cs.DNDTime)/CONVERT(decimal(10,2),cs.TotalTime))*100,2),0),5) [DND Time],
        ISNULL(ap.Crit,0) [Crit Appts],
        ISNULL(ap.NonCrit,0) [Non-Crit Appts]
        
        FROM Salesforce..[User] u
        inner join Salesforce..[User] u2 on u.ManagerId collate latin1_general_CS_AS = u2.Id collate latin1_general_CS_AS
        inner join Salesforce..[Profile] pr on u.ProfileId collate latin1_general_CS_AS = pr.Id collate latin1_general_CS_AS
        inner join SalesforceReporting..BDCTSR bdc on u.Name = bdc.SFBDC
        left outer join #CallStats cs on bdc.NOBSTR = cs.AgentID
        left outer join #TimeStats ts on bdc.NOBSTR = ts.AgentID
        left outer join #Appts ap on u.Name = ap.Agent
        
        WHERE 
        pr.Name = 'Citation BDC' 
        and 
        u.IsActive = 'true'
        
        ORDER BY 
        u2.Name, 
        u.Name
        
        DROP TABLE #Appts
        DROP TABLE #CallStats
        DROP TABLE #TimeStats