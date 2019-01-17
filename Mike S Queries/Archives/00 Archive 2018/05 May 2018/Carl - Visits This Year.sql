SELECT cl.companyName, 'First Visit' VisitType, firstVisit VisitDate, c.fName + ' ' + c.sName, u.FullName Consultant 
FROM Shorthorn..cit_sh_dealsHS dhs
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealId = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_contacts c ON s.mainContactHS = c.contactId
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhs.firstConsul = u.userID
WHERE YEAR(firstVisit) = 2018
UNION ALL
SELECT cl.companyName, 'Install Visit' VisitType, dateInstalled VisitDate, c.fName + ' ' + c.sName, u.FullName Consultant 
FROM Shorthorn..cit_sh_dealsHS dhs
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealId = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_contacts c ON s.mainContactHS = c.contactId
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhs.instConsul = u.userID
WHERE YEAR(dateInstalled) = 2018
UNION ALL
SELECT cl.companyName, 'Second Visit' VisitType, secVisit VisitDate, c.fName + ' ' + c.sName, u.FullName Consultant 
FROM Shorthorn..cit_sh_dealsHS dhs
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealId = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_contacts c ON s.mainContactHS = c.contactId
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhs.secConsul = u.userID
WHERE YEAR(secVisit) = 2018
UNION ALL
SELECT cl.companyName, 'Third Visit' VisitType, thirVisit VisitDate, c.fName + ' ' + c.sName, u.FullName Consultant 
FROM Shorthorn..cit_sh_dealsHS dhs
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealId = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_contacts c ON s.mainContactHS = c.contactId
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhs.thirConsul = u.userID
WHERE YEAR(thirVisit) = 2018
UNION ALL
SELECT cl.companyName, 'Fourth Visit' VisitType, fourthVisit VisitDate, c.fName + ' ' + c.sName, u.FullName Consultant 
FROM Shorthorn..cit_sh_dealsHS dhs
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealId = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_contacts c ON s.mainContactHS = c.contactId
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhs.fourthConsul = u.userID
WHERE YEAR(fourthVisit) = 2018
UNION ALL
SELECT cl.companyName, 'Fifth Visit' VisitType, fifthVisit VisitDate, c.fName + ' ' + c.sName, u.FullName Consultant 
FROM Shorthorn..cit_sh_dealsHS dhs
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealId = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_contacts c ON s.mainContactHS = c.contactId
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhs.fifthConsul = u.userID
WHERE YEAR(fifthVisit) = 2018
UNION ALL
SELECT cl.companyName, 'Sixth Visit' VisitType, sixthVisit VisitDate, c.fName + ' ' + c.sName, u.FullName Consultant 
FROM Shorthorn..cit_sh_dealsHS dhs
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealId = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_contacts c ON s.mainContactHS = c.contactId
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhs.sixthConsul = u.userID
WHERE YEAR(sixthVisit) = 2018