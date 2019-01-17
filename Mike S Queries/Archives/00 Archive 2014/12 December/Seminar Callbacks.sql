SELECT l.Id, l.Company, l.Callback_Date_Time__c
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
inner join Salesforce..CampaignMember cm ON l.Id = cm.LeadId
inner join Salesforce..Campaign c ON cm.CampaignId = c.Id
WHERE l.Status = 'callback requested' and u.Name in ('Lynn Colton','Pamela Wilkinson','Emma Stewart') and c.Name like '%SEM%' and Rating <> 'Hot'