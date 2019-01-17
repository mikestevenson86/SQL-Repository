INSERT INTO CQC..CARE_SINGLE_VIEW
(
[Source],
CI_CaseNumber,
CI_ServiceName,
CI_ServiceType,
CI_DateofRegistration,
CI_Address1,
CI_Address2,
CI_Address3,
CI_Address4,
CI_City,
CI_Postcode,
CI_TelephoneNo,
CI_FaxNo,
CI_ManagerName,
CI_ManagerEmail,
CI_ManagerTelephoneNo,
CI_ProviderID,
CI_Provider,
CI_ServiceStatus
)

SELECT 
'Care Inspectorate',
CaseNumber,
ServiceName,
ci.ServiceType,
DateofRegistration,
Address1,
Address2,
Address3,
Address4,
ci.City,
ci.Postcode,
TelephoneNo,
FaxNo,
ManagerName,
ManagerEmail,
ManagerTelephoneNo,
ProviderID,
Provider,
ServiceStatus

FROM 
CQC..CareInspectorate_April2017 ci
left outer join CQC..CARE_SINGLE_VIEW cqc ON ci.CaseNumber = cqc.CI_CaseNumber

WHERE 
cqc.CI_CaseNumber is null