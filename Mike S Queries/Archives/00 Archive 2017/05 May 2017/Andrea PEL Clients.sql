SELECT dt.dealType, dl.clientID, COUNT(dl.dealId) Deals
INTO #Deals
FROM Shorthorn..cit_sh_deals dl
inner join Shorthorn..cit_sh_dealsPEL dhr ON dl.dealID = dhr.dealID
inner join Shorthorn..cit_sh_dealTypes dt ON dl.dealType = dt.dealTypeID
inner join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18) and 
dl.dealType in (2,3,7,12,14,15) and signDate <= '2017-03-31'
GROUP BY dl.clientID, dt.dealType

SELECT d.dealType, COUNT(cl.clientId), SUM(d.Deals) Deals, SUM(cl.totEmployees)
FROM Shorthorn..cit_sh_clients cl
inner join #Deals d ON cl.clientID = d.clientID
GROUP BY d.dealType

DROP TABLE #Deals

/*
2
3
7
12
14
15
*/