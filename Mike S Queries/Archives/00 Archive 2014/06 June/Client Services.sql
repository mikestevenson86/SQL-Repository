SELECT 
SUM(case when c.Services_Taken_AI_Only_HS__c = 'true' then 1 else 0 end) [HS A&I Only],
SUM(case when c.Services_Taken_AI_Only__c = 'true' then 1 else 0 end) [A&I Only],
SUM(case when c.Services_Taken_Advice_Only_HS__c = 'true' then 1 else 0 end) [HS Advice Only],
SUM(case when c.Services_Taken_Advice_Only__c = 'true' then 1 else 0 end) [Advice Only],
SUM(case when c.Services_Taken_Consultancy__c = 'true' then 1 else 0 end) [Consultancy],
SUM(case when c.Services_Taken_EL__c = 'true' then 1 else 0 end) [Employment Law],
SUM(case when c.Services_Taken_Env__c = 'true' then 1 else 0 end) [Environmental],
SUM(case when c.Services_Taken_FRA__c = 'true' then 1 else 0 end) [Fire Risk Assessments],
SUM(case when c.Services_Taken_Franchise_Comp_EL__c = 'true' then 1 else 0 end) [Franchise EL],
SUM(case when c.Services_Taken_Franchise_Comp_HS__c = 'true' then 1 else 0 end) [Franchise HS],
SUM(case when c.Services_Taken_Franchise_Entry_EL__c = 'true' then 1 else 0 end) [Franchise Entry EL],
SUM(case when c.Services_Taken_Franchise_Entry_HS__c = 'true' then 1 else 0 end) [Franchise Entry HS],
SUM(case when c.Services_Taken_HS__c = 'true' then 1 else 0 end) [Health & Safety],
SUM(case when c.Services_Taken_JIT__c = 'true' then 1 else 0 end) [JIT Tribunal],
SUM(case when c.Services_Taken_SBP__c = 'true' then 1 else 0 end) [Small Business Package],
SUM(case when c.Services_Taken_Training__c = 'true' then 1 else 0 end) [Training],
SUM(case when c.Services_Taken_eRAMS__c = 'true' then 1 else 0 end) [eRAMs]
FROM Salesforce..Account a
inner join Salesforce..Contract c on a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS and c.Status = 'Active'
WHERE a.Type = 'Client'