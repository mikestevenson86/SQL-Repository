SELECT 
'http://database/shorthorn/shClient.asp?clientID=' + CONVERT(varchar, cl.clientId) + '&dealId=' + CONVERT(varchar, dl.dealId) [Shorthorn Link],
cl.companyName [Company Name], 
s.siteName [Site Name], 
s.postcode [Site PostCode], 
hr.inMakeUp [Make Up Date], 
mu.[type] [Make Up Type]

FROM Shorthorn..cit_sh_dealsPEL hr
inner join Shorthorn..cit_sh_deals dl ON hr.dealID = dl.dealID
inner join Shorthorn..cit_sh_sites s ON hr.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Shorthorn..cit_sh_PELMakeUpTypes mu ON hr.makeUpType = mu.ID

WHERE 
dl.renewDate > GETDATE() 
and 
dl.dealStatus not in (2,5,10,18) 
and 
hr.sysRequired = 1