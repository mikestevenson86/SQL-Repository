SELECT AccountId, AccountName, ServiceType, [Deal Start Month], [Service]
FROM
(
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c ServiceType, MONTH(c.StartDate) [Deal Start Month], 'EL & HR' [Service]
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and Services_Taken_EL__c = 'true' 
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'H&S'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and YEAR(c.StartDate) = 2017 
--and c.Services_Taken_HS__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Environmental'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_Env__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'eRAMs'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_eRAMS__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'A&I Only EL & HR'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_AI_Only__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'A&I Only H&S'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_AI_Only_HS__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Advice Only EL & HR'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_Advice_Only__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Advice Only H&S'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_Advice_Only_HS__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Training'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_Training__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Consultancy'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_Consultancy__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'IT Tribunal'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_JIT__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Fire Risk Assessments'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_FRA__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Small Business Package'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Services_Taken_SBP__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Business Defence'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Business_Defence__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'CQC'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.CQC__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Online Tools Only'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.Online_Tools_Only__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'UBT Meeting Room'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.UBT_Meeting_Room__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'QMS 9001'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.QMS_9001__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'QMS 14001'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.QMS_14001__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'QMS 18001'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.QMS_18001__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'QMS 27001'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
--and YEAR(c.StartDate) = 2017 
and c.QMS_27001__c = 'true'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Domiciliary England'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Clinical England'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Residential England'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Domiciliary Scotland'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Clinical Scotland'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Residential Scotland'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Domiciliary Wales'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Clinical Wales'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Residential Wales'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Domiciliary Ireland'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Clinical Ireland'
UNION
SELECT a.Id AccountId, a.Name AccountName, c.Service_Type__c, MONTH(c.StartDate) [Deal Start Month], 'Care Policies - Domiciliary England'
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE Citation_Client__c = 'true' and IsActive__c = 'true' and c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and CONVERT(VarChar, c.Care_Policies_and_Procedures__c) = 'Residential Ireland'
) detail
ORDER BY AccountName, [Service]

SELECT a.Id AccountId, a.Name AccountName, o.Name OpportunityName, MONTH(o.CloseDate) [Deal Start Month],
case when o.Certification_Display__c = 'BS 11000-1' then 'BS 11000-1' 
when o.Certification_Display__c = 'BS 15713' then 'BS 15713'
when o.Certification_Display__c = 'BS 8522' then 'BS 8522'
when o.Certification_Display__c = 'BS EN 1090' then 'BS EN 1090'
when o.Certification_Display__c = 'Cyber Essentials' then 'Cyber Essentials'
when o.Certification_Display__c = 'GDPR Readiness Assessment' then 'GDPR Readiness Assessment'
when o.Certification_Display__c = 'ISO 10002' then 'ISO 10002'
when o.Certification_Display__c = 'ISO 14001,' then 'ISO 14001'
when o.Certification_Display__c = 'ISO 17100' then 'ISO 17100'
when o.Certification_Display__c = 'ISO 20000-1' then 'ISO 20000-1'
when o.Certification_Display__c = 'ISO 22000' then 'ISO 22000'
when o.Certification_Display__c = 'ISO 22301' then 'ISO 22301'
when o.Certification_Display__c = 'ISO 27001' then 'ISO 27001'
when o.Certification_Display__c = 'ISO 27018' then 'ISO 27018'
when o.Certification_Display__c = 'ISO 31000' then 'ISO 31000'
when o.Certification_Display__c = 'ISO 50001' then 'ISO 50001'
when o.Certification_Display__c = 'ISO 9001' then 'ISO 9001'
when o.Certification_Display__c = 'OHSAS 18001' then 'OHSAS 18001' end [Service]
FROM Salesforce..Account a
inner join Salesforce..Opportunity o ON a.Id = o.AccountId
WHERE QMSClientCheck__c = 'true' and IsActive__c = 'true'