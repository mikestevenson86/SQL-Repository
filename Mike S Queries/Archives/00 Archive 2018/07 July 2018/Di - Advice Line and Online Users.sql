SELECT *
FROM
(
SELECT contactId, s.siteID, s.siteName [Site Name], cl.clientID, c.fName + ' ' + c.sName [Contact Name], c.email [Contact Email], c.tel [Contact Phone],
case when ISNULL(c.adviceCard, '') <> '' then 'Yes' else 'No' end AdviceLine, 
case when s.citManSuper = c.contactID then 'Yes' else 'No' end OnlineUser
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID
inner join Shorthorn..cit_sh_contacts c ON s.siteID = c.siteID
WHERE cl.companyName like '%Midway Care%' or cl.companyName like '%Pharos Care%'
) detail
WHERE AdviceLine = 'Yes' or OnlineUser = 'Yes'