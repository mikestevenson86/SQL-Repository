SELECT ml.URN
INTO #BadURN
FROM CQC..[1_TEMP_MLCare] ml
inner join CQC..CARE_SINGLE_VIEW c ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
                                       = REPLACE(case when c.Telephone like '0%' then c.Telephone else '0'+c.Telephone end,' ','')
UNION                               
SELECT ml.URN
FROM CQC..[1_TEMP_MLCare] ml
inner join CQC..CARE_SINGLE_VIEW c ON REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(c.Name,'Ltd',''),'Limited','')
                                      and REPLACE(ml.Postcode,' ','') = REPLACE(c.Postcode,' ','')
UNION                                      
SELECT ml.URN
FROM CQC..[1_TEMP_MLCare] ml
inner join CQC..CARE_SINGLE_VIEW c ON ml.URN = c.ML_URN
UNION
SELECT ml.URN
FROM CQC..[1_TEMP_MLCare] ml
inner join CQC..CARE_SINGLE_VIEW c ON ml.[Address Line 1] = c.Addressline1
                                     and REPLACE(ml.Postcode,' ','') = REPLACE(c.Postcode,' ','')

begin tran

INSERT INTO CQC..CARE_SINGLE_VIEW
(
Id,
[Source],
Dupe_Lead,
Dupe_Toxic,
Dupe_Account,
Dupe_Site,
ToxicSIC,
ToxicSIC_Events,
BadCompany_Exact,
BadCompany_Near,
BadCompany_Events,
BadDomain,
BadDomain_NHS,
BadPosition_Events,
BadSector_Events,
Cross_Sell_Exclusions,
HeadOffice,
CareHome,
ML_URN,
ML_BUSINESS_NAME,
ML_ADDRESS_LINE_1,
ML_ADDRESS_LINE_2,
ML_LOCALITY,
ML_TOWN,
ML_COUNTY,
ML_TELEPHONE_NUMBER,
ML_WEB_ADDRESS,
ML_CONTACT_TITLE,
ML_CONTACT_FORENAME,
ML_CONTACT_SURNAME,
ML_CONTACT_POSITION,
ML_UK_07_SIC_CODE,
ML_POST_CODE
)

SELECT
83394 + ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY ml.URN) Id,
'' [Source],
'' Dupe_Lead,
'' Dupe_Toxic,
'' Dupe_Account,
'' Dupe_Site,
'' ToxicSIC,
'' ToxicSIC_Events,
'' BadCompany_Exact,
'' BadCompany_Near,
'' BadCompany_Events,
'' BadDomain,
'' BadDomain_NHS,
'' BadPosition_Events,
'' BadSector_Events,
'' Cross_Sell_Exclusions,
'' HeadOffice,
'' CareHome,
ml.URN ML_URN,
ml.[Business Name] ML_BUSINESS_NAME,
ml.[Address Line 1] ML_ADDRESS_LINE_1,
ml.[Address Line 2] ML_ADDRESS_LINE_2,
ml.Locality ML_LOCALITY,
ml.Town ML_TOWN,
ml.County ML_COUNTY,
ml.[Telephone Number] ML_TELEPHONE_NUMBER,
ml.[web address] ML_WEB_ADDRESS,
ml.[Contact title] ML_CONTACT_TITLE,
ml.[Contact forename] ML_CONTACT_FORENAME,
ml.[Contact surname] ML_CONTACT_SURNAME,
ml.[Contact position] ML_CONTACT_POSITION,
ml.[UK 07 Sic Code] ML_UK_07_SIC_CODE,
ml.Postcode ML_POST_CODE

FROM 
CQC..[1_TEMP_MLCare] ml
left outer join #BadURN bu ON ml.URN = bu.URN

WHERE bu.URN is null

DROP TABLE #BadURN