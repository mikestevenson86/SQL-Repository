DECLARE @startDate as Date = '2017-10-02'
DECLARE @endDate as Date = '2017-10-02'
		
-- Call Stats
                
        SELECT	
				NVMStatsSF__Date__c as DateOfCall,
                u.DiallerFK__c AgentID,
                ISNULL(SUM(nvm.NVMStatsSF__Inbound_Call_Time__c), 0) + ISNULL(SUM(nvm.NVMStatsSF__Outbound_Call_Time__c), 0) AS TalkTime,
                ISNULL(SUM(nvm.NVMStatsSF__Ready_Time__c), 0) AS WaitTime,
                ISNULL(SUM(NVMStatsSF__Wrap_Up_Time__c), 0) AS WrapTime,
                ISNULL(SUM(nvm.NVMStatsSF__Away_Time__c), 0) + ISNULL(SUM(nvm.NVMStatsSF__Extended_Away_Time__c), 0) AS PauseTime,
                ISNULL(SUM(nvm.NVMStatsSF__Inbound_Call_Time__c), 0) +
                ISNULL(SUM(nvm.NVMStatsSF__Outbound_Call_Time__c), 0) +
                ISNULL(SUM(nvm.NVMStatsSF__Ready_Time__c), 0) +
                ISNULL(SUM(NVMStatsSF__Wrap_Up_Time__c), 0) +
                ISNULL(SUM(nvm.NVMStatsSF__Away_Time__c), 0) + 
                ISNULL(SUM(nvm.NVMStatsSF__Extended_Away_Time__c), 0) TotalTime,
                ISNULL(SUM(nvm.NVMStatsSF__Inbound_Call_Time__c), 0) +
                ISNULL(SUM(nvm.NVMStatsSF__Outbound_Call_Time__c), 0) +
                ISNULL(SUM(nvm.NVMStatsSF__Ready_Time__c), 0) +
                ISNULL(SUM(NVMStatsSF__Wrap_Up_Time__c), 0) TotalProductiveTime
        FROM	
				Salesforce..NVMStatsSF__NVM_Agent_Summary__c nvm
                inner join Salesforce..[User] u ON nvm.NVMStatsSF__Agent__c = u.Id
        WHERE	
				NVMStatsSF__Date__c between @startDate and @endDate
        GROUP BY 
				NVMStatsSF__Date__c,
                u.DiallerFK__c

-- Call Times

		SELECT	
				ncs.NVMStatsSF__Date__c DateOfCall, 
				u.DiallerFK__c AgentID,
				COUNT(ncs.Id) TotalConnects,
				SUM(case when	CallDurationInSeconds > 0 then 1 else 0 end) TotalLiveConnects,
				SUM(case when	t.CallbackDateTime__c is not null then 1 else 0 end) TotalCallbacksScheduled,
				SUM(case when	t.Status__c in ('Closed','Suspended') then 1 else 0 end) TotalClosedLost,
				SUM(case when	t.Status__c = 'Appointment' then 1 else 0 end) TotalClosedWon,
				SUM(case when	ISNULL(t.status__c, '') in ('Open','') then 1 else 0 end) TotalLeftOpen,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and ISNULL(t.status__c, '') in ('Open','') then 1 else 0 end) TotalOpenFromOpen,
				SUM(case when	t.Status__c = 'Callback Requested' 
								and CallDurationInSeconds < 0 then 1 else 0 end) CB_Anomalies,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and t.Status__c = 'Callback Requested' then 1 else 0 end) [Callbacks From Open],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and t.Status__c = 'Callback Requested' then 1 else 0 end)[Callbacks From Callbacks],
				SUM(case when	ncs.NVMStatsSF__After_Call_Work_Time__c > 180 then 1 else 0 end) WrapOverThree,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and CallDurationInSeconds < 30 then 1 else 0 end) [Less Than 30s],
				SUM(case when	t.NVMConnect__DialList__c is not null
								and CallDurationInSeconds >= 30 
								and CallDurationInSeconds  <= 179 then 1 else 0 end) [Between 30s and 3m],
				SUM(case when	t.NVMConnect__DialList__c is not null
								and CallDurationInSeconds >= 180  
								and CallDurationInSeconds  <= 420 then 1 else 0 end) [Between 3m and 7m],
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and CallDurationInSeconds  > 420 then 1 else 0 end) [Greater Than 7m],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and CallDurationInSeconds  < 30 then 1 else 0 end) [Callback Less Than 30s],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and CallDurationInSeconds >= 30 
								and CallDurationInSeconds <= 179 then 1 else 0 end) [Callback Between 30s and 3m],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and CallDurationInSeconds >= 180 
								and CallDurationInSeconds <= 420 then 1 else 0 end) [Callback Between 3m and 7m],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and CallDurationInSeconds > 420 then 1 else 0 end) [Callback Greater Than 7m],
				SUM(case when	t.NVMConnect__DialList__c is null then 1 else 0 end) ManualDials,
				SUM(case when	t.NVMConnect__DialList__c is not null then 1 else 0 end) DiallerDials,
				SUM(case when	t.NVMConnect__DialList__c is not null then 1 else 0 end) Cold,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and l.Affinity_Cold__c = 'Cold' then 1 else 0 end) ColdCold,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and l.Affinity_Cold__c like 'Affinity%' then 1 else 0 end) ColdAffinity,
				SUM(case when	t.NVMConnect__DialList__c is null then 1 else 0 end) Callback,
				SUM(case when	t.CallDurationInSeconds > 0 then 1 else 0 end) Total,
				SUM(case when	t.Suspended_Close__c = 'DM Callback' then 1 else 0 end) DMC,
				SUM(case when	t.Suspended_Close__c = 'None DM Callback' then 1 else 0 end) NonDMC
		FROM	
				Salesforce..NVMStatsSF__NVM_Call_Summary__c ncs
				left outer join Salesforce..[User] u ON ncs.NVMStatsSF__Agent__c = u.Id
				left outer join Salesforce..Task t ON ncs.NVMStatsSF__TaskID__c = t.Id
				left outer join Salesforce..Lead l ON ncs.NVMStatsSF__Related_Lead__c = l.Id
		WHERE	
				ncs.NVMStatsSF__Date__c between @startDate and @endDate
		GROUP BY	
				ncs.NVMStatsSF__Date__c, 
				u.DiallerFK__c

-- Pause Summary

/*
		SELECT
				call_date AS DateOfCall,
				tsr AS AgentID,
				ISNULL(SUM(case when pause_code not in ('BK1','LUN','BK2','PVWD') then pause_time else 0 end) ,0) pausetime,
				ISNULL(SUM(case when pause_code in ('BK1','LUN','BK2') then pause_time else 0 end) ,0) breaktime
		FROM
				SalesforceReporting..tskpauday

		GROUP BY
				call_date,
				TSR

		SELECT 
				call_date, 
				tsr, 
				COUNT(*) 'records'
		FROM 
				SalesforceReporting..tskpauday
		WHERE
				pause_code not in ('BK1','LUN','BK2','PVWD')
		GROUP BY 
				call_date, 
				tsr
*/

-- Populate Agent Hours

		SELECT 
				u.DiallerFK__c Agent
				,NVMStatsSF__Date__c CallDate
				,case when
				LEN(CONVERT(VarChar, DATEPART(Hour, MIN(nvm.CreatedDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Hour, MIN(nvm.CreatedDate)))
				else
				CONVERT(VarChar, DATEPART(Hour, MIN(nvm.CreatedDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Minute, MIN(nvm.CreatedDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Minute, MIN(nvm.CreatedDate)))
				else
				CONVERT(VarChar, DATEPART(Minute, MIN(nvm.CreatedDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Second, MIN(nvm.CreatedDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Second, MIN(nvm.CreatedDate)))
				else
				CONVERT(VarChar, DATEPART(Second, MIN(nvm.CreatedDate)))
				end FirstCall
				,case when
				LEN(CONVERT(VarChar, DATEPART(Hour, MAX(nvm.CreatedDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Hour, MAX(nvm.CreatedDate)))
				else
				CONVERT(VarChar, DATEPART(Hour, MAX(nvm.CreatedDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Minute, MAX(nvm.CreatedDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Minute, MAX(nvm.CreatedDate)))
				else
				CONVERT(VarChar, DATEPART(Minute, MAX(nvm.CreatedDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Second, MAX(nvm.CreatedDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Second, MAX(nvm.CreatedDate)))
				else
				CONVERT(VarChar, DATEPART(Second, MAX(nvm.CreatedDate)))
				end LastCall
		FROM 
				Salesforce..NVMStatsSF__NVM_Call_Summary__c nvm
				inner join Salesforce..[User] u ON nvm.NVMStatsSF__Agent__c = u.Id
		WHERE
				nvm.NVMStatsSF__Date__c between @startDate and @endDate
		GROUP BY
				u.DiallerFK__c,
				NVMStatsSF__Date__c
		ORDER BY
				Agent,
				CallDate
				
--Populate Agent Numbers

		SELECT
				NVMStatsSF__Date__c Calldate,
				COUNT(distinct NVMStatsSF__Agent__c) Agents	
		FROM
				Salesforce..NVMStatsSF__NVM_Agent_Summary__c
		WHERE
				NVMStatsSF__Date__c between @startDate and @endDate
		GROUP BY
				NVMStatsSF__Date__c
	
--Populate Last Appt stats

		SELECT
		u.DiallerFK__c,
		CONVERT(date, NVMStatsSF__Date__c) CallDate
		
		FROM
		Salesforce..NVMStatsSF__NVM_Agent_Summary__c nvm
		inner join Salesforce..[User] u ON nvm.NVMStatsSF__Agent__c = u.Id
		
		GROUP BY DiallerFK__c, NVMStatsSF__Date__c