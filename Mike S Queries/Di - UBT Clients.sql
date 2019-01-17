IF OBJECT_ID('tempdb..#PostCodes') IS NOT NULL DROP TABLE #PostCodes

SELECT clientId, postcode
INTO #PostCodes
FROM Shorthorn..cit_sh_sites
WHERE HeadOffice = 1
UNION
SELECT clientId, postcode
FROM Shorthorn..cit_sh_sites
WHERE clientID in
(
	SELECT clientID
	FROM Shorthorn..cit_sh_sites
	GROUP BY clientID
	HAVING COUNT(siteID) = 1
)

SELECT sageCode [Sage Code]
,companyName [Company Name]
,ds.dealStatus [Deal Status]
,dt.dealType [Deal Type]
,bs.title [Business Sector]
,LEFT(pc.postcode, CHARINDEX(' ',pc.postcode)-1) AreaCode
,dl.Cost
,dl.renewDate [Agreement Expiry Date]

FROM Shorthorn..cit_sh_clients cl
left outer join Shorthorn..cit_sh_deals dl ON cl.clientID = dl.clientID
left outer join Shorthorn..cit_sh_dealTypes dt ON dl.dealType = dt.dealTypeID
left outer join Shorthorn..cit_sh_dealStatus ds ON dl.dealStatus = ds.dealStatusID
left outer join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
left outer join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
left outer join #PostCodes pc ON cl.clientID = pc.clientID

WHERE cl.clienttype = 'UBT' and cl.active = 1

ORDER BY cl.companyName