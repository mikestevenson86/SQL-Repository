-- Declare dates
		
		DECLARE @Start as Date
		DECLARE @End as Date
		
		SET @Start = DATEADD(wk, DATEDIFF(wk, 0,GETDATE())-1,0)
		SET @End = DATEADD(wk, DATEDIFF(wk, 0,GETDATE())-1,4) --CONVERT(date, DATEADD(d, -((DATEPART(weekday, GETDATE()) + 1 + @@DATEFIRST) % 7), GETDATE()))

-- Staging Table 1: Visits

		SELECT 
		Email, 
		CONVERT(date, VisitDate) VisitDate, 
		COUNT(*) Visits
		
		INTO 
		#Visits
		
		FROM
		(
			SELECT u.email, ev.dueDate VisitDate, cl.CompanyName, s.postcode, 'Extra' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_HSExtraVisits ev
			inner join [database].Shorthorn.dbo.cit_sh_users u ON ev.consultant = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON ev.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, ev.dueDate) between @Start and @End-- and ev.visitDate is not null
				UNION
			SELECT u.email, hs.installdatebook VisitDate, cl.companyName, s.postcode, 'Install' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
			inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.installConID = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, hs.installdatebook) between @Start and @End and hs.dateInstalled is not null
				UNION
			SELECT u.email, visit1book VisitDate, cl.CompanyName, s.postcode, '1st' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
			inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit1conID = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, visit1book) between @Start and @End and hs.firstVisit is not null 
				UNION
			SELECT u.email, visit2book VisitDate, cl.CompanyName, s.postcode, '2nd' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
			inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
			inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit2conID = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, visit2book) between @Start and @End and hs.secVisit is not null
				UNION
			SELECT u.email, visit3book VisitDate, cl.CompanyName, s.postcode, '3rd' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
			inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
			inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit3conID = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, visit3book) between @Start and @End and hs.thirVisit is not null
				UNION
			SELECT u.email, visit4book VisitDate, cl.CompanyName, s.postcode, '4th' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
			inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
			inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit4conID = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, visit4book) between @Start and @End and hs.fourthVisit is not null
				UNION
			SELECT u.email, visit5book VisitDate, cl.CompanyName, s.postcode, '5th' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
			inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
			inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit5conID = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, visit5book) between @Start and @End and hs.fifthVisit is not null
				UNION
			SELECT u.email, visit6book VisitDate, cl.CompanyName, s.postcode, '6th' VisitNo
			FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
			inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
			inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit6conID = u.userID
			inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
			inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
			WHERE CONVERT(date, visit6book) between @Start and @End and hs.sixthVisit is not null
		) detail
		
		GROUP BY 
		Email, CONVERT(date, VisitDate)

-- Staging Table 3: Weeks Visits Totals

		SELECT 
		hsu.email, 
		ISNULL(mon.Visits, 0) Monday, 
		ISNULL(tue.Visits, 0) Tuesday, 
		ISNULL(wed.Visits, 0) Wednesday, 
		ISNULL(thu.Visits, 0) Thursday, 
		ISNULL(fri.Visits, 0) Friday,
		ISNULL(mon.Visits, 0) + ISNULL(tue.Visits, 0) + ISNULL(wed.Visits, 0) + ISNULL(thu.Visits, 0) + ISNULL(fri.Visits, 0) TotalVisits
		 
		INTO 
		#AllVisits
		 
		FROM 
		SalesforceReporting..HS_Users hsu
		left outer join 
		(
		SELECT email, CONVERT(int, Visits) Visits FROM #Visits WHERE VisitDate = DATEADD(wk, DATEDIFF(wk, 0,GETDATE())-1,0)
		) mon ON hsu.email = mon.email
		left outer join 
		(
		SELECT email, CONVERT(int, Visits) Visits FROM #Visits WHERE VisitDate = DATEADD(wk, DATEDIFF(wk, 0,GETDATE())-1,1)
		) tue ON hsu.email = tue.email
		left outer join 
		(
		SELECT email, CONVERT(int, Visits) Visits FROM #Visits WHERE VisitDate = DATEADD(wk, DATEDIFF(wk, 0,GETDATE())-1,2)
		) wed ON hsu.email = wed.email
		left outer join 
		(
		SELECT email, CONVERT(int, Visits) Visits FROM #Visits WHERE VisitDate = DATEADD(wk, DATEDIFF(wk, 0,GETDATE())-1,3)
		) thu ON hsu.email = thu.email
		left outer join 
		(
		SELECT email, CONVERT(int, Visits) Visits FROM #Visits WHERE VisitDate = DATEADD(wk, DATEDIFF(wk, 0,GETDATE())-1,4)
		) fri ON hsu.email = fri.email
		
-- Staging Table 3: Activity

		SELECT
		hsa.*,
		hsu.Email,
		hsa.NormalWorkingDays - hsa.Holidays - hsa.Sickness - hsa.Helpline - hsa.OtherMeetings - hsa.AdminDays ThisWorkingWeek,
		hsa.FirstVisits + hsa.InstallVisits + hsa.AnnualVisits + hsa.ExtraContractual + hsa.OtherExtraVisits TotalSAT,
		hsa.FirstVisits + hsa.InstallVisits + hsa.AnnualVisits + hsa.ExtraContractual + hsa.OtherExtraVisits 
		+ hsa.ArrCancelled + hsa.DayCancelled [Sat + COA/COD]
		
		INTO
		#HSActivity
		
		FROM
		SalesforceReporting..HS_Activity hsa
		left outer join SalesforceReporting..HS_Users hsu ON hsa.Consultant = hsu.FullName
		
		WHERE
		RunDate = @End
		
-- Final Resultset

		SELECT 
		hsu.FullName Consultant,  
		hsu.Diary,
		hsu.Team,
		hsu.[Role],
		hsu.FTE,
		av.Monday, 
		av.Tuesday, 
		av.Wednesday, 
		av.Thursday, 
		av.Friday,
		CONVERT(int, NormalWorkingDays) NormalWorkingWeek,
		hsa.ThisWorkingWeek,
		case when hsa.ThisWorkingWeek > 0 then CONVERT(decimal (18,2),av.TotalVisits/hsa.ThisWorkingWeek) else 0 end AverageVisits,
		CONVERT(decimal (18,2),hsa.ThisWorkingWeek) * 2 [Target],
		av.TotalVisits ActualVisits,
		CONVERT(decimal (18,2),hsa.ThisWorkingWeek) * 2 - CONVERT(decimal (18,2),av.TotalVisits) [Difference],
		hsa.Holidays DaysOnHoliday,
		hsa.Sickness DaysOffSick,
		hsa.Helpline DaysOnHelpline,
		hsa.OtherMeetings OtherNoVisitDays,
		hsa.AdminDays,
		hsa.FirstVisits,
		hsa.InstallVisits,
		hsa.AnnualVisits,
		hsa.ExtraContractual,
		hsa.OtherExtraVisits,
		hsa.TotalSAT,
		hsa.ArrCancelled COA,
		hsa.DayCancelled COD,
		hsa.[Sat + COA/COD],
		hsa.[Sat + COA/COD] - (CONVERT(decimal (18,2),hsa.ThisWorkingWeek) * 2) TargetAchieved,
		case when (hsa.TotalSAT + hsa.ArrCancelled + hsa.DayCancelled) - (CONVERT(decimal (18,2),hsa.ThisWorkingWeek) * 2) >= 0 
		then 'Yes' else 'No' end [Target Achieved with COD Included],
		ROW_NUMBER () OVER (ORDER BY [Sat + COA/COD] DESC) [Rank]
		
		FROM
		SalesforceReporting..HS_Users hsu
		left outer join Salesforce..[User] u ON hsu.FullName = u.Name
		left outer join #HSActivity hsa ON hsu.FullName = hsa.Consultant 
		left outer join #AllVisits av ON u.Email = av.email

		WHERE 
		IsActive = 'true' 
		and
		hsu.Manager = 0
		and 
		hsa.ID is not null

		ORDER BY 
		hsu.FullName

DROP TABLE #Visits
DROP TABLE #AllVisits
DROP TABLE #HSActivity