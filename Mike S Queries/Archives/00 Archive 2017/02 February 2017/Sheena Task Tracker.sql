DECLARE @StartDate as Date = DATEADD(ww,DATEDIFF(ww,0,GETDATE())-1,0)
DECLARE @EndDate as Date = DATEADD(ww,DATEDIFF(ww,0,GETDATE())-1,6)

SELECT 
detail.FullName Consultant,
cl.companyName,
s.siteName,
CONVERT(date, detail.[Task Date]) [Task Date],
[Type],
case when [Type] = 'First Visit Booked' then 1
when [Type] = 'First Visit Sat' then 2
when [Type] = 'Install Booked' then 3
when [Type] = 'Installed' then 4
when [Type] = 'Renewal Review Booked' then 6
when [Type] = 'Renewal Review' then 7 end TypeNo
FROM
(
SELECT u.FullName, clientID, siteID, dhr.firstVisitBooked [Task Date], 'First Visit Booked' [Type]
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_users u ON dhr.firstVisitConsultantID = u.userID
WHERE firstVisitBooked between @StartDate and @EndDate
UNION
SELECT u.FullName, clientID, siteID, dhr.firstVisit [Task Date], 'First Visit Sat' [Type]
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_users u ON dhr.firstVisitConsultantID = u.userID
WHERE firstVisit between @StartDate and @EndDate
UNION
SELECT u.FullName, clientID, siteID, dhr.installBooked [Task Date], 'Install Booked' [Type]
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_users u ON dhr.installConsul = u.userID
WHERE installBooked between @StartDate and @EndDate
UNION
SELECT u.FullName, clientID, siteID, dhr.installed [Task Date], 'Installed' [Type]
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_users u ON dhr.installConsul = u.userID
WHERE installed between @StartDate and @EndDate
UNION
SELECT u.FullName, clientID, siteID, dhr.docReviewBooked [Task Date], 'Renewal Review Booked' [Type]
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_users u ON dhr.installConsul = u.userID
WHERE dhr.docReview between @StartDate and @EndDate
UNION
SELECT u.FullName, clientID, siteID, dhr.docReview [Task Date], 'Renewal Reviewed' [Type]
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_users u ON dhr.installConsul = u.userID
WHERE dhr.docReview between @StartDate and @EndDate
) detail
inner join Shorthorn..cit_sh_sites s ON detail.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON detail.clientID = cl.clientID
ORDER BY FullName, CONVERT(date, [Task Date]), detail.clientID, detail.siteID, TypeNo