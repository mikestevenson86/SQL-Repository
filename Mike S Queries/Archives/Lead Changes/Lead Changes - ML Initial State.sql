-- ML_CreatedState

IF OBJECT_ID('LeadChangeReview..ML_InitialState') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..ML_InitialState
	END

SELECT *
INTO LeadChangeReview..ML_InitialState
FROM [LSAUTOMATION].LEADS_ODS.ml.MainDataSet
/*
Actual_turnover_band_c
Address Line 1
Address Line 2
Business Name
Company email address
Contact email address
Contact forename
Contact position
Contact surname
Contact title
County
cro_number
ctps
Easy_sector_code
immediate_parent_cro_c
immediate_parent_name__c
Locality
Major_sector_code__c
Major_sector_description__c
Modelled_turnover_band__c
Nat Employees
Postcode
SIC2007_Description3__c
Sub_sector_code__c
Sub_sector_description__c
Telephone Number
Town
Type
UK 07 Sic Code
Ultimate_parent_cro__c
Ultimate_parent_name__c
Update_Band
Web address
Year_established__c
*/

UPDATE ml SET Actual_turnover_band = scd.OldValue
--SELECT ml.URN, scd.OldValue Actual_turnover_band
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Actual_turnover_band_c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Actual_turnover_band_c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Address Line 1] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Address Line 1]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Address Line 1'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Address Line 1'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Address Line 2] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Address Line 2]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Address Line 2'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Address Line 2'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Business Name] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Business Name]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Business Name'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Business Name'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Company email address] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Company email address]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Company email address'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Company email address'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Contact email address] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Contact email address]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Contact email address'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Contact email address'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Contact forename] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Contact forename]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Contact forename'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Contact forename'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Contact position] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Contact position]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Contact position'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Contact position'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Contact surname] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Contact surname]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Contact surname'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Contact surname'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Contact title] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Contact title]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Contact title'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Contact title'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET County = scd.OldValue
--SELECT ml.URN, scd.OldValue County
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'County'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'County'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET cro_number = scd.OldValue
--SELECT ml.URN, scd.OldValue cro_number
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'cro_number'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'cro_number'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET ctps = scd.OldValue
--SELECT ml.URN, scd.OldValue ctps
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'ctps'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'ctps'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Easy_sector_code = scd.OldValue
--SELECT ml.URN, scd.OldValue Easy_sector_code
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Easy_sector_code'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Easy_sector_code'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET immediate_parent_cro = scd.OldValue
--SELECT ml.URN, scd.OldValue immediate_parent_cro_c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'immediate_parent_cro_c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'immediate_parent_cro_c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET immediate_parent_name = scd.OldValue
--SELECT ml.URN, scd.OldValue immediate_parent_name__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'immediate_parent_name__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'immediate_parent_name__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Locality = scd.OldValue
--SELECT ml.URN, scd.OldValue Locality
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Locality'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Locality'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Major_sector_code = scd.OldValue
--SELECT ml.URN, scd.OldValue Major_sector_code__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Major_sector_code__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Major_sector_code__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Major_sector_description = scd.OldValue
--SELECT ml.URN, scd.OldValue Major_sector_description__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Major_sector_description__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Major_sector_description__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Modelled_turnover_band = scd.OldValue
--SELECT ml.URN, scd.OldValue Modelled_turnover_band__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Modelled_turnover_band__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Modelled_turnover_band__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Nat Employees] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Nat Employees]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Nat Employees'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Nat Employees'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Postcode = scd.OldValue
--SELECT ml.URN, scd.OldValue Postcode
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Postcode'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Postcode'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [UK 07 Sic Desc] = scd.OldValue
--SELECT ml.URN, scd.OldValue SIC2007_Description3__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'SIC2007_Description3__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'SIC2007_Description3__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Sub_sector_code = scd.OldValue
--SELECT ml.URN, scd.OldValue Sub_sector_code__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Sub_sector_code__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Sub_sector_code__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Sub_sector_description = scd.OldValue
--SELECT ml.URN, scd.OldValue Sub_sector_description__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Sub_sector_description__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Sub_sector_description__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Telephone Number] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Telephone Number]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Telephone Number'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Telephone Number'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Town = scd.OldValue
--SELECT ml.URN, scd.OldValue Town
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Town'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Town'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Type] = scd.OldValue
--SELECT ml.URN, scd.OldValue Type
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Type'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Type'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [UK 07 Sic Code] = scd.OldValue
--SELECT ml.URN, scd.OldValue [UK 07 Sic Code]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'UK 07 Sic Code'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'UK 07 Sic Code'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Ultimate_parent_cro = scd.OldValue
--SELECT ml.URN, scd.OldValue Ultimate_parent_cro__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Ultimate_parent_cro__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Ultimate_parent_cro__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Ultimate_parent_name = scd.OldValue
--SELECT ml.URN, scd.OldValue Ultimate_parent_name__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Ultimate_parent_name__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Ultimate_parent_name__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Update_Band = scd.OldValue
--SELECT ml.URN, scd.OldValue Update_Band
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Update_Band'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Update_Band'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET [Web address] = scd.OldValue
--SELECT ml.URN, scd.OldValue [Web address]
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Web address'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Web address'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null

UPDATE ml SET Year_established = scd.OldValue
--SELECT ml.URN, scd.OldValue Year_established__c
FROM LeadChangeReview..ML_InitialState ml
left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN and scd.Field = 'Year_established__c'
left outer join (
					SELECT ml.URN, MIN(scd.CreatedDate) FirstDate
					FROM LeadChangeReview..ML_InitialState ml
					left outer join [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd ON ml.URN = scd.URN
					WHERE scd.Field = 'Year_established__c'
					GROUP BY ml.URN
				) fd ON ml.URN = fd.URN and scd.CreatedDate = fd.FirstDate
WHERE fd.URN is not null