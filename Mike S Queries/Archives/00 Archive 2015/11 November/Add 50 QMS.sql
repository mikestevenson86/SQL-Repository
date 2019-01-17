SELECT l.Company, l.PostalCode, l.Phone
INTO #NBS
FROM Salesforce..Lead l
WHERE RecordTypeId = '012D0000000NbJtIAK'

SELECT l.Id
INTO #Temp
FROM Salesforce..Lead l
left outer join SalesforceReporting..QMSClients cl ON REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') = REPLACE(case when cl.Phone1 like '0%' then cl.Phone1 else '0'+cl.Phone1 end,' ','')
WHERE Suspended_Closed_Reason__c <> 'Duplicate' and SIC2007_Code3__c in
(
71129,82990,42990,43999,71111,81210,62090,77390,41202,62012,61900,78300,43210,70229,71200,18130,71122,43220,86900,62020,28230,52219,38320,
32990,43290,28990,27120,85590,80200,45200,43320,52290,36000,58190,31010,37000,43910,87900,28250,26513,38220,71121,52103,27900,49410,32500,28220
) 
and cl.Id is null

SELECT l.Id
INTO #Temp2
FROM Salesforce..Lead l
inner join #Temp t ON l.Id = t.Id
left outer join SalesforceReporting..QMSClients cl ON REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','') = REPLACE(case when cl.Phone1 like '0%' then cl.Phone1 else '0'+cl.Phone1 end,' ','')
WHERE cl.Id is null

SELECT l.Id
INTO #Temp3
FROM Salesforce..Lead l
inner join #Temp2 t ON l.Id = t.Id
left outer join SalesforceReporting..QMSClients cl ON REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','') = REPLACE(case when cl.Phone1 like '0%' then cl.Phone1 else '0'+cl.Phone1 end,' ','')
WHERE cl.Id is null

SELECT l.Id
INTO #Temp4
FROM Salesforce..Lead l
inner join #Temp3 t ON l.Id = t.Id
left outer join SalesforceReporting..QMSClients cl ON REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') = REPLACE(case when cl.Phone2 like '0%' then cl.Phone2 else '0'+cl.Phone2 end,' ','')
WHERE cl.Id is null

SELECT l.Id
INTO #Temp5
FROM Salesforce..Lead l
inner join #Temp4 t ON l.Id = t.Id
left outer join SalesforceReporting..QMSClients cl ON REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','') = REPLACE(case when cl.Phone2 like '0%' then cl.Phone2 else '0'+cl.Phone2 end,' ','')
WHERE cl.Id is null

SELECT L.Id
INTO #Temp6
FROM Salesforce..Lead l
inner join #Temp5 t ON l.Id = t.Id
left outer join SalesforceReporting..QMSClients cl ON REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','') = REPLACE(case when cl.Phone2 like '0%' then cl.Phone2 else '0'+cl.Phone2 end,' ','')
WHERE cl.Id is null

SELECT * INTO SalesforceReporting..NewQMS
FROM
(
SELECT SIC2007_Code3__c, L.Id, ROW_NUMBER () OVER (PARTITION BY SIC2007_Code3__c ORDER BY l.Id) rn
FROM Salesforce..Lead l
inner join #Temp6 t ON l.Id = t.Id
left outer join SalesforceReporting..QMSClients cl ON REPLACE(PostalCode,' ','') = REPLACE(PostCode,' ','')
													and REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(cl.Company,'Ltd',''),'Limited','')
left outer join #NBS n ON l.Company = n.Company and l.PostalCode = n.PostalCode and l.Phone = n.Phone
WHERE cl.Id is null and RecordTypeId <> '012D0000000NbJtIAK' and n.Company is null and l.Phone is not null and l.Phone <> '' and Status <> 'callback Requested' and Suspended_Closed_Reason__c <> 'Do Not Call'
) detail
WHERE detail.rn < 51
ORDER BY SIC2007_Code3__c

DROP TABLE #Temp
DROP TABLE #Temp2
DROP TABLE #Temp3
DROP TABLE #Temp4
DROP TABLE #Temp5
DROP TABLE #Temp6
DROP TABLE #NBS