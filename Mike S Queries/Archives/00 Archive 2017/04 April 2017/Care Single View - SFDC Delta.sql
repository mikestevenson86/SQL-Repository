INSERT INTO CQC..CARE_SINGLE_VIEW
(
 SF_Co_Reg__c,
 [Source],
 SF_Company,
 SF_Email,
 SF_FirstName,
 SFDCId,
 SF_LastName,
 SF_Phone,
 SF_PostalCode,
 SF_SIC2007_Code__c,
 SF_Status,
 SF_Street,
 SF_Website,
 SF_Suspended_Closed_Reason
)

SELECT 
[Co_Reg__c] SF_Co_Reg__c,
'SFDC' [Source],
[Company] SF_Company,
[Email] SF_Email,
[FirstName] SF_FirstName,
l.[Id] SFDCId,
[LastName] SF_LastName,
[Phone] SF_Phone,
[PostalCode] SF_PostalCode,
[SIC2007_Code__c] SF_SIC2007_Code__c,
[Status] SF_Status,
[Street] SF_Street,
[Website] SF_Website,
[Suspended_Closed_Reason__c] SF_Suspended_Closed_Reason

FROM 
[CQC].[dbo].[2_TEMP_SFDCLeads] l
left outer join CQC..CARE_SINGLE_VIEW cqc ON l.Id = cqc.SFDCId

WHERE 
cqc.SFDCId is null