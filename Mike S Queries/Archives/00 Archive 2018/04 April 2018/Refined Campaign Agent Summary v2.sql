DECLARE @LOCAL_StartDate as Date
DECLARE @LOCAL_EndDate as Date

SET @LOCAL_StartDate = '2018-04-18'
SET @LOCAL_EndDate = '2018-04-18'

        IF OBJECT_ID('tempdb..#CallStats') IS NOT NULL 
            BEGIN
                DROP TABLE #CallStats
            END
        IF OBJECT_ID('tempdb..#TimeStats') IS NOT NULL 
            BEGIN
                DROP TABLE #TimeStats
            END     
        IF OBJECT_ID('tempdb..#UniqueCallback') IS NOT NULL
			BEGIN
				DROP TABLE #UniqueCallback
			END
		IF OBJECT_ID('tempdb..#LogTimes') IS NOT NULL 
            BEGIN
                DROP TABLE #LogTimes
            END
        IF OBJECT_ID('tempdb..#LogDays') IS NOT NULL 
            BEGIN
                DROP TABLE #LogDays
            END
        IF OBJECT_ID('tempdb..#Appts') IS NOT NULL 
            BEGIN
                DROP TABLE #Appts
            END   
        IF OBJECT_ID('tempdb..#Out') IS NOT NULL 
            BEGIN
                DROP TABLE #Out
            END

      --Populate #TimeStats table

		SELECT	
                u.Id AgentID,
                ISNULL(SUM(t.NVMContactWorld__CallTalkTimeInSeconds__c), 0) AS TalkTime,
                ISNULL(SUM(t.NVMContactWorld__CallRingTimeInSeconds__c), 0) AS WaitTime,
                ISNULL(MAX(nvm.NVMStatsSF__Wrap_Up_Time__c), 0) AS WrapTime,
                ISNULL(MAX(nvm.NVMStatsSF__Away_Time__c), 0) + 
                ISNULL(MAX(nvm.NVMStatsSF__Extended_Away_Time__c), 0) AS PauseTime,
                ISNULL(SUM(t.NVMContactWorld__CallTalkTimeInSeconds__c), 0) +
                ISNULL(SUM(t.NVMContactWorld__CallRingTimeInSeconds__c), 0) +
                ISNULL(MAX(nvm.NVMStatsSF__Wrap_Up_Time__c), 0) +
                ISNULL(MAX(nvm.NVMStatsSF__Away_Time__c), 0) + 
                ISNULL(MAX(nvm.NVMStatsSF__Extended_Away_Time__c), 0) AS TotalTime,
                ISNULL(SUM(t.NVMContactWorld__CallTalkTimeInSeconds__c), 0) +
                ISNULL(SUM(t.NVMContactWorld__CallRingTimeInSeconds__c), 0) +
                ISNULL(MAX(NVMStatsSF__Wrap_Up_Time__c), 0) AS TotalProductiveTime
		INTO
				#TimeStats
        FROM	
				Salesforce..Task t
                left outer join Salesforce..[User] u ON t.OwnerId = u.Id
                left outer join Salesforce..NVMStatsSF__NVM_Agent_Summary__c nvm ON t.OwnerId = nvm.NVMStatsSF__Agent__c
																					and t.ActivityDate = nvm.NVMStatsSF__Date__c
        WHERE	
				t.ActivityDate between @LOCAL_StartDate and @LOCAL_EndDate
				and
				t.CallObject is not null
				and
				t.CallType in ('Inbound','Outbound')
				and 
				u.Department in ('Telemarketing','Contact Centre')
        GROUP BY 
                u.Id
                
      --Populate #CallStats table
      
        SELECT	
				u.Id AgentID,
				MAX(nas.Connects) TotalConnects,
				SUM(case when	t.NVMContactWorld__CallTalkTimeInSeconds__c > 0 then 1 else 0 end) TotalLiveConnects,
				SUM(case when	t.CallbackDateTime__c is not null then 1 else 0 end) TotalCallbacksScheduled,
				SUM(case when	t.Status__c in ('Closed','Suspended') and t.NVMConnect__DialList__c is not null then 1 else 0 end) DiallerClosedLost,
				SUM(case when	t.Status__c in ('Closed','Suspended') and t.NVMConnect__DialList__c is null then 1 else 0 end) CallbackClosedLost,
				SUM(case when	t.Status__c = 'Appointment' and t.NVMConnect__DialList__c is not null  then 1 else 0 end) DiallerClosedWon,
				SUM(case when	t.Status__c = 'Appointment' and t.NVMConnect__DialList__c is null then 1 else 0 end) CallbackClosedWon,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and ISNULL(t.status__c, '') in ('Open','') then 1 else 0 end) TotalOpenFromOpen,
				SUM(case when	t.NVMConnect__DialList__c is null 
								and ISNULL(t.status__c, '') in ('Open','') then 1 else 0 end) TotalOpenFromCallback,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and t.Status__c = 'Callback Requested' then 1 else 0 end) [Callbacks From Open],
				SUM(case when	t.NVMConnect__DialList__c is not null
								and t.NVMContactWorld__CallTalkTimeInSeconds__c >= 30 
								and t.NVMContactWorld__CallTalkTimeInSeconds__c  <= 179 then 1 else 0 end) [Between 30s and 3m],
				SUM(case when	t.NVMConnect__DialList__c is not null
								and t.NVMContactWorld__CallTalkTimeInSeconds__c >= 180  
								and t.NVMContactWorld__CallTalkTimeInSeconds__c  <= 420 then 1 else 0 end) [Between 3m and 7m],
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and t.NVMContactWorld__CallTalkTimeInSeconds__c  > 420 then 1 else 0 end) [Greater Than 7m],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and t.NVMContactWorld__CallTalkTimeInSeconds__c >= 30 
								and t.NVMContactWorld__CallTalkTimeInSeconds__c <= 179 then 1 else 0 end) [Callback Between 30s and 3m],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and t.NVMContactWorld__CallTalkTimeInSeconds__c >= 180 
								and t.NVMContactWorld__CallTalkTimeInSeconds__c <= 420 then 1 else 0 end) [Callback Between 3m and 7m],
				SUM(case when	t.NVMConnect__DialList__c is null 
								and t.NVMContactWorld__CallTalkTimeInSeconds__c > 420 then 1 else 0 end) [Callback Greater Than 7m],
				SUM(case when	t.NVMConnect__DialList__c is not null then 1 else 0 end) Cold,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and l.Affinity_Cold__c = 'Cold' then 1 else 0 end) ColdCold,
				SUM(case when	t.NVMConnect__DialList__c is not null 
								and l.Affinity_Cold__c like 'Affinity%' then 1 else 0 end) ColdAffinity,
				SUM(case when	t.NVMConnect__DialList__c is null then 1 else 0 end) Callback,
				SUM(case when	t.Suspended_Close__c = 'DM Callback' then 1 else 0 end) DMC,
				SUM(case when	t.Suspended_Close__c = 'None DM Callback' then 1 else 0 end) NonDMC
		INTO
				#CallStats
		FROM	
				Salesforce..Task t
				left outer join Salesforce..NVMStatsSF__NVM_Call_Summary__c ncs ON t.Id = ncs.NVMStatsSF__TaskID__c
				left outer join Salesforce..[User] u ON t.OwnerId = u.Id
				left outer join Salesforce..Lead l ON t.WhoId = l.Id
				left outer join	(
									SELECT t.ActivityDate, t.OwnerId, COUNT(t.Id) Connects 
									FROM Salesforce..Task t
									WHERE ActivityDate between @LOCAL_StartDate and @LOCAL_EndDate 
									and CallType in ('Inbound','Outbound') 
									and CallObject is not null
									GROUP BY t.ActivityDate, t.OwnerId
								) nas ON t.OwnerId = nas.OwnerId
										and ncs.NVMStatsSF__Date__c = nas.ActivityDate
		WHERE	
				t.ActivityDate between @LOCAL_StartDate and @LOCAL_EndDate
				and
				CallObject is not null
				and
				CallType in ('Inbound','Outbound')
				and 
				u.Department in ('Telemarketing','Contact Centre')
		GROUP BY	
				u.Id

	  --Populate unique callback 2 callback
	  
	    SELECT	
				u.Id AgentID,
				COUNT(distinct l.Id) [Callbacks From Callbacks]
		INTO
				#UniqueCallback
		FROM	
				Salesforce..Task t
				left outer join Salesforce..[User] u ON t.OwnerId = u.Id
				left outer join Salesforce..Lead l ON t.WhoId = l.Id
		WHERE	
				t.ActivityDate between @LOCAL_StartDate and @LOCAL_EndDate
				and t.NVMConnect__DialList__c is null 
				and t.Status__c = 'Callback Requested'
				and t.WhoId like '00QD%'
		GROUP BY	
				u.Id

	  --Populate Agent Hours
	  
		SELECT 
				u.ID Agent
				,case when
				LEN(CONVERT(VarChar, DATEPART(Hour, MIN(t.ActivityDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Hour, MIN(t.ActivityDate)))
				else
				CONVERT(VarChar, DATEPART(Hour, MIN(t.ActivityDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Minute, MIN(t.ActivityDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Minute, MIN(t.ActivityDate)))
				else
				CONVERT(VarChar, DATEPART(Minute, MIN(t.ActivityDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Second, MIN(t.ActivityDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Second, MIN(t.ActivityDate)))
				else
				CONVERT(VarChar, DATEPART(Second, MIN(t.ActivityDate)))
				end FirstCall
				,case when
				LEN(CONVERT(VarChar, DATEPART(Hour, MAX(t.ActivityDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Hour, MAX(t.ActivityDate)))
				else
				CONVERT(VarChar, DATEPART(Hour, MAX(t.ActivityDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Minute, MAX(t.ActivityDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Minute, MAX(t.ActivityDate)))
				else
				CONVERT(VarChar, DATEPART(Minute, MAX(t.ActivityDate)))
				end
				+
				case when
				LEN(CONVERT(VarChar, DATEPART(Second, MAX(t.ActivityDate)))) = 1 
				then
				'0'+CONVERT(VarChar, DATEPART(Second, MAX(t.ActivityDate)))
				else
				CONVERT(VarChar, DATEPART(Second, MAX(t.ActivityDate)))
				end LastCall
		INTO
				#LogTimes
		FROM 
				Salesforce..Task t
				inner join Salesforce..[User] u ON t.OwnerId = u.Id
		WHERE
				t.ActivityDate between @LOCAL_StartDate and @LOCAL_EndDate
				and t.CallObject is not null
				and t.CallType in ('Inbound','Outbound')
				and u.Department in ('Telemarketing','Contact Centre')
		GROUP BY
				u.Id

	  --Populate Log Days
	  
		SELECT
				OwnerId UserId,
				COUNT(distinct CONVERT(date, CreatedDate)) LogDays
	    INTO
				#LogDays
	    FROM
				Salesforce..Task
	    WHERE 
				CONVERT(date, CreatedDate) between @LOCAL_StartDate and @LOCAL_EndDate
	    GROUP BY
				OwnerId

		-- Populate Appointments
      
        SELECT 
				U.Id UserId,
				COUNT(l.Id) TMSAppointments
		INTO
				#Appts
		FROM 
				Salesforce..Lead l
				left outer join Salesforce..[User] u ON l.BDC__c = u.Id
				left outer join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
				left outer join Salesforce..[Profile] p ON u.ProfileId = p.Id 
		WHERE 
				CONVERT(date, l.Date_Made__c) between @LOCAL_StartDate and @LOCAL_EndDate
				and 
				ISNULL(RecordTypeId, '') not in ('012D0000000NbJtIAK','')
				and 
				p.Name = 'Business Solutions Team'
				and 
				(
					MADE_Criteria__c like '%1%' 
					or 
					MADE_Criteria__c like '%2%'
					or 
					MADE_Criteria__c like '%4%' 
					or 
					MADE_Criteria__c = 'Seminars - Appointment' 
					or 
					MADE_Criteria__c = 'Outbound - 3' 
					or 
					MADE_Criteria__c = 'Outbound Marketing - 3' 
					or 
					MADE_Criteria__c = 'Seminar Appointment 3'
				) 
				and 
				MADE_Criteria__c not like '%seminar registered%' 
				and 
				ISNULL(LeadSource, '') <> 'CGHT' 
				and 
				ISNULL(uMan.Name, '') <> 'Peter Sherlock' 
		GROUP BY 
				u.Id
				
      --Build Call Staging Ground
      
        SELECT  
				case when u.Id is null or uman.name = 'Jo Wood' then 'No Manager' else uman.Name end AS TeamManager ,
				u.Id UserId,
				uMan.Id UserManagerId,
                case when u.Id is null then 'No Agent' else u.name end AS AgentName ,
                u.IsActive,
                uMan.IsActive ManagerActive,
                c.TalkTime ,
                c.WaitTime,
                c.PauseTime,
                c.WrapTime,
                c.TotalTime,
                c.TotalProductiveTime,
                ISNULL(t.TotalConnects, 0) AS TotalConnects ,
                ISNULL(t.TotalLiveConnects, 0) AS TotalLiveConnects ,
                t.TotalOpenFromCallback ,
                t.TotalOpenFromOpen ,
                t.TotalCallbacksScheduled AS TotalCallbacksScheduled ,
                t.DiallerClosedLost AS DiallerClosedLost ,
                t.CallbackClosedLost AS CallbackClosedLost ,
                t.DiallerClosedWon AS DiallerClosedWon ,
                t.CallbackClosedWon AS CallbackClosedWon ,
                t.[Callbacks From Open],
                uc.[Callbacks From Callbacks],
                a.TMSAppointments,
                la.LastAppt,
                la.WorkDays,
                ISNULL(t.Cold,0) Cold,
                ISNULL(t.ColdCold,0) ColdCold,
                ISNULL(t.ColdAffinity,0) ColdAffinity,
				ISNULL(t.Callback,0) Callback,
				ISNULL(t.DMC,0) DMC,
				ISNULL(t.NonDMC,0) NonDMC,
				ISNULL(t.[Between 30s and 3m],0) [Between 30s and 3],
				ISNULL(t.[Between 3m and 7m],0) [Between 3m and 7m],
				ISNULL(t.[Greater Than 7m],0) [Greater Than 7m],
				ISNULL(t.[Callback Between 30s and 3m],0) [Callback Between 30s and 3],
				ISNULL(t.[Callback Between 3m and 7m],0) [Callback Between 3m and 7m],
				ISNULL(t.[Callback Greater Than 7m],0) [Callback Greater Than 7m],
				ISNULL(ld.LogDays, 0) LogDays,
				case when u.CreatedDate <= GETDATE()-183 then 1 else 0 end AgentAge
        FROM    
				Salesforce..[User] u
				LEFT OUTER JOIN #CallStats AS t ON u.Id = t.AgentID
                LEFT OUTER JOIN #TimeStats AS c ON t.AgentID = c.AgentID
                LEFT OUTER JOIN #LogDays As ld ON t.AgentID = ld.UserId
                LEFT OUTER JOIN #UniqueCallback uc ON t.AgentID = uc.AgentID
                LEFT OUTER JOIN #Appts a ON u.Id = a.UserId
                LEFT OUTER JOIN SalesforceReporting..CampaignAgent_LastAppts la ON u.Id = la.Id
                LEFT OUTER JOIN Salesforce..[User] uMan ON u.ManagerId = uMan.id
                LEFT OUTER JOIN Salesforce..[Profile] p ON u.ProfileId = p.Id and p.Name = 'Business Solutions Team'
                LEFT OUTER JOIN Salesforce..[Profile] pMan ON uMan.ProfileId = pMan.Id and pMan.Name in ('Citation Contact Centre Manager','Citation Data Quality & Diary Mgmt (inc MI)')	
		WHERE	
				u.Name not in ('Justin Robinson','Matthew Walker','Alicia Roebuck','Emma Barnes')
				and
				(
					t.AgentID is not null
					or
					a.UserId is not null
				)