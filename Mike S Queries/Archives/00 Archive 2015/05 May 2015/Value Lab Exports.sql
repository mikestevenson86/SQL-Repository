SELECT ParentId
INTO #Franchise
FROM Salesforce..Account
WHERE ParentId is not null
GROUP BY ParentID

SELECT 
a.Id SFDC_Id,
a.CreatedDate,
a.LastModifiedDate,
a.Sage_Id__c SageCode,
a.Name CompanyName, 
a.BillingStreet Address1, 
a.BillingCity Address2,
a.BillingPostalCode PostCode, 
sc.Description, 
a.Sector__c Sector,
MIN(c.StartDate) EarliestContractDate,
MIN(c.EndDate) NextRenewalDate,
a.TEXT_Services_Taken_Long_Consultant__c AllServices

FROM Salesforce..Account a
left outer join SalesforceReporting..SIC1 sc ON a.SIC2007_Code__c = sc.[SIC Code 1]
left outer join Salesforce..Contract c ON a.Id = c.AccountId
left outer join #Franchise f ON a.Id = f.ParentId
WHERE f.ParentId is null and a.ParentId is null and c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
GROUP BY
a.Id , 
a.CreatedDate,
a.LastModifiedDate,
a.Sage_Id__c,
a.Name , 
a.BillingStreet , 
a.BillingCity ,
a.BillingPostalCode , 
sc.Description , 
a.Sector__c ,
a.TEXT_Services_Taken_Long_Consultant__c

SELECT 
a.Id FranchiseId, 
a.Name FranchiseCompany, 
a2.Id SFDC_Id, 
a2.CreatedDate,
a2.LastModifiedDate,
a2.Sage_Id__c SageCode,
a2.Name SFDC_Company,
a2.BillingStreet Address1,
a2.BillingCity Address2,
a2.BillingPostalCode PostCode,
sc.Description,
a2.Sector__c Sector,
MIN(c.StartDate) EarliestContractDate,
MIN(c.EndDate) NextRenewalDate,
a.TEXT_Services_Taken_Long_Consultant__c AllServices

FROM Salesforce..Account a
inner join #Franchise f ON a.Id = f.ParentId
left outer join SalesforceReporting..SIC1 sc ON a.SIC2007_Code__c = sc.[SIC Code 1]
left outer join Salesforce..Account a2 ON a.Id = a2.ParentId
left outer join Salesforce..Contract c ON a2.Id = c.AccountId
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
GROUP BY 
a.Id , 
a.Name , 
a2.Id ,
a2.CreatedDate,
a2.LastModifiedDate,
a2.Sage_Id__c, 
a2.Name ,
a2.BillingStreet ,
a2.BillingCity ,
a2.BillingPostalCode ,
sc.Description,
a2.Sector__c,
a.TEXT_Services_Taken_Long_Consultant__c

ORDER BY FranchiseId

SELECT a.Id AccId
INTO #Clients
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
GROUP BY a.Id

SELECT 
a.Id AccountId,
c.Id SFDC_Id,
c.CreatedDate,
c.LastModifiedDate,
Sage_Contract_Number__c SageCode,
a.Name CompanyName,

case when c.Services_Taken_AI_Only_HS__c = 'true' then 'Health & Safety A&I Only, ' else '' end +
case when c.Services_Taken_AI_Only__c = 'true' then 'Employment Law and HR A&I Only, ' else '' end +
case when c.Services_Taken_Advice_Only_HS__c = 'true' then 'Health & Safety Advice Only, ' else '' end +
case when c.Services_Taken_Advice_Only__c = 'true' then 'Employment Law and HR Advice Only, ' else '' end +
case when c.Services_Taken_Consultancy__c = 'true' then 'Consultancy, ' else '' end +
case when c.Services_Taken_EL__c = 'true' then 'Employment Law and HR, ' else '' end +
case when c.Services_Taken_Env__c = 'true' then 'Environmental, ' else '' end +
case when c.Services_Taken_FRA__c = 'true' then 'Fire Risk Assessments, ' else '' end +
case when c.Services_Taken_Franchise_Comp_EL__c = 'true' then 'Franchise - Comprehensive EL and HR, ' else '' end +
case when c.Services_Taken_Franchise_Comp_HS__c = 'true' then 'Franchise - Comprehensive Health & Safety, ' else '' end +
case when c.Services_Taken_Franchise_Entry_EL__c = 'true' then 'Franchise - Entry Level EL and HR, ' else '' end +
case when c.Services_Taken_Franchise_Entry_HS__c = 'true' then 'Franchise - Entry Level Health & Safety, ' else '' end +
case when c.Services_Taken_HS__c = 'true' then 'Health & Safety, ' else '' end +
case when c.Services_Taken_JIT__c = 'true' then 'JIT Tribunal, ' else '' end +
case when c.Services_Taken_SBP__c = 'true' then 'Small Business Package, ' else '' end +
case when c.Services_Taken_Training__c = 'true' then 'Training, ' else '' end +
case when c.Services_Taken_eRAMS__c = 'true' then 'eRAMs, ' else '' end +
case when c.CQC__c = 'true' then 'CQC, ' else '' end +
case when c.Online_Tools_Only__c = 'true' then 'Online Tools Only, ' else '' end +
case when c.Business_Defence__c = 'true, ' then 'Business Defence, ' else '' end ContractType,

c.Renewal_Type__c RenewalType, 
a.BillingStreet Address1, 
a.BillingCity Address2,
a.BillingPostalCode PostCode, 
sc.Description, 
a.Sector__c Sector

FROM Salesforce..Contract c
inner join #Clients cl ON c.AccountId = cl.AccId
inner join Salesforce..Account a ON cl.AccId = a.Id
left outer join SalesforceReporting..SIC1 sc ON a.SIC2007_Code__c = sc.[SIC Code 1]

SELECT 
a.Id AccountId,
c.Id SFDC_Id,
c.CreatedDate,
c.LastModifiedDate,
a.Sage_Id__c SageCode,
a.Name CompanyName, 
a.BillingStreet Address1, 
a.BillingCity Address2,
a.BillingPostalCode PostCode, 
c.Name,
c.Position__c,
c.Phone,
c.Email,
sc.Description, 
a.Sector__c Sector

FROM Salesforce..Contact c
inner join #Clients cl ON c.AccountId = cl.AccId
inner join Salesforce..Account a ON cl.AccId = a.Id
left outer join SalesforceReporting..SIC1 sc ON a.SIC2007_Code__c = sc.[SIC Code 1]

SELECT
a.Id AccountId,
s.Id SFDC_Id,
s.CreatedDate,
s.LastModifiedDate,
a.Sage_Id__c SageCode,
a.Name CompanyName, 
s.Site_Type__c SiteType,
s.Street__c SiteAddress1,
s.City__c SiteAddress2,
s.Postcode__c SitePostCode, 
sc.Description, 
a.Sector__c Sector

FROM Salesforce..Site__c s
inner join #Clients cl ON s.Account__c = cl.AccId
inner join Salesforce..Account a ON cl.AccId = a.Id
left outer join SalesforceReporting..SIC1 sc ON a.SIC2007_Code__c = sc.[SIC Code 1]

DROP TABLE #Clients

DROP TABLE #Franchise