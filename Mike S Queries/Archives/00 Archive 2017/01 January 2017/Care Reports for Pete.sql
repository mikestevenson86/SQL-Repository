SELECT 
o.SAT_Date__c,
u.Name BDC, 
case when il.LeadSource is not null then 'Inbound' else 'Outbound' end Direction,
COUNT(l.Id) Appts

FROM 
Salesforce..Lead l
left outer join Salesforce..[User] u ON l.BDC__c = u.Id
left outer join SalesforceReporting..InboundLeadSources il ON l.LeadSource = il.LeadSource
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id

WHERE 
Date_Made__c between '2016-10-01' and '2016-12-31' and CitationSector__c = 'Care'

GROUP BY
o.SAT_Date__c,
u.Name, 
case when il.LeadSource is not null then 'Inbound' else 'Outbound' end

SELECT o.North_South__c Region, u.Name BDM, COUNT(o.Id) SAT
FROM Salesforce..Opportunity o
inner join Salesforce..Account a ON o.AccountId = a.Id
inner join Salesforce..[User] u ON o.OwnerId = u.ID
WHERE a.CitationSector__c = 'Care' and SAT_Date__c between '2016-10-01' and '2016-12-31'
GROUP BY o.North_South__c, u.Name

SELECT u.Name CallAgent, ch.status, ad.description, COUNT(seqno)
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
left outer join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
left outer join SalesforceReporting..addistats ad ON ch.status = ad.pstatus
													and ch.addi_status = ad.addistatus
													and pappl = 'AFF1'
WHERE l.CitationSector__c = 'Care' and ch.act_date between '2016-10-01' and '2016-12-31'
GROUP BY u.Name, ch.status, ad.description