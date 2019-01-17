SELECT clientId, dealId, ROW_NUMBER () OVER (PARTITION BY clientId ORDER BY dealID) DealNumber
INTO #Deals
FROM Shorthorn..cit_sh_deals

SELECT 
'http://database/shorthorn/shClient.asp?clientID=' + CONVERT(varchar, cl.clientId) + '&dealId=' + CONVERT(varchar,ds.dealId) [Shorthorn Link],
cl.companyName [Company Name], 
s.siteName [Site Name],
s.postcode [Site PostCode],
dst.dealStatus [Deal Status],
hr.firstVisit [First Visit Date],
hr.docReview [Renewal Review Date],
ds.signDate [Contract Start Date],
ds.renewDate [Contract End Date],
dl.DealNumber [Deal Number],
u.FullName [Main Consultant]

FROM Shorthorn..cit_sh_dealsPEL hr
inner join Shorthorn..cit_sh_deals ds ON hr.dealID = ds.dealID
inner join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID
inner join Shorthorn..cit_sh_sites s ON hr.siteID = s.siteID
inner join #Deals dl ON hr.dealID = dl.dealID
inner join Shorthorn..cit_sh_dealStatus dst ON ds.dealStatus = dst.dealStatusID
left outer join Shorthorn..cit_sh_users u ON hr.mainConsul = u.userID

WHERE 
(
firstVisit < DATEADD(day,-14,GETDATE()) or docReview < DATEADD(day,-14,GETDATE())
)
and
firstDraftToClient is null and secDraftToClient is null and thirDraftToClient is null 
and
ds.signDate <= GETDATE() and ds.renewDate > GETDATE() and ds.dealStatus not in (2,5,10,18)

DROP TABLE #Deals