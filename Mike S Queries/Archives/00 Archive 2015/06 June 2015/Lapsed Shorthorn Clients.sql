SELECT 
c.clientID ShorthornID, 
c.SFDC_AccountID,
c.companyName Company,
c.ClientType,
d.DealID,
case when dhs.dealID is not null and dhr.dealID is not null then 'Combined'
when dhs.dealID is null and dhr.dealID is not null then 'PEL'
when dhs.dealID is not null and dhr.dealID is null then 'HS' end DealType,
lc.[Expiry Date], 
s.address1 + ' ' + s.address2 Street,  
s.town City, 
s.postcode PostCode, 
fName + ' ' + sName Contact, 
position Position, 
tel Phone1, 
mob Phone2, 
genTel Phone3, 
email Email1, 
genEmail Email2,
c.website Website
FROM [database].shorthorn.dbo.cit_sh_clients c
inner join [database].shorthorn.dbo.cit_sh_sites s ON c.clientID = s.clientId
inner join [database].shorthorn.dbo.cit_sh_contacts con ON s.genContact = con.contactId
inner join SalesforceReporting..LapsedClients lc ON c.CompanyName = lc.[Company Name] and s.postcode = lc.Postcode
inner join [database].shorthorn.dbo.cit_sh_deals d ON c.clientID = d.clientID
left outer join [database].shorthorn.dbo.cit_sh_dealsHS dhs ON d.dealID = dhs.dealID
left outer join [database].shorthorn.dbo.cit_sh_dealsPEL dhr ON d.dealID = dhr.dealID