SELECT
Id,
LEFT(
case when Services_Taken_AI_Only_HS__c = 'true' then 'A&I Only - Health & Safety, ' else '' end +
case when Services_Taken_AI_Only__c = 'true' then 'A&I only - EL & HR, ' else '' end +
case when Services_Taken_Advice_Only_HS__c = 'true' then 'Advice Only - Health & Safety, ' else '' end +
case when Services_Taken_Advice_Only__c = 'true' then 'Advice Only - EL & HR, ' else '' end +
case when Services_Taken_Consultancy__c = 'true' then 'Consultancy, ' else '' end +
case when Services_Taken_EL__c = 'true' then 'EL & HR, ' else '' end +
case when Services_Taken_Env__c = 'true' then 'Environmental, ' else '' end +
case when Services_Taken_FRA__c = 'true' then 'Fire Risk Assessment, ' else '' end +
case when Services_Taken_Franchise_Comp_EL__c = 'true' then 'Franchise - Comprehensive - EL & HR, ' else '' end +
case when Services_Taken_Franchise_Comp_HS__c = 'true' then 'Franchise - Comprehensive - Health & Safety, ' else '' end +
case when Services_Taken_Franchise_Entry_EL__c = 'true' then 'Franchise - Entry Level - EL & HR, ' else '' end +
case when Services_Taken_Franchise_Entry_HS__c = 'true' then 'Franchise - Entry Level - Health & Safety, ' else '' end +
case when Services_Taken_HS__c = 'true' then 'Health & Safety, ' else '' end +
case when Services_Taken_JIT__c = 'true' then 'JIT Tribunal, ' else '' end +
case when Services_Taken_SBP__c = 'true' then 'Small Business Package, ' else '' end +
case when Services_Taken_Training__c = 'true' then 'Training, ' else '' end +
case when Services_Taken_eRAMS__c = 'true' then 'eRAMs, ' else '' end, 
LEN(
case when Services_Taken_AI_Only_HS__c = 'true' then 'A&I Only - Health & Safety, ' else '' end +
case when Services_Taken_AI_Only__c = 'true' then 'A&I only - EL & HR, ' else '' end +
case when Services_Taken_Advice_Only_HS__c = 'true' then 'Advice Only - Health & Safety, ' else '' end +
case when Services_Taken_Advice_Only__c = 'true' then 'Advice Only - EL & HR, ' else '' end +
case when Services_Taken_Consultancy__c = 'true' then 'Consultancy, ' else '' end +
case when Services_Taken_EL__c = 'true' then 'EL & HR, ' else '' end +
case when Services_Taken_Env__c = 'true' then 'Environmental, ' else '' end +
case when Services_Taken_FRA__c = 'true' then 'Fire Risk Assessment, ' else '' end +
case when Services_Taken_Franchise_Comp_EL__c = 'true' then 'Franchise - Comprehensive - EL & HR, ' else '' end +
case when Services_Taken_Franchise_Comp_HS__c = 'true' then 'Franchise - Comprehensive - Health & Safety, ' else '' end +
case when Services_Taken_Franchise_Entry_EL__c = 'true' then 'Franchise - Entry Level - EL & HR, ' else '' end +
case when Services_Taken_Franchise_Entry_HS__c = 'true' then 'Franchise - Entry Level - Health & Safety, ' else '' end +
case when Services_Taken_HS__c = 'true' then 'Health & Safety, ' else '' end +
case when Services_Taken_JIT__c = 'true' then 'JIT Tribunal, ' else '' end +
case when Services_Taken_SBP__c = 'true' then 'Small Business Package, ' else '' end +
case when Services_Taken_Training__c = 'true' then 'Training, ' else '' end +
case when Services_Taken_eRAMS__c = 'true' then 'eRAMs, ' else '' end
) - 1) [Services]
FROM
Salesforce..Contract
WHERE
Services_Taken_AI_Only_HS__c = 'true' or
Services_Taken_AI_Only_HS__c = 'true' or
Services_Taken_AI_Only__c = 'true' or
Services_Taken_Advice_Only_HS__c = 'true' or
Services_Taken_Advice_Only__c = 'true' or
Services_Taken_Consultancy__c = 'true' or
Services_Taken_EL__c = 'true' or
Services_Taken_Env__c = 'true' or
Services_Taken_FRA__c = 'true' or
Services_Taken_Franchise_Comp_EL__c = 'true' or
Services_Taken_Franchise_Comp_HS__c = 'true' or
Services_Taken_Franchise_Entry_EL__c = 'true' or
Services_Taken_Franchise_Entry_HS__c = 'true' or
Services_Taken_HS__c = 'true' or
Services_Taken_JIT__c = 'true' or
Services_Taken_SBP__c = 'true' or
Services_Taken_Training__c = 'true' or
Services_Taken_eRAMS__c = 'true'