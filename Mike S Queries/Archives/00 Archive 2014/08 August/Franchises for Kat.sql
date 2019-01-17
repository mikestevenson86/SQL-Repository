SELECT 
distinct(cl.clientId)

INTO
#temp

FROM 
[database].shorthorn.dbo.cit_sh_contacts c

inner join [database].Shorthorn.dbo.cit_sh_sites s ON c.siteID = s.siteID
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
inner join [database].Shorthorn.dbo.cit_sh_deals d ON cl.clientID = d.clientID

WHERE 
d.OnHold = 0 and d.dealStatus not in (2,5,8,18) and d.RenewDate >= GETDATE() and
(
c.email in
	(
	SELECT Email
	FROM [database].Shorthorn.dbo.Franchises
	WHERE Email is not null and Email <>''
	)
or
REPLACE(c.tel,' ','') in
	(
	SELECT REPLACE(Mobile,' ','')
	FROM [database].Shorthorn.dbo.Franchises
	WHERE Mobile is not null and Mobile <>''
	)
or
REPLACE(c.mob,' ','') in
	(
	SELECT REPLACE(Mobile,' ','')
	FROM [database].Shorthorn.dbo.Franchises
	WHERE Mobile is not null and Mobile <>''
	)
)

SELECT
cl.clientID [Shorthorn ID], cl.companyname [Company Name],cl.tradingas [Trading Name], cl.clienttype [Client Type],cl.sageCode [Sage Code]

FROM 
[database].shorthorn.dbo.cit_sh_clients cl

inner join #temp t ON cl.clientID = t.clientID

DROP TABLE #Temp