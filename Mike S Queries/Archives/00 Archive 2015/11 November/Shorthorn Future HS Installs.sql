SELECT cl.ClientId, cl.companyName [Company Name], d.DealId, s.siteID, hs.installdatebook [Date Install Booked], 
u.FullName HSConsultant, c.fName + ' ' + c.sName [Main Contact], c.Position, c1.fName + ' ' + c1.sName [General Contact], c1.Position
FROM Shorthorn..cit_sh_clients AS cl
INNER JOIN Shorthorn..cit_sh_deals AS d on d.clientID = cl.clientID and d.enabled = 1
LEFT JOIN Shorthorn..cit_sh_dealsHS as hs on hs.dealID = d.dealID 
LEFT JOIN Shorthorn..cit_sh_sites as s on s.siteID = hs.siteID 
LEFT JOIN Shorthorn..cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN Shorthorn..cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN Shorthorn..cit_sh_users as u on u.userID = hs.mainConsul 
WHERE (d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17))
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) and installdatebook > GETDATE()
order by installdatebook