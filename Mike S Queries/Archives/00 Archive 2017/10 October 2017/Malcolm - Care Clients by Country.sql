SELECT 
case when LEFT(BillingPostalCode, 2) in ('AB','DD','DG','EH','FK','G1','G2','G3','G4','G5','G6','G7','G8','G9','HS','IV','KA','KW','KY','ML','PA','PH','TD','ZE') then 'Scotland'
when LEFT(BillingPostalCode, 2) = 'BT' then 'Northern Ireland'
when LEFT(BillingPostalCode, 2) in ('CF','LD','LL','NP','SA','SY') then 'Wales' else 'England' end Country, COUNT(Id) Clients, 
AVG(FT_Employees__c) AverageFTE,
MIN(FT_Employees__c) MinFTE,
MAX(FT_Employees__c) MaxFTE
FROM Salesforce..Account
WHERE CitationSector__c = 'CARE' and Citation_Client__c = 'true' and IsActive__c = 'true'
GROUP BY
case when LEFT(BillingPostalCode, 2) in ('AB','DD','DG','EH','FK','G1','G2','G3','G4','G5','G6','G7','G8','G9','HS','IV','KA','KW','KY','ML','PA','PH','TD','ZE') then 'Scotland'
when LEFT(BillingPostalCode, 2) = 'BT' then 'Northern Ireland'
when LEFT(BillingPostalCode, 2) in ('CF','LD','LL','NP','SA','SY') then 'Wales' else 'England' end