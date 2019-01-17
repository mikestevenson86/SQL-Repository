SELECT a.Name [Account Name], c.FirstName, c.LastName, c.Billing_Contact__c [Billing Contact?], c.Service_Owner__c [Onboarding Contact?], 
c.Main_User__c [Main User], c.Helpline_H_S__c [H&S Contact], Helpline_PEL__c [PEL Contact], Online_Super_User__c [Online Super User], 
AdviceCard__c [Advice Card?], c.HasOptedOutOfEmail [Email Opt Out?], c.Email, c.Id [Contact Id]
FROM Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
inner join Salesforce..Contract d ON a.Id = d.AccountId
WHERE 
c.HasOptedOutOfEmail <> 'true' 
and 
ISNULL(c.Email, '') <> '' 
and 
c.Email not like '%citation%'
and 
--a.HR_EL_Service_Taken__c = 'true' 
--and 
Citation_Client__c = 'true' 
and 
a.IsActive__c = 'true'
and
c.Active__c = 'true'
and 
d.Services_Taken_EL__c = 'true' 
and 
d.StartDate < GETDATE() 
and 
d.EndDate > GETDATE() 
and 
d.Cancellation_Date__c is null
ORDER BY
[Account Name]