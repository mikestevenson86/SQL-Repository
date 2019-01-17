SELECT o.Id, c.Contract_Value__c Value, c.ContractTerm, ROUND((c.Contract_Value__c/c.ContractTerm) * 12,2) AnnualValue
INTO #CValues
FROM Salesforce..Opportunity o
inner join Salesforce..Account a ON o.AccountId = a.Id
inner join Salesforce..Contract c ON a.Id = c.AccountId

------------------------------------------------------------------------------------------------------------------------

SELECT sc.Description, COUNT(l.Id) Appointments, SUM(case when o.StageName = 'Closed Won' then 1 else 0 end) Deals, SUM(ISNULL(cv.Value,0)) TValue, SUM(ISNULL(cv.AnnualValue,0)) AValue
INTO #Appts
FROM Salesforce..Lead l
inner join SalesforceReporting..SIC1 sc ON l.SIC2007_Code__c = sc.[SIC Code 1]
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join #CValues cv ON o.Id = cv.Id
WHERE Date_Made__c > '2014-10-22'
GROUP BY sc.Description

SELECT sc.Description, COUNT(l.Id) Prospects
INTO #Lds
FROM Salesforce..Lead l
inner join SalesforceReporting..SIC1 sc ON l.SIC2007_Code__c = sc.[SIC Code 1]
GROUP BY sc.Description

SELECT sc.Description [SIC Level 1], COUNT(seqno) Calls, ISNULL(ap.Appointments,0) Appointments, '' CTA, ISNULL(ld.Prospects,0) Prospects, ISNULL(ap.Deals,0) Deals, TValue [Total Value], AValue [Annualized Value]
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join SalesforceReporting..SIC1 sc ON l.SIC2007_Code__c = sc.[SIC Code 1]
left outer join #Appts ap ON sc.Description = ap.Description
left outer join #Lds ld ON sc.Description = ld.Description
WHERE ch.act_date > '2014-10-22' and ch.call_type in (0,2,4)
GROUP BY sc.Description, ap.Appointments, ld.Prospects, ap.Deals, ap.TValue, ap.AValue
ORDER BY sc.Description

DROP TABLE #Appts
DROP TABLE #Lds

----------------------------------------------------------------------------------------------------------------------------------

SELECT sc.[Description 2], COUNT(l.Id) Appointments, SUM(case when o.StageName = 'Closed Won' then 1 else 0 end) Deals, SUM(ISNULL(cv.Value,0)) TValue, SUM(ISNULL(cv.AnnualValue,0)) AValue
INTO #Appts2
FROM Salesforce..Lead l
inner join SalesforceReporting..SIC2 sc ON l.SIC2007_Code2__c = sc.[SIC Code 2]
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join #CValues cv ON o.Id = cv.Id
WHERE Date_Made__c > '2014-10-22'
GROUP BY sc.[Description 2]

SELECT sc.[Description 2], COUNT(l.Id) Prospects
INTO #Lds2
FROM Salesforce..Lead l
inner join SalesforceReporting..SIC2 sc ON l.SIC2007_Code2__c = sc.[SIC Code 2]
GROUP BY sc.[Description 2]

SELECT sc.[Description 2] [SIC Level 2], COUNT(seqno) Calls, ISNULL(ap.Appointments,0) Appointments, '' CTA, ISNULL(ld.Prospects,0) Prospects, ISNULL(ap.Deals,0) Deals, TValue [Total Value], AValue [Annualized Value]
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join SalesforceReporting..SIC2 sc ON l.SIC2007_Code2__c = sc.[SIC Code 2]
left outer join #Appts2 ap ON sc.[Description 2] = ap.[Description 2]
left outer join #Lds2 ld ON sc.[Description 2] = ld.[Description 2]
WHERE ch.act_date > '2014-10-22' and ch.call_type in (0,2,4)
GROUP BY sc.[Description 2], ap.Appointments, ld.Prospects, ap.Deals, ap.TValue, ap.AValue
ORDER BY sc.[Description 2]

DROP TABLE #Appts2
DROP TABLE #Lds2

-----------------------------------------------------------------------------------------------------------------------------------

SELECT sc.SIC_Description3, COUNT(l.Id) Appointments, SUM(case when o.StageName = 'Closed Won' then 1 else 0 end) Deals, SUM(ISNULL(cv.Value,0)) TValue, SUM(ISNULL(cv.AnnualValue,0)) AValue
INTO #Appts3
FROM Salesforce..Lead l
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.SIC_Code3
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join #CValues cv ON o.Id = cv.Id
WHERE Date_Made__c > '2014-10-22'
GROUP BY sc.SIC_Description3

SELECT sc.SIC_Description3, COUNT(l.Id) Prospects
INTO #Lds3
FROM Salesforce..Lead l
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.SIC_Code3
GROUP BY sc.SIC_Description3

SELECT sc.SIC_Description3 [SIC Level 3], COUNT(seqno) Calls, ISNULL(ap.Appointments,0) Appointments, '' CTA, ISNULL(ld.Prospects,0) Prospects, ISNULL(ap.Deals,0) Deals, TValue [Total Value], AValue [Annualized Value]
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.SIC_Code3
left outer join #Appts3 ap ON sc.SIC_Description3 = ap.SIC_Description3
left outer join #Lds3 ld ON sc.SIC_Description3 = ld.SIC_Description3
WHERE ch.act_date > '2014-10-22' and ch.call_type in (0,2,4)
GROUP BY sc.SIC_Description3, ap.Appointments, ld.Prospects, ap.Deals, ap.TValue, ap.AValue
ORDER BY sc.SIC_Description3

DROP TABLE #Appts3
DROP TABLE #Lds3

--------------------------------------------------------------------------------------------------------------------------------

SELECT sc.CitationSector, COUNT(l.Id) Appointments, SUM(case when o.StageName = 'Closed Won' then 1 else 0 end) Deals, SUM(ISNULL(cv.Value,0)) TValue, SUM(ISNULL(cv.AnnualValue,0)) AValue
INTO #ApptsCS
FROM Salesforce..Lead l
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.SIC_Code3
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join #CValues cv ON o.Id = cv.Id
WHERE Date_Made__c > '2014-10-22'
GROUP BY sc.CitationSector

SELECT sc.CitationSector, COUNT(l.Id) Prospects
INTO #LdsCS
FROM Salesforce..Lead l
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.SIC_Code3
GROUP BY sc.CitationSector

SELECT sc.CitationSector [Citation Sector], COUNT(seqno) Calls, ISNULL(ap.Appointments,0) Appointments, '' CTA, ISNULL(ld.Prospects,0) Prospects, ISNULL(ap.Deals,0) Deals, TValue [Total Value], AValue [Annualized Value]
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.SIC_Code3
left outer join #ApptsCS ap ON sc.CitationSector = ap.CitationSector
left outer join #LdsCS ld ON sc.CitationSector = ld.CitationSector
WHERE ch.act_date > '2014-10-22' and ch.call_type in (0,2,4)
GROUP BY sc.CitationSector, ap.Appointments, ld.Prospects, ap.Deals, ap.TValue, ap.AValue
ORDER BY sc.CitationSector

DROP TABLE #ApptsCS
DROP TABLE #LdsCS
DROP TABLE #CValues