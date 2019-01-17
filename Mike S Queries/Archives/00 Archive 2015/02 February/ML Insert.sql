SELECT ml.URN
INTO #Leads
FROM Salesforce..Lead l
inner join SalesforceReporting..[ML-FebruaryData-2015] ml ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = ml.Phone

UNION
SELECT ml.URN
FROM Salesforce..Lead l
inner join SalesforceReporting..[ML-FebruaryData-2015] ml ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') = ml.Phone
UNION
SELECT ml.urn
FROM Salesforce..Lead l
inner join SalesforceReporting..[ML-FebruaryData-2015] ml ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') = ml.Phone

SELECT ml.Company, ml.Street, ml.City, ml.State, ml.PostalCode, ml.Phone, ml.Title, ml.FirstName, ml.LastName,ml.Position__c,
ml.Website, ml.FT_Employees__c, s.[SIC Code 1] SIC2007_Code__c, s.Description SIC2007_Description__c, 
ml.SIC2007_Code2__c, ml.SIC2007_Description2__c, ml.SIC2007_Code3__c,ml.SIC2007_Description3__c, '2015-02-13' Completed_Date__c,
'ML Update' Source__c, case when af.[SIC Code 2007] is not null then 'Affinity - Key' else 'Cold' end Affinity_Cold__c
FROM SalesforceReporting..[ML-FebruaryData-2015] ml
left outer join #Leads l ON ml.URN = l.URN
left outer join SalesforceReporting..SICCodes2007 s ON ml.SIC2007_Code3__c = s.[SIC Code 3]
left outer join SalesforceReporting..AffinitySICCodes af ON ml.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE l.URN is null and IsTPS__c is null

DROP TABLE #Leads