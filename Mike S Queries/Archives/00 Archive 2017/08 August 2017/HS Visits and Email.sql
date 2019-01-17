IF OBJECT_ID('tempdb..#Emails') IS NOT NULL
	BEGIN
		DROP TABLE #Emails
	END

IF OBJECT_ID('ReportServer..Visits') IS NOT NULL
	BEGIN
		DROP TABLE ReportServer..Visits
	END

SELECT 
cl.ClientLetterID, l.letterName, cl.letterDate, cl.appDate, u.FullName Consultant, 
c.fName + ' ' + c.sName Contact, c.position, c.tel, c.mob, c.email
INTO 
#Emails
FROM 
Shorthorn..cit_sh_ClientLetters cl
inner join Shorthorn..cit_sh_letters l ON cl.letterID = l.letterID
inner join Shorthorn..cit_sh_contacts c ON cl.contactID = c.contactID
inner join Shorthorn..cit_sh_users u ON cl.userID = u.userID
WHERE 
l.letterID in (57,58,68,65) 
and 
CONVERT(date, appDate) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

CREATE TABLE ReportServer..Visits
(
ClientName VarChar(200),
SiteName VarChar(200),
SitePostCode VarChar(20),
VisitType VarChar(50),
BookedDate Datetime,
VisitedDate Datetime,
Consultant VarChar(200),
LetterID Int
)

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'Install', installdatebook, dateInstalled, u.FullName, dhs.installLetterID
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.instConsul = u.UserId
WHERE 
CONVERT(date, installdatebook) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'First Visit', visit1book, firstVisit, u.FullName, dhs.visit1LetterID
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit1ConID = u.UserId
WHERE 
CONVERT(date, visit1book) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'Second Visit', visit2book, secVisit, u.FullName, dhs.visit2LetterID
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit2ConID = u.UserId
WHERE 
CONVERT(date, visit2book) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'Third Visit', visit3book, thirVisit, u.FullName, dhs.visit3LetterID
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit3ConID = u.UserId
WHERE 
CONVERT(date, visit3book) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'Fourth Visit', visit4book, fourthVisit, u.FullName, dhs.visit4LetterID
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit4ConID = u.UserId
WHERE 
CONVERT(date, visit4book) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'Fifth Visit', visit5book, fifthVisit, u.FullName, dhs.visit5LetterID
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit5ConID = u.UserId
WHERE 
CONVERT(date, visit5book) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'Sixth Visit', visit6book, sixthVisit, u.FullName, dhs.visit6LetterID
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhs.visit6ConID = u.UserId
WHERE 
CONVERT(date, visit6book) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

INSERT INTO ReportServer..Visits
SELECT cl.companyName, s.SiteName, s.PostCode, 'Extra Visit', ev.dueDate, ev.visitDate, u.FullName, ev.evID
FROM Shorthorn..cit_sh_HSExtraVisits ev
inner join Shorthorn..cit_sh_dealsHS dhs ON ev.hsID = dhs.hsID
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON ev.consultant = u.UserId
WHERE 
CONVERT(date, ev.dueDate) = case when DATENAME(weekday,DATEADD(day,3,GETDATE())) in ('Saturday','Sunday','Monday') 
then 
CONVERT(date, DATEADD(day,5,GETDATE()))
else 
CONVERT(date, DATEADD(day,3,GETDATE())) end

SELECT 
v.VisitType, 
v.BookedDate, 
v.VisitedDate,
v.Consultant, 
up.PotNo,
case when em.clientLetterID is not null then 'Yes' else 'No' end [Email Sent],
em.letterDate [Date Email Sent], 
em.appDate [Date Visit Set],
v.ClientName, 
v.SiteName,
v.SitePostCode,
case when v.VisitType = 'Extra Visit' then con.fName + ' ' + sName else em.Contact end Contact, 
case when v.VisitType = 'Extra Visit' then con.position else em.Position end Position, 
case when v.VisitType = 'Extra Visit' then con.email else em.Email end Email, 
case when v.VisitType = 'Extra Visit' then con.tel else em.tel end Phone, 
case when v.VisitType = 'Extra Visit' then con.mob else em.mob end Mobile,
'' Contacted,
'' Response

FROM 
ReportServer..Visits v
left outer join #Emails em ON v.LetterID = em.clientLetterID
left outer join [DB01].SalesforceReporting.dbo.HS_UserPots up ON v.Consultant collate latin1_general_CI_AS = up.Consultant collate latin1_general_CI_AS
left outer join Shorthorn..cit_sh_HSExtraVisits ev ON v.LetterID = ev.evID and v.VisitType = 'Extra Visit'
left outer join Shorthorn..cit_sh_contacts con ON ev.visiting = con.contactID

ORDER BY 
VisitType, 
BookedDate, 
Consultant

/*
letterID,lettername
57,'H&S - 1st Visit Appointment E-mail'
114,'H&S - 48 Hour E-mail reminder'
58,'H&S - Annual Visit Appointment E-mail'
71,'H&S - Canx 1 1st Visit Appointment E-mail'
61,'H&S - Canx 1 Annual Visit Appointment E-mail'
70,'H&S - Canx 1 Extra Visit Appointment E-mail'
62,'H&S - Canx 1 Installation Appointment E-mail'
63,'H&S - Canx 2 (Client Reschedule) E-mail'
68,'H&S - Extra Visit email'
65,'H&S - Installation Appointment E-mail'
*/

/*
SELECT ev.evID, cl.companyName, s.siteName, s.mainContactHS, c.contactID, c.fName, c.sName
FROM [Shorthorn].[dbo].[cit_sh_HSExtraVisits] ev 
inner join Shorthorn..cit_sh_dealsHS hs ON ev.hsID = hs.hsID
inner join Shorthorn..cit_sh_clients cl ON hs.clientID = cl.clientID
inner join Shorthorn..cit_sh_sites s ON ev.siteID = s.siteID
inner join Shorthorn..cit_sh_contacts c ON ev.visiting = c.contactID
*/