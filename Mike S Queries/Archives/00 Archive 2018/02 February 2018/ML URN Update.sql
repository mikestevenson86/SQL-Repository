UPDATE l
SET NEW_ML_URN = ml.URN
FROM SalesforceReporting..Lead_Bkp l
inner join SalesforceReporting..MLMainDataSet ml ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
													= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(ml.[Telephone Number], '') <> '' and l.Status <> 'Approved'

UPDATE l
SET NEW_ML_URN = ml.URN
FROM SalesforceReporting..Lead_Bkp l
inner join SalesforceReporting..MLMainDataSet ml ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
													= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(ml.[Telephone Number], '') <> '' and l.Status <> 'Approved'

UPDATE l
SET NEW_ML_URN = ml.URN
FROM SalesforceReporting..Lead_Bkp l
inner join SalesforceReporting..MLMainDataSet ml ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
													= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(ml.[Telephone Number], '') <> '' and l.Status <> 'Approved'

UPDATE l
SET NEW_ML_URN = ml.URN
FROM SalesforceReporting..Lead_Bkp l
inner join SalesforceReporting..MLMainDataSet ml ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','')
													and REPLACE(l.PostalCode,' ','') = REPLACE(ml.PostCode,' ','')
WHERE ISNULL(ml.[Business Name], '') <> '' and ISNULL(ml.Postcode, '') <> '' and l.Status <> 'Approved'

UPDATE l
SET NEW_ML_URN = ml.URN
FROM SalesforceReporting..Lead_Bkp l
inner join SalesforceReporting..MLMainDataSet ml ON ml.cro_number = l.Co_Reg__c
WHERE ISNULL(ml.cro_number, '') <> '' and l.Status <> 'Approved'

SELECT COUNT(Id)
FROM SalesforceReporting..Lead_Bkp
WHERE ISNULL(Market_Location_URN__c, '') <> '' and RecordTypeId = '012D0000000NbJsIAK'

SELECT COUNT(Id)
FROM SalesforceReporting..Lead_Bkp
WHERE ISNULL(NEW_ML_URN, '') <> ''