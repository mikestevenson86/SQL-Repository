SELECT distinct email2DBId,
STUFF((SELECT ', '+attName
FROM Shorthorn..cit_sh_emailAttachments a1
WHERE a1.email2dbID = a2.email2dbID
FOR XML PATH('')),1,1,'') EmailAttachments
INTO #Att
FROM Shorthorn..cit_sh_emailAttachments a2

SELECT 
CONVERT(VarChar(MAX),advice_note), 
c.fName + ' ' + c.sName Contact,
CONVERT(date, dateOfCall) CallDate ,
CONVERT(time, dateOfCall) CallTime,
u.FullName Consultant,
s.siteName,
emp.fName + ' ' + emp.sName Employee,
e.subject,
att.EmailAttachments

FROM 
Shorthorn..cit_sh_advice a
inner join Shorthorn..cit_sh_emails e ON e.ticketNum = a.adviceID
inner join #Att att ON att.email2dbID = e.email2dbID collate SQL_latin1_general_CP1_CS_AS
inner join Shorthorn..cit_sh_contacts c ON a.contactID = c.contactID
inner join Shorthorn..cit_sh_users u ON a.consultant = u.userID
inner join Shorthorn..cit_sh_sites s ON a.siteID = s.siteID
left outer join Shorthorn..cit_sh_employees emp ON a.empID = emp.empID

WHERE
CONVERT(date, dateOfCall) = CONVERT(date, GETDATE()-1)

DROP TABLE #Att