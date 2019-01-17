/*
Use this as alternative - Adds field to imported table, then updates field with Prospect ID from Toxic Data on inner join

ALTER TABLE SalesforceReporting..GarySmith_Release_July2017 ADD SFDC_Id VarChar(255)

UPDATE SalesforceReporting..GarySmith_Release_July2017
SET SFDC_Id = l.[Prospect ID]
FROM SalesforceReporting..GarySmith_Release_July2017 g
inner join SalesforceReporting..toxicdata l ON REPLACE(case when g.[Telephone Number] like '0%' then g.[Telephone Number] else '0'+g.[Telephone Number] end,' ','')
												= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
WHERE ISNULL(g.[Telephone Number],'') <> ''

*/


Select *
FROM SalesforceReporting..CQC_NN_Toxic g

DELETE FROM SalesforceReporting..toxicdata
FROM SalesforceReporting..CQC_NN_Toxic g
inner join SalesforceReporting..toxicdata l ON REPLACE(case when g.[Telephone Number] like '0%' then g.[Telephone Number] else '0'+g.[Telephone Number] end,' ','')
												= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
WHERE ISNULL(g.[Telephone Number],'') <> ''

DELETE FROM SalesforceReporting..toxicdata
FROM SalesforceReporting..GarySmith_Release_July2017 g
inner join SalesforceReporting..toxicdata l ON REPLACE(case when g.[Telephone Number] like '0%' then g.[Telephone Number] else '0'+g.[Telephone Number] end,' ','')
												= REPLACE(case when l.Mobile like '0%' then l.Mobile else '0'+l.Mobile end,' ','')
WHERE ISNULL(g.[Telephone Number],'') <> ''

DELETE FROM SalesforceReporting..toxicdata
FROM SalesforceReporting..GarySmith_Release_July2017 g
inner join SalesforceReporting..toxicdata l ON REPLACE(case when g.[Telephone Number] like '0%' then g.[Telephone Number] else '0'+g.[Telephone Number] end,' ','')
												= REPLACE(case when l.[Other Phone] like '0%' then l.[Other Phone] else '0'+l.[Other Phone] end,' ','')
WHERE ISNULL(g.[Telephone Number],'') <> ''

DELETE FROM SalesforceReporting..toxicdata
FROM SalesforceReporting..CQC_NN_Toxic ml
inner join SalesforceReporting..toxicdata l ON REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(l.[Company   Account],'Ltd',''),'Limited','')
								and REPLACE(ml.PostCode,' ','') = REPLACE(l.[Post Code],' ','')
WHERE ISNULL(ml.[Business Name],'') <> '' and ISNULL(ml.PostCode,'') <> ''

-- Go to LSAUTOMATION, Delete SalesforceReporting..toxicdata, Import new file and toxicdata from DB01..SalesforceReporting using Import Wizard
-- Run this query on LSAUTOMATION after new file has finished loading to LSAUTOMATION

UPDATE LEADS_ODS..LeadsSingleViewAuto
SET Dupe_Toxic = NULL, Exc_ContactCentre = NULL, Exc_Events = NULL
FROM LEADS_ODS..LeadsSingleViewAuto sv
inner join SalesforceReporting..CQC_NN_Toxic gs ON sv.ML_URN collate latin1_general_CI_AS = gs.URN collate latin1_general_CI_AS


Select *
FROM LEADS_ODS..LeadsSingleViewAuto sv
inner join SalesforceReporting..CQC_NN_NonML l ON REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(l.[Company   Account],'Ltd',''),'Limited','')
								and REPLACE(ml.PostCode,' ','') = REPLACE(l.[Post Code],' ','')
WHERE ISNULL(ml.[Business Name],'') <> '' and ISNULL(ml.PostCode,'') <> ''

