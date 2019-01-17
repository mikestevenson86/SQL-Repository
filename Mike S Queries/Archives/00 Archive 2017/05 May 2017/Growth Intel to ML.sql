UPDATE SalesforceReporting..GI_May2017
SET ML_URN = ml.URN
FROM SalesforceReporting..GI_May2017 gi
inner join [LSAUTOMATION].LEADS_ODS.ml.MainDataSet ml ON gi.[Company Registration] collate latin1_general_CI_AS = ml.cro_number collate latin1_general_CI_AS 
WHERE ISNULL(gi.[Company Registration],'') <> ''

UPDATE SalesforceReporting..GI_May2017
SET ML_URN = ml.URN
FROM SalesforceReporting..GI_May2017 gi
inner join [LSAUTOMATION].LEADS_ODS.ml.MainDataSet ml ON REPLACE(REPLACE(gi.[Company Name],'Ltd',''),'Limited','') collate latin1_general_CI_AS  = REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') collate latin1_general_CI_AS 
														and REPLACE(gi.Postcode,' ','') collate latin1_general_CI_AS  = REPLACE(ml.Postcode,' ','') collate latin1_general_CI_AS 
WHERE ISNULL(gi.[Company Name],'') <> '' and ISNULL(gi.Postcode,'') <> ''

UPDATE SalesforceReporting..GI_May2017
SET ML_URN = ml.URN
FROM SalesforceReporting..GI_May2017 gi
inner join [LSAUTOMATION].LEADS_ODS.ml.MainDataSet ml ON REPLACE(case when gi.[Phone Number] like '0%' then gi.[Phone Number] else '0'+gi.[Phone Number] end,' ','') collate latin1_general_CI_AS 
														= REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS 
WHERE ISNULL(gi.[Phone Number],'') not in ('','0')