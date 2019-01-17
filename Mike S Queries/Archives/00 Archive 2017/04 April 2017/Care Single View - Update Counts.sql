SELECT 'CQC/LB - Telephone' [Join], COUNT(cqc.Id) Updates
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone else '0'+cqc.Telephone end,' ','')
												= REPLACE(case when ci.TelephoneNo like '0%' then ci.TelephoneNo else '0'+ci.TelephoneNo end,' ','')
WHERE ISNULL(cqc.Telephone,'') <> ''
UNION
SELECT 'CQC/LB - Manager Phone', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone else '0'+cqc.Telephone end,' ','')
												= REPLACE(case when ci.ManagerTelephoneNo like '0%' then ci.ManagerTelephoneNo else '0'+ci.ManagerTelephoneNo end,' ','')
WHERE ISNULL(cqc.Telephone,'') <> ''
UNION
SELECT 'CQC/LB - Co and Po', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.ServiceName,'Ltd',''),'Limited','')
												and REPLACE(cqc.PostCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.Name,'') <> '' and ISNULL(cqc.PostCode,'') <> ''
UNION
SELECT 'CQC/LB - Prov and Po', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.Provider,'Ltd',''),'Limited','')
												and REPLACE(cqc.PostCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.Name,'') <> '' and ISNULL(cqc.PostCode,'') <> ''
UNION
-- SFDC

SELECT 'SFDC - Telephone', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.SF_Phone like '0%' then cqc.SF_Phone else '0'+cqc.SF_Phone end,' ','')
												= REPLACE(case when ci.TelephoneNo like '0%' then ci.TelephoneNo else '0'+ci.TelephoneNo end,' ','')
WHERE ISNULL(cqc.SF_Phone,'') <> ''
UNION
SELECT 'SFDC - Manager Phone', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.SF_Phone like '0%' then cqc.SF_Phone else '0'+cqc.SF_Phone end,' ','')
												= REPLACE(case when ci.ManagerTelephoneNo like '0%' then ci.ManagerTelephoneNo else '0'+ci.ManagerTelephoneNo end,' ','')
WHERE ISNULL(cqc.SF_Phone,'') <> ''
UNION
SELECT 'SFDC - Co and Po', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.SF_Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.ServiceName,'Ltd',''),'Limited','')
												and REPLACE(cqc.SF_PostalCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.SF_Company,'') <> '' and ISNULL(cqc.SF_PostalCode,'') <> ''
UNION
SELECT 'SFDC Prov and Po', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.SF_Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.Provider,'Ltd',''),'Limited','')
												and REPLACE(cqc.SF_PostalCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.SF_Company,'') <> '' and ISNULL(cqc.SF_PostalCode,'') <> ''
UNION
-- ML

SELECT 'ML - Telephone', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.ML_TELEPHONE_NUMBER like '0%' then cqc.ML_TELEPHONE_NUMBER else '0'+cqc.ML_TELEPHONE_NUMBER end,' ','')
												= REPLACE(case when ci.TelephoneNo like '0%' then ci.TelephoneNo else '0'+ci.TelephoneNo end,' ','')
WHERE ISNULL(cqc.ML_TELEPHONE_NUMBER,'') <> ''
UNION
SELECT 'ML - Manager Phone', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.ML_TELEPHONE_NUMBER like '0%' then cqc.ML_TELEPHONE_NUMBER else '0'+cqc.ML_TELEPHONE_NUMBER end,' ','')
												= REPLACE(case when ci.ManagerTelephoneNo like '0%' then ci.ManagerTelephoneNo else '0'+ci.ManagerTelephoneNo end,' ','')
WHERE ISNULL(cqc.ML_TELEPHONE_NUMBER,'') <> ''
UNION
SELECT 'ML - Co and Po', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.ML_BUSINESS_NAME,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.ServiceName,'Ltd',''),'Limited','')
												and REPLACE(cqc.ML_POST_CODE,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.ML_BUSINESS_NAME,'') <> '' and ISNULL(cqc.ML_POST_CODE,'') <> ''
UNION
SELECT 'ML - Prov and Po', COUNT(cqc.Id)
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.ML_BUSINESS_NAME,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.Provider,'Ltd',''),'Limited','')
												and REPLACE(cqc.ML_POST_CODE,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.ML_BUSINESS_NAME,'') <> '' and ISNULL(cqc.ML_POST_CODE,'') <> ''