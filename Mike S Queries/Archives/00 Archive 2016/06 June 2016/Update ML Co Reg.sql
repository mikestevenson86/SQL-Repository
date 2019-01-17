SELECT Id, ml.cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(case when l.Phone like '0%' then l.phone else '0'+l.Phone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number <> '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
UNION
SELECT Id, ml.cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number <> '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
UNION
SELECT Id, ml.cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number <> '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
UNION
SELECT Id, ml.cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','')
											and REPLACE(l.PostalCode,' ','') = REPLACE(ml.PostCode,' ','')
WHERE ml.cro_number <> '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
----------------------------------------------------------------------------------------------------------------------------------------------
SELECT Id, 'ML-'+ml.URN
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(case when l.Phone like '0%' then l.phone else '0'+l.Phone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number = '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
UNION
SELECT Id, 'ML-'+ml.URN
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number = '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
UNION
SELECT Id, 'ML-'+ml.URN
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number = '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
UNION
SELECT Id, 'ML-'+ml.URN
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','')
											and REPLACE(l.PostalCode,' ','') = REPLACE(ml.PostCode,' ','')
WHERE ml.cro_number = '' and (RecordTypeId not in ('012D0000000KKTvIAO') or RecordTypeId is null)
----------------------------------------------------------------------------------------------------------------------------------------------
SELECT Id, ml.cro_number
FROM Salesforce..Account a
inner join MarketLocation..MainDataSet ml ON REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number <> ''
UNION
SELECT Id, ml.cro_number
FROM Salesforce..Account a
inner join MarketLocation..MainDataSet ml ON REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','')
											and REPLACE(a.BillingPostalCode,' ','') = REPLACE(ml.PostCode,' ','')
WHERE ml.cro_number <> ''
----------------------------------------------------------------------------------------------------------------------------------------------
SELECT Id, 'ML-'+ml.URN
FROM Salesforce..Account a
inner join MarketLocation..MainDataSet ml ON REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ml.[Telephone Number] <> '' and ml.cro_number = ''
UNION
SELECT Id, 'ML-'+ml.URN
FROM Salesforce..Account a
inner join MarketLocation..MainDataSet ml ON REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','')
											and REPLACE(a.BillingPostalCode,' ','') = REPLACE(ml.PostCode,' ','')
WHERE ml.cro_number = ''