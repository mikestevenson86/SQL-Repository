SELECT l.Id, ml.*, s.[SIC Code 1], s.Description
FROM Salesforce..Lead l
inner join SalesforceReporting..[ML-FebruaryData-2015] ml ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = ml.Phone
inner join SalesforceReporting..SICCodes2007 s ON ml.SIC2007_Code3__c = s.[SIC Code 3]
WHERE Status not in ('Callback Requested','Approved')

SELECT l.Id, ml.*, s.[SIC Code 1] SIC2007_Code__c, s.Description SIC2007_Description__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[ML-FebruaryData-2015] ml ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') = ml.Phone
inner join SalesforceReporting..SICCodes2007 s ON ml.SIC2007_Code3__c = s.[SIC Code 3]
WHERE Status not in ('Callback Requested','Approved')

SELECT l.Id, ml.*, s.[SIC Code 1] SIC2007_Code__c, s.Description SIC2007_Description__c
FROM Salesforce..Lead l
inner join SalesforceReporting..[ML-FebruaryData-2015] ml ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') = ml.Phone
inner join SalesforceReporting..SICCodes2007 s ON ml.SIC2007_Code3__c = s.[SIC Code 3]
WHERE Status not in ('Callback Requested','Approved')