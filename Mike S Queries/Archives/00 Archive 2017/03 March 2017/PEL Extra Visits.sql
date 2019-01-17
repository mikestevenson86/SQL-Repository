SELECT 
ev.DueDate [Due Date],
cl.CompanyName Company,
u.FullName Consultant,
c.fName + ' ' + c.sName [Visiting],
ptd.disposition [Visit Type],
ev.comments Comments

FROM
Shorthorn..cit_sh_PELExtraVisits ev
left outer join Shorthorn..cit_sh_sites s ON ev.siteID = s.siteID
left outer join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON ev.consultant = u.userID
left outer join Shorthorn..cit_sh_contacts c ON ev.visiting = c.contactID
left outer join Shorthorn..cit_sh_PELTracker_Dispositions ptd ON ev.PELTracker_DispositionsID_fk = ptd.ID

WHERE
ev.dueDate >= DATEADD(Year,-1,GETDATE())

ORDER BY
[Due Date]