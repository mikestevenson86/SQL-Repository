IF OBJECT_ID('tempdb..#Dates') IS NOT NULL
	BEGIN
		DROP TABLE #Dates
	END
IF OBJECT_ID('tempdb..#Deals') IS NOT NULL
	BEGIN
		DROP TABLE #Deals
	END
IF OBJECT_ID('tempdb..#LastRenew') IS NOT NULL
	BEGIN
		DROP TABLE #LastRenew
	END
IF OBJECT_ID('tempdb..#FirstStart') IS NOT NULL
	BEGIN
		DROP TABLE #FirstStart
	END

DECLARE @Start as Date

SET @Start = '2015-01-01'

CREATE TABLE #Dates
(
MonthStart Date
)
 
WHILE @Start < '2017-04-01'
BEGIN

	INSERT INTO #Dates
	(MonthStart) VALUES (@Start)

	SET @Start = DATEADD(month,1,@Start)
	
END

SELECT ds.clientId, dealID, signDate, renewDate, originalrenewdate, dealstatus, dealtype, cl.Active, ds.enabled, ROW_NUMBER () OVER (PARTITION BY ds.clientId ORDER BY signDate) rn
INTO #Deals
FROM Shorthorn..cit_sh_deals ds
inner join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID

SELECT dn1.dealID, 
case when dn2.renewDate >= dn2.OriginalRenewDate and dn2.dealType <> dn1.dealType and dn2.signDate <= GETDATE() and dn2.renewDate > GETDATE() and dn2.dealStatus not in (2,5,10,18) then 'Upsell'
when dn1.rn = 1 and dn1.dealStatus not in (12,15) then 'New'
when dn2.renewDate < dn2.OriginalRenewDate and dn2.dealType <> dn1.dealType then 'Early Renewal_Upsell'
when dn2.renewDate < dn2.OriginalRenewDate then 'Early Renewal' else 'Renewal' end SignReason
INTO #SignReasons
FROM #Deals dn1
LEFT outer join #Deals dn2 ON dn1.clientId = dn2.clientId and dn1.rn-1 = dn2.rn

SELECT clientId, MAX(de.RenewDate) LastRenew
INTO #LastRenew
FROM #Deals de
GROUP BY clientId

SELECT clientId, MIN(de.SignDate) FirstStart
INTO #FirstStart
FROM #Deals de
GROUP BY clientId

SELECT 
MonthStart,
SUM(ActiveStart) ActiveStart,
SUM(Renewed) Renewed,
SUM(Expired) Expired,
SUM(WrittenOff) WrittenOff,
SUM(MonthNew) MonthNew,
SUM(ClosedActive) ClosedActive

FROM
(
	SELECT MonthStart, COUNT(distinct de.clientId) ActiveStart, 0 Renewed, 0 Expired, 0 WrittenOff, 0 MonthNew, 0 ClosedActive
	FROM #Dates da
	inner join #Deals de ON da.MonthStart between de.signDate and de.renewDate and de.dealStatus not in (2,5,10,18)
	WHERE signDate <> renewDate and clientID is not null and clientID <> '79914' and active = 1 and enabled = 1
	GROUP BY MonthStart
	UNION
	SELECT MonthStart, 0 ActiveStart, COUNT(distinct re.clientId) Renewed, 0 Expired, 0 WrittenOff, 0 MonthNew, 0 ClosedActive
	FROM #Dates da
	inner join #Deals re ON DATEPART(Month, da.MonthStart) = DATEPART(Month, re.signDate) 
									and DATEPART(Year, da.MonthStart) = DATEPART(Year, re.signDate) 
									and re.dealStatus not in (2,5,10,18)
	inner join #SignReasons sr ON re.dealID = sr.dealID
	WHERE --re.rn > 1 and re.renewDate > = re.OriginalRenewDate and re.renewDate > GETDATE() and re.dealStatus in (12,15) and
	sr.SignReason = 'Renewal' and
	signDate <> renewDate and re.clientID is not null and re.clientID <> '79914' and active = 1 and enabled = 1
	GROUP BY MonthStart
	UNION
	SELECT MonthStart, 0 ActiveStart, 0 Renewed, COUNT(distinct re.clientId) Expired, 0 WrittenOff, 0 MonthNew, 0 ClosedActive
	FROM #Dates da
	inner join #Deals re ON DATEPART(Month, da.MonthStart) = DATEPART(Month, re.renewDate) 
									and DATEPART(Year, da.MonthStart) = DATEPART(Year, re.renewDate) 
	inner join #LastRenew lr ON re.clientID = lr.clientID
	WHERE re.renewDate >= re.OriginalRenewDate and renewDate < GETDATE() and
	signDate <> renewDate and re.clientID is not null and re.clientID <> '79914' and active = 1 and enabled = 1
	GROUP BY MonthStart
	UNION
	SELECT MonthStart, 0 ActiveStart, 0 Renewed, 0 Expired, COUNT(distinct re.clientId) WrittenOff, 0 MonthNew, 0 ClosedActive
	FROM #Dates da
	inner join #Deals re ON DATEPART(Month, da.MonthStart) = DATEPART(Month, re.renewDate) 
									and DATEPART(Year, da.MonthStart) = DATEPART(Year, re.renewDate) 
	inner join #LastRenew lr ON re.clientID = lr.clientID
	WHERE ((re.renewDate < re.OriginalRenewDate and re.renewDate = lr.LastRenew) or re.dealStatus in (2,5,10,18)) and
	signDate <> renewDate and re.clientID is not null and re.clientID <> '79914' and active = 1 and enabled = 1
	GROUP BY MonthStart
	UNION
	SELECT MonthStart, 0 ActiveStart, 0 Renewed, 0 Expired, 0 WrittenOff, COUNT(distinct re.clientId) MonthNew, 0 ClosedActive
	FROM #Dates da
	inner join #Deals re ON DATEPART(Month, da.MonthStart) = DATEPART(Month, re.signDate) 
									and DATEPART(Year, da.MonthStart) = DATEPART(Year, re.signDate) 
	inner join #SignReasons sr ON re.dealID = sr.dealId
	WHERE sr.SignReason = 'New' and signDate <> renewDate and re.clientID is not null and re.clientID <> '79914' and active = 1 and enabled = 1
	GROUP BY MonthStart
	UNION
	SELECT MonthStart, 0 ActiveStart, 0 Renewed, 0 Expired, 0 WrittenOff, 0 MonthNew, COUNT(distinct de.clientId) ClosedActive
	FROM #Dates da
	inner join #Deals de ON DATEADD(month,DATEDIFF(month,1,de.signDate)+1,-1) <= DATEADD(day,-1,DATEADD(month,1,da.MonthStart))
	WHERE signDate < GETDATE() and renewDate > GETDATE() and dealStatus not in (2,5,10,18) and
	signDate <> renewDate and clientID is not null and clientID <> '79914' and active = 1 and enabled = 1
	GROUP BY MonthStart
) detail

GROUP BY 
MonthStart

DROP TABLE #Deals
DROP TABLE #Dates
DROP TABLE #LastRenew
DROP TABLE #FirstStart
DROP TABLE #SignReasons