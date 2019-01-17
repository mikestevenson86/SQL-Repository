
SELECT 
l.ID, 
l.Company, 
l.Product_Interest__c,
l.CreatedDate,
l.Status,
l.Approved_Date__c,
l.Date_Made__c,
l.Suspended_Closed_Reason__c,
l.LeadSource,
l.Actual_turnover_band__c,
l.CitationSector__c,
l.TEXT_BDM__c
FROM Salesforce..Lead l
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
WHERE rt.Name = 'QMS Record Type'

SELECT 
o.Id,
q.Discount,
q.Name,
ISNULL(u.Name, g.Name) OppOwner,
q.CreatedDate
FROM Salesforce..Opportunity o
left outer join Salesforce..Quote q ON o.Id = q.OpportunityId
left outer join Salesforce..RecordType rt ON o.RecordTypeId = rt.Id
left outer join Salesforce..[User] u ON o.OwnerId = u.Id
left outer join Salesforce..[Group] g ON o.OwnerId = g.Id
WHERE rt.Name = 'QMS'

SELECT
o.FM_Opportunity_External_Id__c,
o.Approved_Date__c,
o.Service_Delivery__c,
o.Contract_Length_Yrs__c,
o.Consultancy_Fee__c,
o.Audit_Fee__c,
Discount_Percentage__c
FROM Salesforce..Opportunity o
left outer join Salesforce..Account a ON o.AccountId = a.Id
left outer join Salesforce..RecordType rt ON o.RecordTypeId = rt.Id
left outer join Salesforce..[Contract] c ON o.ContractId = c.Id
WHERE rt.Name = 'QMS' and o.StageName = 'Closed Won'