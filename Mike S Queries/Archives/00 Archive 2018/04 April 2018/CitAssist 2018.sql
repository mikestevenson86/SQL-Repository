SELECT hsa.commentDate, cl.companyName, cl.clienttype, hsd.disposition, hsa.comments, u.FullName Advisor, c.fName + ' ' + c.sName Contact
FROM Shorthorn..cit_sh_HSCitassist hsa
left outer join Shorthorn..cit_sh_dealsHS dhs ON hsa.HSID = dhs.hsID
left outer join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON hsa.citUser = u.userID
left outer join Shorthorn..cit_sh_contacts c ON hsa.contactID = c.contactID
left outer join Shorthorn..cit_sh_HSDispositions hsd ON hsa.disposition = hsd.dispositionID
WHERE YEAR(commentDate) = 2018
ORDER BY commentDate