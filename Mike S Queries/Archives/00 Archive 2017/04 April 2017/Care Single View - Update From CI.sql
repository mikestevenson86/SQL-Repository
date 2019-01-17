-- ML

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.ML_BUSINESS_NAME,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.Provider,'Ltd',''),'Limited','')
												and REPLACE(cqc.ML_POST_CODE,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.ML_BUSINESS_NAME,'') <> '' and ISNULL(cqc.ML_POST_CODE,'') <> ''


UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.ML_TELEPHONE_NUMBER like '0%' then cqc.ML_TELEPHONE_NUMBER else '0'+cqc.ML_TELEPHONE_NUMBER end,' ','')
												= REPLACE(case when ci.ManagerTelephoneNo like '0%' then ci.ManagerTelephoneNo else '0'+ci.ManagerTelephoneNo end,' ','')
WHERE ISNULL(cqc.ML_TELEPHONE_NUMBER,'') <> ''

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.ML_BUSINESS_NAME,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.ServiceName,'Ltd',''),'Limited','')
												and REPLACE(cqc.ML_POST_CODE,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.ML_BUSINESS_NAME,'') <> '' and ISNULL(cqc.ML_POST_CODE,'') <> ''

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.ML_TELEPHONE_NUMBER like '0%' then cqc.ML_TELEPHONE_NUMBER else '0'+cqc.ML_TELEPHONE_NUMBER end,' ','')
												= REPLACE(case when ci.TelephoneNo like '0%' then ci.TelephoneNo else '0'+ci.TelephoneNo end,' ','')
WHERE ISNULL(cqc.ML_TELEPHONE_NUMBER,'') <> ''

-- SFDC

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.SF_Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.Provider,'Ltd',''),'Limited','')
												and REPLACE(cqc.SF_PostalCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.SF_Company,'') <> '' and ISNULL(cqc.SF_PostalCode,'') <> ''

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.SF_Phone like '0%' then cqc.SF_Phone else '0'+cqc.SF_Phone end,' ','')
												= REPLACE(case when ci.ManagerTelephoneNo like '0%' then ci.ManagerTelephoneNo else '0'+ci.ManagerTelephoneNo end,' ','')
WHERE ISNULL(cqc.SF_Phone,'') <> ''
UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.SF_Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.ServiceName,'Ltd',''),'Limited','')
												and REPLACE(cqc.SF_PostalCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.SF_Company,'') <> '' and ISNULL(cqc.SF_PostalCode,'') <> ''

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.SF_Phone like '0%' then cqc.SF_Phone else '0'+cqc.SF_Phone end,' ','')
												= REPLACE(case when ci.TelephoneNo like '0%' then ci.TelephoneNo else '0'+ci.TelephoneNo end,' ','')
WHERE ISNULL(cqc.SF_Phone,'') <> ''

--CQC/LB

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.Provider,'Ltd',''),'Limited','')
												and REPLACE(cqc.PostCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.Name,'') <> '' and ISNULL(cqc.PostCode,'') <> ''

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone else '0'+cqc.Telephone end,' ','')
												= REPLACE(case when ci.ManagerTelephoneNo like '0%' then ci.ManagerTelephoneNo else '0'+ci.ManagerTelephoneNo end,' ','')
WHERE ISNULL(cqc.Telephone,'') <> ''

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(REPLACE(cqc.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(ci.ServiceName,'Ltd',''),'Limited','')
												and REPLACE(cqc.PostCode,' ','') = REPLACE(ci.Postcode,' ','')
WHERE ISNULL(cqc.Name,'') <> '' and ISNULL(cqc.PostCode,'') <> ''

UPDATE CQC..CARE_SINGLE_VIEW
SET
CI_CaseNumber = CaseNumber,
CI_ServiceName = ServiceName,
CI_ServiceType = ci.ServiceType,
CI_DateofRegistration = DateofRegistration,
CI_Address1 = Address1,
CI_Address2 = Address2,
CI_Address3 = Address3,
CI_Address4 = Address4,
CI_City = ci.City,
CI_Postcode = ci.Postcode,
CI_TelephoneNo = TelephoneNo,
CI_FaxNo = FaxNo,
CI_ManagerName = ManagerName,
CI_ManagerEmail = ManagerEmail,
CI_ManagerTelephoneNo = ManagerTelephoneNo,
CI_ProviderID = ProviderID,
CI_Provider = Provider,
CI_ServiceStatus = ServiceStatus
FROM 
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..CareInspectorate_April2017 ci ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone else '0'+cqc.Telephone end,' ','')
												= REPLACE(case when ci.TelephoneNo like '0%' then ci.TelephoneNo else '0'+ci.TelephoneNo end,' ','')
WHERE ISNULL(cqc.Telephone,'') <> ''