SELECT *
FROM
(
SELECT 
Id, 
ml.update_band MLRecencyBanding__c, 
case when ml.update_band = 'A' then DATEADD(week,-2,GETDATE())
when ml.update_band = 'B' then DATEADD(week,-8,GETDATE())
when ml.update_band = 'C' then DATEADD(week,-18,GETDATE())
when ml.update_band = 'D' then DATEADD(week,-30,GETDATE())
when ml.update_band = 'E' then DATEADD(week,-42,GETDATE()) end MLEstimatedRecencyDate__c

FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON l.Market_Location_URN__c = ml.URN

WHERE update_band in ('A','B','C','D','E')
UNION
SELECT 
Id, 
ml.update_band MLRecencyBanding__c, 
case when ml.update_band = 'A' then DATEADD(week,-2,GETDATE())
when ml.update_band = 'B' then DATEADD(week,-8,GETDATE())
when ml.update_band = 'C' then DATEADD(week,-18,GETDATE())
when ml.update_band = 'D' then DATEADD(week,-30,GETDATE())
when ml.update_band = 'E' then DATEADD(week,-42,GETDATE()) end MLEstimatedRecencyDate__c

FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON
											REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') 
											and 
											REPLACE(ml.Postcode,' ','') = REPLACE(l.PostalCode,' ','')

WHERE update_band in ('A','B','C','D','E')
) detail

GROUP BY Id, MLRecencyBanding__c, MLEstimatedRecencyDate__c