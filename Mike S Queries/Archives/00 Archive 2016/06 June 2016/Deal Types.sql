SELECT 
AccountId, c.ID, 
case when LEN(
case when Services_Taken_AI_Only_HS__c <> 'false' then 'Health & Safety A&I Only' + ';' else '' end +
case when Services_Taken_AI_Only__c <> 'false' then 'Employment Law and HR A&I Only' + ';' else '' end +
case when Services_Taken_Advice_Only_HS__c <> 'false' then 'Health & Safety Advice Only' + ';' else '' end +
case when Services_Taken_Advice_Only__c <> 'false' then 'Employment Law and HR Advice Only' + ';' else '' end +
case when Services_Taken_Consultancy__c <> 'false' then 'Consultancy' + ';' else '' end +
case when Services_Taken_EL__c <> 'false' then 'Employment Law and HR' + ';' else '' end +
case when Services_Taken_Env__c <> 'false' then 'Environmental' + ';' else '' end +
case when Services_Taken_FRA__c <> 'false' then 'Fire Risk Assessments' + ';' else '' end +
case when Services_Taken_Franchise_Comp_EL__c <> 'false' then 'Franchise - Comprehensive EL and HR' + ';' else '' end +
case when Services_Taken_Franchise_Comp_HS__c <> 'false' then 'Franchise - Comprehensive Health & Safety' + ';' else '' end +
case when Services_Taken_Franchise_Entry_EL__c <> 'false' then 'Franchise - Entry Level EL and HR' + ';' else '' end +
case when Services_Taken_Franchise_Entry_HS__c <> 'false' then 'Franchise - Entry Level Health & Safety' + ';' else '' end +
case when Services_Taken_HS__c <> 'false' then 'Health & Safety' + ';' else '' end +
case when Services_Taken_JIT__c <> 'false' then 'JIT Tribunal' + ';' else '' end +
case when Services_Taken_SBP__c <> 'false' then 'Small Business Package' + ';' else '' end +
case when Services_Taken_Training__c <> 'false' then 'Training' + ';' else '' end +
case when Services_Taken_eRAMS__c <> 'false' then 'eRAMs' + ';' else '' end +
case when Business_Defence__c <> 'false' then 'Business Defence' + ';' else '' end +
case when CQC__c <> 'false' then 'CQC' + ';' else '' end +
case when Online_Tools_Only__c <> 'false' then 'Online Tools Only' + ';' else '' end +
case when X14001__c <> 'false' OR X18001__c <> 'false' OR X9001__c <> 'false' then 'ISO Certification' + ';' else '' end) = 0 then '' else 
LEFT(
case when Services_Taken_AI_Only_HS__c <> 'false' then 'Health & Safety A&I Only' + ';' else '' end +
case when Services_Taken_AI_Only__c <> 'false' then 'Employment Law and HR A&I Only' + ';' else '' end +
case when Services_Taken_Advice_Only_HS__c <> 'false' then 'Health & Safety Advice Only' + ';' else '' end +
case when Services_Taken_Advice_Only__c <> 'false' then 'Employment Law and HR Advice Only' + ';' else '' end +
case when Services_Taken_Consultancy__c <> 'false' then 'Consultancy' + ';' else '' end +
case when Services_Taken_EL__c <> 'false' then 'Employment Law and HR' + ';' else '' end +
case when Services_Taken_Env__c <> 'false' then 'Environmental' + ';' else '' end +
case when Services_Taken_FRA__c <> 'false' then 'Fire Risk Assessments' + ';' else '' end +
case when Services_Taken_Franchise_Comp_EL__c <> 'false' then 'Franchise - Comprehensive EL and HR' + ';' else '' end +
case when Services_Taken_Franchise_Comp_HS__c <> 'false' then 'Franchise - Comprehensive Health & Safety' + ';' else '' end +
case when Services_Taken_Franchise_Entry_EL__c <> 'false' then 'Franchise - Entry Level EL and HR' + ';' else '' end +
case when Services_Taken_Franchise_Entry_HS__c <> 'false' then 'Franchise - Entry Level Health & Safety' + ';' else '' end +
case when Services_Taken_HS__c <> 'false' then 'Health & Safety' + ';' else '' end +
case when Services_Taken_JIT__c <> 'false' then 'JIT Tribunal' + ';' else '' end +
case when Services_Taken_SBP__c <> 'false' then 'Small Business Package' + ';' else '' end +
case when Services_Taken_Training__c <> 'false' then 'Training' + ';' else '' end +
case when Services_Taken_eRAMS__c <> 'false' then 'eRAMs' + ';' else '' end +
case when Business_Defence__c <> 'false' then 'Business Defence' + ';' else '' end +
case when CQC__c <> 'false' then 'CQC' + ';' else '' end +
case when Online_Tools_Only__c <> 'false' then 'Online Tools Only' + ';' else '' end +
case when X14001__c <> 'false' OR X18001__c <> 'false' OR X9001__c <> 'false' then 'ISO Certification' + ';' else '' end,
LEN(
case when Services_Taken_AI_Only_HS__c <> 'false' then 'Health & Safety A&I Only' + ';' else '' end +
case when Services_Taken_AI_Only__c <> 'false' then 'Employment Law and HR A&I Only' + ';' else '' end +
case when Services_Taken_Advice_Only_HS__c <> 'false' then 'Health & Safety Advice Only' + ';' else '' end +
case when Services_Taken_Advice_Only__c <> 'false' then 'Employment Law and HR Advice Only' + ';' else '' end +
case when Services_Taken_Consultancy__c <> 'false' then 'Consultancy' + ';' else '' end +
case when Services_Taken_EL__c <> 'false' then 'Employment Law and HR' + ';' else '' end +
case when Services_Taken_Env__c <> 'false' then 'Environmental' + ';' else '' end +
case when Services_Taken_FRA__c <> 'false' then 'Fire Risk Assessments' + ';' else '' end +
case when Services_Taken_Franchise_Comp_EL__c <> 'false' then 'Franchise - Comprehensive EL and HR' + ';' else '' end +
case when Services_Taken_Franchise_Comp_HS__c <> 'false' then 'Franchise - Comprehensive Health & Safety' + ';' else '' end +
case when Services_Taken_Franchise_Entry_EL__c <> 'false' then 'Franchise - Entry Level EL and HR' + ';' else '' end +
case when Services_Taken_Franchise_Entry_HS__c <> 'false' then 'Franchise - Entry Level Health & Safety' + ';' else '' end +
case when Services_Taken_HS__c <> 'false' then 'Health & Safety' + ';' else '' end +
case when Services_Taken_JIT__c <> 'false' then 'JIT Tribunal' + ';' else '' end +
case when Services_Taken_SBP__c <> 'false' then 'Small Business Package' + ';' else '' end +
case when Services_Taken_Training__c <> 'false' then 'Training' + ';' else '' end +
case when Services_Taken_eRAMS__c <> 'false' then 'eRAMs' + ';' else '' end +
case when Business_Defence__c <> 'false' then 'Business Defence' + ';' else '' end +
case when CQC__c <> 'false' then 'CQC' + ';' else '' end +
case when Online_Tools_Only__c <> 'false' then 'Online Tools Only' + ';' else '' end +
case when X14001__c <> 'false' OR X18001__c <> 'false' OR X9001__c <> 'false' then 'ISO Certification' + ';' else '' end
)-1) end Deal_Type,
ATLAS_Deal_Type__c
INTO 
#Types
FROM 
Salesforce..Contract c
inner join Salesforce..Account a ON c.AccountId = a.Id
WHERE 
CONVERT(date, StartDate) <= CONVERT(date, GETDATE()) 
and 
CONVERT(date, EndDate) > CONVERT(date, GETDATE()) 
and 
Cancellation_Date__c is null

SELECT
     AccountId,
     ac.Company_Registration_Number__c,
     ac.ATLAS_Deal_Type__c OldValue,
     REPLACE(
     STUFF(
         (SELECT DISTINCT ',' + Deal_Type
          FROM #Types
          WHERE AccountId = a.AccountId
          FOR XML PATH (''))
          , 1, 1, ''),'&amp;','&') AS NewValue
FROM #Types AS a
inner join Salesforce..Account ac ON a.AccountId = ac.Id
GROUP BY AccountId, ac.Company_Registration_Number__c, ac.ATLAS_Deal_Type__c

DROP TABLE #Types