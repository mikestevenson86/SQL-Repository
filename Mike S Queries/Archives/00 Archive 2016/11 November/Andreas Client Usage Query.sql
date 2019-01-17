SELECT cl.clientId, MIN(signDate) StartDate, MAX(renewDate) EndDate
INTO #Temp
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_deals dl ON cl.clientID = dl.clientID
inner join Shorthorn..cit_sh_dealsPEL hr ON dl.dealID = hr.dealID
GROUP BY cl.clientID

SELECT
cl.clientID,
cl.companyName AS [Company Name], 
cl.sagecode AS [SageCode],
(Shorthorn.dbo.GetServiceTypeChar(cl.sagecode, ds.signDate, ds.renewDate)) AS [Service],
(Shorthorn.dbo.GetHelplinePELCallCount(cl.sagecode, dl.StartDate, dl.EndDate)) Helpline_EL,
StartDate, EndDate

FROM 
Shorthorn..cit_sh_clients cl
inner join #Temp dl ON cl.clientID = dl.clientID
inner join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
WHERE 
ds.RenewDate > GETDATE() and ds.dealStatus not in (2,5,10,18) 
and 
(Shorthorn.dbo.GetHelplinePELCallCount(cl.sagecode, dl.StartDate, dl.EndDate)) = 0
and
(Shorthorn.dbo.GetServiceTypeChar(cl.sagecode, ds.signDate, ds.renewDate)) in ('C','P')

DROP TABLE #Temp