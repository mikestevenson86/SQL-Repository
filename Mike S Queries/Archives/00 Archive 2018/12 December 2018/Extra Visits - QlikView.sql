SELECT visitType,  dl.dealID,
cl.clientId, companyName, dealLength, ISNULL(su.FullName, mu.FullName), t.title, case when c.contactID is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end, 
case when c.contactID is null then c1.email else c.email end email, s.siteID, s.postcode, s.genTel, genEmail, dl.signDate, renewDate,
visitDate/*, ev.bookeddate*/, dl.cost, bs.title, SFDC_AccountId, case when c.contactID is null then c1.contactID else c.contactID end, dealStatus, 
a.s__c, ISNULL(su.userID, mu.userID)
FROM Shorthorn..cit_sh_HSExtraVisits ev
--left outer join [DEV1].ShorthornLive.dbo.cit_sh_HSextraVisitType evt ON ev.visitType = evt.visitTypeId
left outer join Shorthorn..cit_sh_dealsHS dhs ON ev.hsID = dhs.hsID
left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
left outer join Shorthorn..cit_sh_deals dl ON dhs.dealID = dl.dealID
left outer join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join cit_sh_users mu ON dhs.mainConsul = mu.userID
left outer join cit_sh_users su ON dhs.subConsul = su.userID
left outer join cit_sh_contacts c ON s.mainContactHS = c.contactID 
left outer join cit_sh_contacts c1 ON s.genContact = c1.contactID
left outer join cit_sh_titles t ON c.title  = t.titleID
left outer join cit_sh_busType b ON cl.busType = b.busTypeID
left outer join cit_sh_businessSectors bs ON bs.id = b.businessSectorID
left outer join [DB01].Salesforce.dbo.Account a ON cl.clientId = a.Shorthorn_Id__c
WHERE ev.visitDate is null and ev.dueDate < CONVERT(date, GETDATE()+30) and ev.dueDate < CONVERT(date, GETDATE())		