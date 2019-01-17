/*
Dear Dave,
The list below shows clients that have had a Visit Booked Date entered into the system, that has now passed, but there is no actual Sat Date entered after the event.
Kingfisher House Day Nursery (Kingfisher House Day Nursery)
Second Visit – 10/8/2017 10:00am
Please fill in the missing data as soon as possible to eliminate any anomalies with Performance Reviews and Management Reports.
Thanks and regards,
hsfieldsupport
*/

SELECT clientId, companyName, FullName Consultant, VisitType, BookedVisitDate
FROM
(
SELECT cl.clientId, companyName, u.FullName, installdatebook as BookedVisitDate, 'Install' as VisitType
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.userID
WHERE installdatebook between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and dateInstalled is null
UNION
SELECT cl.clientId, companyName, u.FullName, visit1book, 'First Visit'
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.userID
WHERE visit1book between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and firstVisit is null
UNION
SELECT cl.clientId, companyName, u.FullName, visit2book, 'Second Visit'
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.userID
WHERE visit2book between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and secVisit is null
UNION
SELECT cl.clientId, companyName, u.FullName, visit3book, 'Third Visit'
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.userID
WHERE visit3book between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and thirVisit is null
UNION
SELECT cl.clientId, companyName, u.FullName, visit4book, 'Fourth Visit'
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.userID
WHERE visit4book between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and fourthVisit is null
UNION
SELECT cl.clientId, companyName, u.FullName, visit5book, 'Fifth Visit'
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.userID
WHERE visit5book between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and fifthVisit is null
UNION
SELECT cl.clientId, companyName, u.FullName, visit6book, 'Sixth Visit'
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.userID
WHERE visit6book between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and sixthVisit is null
UNION
SELECT cl.clientId, companyName, u.FullName, dueDate, 'Extra Visit'
FROM Shorthorn..cit_sh_HSExtraVisits ev
inner join Shorthorn..cit_sh_sites s ON ev.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON ev.consultant = u.userID
WHERE dueDate between DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) and DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),4) and visitDate is null
) detail
WHERE BookedVisitDate < GETDATE()