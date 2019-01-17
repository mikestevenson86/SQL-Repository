SELECT *
FROM
(
SELECT 
s.clientID [Shorthorn ID], 
cl.companyName [Client Name], 
c.fName + ' ' + c.sName [Contact Name], 
s.siteID,
case when c.contactID = (SELECT mainContactHS FROM Shorthorn..cit_sh_sites WHERE siteID = s.siteID) then 'Yes' else 'No' end [Main H&S Contact],
case when c.contactID = (SELECT secContactHS FROM Shorthorn..cit_sh_sites WHERE siteID = s.siteID) then 'Yes' else 'No' end [Secondary H&S Contact],
case when c.contactID = (SELECT genContact FROM Shorthorn..cit_sh_sites WHERE siteID = s.siteID) then 'Yes' else 'No' end [Main Site Contact],
tel [Telephone Number], 
mob [Mobile Number],
'http://database/shorthorn/shClient.asp?clientID=' + CONVERT(VarChar, cl.clientID) [Shorthorn Client Link],
'http://database/shorthorn/clientDetails-Contact.asp?siteID=' + CONVERT(VarChar, s.siteId) + '&contactID=' + CONVERT(VarChar, c.contactID) [Shorthorn Contact Link]

FROM Shorthorn..cit_sh_contacts c
inner join Shorthorn..cit_sh_sites s ON c.siteID = s.siteID
inner join Shorthorn..cit_sh_deals dl ON s.clientID = dl.clientID
inner join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID

WHERE
dl.signDate < GETDATE() and dl.renewDate > GETDATE() and dl.dealStatus not in (2,5,10,18)
and
(Tel like '07%' or Tel like '7%')
and
( 
	--Mob not like '07%'
	--or 
	ISNULL(Mob, '') = ''
)
and c.enabled = 1
and
(
	c.contactID = (SELECT mainContactHS FROM Shorthorn..cit_sh_sites WHERE siteID = s.siteID)
	or
	c.contactID = (SELECT secContactHS FROM Shorthorn..cit_sh_sites WHERE siteID = s.siteID)
	or
	c.contactID = (SELECT genContact FROM Shorthorn..cit_sh_sites WHERE siteID = s.siteID)
)
) detail

GROUP BY
[Shorthorn ID], 
[Client Name], 
[Contact Name], 
siteID, 
[Main H&S Contact], 
[Secondary H&S Contact], 
[Main Site Contact], 
[Telephone Number], 
[Mobile Number], 
[Shorthorn Client Link], 
[Shorthorn Contact Link]

ORDER BY
[Client Name],
[Contact Name]