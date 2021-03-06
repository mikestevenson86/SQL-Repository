IF OBJECT_ID('tempdb..#Onboards') IS NOT NULL
	BEGIN
		DROP TABLE #Onboards
	END

SELECT clientId, MIN(dealId) Start
INTO #Onboards
FROM Shorthorn..cit_sh_deals ds
GROUP BY clientID

SELECT COUNT(distinct cl.clientId) ActiveClients
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
inner join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
inner join #Onboards o ON ds.dealID = o.Start
WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18) and bs.title = 'Construction'

SELECT DATEPART(Year, signDate)YearSigned, COUNT(distinct cl.clientId) OnboardedClients
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
inner join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
inner join #Onboards o ON ds.dealID = o.Start
WHERE dealStatus not in (2,5,18) and bs.title = 'Construction' and CONVERT(date, ds.renewDate) = CONVERT(date, ds.OriginalRenewDate)
and DATEPART(Year, signDate) >= 2011
GROUP BY DATEPART(Year, signDate)
ORDER BY DATEPART(Year, signDate)

SELECT DATEPART(Month, signDate)MonthSigned, COUNT(distinct cl.clientId) OnboardedClients
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
inner join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
inner join #Onboards o ON ds.dealID = o.Start
WHERE dealStatus not in (2,5,18) and bs.title = 'Construction' and CONVERT(date, ds.renewDate) = CONVERT(date, ds.OriginalRenewDate)
and DATEPART(Year, signDate) = 2017
GROUP BY DATEPART(Month, signDate)
ORDER BY DATEPART(Month, signDate)

DROP TABLE #Onboards