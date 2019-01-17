/*
UPDATE CQC..CARE_SINGLE_VIEW 
SET
SFDCId = l.Id ,
SF_Status = l.Status ,
SF_Suspended_Closed_Reason = l.Suspended_Closed_Reason__c ,
SF_Company = l.Company ,
SF_Co_Reg__c = l.Co_Reg__c ,
SF_Email = l.Email,
SF_FirstName = l.FirstName ,
SF_LastName = l.LastName ,
SF_Phone = l.Phone ,
SF_PostalCode = l.PostalCode ,
SF_SIC2007_Code__c = l.SIC2007_Code__c ,
SF_Street = l.Street,
SF_Website = l.Website
FROM
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..[2_TEMP_SFDCLeads] l ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone  else '0'+cqc.Telephone end,' ','') = 
										REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
										
WHERE
ISNULL(l.Other_Phone__c,'') <> ''
*/

SELECT
cqc.Id,
l.Id SFDCId,
l.Status SF_Status,
l.Suspended_Closed_Reason__c SF_Suspended_Closed_Reason,
l.Company SF_Company,
l.Co_Reg__c SF_Co_Reg__c,
l.Email SF_Email,
l.FirstName SF_FirstName,
l.LastName SF_LastName,
l.Phone SF_Phone,
l.PostalCode SF_PostalCode,
l.SIC2007_Code__c SF_SIC2007_Code__c,
l.Street SF_Street,
l.Website SF_Website,
'Phone' JoinOn

FROM
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..[2_TEMP_SFDCLeads] l ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone  else '0'+cqc.Telephone end,' ','') = 
										REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
										
WHERE
ISNULL(l.Phone,'') <> ''



SELECT
cqc.Id,
l.Id SFDCId,
l.Status SF_Status,
l.Suspended_Closed_Reason__c SF_Suspended_Closed_Reason,
l.Company SF_Company,
l.Co_Reg__c SF_Co_Reg__c,
l.Email SF_Email,
l.FirstName SF_FirstName,
l.LastName SF_LastName,
l.Phone SF_Phone,
l.PostalCode SF_PostalCode,
l.SIC2007_Code__c SF_SIC2007_Code__c,
l.Street SF_Street,
l.Website SF_Website,
'MobilePhone' JoinOn

FROM
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..[2_TEMP_SFDCLeads] l ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone  else '0'+cqc.Telephone end,' ','') = 
										REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
										
WHERE
ISNULL(l.MobilePhone,'') <> ''



SELECT
cqc.Id,
l.Id SFDCId,
l.Status SF_Status,
l.Suspended_Closed_Reason__c SF_Suspended_Closed_Reason,
l.Company SF_Company,
l.Co_Reg__c SF_Co_Reg__c,
l.Email SF_Email,
l.FirstName SF_FirstName,
l.LastName SF_LastName,
l.Phone SF_Phone,
l.PostalCode SF_PostalCode,
l.SIC2007_Code__c SF_SIC2007_Code__c,
l.Street SF_Street,
l.Website SF_Website,
'Other Phone' JoinOn

FROM
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..[2_TEMP_SFDCLeads] l ON REPLACE(case when cqc.Telephone like '0%' then cqc.Telephone  else '0'+cqc.Telephone end,' ','') = 
										REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
										
WHERE
ISNULL(l.Other_Phone__c,'') <> ''



SELECT
cqc.Id,
l.Id SFDCId,
l.Status SF_Status,
l.Suspended_Closed_Reason__c SF_Suspended_Closed_Reason,
l.Company SF_Company,
l.Co_Reg__c SF_Co_Reg__c,
l.Email SF_Email,
l.FirstName SF_FirstName,
l.LastName SF_LastName,
l.Phone SF_Phone,
l.PostalCode SF_PostalCode,
l.SIC2007_Code__c SF_SIC2007_Code__c,
l.Street SF_Street,
l.Website SF_Website,
'Company and PostCode' JoinOn

FROM
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..[2_TEMP_SFDCLeads] l ON REPLACE(REPLACE(cqc.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','')
										and REPLACE(cqc.Postcode,' ','') = REPLACE(l.PostalCode,' ','')

WHERE
ISNULL(l.Company,'') <> '' and ISNULL(l.PostalCode,'') <> ''



SELECT
cqc.Id,
l.Id SFDCId,
l.Status SF_Status,
l.Suspended_Closed_Reason__c SF_Suspended_Closed_Reason,
l.Company SF_Company,
l.Co_Reg__c SF_Co_Reg__c,
l.Email SF_Email,
l.FirstName SF_FirstName,
l.LastName SF_LastName,
l.Phone SF_Phone,
l.PostalCode SF_PostalCode,
l.SIC2007_Code__c SF_SIC2007_Code__c,
l.Street SF_Street,
l.Website SF_Website,
'ML URN' JoinOn

FROM
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..[2_TEMP_SFDCLeads] l ON cqc.ML_URN = l.Market_Location_URN__c

WHERE
ISNULL(l.Market_Location_URN__c,'') <> ''



SELECT
cqc.Id,
l.Id SFDCId,
l.Status SF_Status,
l.Suspended_Closed_Reason__c SF_Suspended_Closed_Reason,
l.Company SF_Company,
l.Co_Reg__c SF_Co_Reg__c,
l.Email SF_Email,
l.FirstName SF_FirstName,
l.LastName SF_LastName,
l.Phone SF_Phone,
l.PostalCode SF_PostalCode,
l.SIC2007_Code__c SF_SIC2007_Code__c,
l.Street SF_Street,
l.Website SF_Website,
'Company Reg' JoinOn

FROM
CQC..CARE_SINGLE_VIEW cqc
inner join CQC..[2_TEMP_SFDCLeads] l ON cqc.CRO = l.Co_Reg__c 

WHERE
ISNULL(l.Co_Reg__c,'') <> ''								