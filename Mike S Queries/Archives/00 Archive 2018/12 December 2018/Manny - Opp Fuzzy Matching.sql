SELECT l.Id [Prospect Id], o.Id [Opportunity Id], o.StageName [Stage Name], o.SAT_Date__c [SAT Date], o.CloseDate [Close Date], u.Name BDC
FROM Salesforce..[User] u
left outer join Salesforce..UserRole ur ON u.UserRoleId = ur.Id
left outer join Salesforce..[Profile] p ON u.ProfileId = p.Id
left outer join Salesforce..Lead l ON u.Id = l.CreatedById
left outer join Salesforce..Account a ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
												= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
--left outer join Salesforce..Account a ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
--												= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
--left outer join Salesforce..Account a ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
--												= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
--left outer join Salesforce..Account a ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
--											and REPLACE(l.PostalCode,' ','') = REPLACE(a.BillingPostalCode,' ','')
left outer join Salesforce..Opportunity o ON a.Id = o.AccountId
WHERE ur.Name = 'Business Solutions Team' and p.Name = 'New BDC Profile' and l.IsConverted = 'false' and o.Id is not null