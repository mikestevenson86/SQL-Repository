/*SELECT Id, l.Company, l.PostalCode, ch.[ CompanyNumber]
FROM Salesforce..Lead l
inner join SalesforceReporting..CompaniesHouse ch ON REPLACE(REPLACE(l.Company,'LTd',''),'Limited','') = REPLACE(REPLACE(ch.CompanyName,'ltd',''),'Limited','')
													and REPLACE(l.PostalCode,' ','') = REPLACE(ch.[RegAddress PostCode],' ','')
WHERE l.Co_Reg__c is null and l.Status <> 'Approved'*/

SELECT l.ID, URN, cro_number
FROM
(
SELECT ID, URN, cro_number
FROM Salesforce..Lead l with(nolock)
inner join MarketLocation..MainDataSet_NEW ml with(nolock) ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(l.Phone,'') <> '' and cro_number <> '' and ml.[Telephone Number] <> ''
UNION
SELECT ID, URN, cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(l.MobilePhone,'') <> '' and cro_number <> '' and ml.[Telephone Number] <> ''
UNION
SELECT ID, URN, cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
											= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(l.Other_Phone__c,'') <> '' and cro_number <> '' and ml.[Telephone Number] <> ''
UNION
SELECT ID, URN, cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','')
											and REPLACE(l.PostalCode,' ','') = REPLACE(ml.PostCode,' ','')
WHERE cro_number <> ''
UNION
SELECT ID, URN, cro_number
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE cro_number <> ''
) detail
inner join Salesforce..Lead l ON detail.Id = l.Id
WHERE l.Co_Reg__c is null
GROUP BY l.ID, URN, cro_number

