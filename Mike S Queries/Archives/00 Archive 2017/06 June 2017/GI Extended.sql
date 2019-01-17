/*
UPDATE SalesforceReporting..GI_Matches
SET ML_URN = ml.URN
FROM SalesforceReporting..GI_Matches gi 
left outer join SalesforceReporting..GI_Universe giu ON gi.GI_id = giu.[Registration Number]
left outer join MarketLocation..MainDataSet ml ON REPLACE(case when giu.[Phone number] like '0%' then giu.[Phone number] else '0'+giu.[Phone number] end,' ','')
												= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE 
ISNULL(giu.[Phone number],'') <> ''
and
ISNULL(giu.ML_URN,'') = ''
and
ISNULL(ml.URN,'') <> ''
*/

SELECT 
GI_Id, SFDC_Id, ML_URN, 
GI_COMPANY, SFDC_COMPANY, ML_COMPANY, 
GI_POSTCODE, SFDC_POSTCODE, ML_POSTCODE ,
GI_PHONE, SFDC_PHONE, ML_PHONE,
GI_Id, SFDC_CO_REG, ML_CO_REG

FROM 
SalesforceReporting..GI_Matches

WHERE
ISNULL(SFDC_Id,'') <> '' or ISNULL(ML_URN,'') <> ''