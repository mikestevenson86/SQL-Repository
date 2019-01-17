
        SELECT	
				ncs.NVMStatsSF__Date__c DateOfCall, 
				u.Name AgentID,
				--u.DiallerFK__c AgentID
				SUM(ncs.NVMStatsSF__Number_of_Transfers__c) TransferOut,
				ISNULL(MAX(tr.Transfers), 0) TransferIn,
				SUM(ncs.NVMStatsSF__Agent_Consult_Time__c) ConsultOut,
				ISNULL(MAX(tr.Consult), 0) ConsultIn,
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
				left outer join	(
								SELECT u.DiallerFK__c, COUNT(ncs.Id) Transfers, SUM(NVMStatsSF__Agent_Consult_Time__c) Consult
								FROM Salesforce..NVMStatsSF__NVM_Call_Summary__c ncs
								left outer join Salesforce..[User] u ON ncs.NVMStatsSF__Agent2__c = u.Id
								WHERE NVMStatsSF__Date__c between '2017-10-11' and '2017-10-11'
								GROUP BY u.DiallerFK__c
								) tr ON u.DiallerFK__c = tr.DiallerFK__c
		WHERE
				ncs.NVMStatsSF__Date__c between '2017-10-11' and '2017-10-11'
				and
				u.Name is not null
				
		GROUP BY	
				ncs.NVMStatsSF__Date__c, 
				u.Name
				--u.DiallerFK__c
				
				ORDER BY u.Name