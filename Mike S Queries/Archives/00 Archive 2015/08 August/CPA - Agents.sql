SELECT sc.Description, u.Name, SUM(case when call_type in (0,2,4) then 1 else 0 end) Connects
INTO #Temp0
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c and u.ProfileId <> '00eD0000001Iz3LIAS' and u.IsActive = 'true'
inner join SalesforceReporting..SIC1 sc ON l.SIC2007_Code__c = sc.[SIC Code 1]
WHERE act_date between '2015-01-01' and '2015-06-30'
GROUP BY sc.Description, u.Name
ORDER BY sc.Description, u.Name

SELECT u.Name, sc.Description, COUNT(l.Id) Callbacks
INTO #CB0
FROM Salesforce..Lead l
inner join SalesforceReporting..SIC1 sc ON l.SIC2007_Code__c = sc.[SIC Code 1]
inner join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE l.Status = 'Callback Requested'
GROUP BY u.Name, sc.Description

SELECT *
FROM 
(
SELECT sc.Description, u.Name,
ROW_NUMBER () OVER (PARTITION BY  sc.Description ORDER BY COUNT(l.Id) DESC) [Rank],
COUNT(l.Id) Appts, SUM(case when o.SAT_Date__c is not null then 1 else 0 end) SAT, t0.Connects, cb.Callbacks
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id and u.ProfileId <> '00eD0000001Iz3LIAS' and u.IsActive = 'true'
inner join SalesforceReporting..SIC1 sc ON l.SIC2007_Code__c = sc.[SIC Code 1]
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join #Temp0 t0 ON sc.Description = t0.Description and u.Name = t0.Name
left outer join #CB0 cb ON u.Name = cb.Name and sc.Description = cb.Description
WHERE Date_Made__c >= '2015-01-01' and Date_Made__c <= '2015-06-30'
GROUP BY sc.Description, u.Name, t0.Connects, cb.Callbacks
) detail
WHERE [RANK] between 1 and 10
ORDER BY Description, [Rank]

SELECT af.Sector, u.Name, SUM(case when call_type in (0,2,4) then 1 else 0 end) Connects
INTO #Temp
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c and u.ProfileId <> '00eD0000001Iz3LIAS' and u.IsActive = 'true'
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE act_date between '2015-01-01' and '2015-06-30'
GROUP BY af.Sector, u.Name
ORDER BY af.Sector, u.Name

SELECT u.Name, af.Sector, COUNT(l.Id) Callbacks
INTO #CB
FROM Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
inner join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE l.Status = 'Callback Requested'
GROUP BY u.Name, af.Sector

SELECT *
FROM 
(
SELECT af.Sector, u.Name, 
ROW_NUMBER () OVER (PARTITION BY af.Sector ORDER BY COUNT(l.Id) DESC) [Rank],
COUNT(l.Id) Appts, SUM(case when o.SAT_Date__c is not null then 1 else 0 end) SAT, t.Connects, cb.Callbacks
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id and u.ProfileId <> '00eD0000001Iz3LIAS' and u.IsActive = 'true'
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join #Temp t ON af.Sector = t.Sector and u.Name = t.Name
left outer join #CB cb ON u.Name = cb.Name and af.Sector = cb.Sector
WHERE Date_Made__c >= '2015-01-01' and Date_Made__c <= '2015-06-30'
GROUP BY af.Sector, u.Name, t.Connects, cb.Callbacks
) detail
WHERE [RANK] between 1 and 10
ORDER BY Sector, [Rank]

DROP TABLE #Temp
DROP TABLE #Temp0
DROP TABLE #CB
DROP TABLE #CB0