SELECT a.Id, c.CompanyName, ct.uid [CitWeb ID]
FROM SalesforceReporting..MissingCitWebID c
inner join Salesforce..Account a ON c.SalesForceAccountId = a.Id
left outer join [database].CitationMain.dbo.citation_CompanyTable2 ct ON REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','') collate latin1_general_CI_AS
																	= REPLACE(case when ct.contactPhone like '0%' then ct.contactPhone else '0'+ct.contactPhone end,' ','')  collate latin1_general_CI_AS
WHERE a.Phone <> '0' and contactPhone is not null

SELECT a.Id, c.CompanyName, ct.uid [CitWeb ID]
FROM SalesforceReporting..MissingCitWebID c
inner join Salesforce..Account a ON c.SalesForceAccountId = a.Id
left outer join [database].CitationMain.dbo.citation_CompanyTable2 ct ON REPLACE(REPLACE(REPLACE(a.Name,'Ltd',''),'Limited',''),' ','') collate latin1_general_CI_AS = REPLACE(REPLACE(REPLACE(ct.coName,'Ltd',''),'Limited',''),' ','') collate latin1_general_CI_AS
																		and REPLACE(a.BillingPostalCode,' ','') collate latin1_general_CI_AS = REPLACE(ct.postcode,' ','') collate latin1_general_CI_AS
WHERE ct.coName is not null

SELECT c.CitwebId, c.CompanyName, a.Id [SFDC ID]
FROM SalesforceReporting..MissingSFDCID c
inner join [database].CitationMain.dbo.citation_CompanyTable2 ct ON c.CitwebId = ct.UID
left outer join Salesforce..Account a ON REPLACE(case when ct.contactPhone like '0%' then ct.contactPhone else '0'+ct.contactPhone end,' ','')  collate latin1_general_CI_AS
										= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','') collate latin1_general_CI_AS
WHERE ct.ContactPhone <> '' and a.Phone <> '0'

SELECT c.CitwebId, c.CompanyName, a.Id [SFDC ID]
FROM SalesforceReporting..MissingSFDCID c
inner join [database].CitationMain.dbo.citation_CompanyTable2 ct ON c.CitwebId = ct.UID
left outer join Salesforce..Account a ON REPLACE(REPLACE(REPLACE(ct.coName,'Ltd',''),'Limited',''),' ','') collate latin1_general_CI_AS = REPLACE(REPLACE(REPLACE(a.Name,'Ltd',''),'Limited',''),' ','') collate latin1_general_CI_AS
										and REPLACE(ct.postcode,' ','') collate latin1_general_CI_AS = REPLACE(a.BillingPostalCode,' ','') collate latin1_general_CI_AS
WHERE a.BillingPostalCode is not null