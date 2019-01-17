SELECT a.Id SFDC_Id, a.CreatedDate, a.LastModifiedDate, a.Sage_Id__c SageCode, a.Name CompanyName, a.BillingStreet Address1, 
a.BillingCity Address2, a.BillingPostalCode PostCode, sc.Description, a.Sector__c Sector, MIN(c.StartDate) EarliestContractDate, 
MIN(c.EndDate) NextRenewalDate, a.TEXT_Services_Taken_Long_Consultant__c AllServices, Industry [ATLAS Sector Type]
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
left outer join SalesforceReporting..SICCodes2007 sc ON a.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null and a.ParentId is null
GROUP BY a.Id , a.CreatedDate, a.LastModifiedDate, a.Sage_Id__c , a.Name , a.BillingStreet , 
a.BillingCity , a.BillingPostalCode , sc.Description, a.Sector__c , 
a.TEXT_Services_Taken_Long_Consultant__c, Industry

SELECT fa.Id FranchiseId, fa.Name FranchiseCompany, a.Id SFDC_Id, a.CreatedDate, a.LastModifiedDate, a.Sage_Id__c SageCode, a.Name CompanyName, a.BillingStreet Address1,
a.BillingCity Address2, a.BillingPostalCode PostCode, sc.Description, a.Sector__c Sector, MIN(c.StartDate) EarliestContractDate, 
MIN(c.EndDate) NextRenewalDate, a.TEXT_Services_Taken_Long_Consultant__c AllServices, a.Industry [ATLAS Sector Type]
FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
inner join Salesforce..Account fa ON a.ParentId = fa.Id
left outer join SalesforceReporting..SICCodes2007 sc ON a.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null and a.ParentId is not null
GROUP BY fa.Id, fa.Name, a.Id , a.CreatedDate, a.LastModifiedDate, a.Sage_Id__c , a.Name , a.BillingStreet , 
a.BillingCity , a.BillingPostalCode , sc.Description, a.Sector__c , 
a.TEXT_Services_Taken_Long_Consultant__c, a.Industry

SELECT a.Id AccountId, c.Id SFDC_Id, c.CreatedDate, c.LastModifiedDate, c.Sage_Id__c SageCode, a.Name CompanyName, c.Renewal_Type__c,

case when Services_Taken_AI_Only_HS__c = 'true' then 'A&I Only H&S, ' else '' end +
case when Services_Taken_AI_Only__c = 'true' then 'A&I Only EL & HR, ' else '' end +
case when Services_Taken_Advice_Only_HS__c = 'true' then 'Advice Only H&S, ' else '' end +
case when Services_Taken_Advice_Only__c = 'true' then 'Advice Only EL & HR, ' else '' end +
case when Services_Taken_Consultancy__c = 'true' then 'Consultancy, ' else '' end +
case when Services_Taken_EL__c = 'true' then 'EL & HR, ' else '' end +
case when Services_Taken_Env__c = 'true' then 'Environmental, ' else '' end +
case when Services_Taken_FRA__c = 'true' then 'Fire Risk Assessments, ' else '' end +
case when Services_Taken_Franchise_Comp_EL__c = 'true' then 'Franchise - Comprehensive EL & HR, ' else '' end +
case when Services_Taken_Franchise_Comp_HS__c = 'true' then 'Franchise - Comprehensive H&S, ' else '' end +
case when Services_Taken_Franchise_Entry_EL__c = 'true' then 'Franchise - Entry Level EL & HR, ' else '' end +
case when Services_Taken_Franchise_Entry_HS__c = 'true' then 'Franchise - Entry Level H&S, ' else '' end +
case when Services_Taken_HS__c = 'true' then 'H&S, ' else '' end +
case when Services_Taken_JIT__c = 'true' then 'JIT Tribunal, ' else '' end +
case when Services_Taken_SBP__c = 'true' then 'Small Business Package, ' else '' end +
case when Services_Taken_Training__c = 'true' then 'Training, ' else '' end +
case when Services_Taken_eRAMS__c = 'true' then 'eRAMS, ' else '' end +
case when Business_Defence__c = 'true' then 'Business Defence, ' else '' end +
case when CQC__c = 'true' then 'CQC, ' else '' end +
case when Online_Tools_Only__c = 'true' then 'Online Tools Only, ' else '' end ServicesTaken,

 a.BillingStreet Address1, a.BillingCity Address2, a.BillingPostalCode PostCode, sc.Description, a.Sector__c Sector
FROM Salesforce..Contract c
inner join Salesforce..Account a ON c.AccountId = a.Id
left outer join SalesforceReporting..SICCodes2007 sc ON a.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null

SELECT con.AccountId, con.Id SFDC_Id, con.CreatedDate, con.LastModifiedDate, a.Sage_Id__c SageCode, a.Name, con.MailingStreet Address1,
con.MailingCity Address2, con.MailingPostalCode PostCode, con.Name, con.Position__c, con.Phone, con.Email, sc.Description, a.Sector__c Sector
FROM Salesforce..Contact con
inner join Salesforce..Account a ON con.AccountId = a.Id
inner join Salesforce..Contract c ON a.Id = c.AccountId
left outer join SalesforceReporting..SICCodes2007 sc ON a.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null

SELECT s.Account__c AccountId, s.Id SFDC_Id, s.CreatedDate, s.LastModifiedDate, a.Sage_Id__c SageCode, a.Name, s.Site_Type__c SiteType, 
s.Street__c SiteAddress1, s.City__c SiteAddress2, s.Postcode__c SitePostCode, sc.Description, a.Sector__c Sector
FROM Salesforce..Site__c s
inner join Salesforce..Account a ON s.Account__c = a.Id
inner join Salesforce..Contract c ON a.Id = c.AccountId
left outer join SalesforceReporting..SICCodes2007 sc ON a.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null