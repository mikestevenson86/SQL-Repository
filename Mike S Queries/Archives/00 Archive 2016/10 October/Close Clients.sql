SELECT detail.*, Source__c, Data_Supplier__c, l.CreatedDate, rt.Name RecordType, Status, Suspended_Closed_Reason__c
FROM
(
SELECT l.ID
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
WHERE Status = 'Open' and a.IsActive__c = 'true'
UNION
SELECT l.ID
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
WHERE Status = 'Open' and a.IsActive__c = 'true'
UNION
SELECT l.ID
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
WHERE Status = 'Open' and a.IsActive__c = 'true'
UNION
SELECT l.ID
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
								and REPLACE(l.PostalCode,' ','') = REPLACE(a.BillingPostalcode,' ','')
WHERE Status = 'Open' and a.IsActive__c = 'true'
UNION
SELECT l.ID
FROM Salesforce..Lead l
inner join Salesforce..Site__c s ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
									= REPLACE(case when s.Phone__c like '0%' then s.Phone__c else '0'+s.Phone__c end,' ','')
inner join Salesforce..Account a ON s.Account__c = a.Id
WHERE Status = 'Open' and a.IsActive__c = 'true'
UNION
SELECT l.ID
FROM Salesforce..Lead l
inner join Salesforce..Site__c s ON REPLACE(l.PostalCode,' ','') = REPLACE(s.Postcode__c,' ','')
inner join Salesforce..Account a ON s.Account__c = a.Id
								and REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
WHERE Status = 'Open' and a.IsActive__c = 'true'
) detail
inner join Salesforce..Lead l ON detail.Id = l.ID
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
GROUP BY detail.ID, Source__c, Data_Supplier__c, l.CreatedDate, rt.Name, Status, Suspended_Closed_Reason__c