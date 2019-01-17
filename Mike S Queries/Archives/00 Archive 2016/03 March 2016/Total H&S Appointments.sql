		SELECT fullname, CONVERT(date, VisitDate) VisitDate, COUNT(*) Appts
		FROM
		(
		SELECT u.fullName, ev.dueDate VisitDate, cl.CompanyName, s.postcode, 'Extra' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_HSExtraVisits ev
		inner join [database].Shorthorn.dbo.cit_sh_users u ON ev.consultant = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON ev.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, ev.dueDate))  = DATEPART(Year, GETDATE())
		UNION
		SELECT u.fullName, hs.installdatebook VisitDate, cl.companyName, s.postcode, 'Install' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.installConID = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, hs.installdatebook))  = DATEPART(Year, GETDATE())
		UNION
		SELECT u.fullName, visit1book VisitDate, cl.CompanyName, s.postcode, '1st' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit1conID = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, visit1book))  = DATEPART(Year, GETDATE())
		UNION
		SELECT u.fullName, visit2book VisitDate, cl.CompanyName, s.postcode, '2nd' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
		inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
		inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit2conID = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, visit2book))  = DATEPART(Year, GETDATE())
		UNION
		SELECT u.fullName, visit3book VisitDate, cl.CompanyName, s.postcode, '3rd' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
		inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
		inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit3conID = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, visit3book)) = DATEPART(Year, GETDATE())
		UNION
		SELECT u.fullName, visit4book VisitDate, cl.CompanyName, s.postcode, '4th' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
		inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
		inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit4conID = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, visit4book)) = DATEPART(Year, GETDATE())
		UNION
		SELECT u.fullName, visit5book VisitDate, cl.CompanyName, s.postcode, '5th' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
		inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
		inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit5conID = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, visit5book)) = DATEPART(Year, GETDATE())
		UNION
		SELECT u.fullName, visit6book VisitDate, cl.CompanyName, s.postcode, '6th' VisitNo
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS hs
		inner join [database].Shorthorn.dbo.cit_sh_deals d ON hs.dealID = d.dealID
		inner join [database].Shorthorn.dbo.cit_sh_users u ON hs.visit6conID = u.userID
		inner join [database].Shorthorn.dbo.cit_sh_sites s ON hs.siteID = s.siteID
		inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
		WHERE DATEPART(Year, CONVERT(date, visit6book)) = DATEPART(Year, GETDATE())
		) detail
		GROUP BY CONVERT(date, VisitDate), fullname
		ORDER BY VisitDate, fullname