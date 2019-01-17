	SELECT LeadID
	INTO #Leads
	FROM Salesforce..CampaignMember cm
	inner join Salesforce..Campaign c ON cm.CampaignId = c.Id
	WHERE c.Name like 
	case when DATEPART(Month,@StartDate) = 1 then 'AFF_Care%'
	when DATEPART(Month,@StartDate) = 2 then 'AFF_Nurser%'
	when DATEPART(Month,@StartDate) = 3 then 'AFF_Education%'
	when DATEPART(Month,@StartDate) = 4 then 'AFF_Construction%'
	when DATEPART(Month,@StartDate) = 5 then 'AFF_Engineering%'
	when DATEPART(Month,@StartDate) = 6 then 'AFF_Vets%'
	when DATEPART(Month,@StartDate) = 7 then 'AFF_Cleaning%'
	when DATEPART(Month,@StartDate) = 8 then 'AFF_Funeral%pharmac%'
	when DATEPART(Month,@StartDate) = 9 then 'AFF_Construction%'
	when DATEPART(Month,@StartDate) = 10 then 'AFF_Manufactur%'
	when DATEPART(Month,@StartDate) = 11 then 'AFF_Horitcultur%'
	when DATEPART(Month,@StartDate) = 12 then 'AFF_Renew%' end
	GROUP BY LeadId

	SELECT l.LeadId, COUNT(seqno) Dials, SUM(case when call_type in (0,2,4) then 1 else 0 end) LiveConnects
	INTO #Calls
	FROM SalesforceReporting..call_history ch
	inner join #Leads l ON ch.lm_filler2 = l.LeadId
	WHERE act_date between @StartDate and @EndDate
	GROUP BY l.LeadId

	SELECT ls.LeadId, SUM(case when Date_Made__c between @StartDate and @EndDate then 1 else 0 end) Appointments
	INTO #Apps
	FROM Salesforce..Lead l
	inner join #Leads ls ON l.Id = ls.LeadId
	GROUP BY ls.LeadId

	SELECT 
	ls.LeadId [Id], 
	case when c.LeadId is not null then 1 else 0 end Dialled, 
	case when c.LeadId is not null then c.Dials else 0 end Dials, 
	case when c.LeadId is not null then c.LiveConnects else 0 end [Live Connects], 
	ap.Appointments
	FROM #Leads ls
	left outer join #Calls c ON ls.LeadId = c.LeadId
	left outer join #Apps ap ON ls.LeadId = ap.LeadId

	DROP TABLE #Leads
	DROP TABLE #Calls