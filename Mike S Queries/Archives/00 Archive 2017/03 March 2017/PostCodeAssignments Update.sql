/*
-- Add fields if necessary

ALTER TABLE LEADS_ODS..PostCodeAssignments ADD PostCodeLabel VarChar(255)
ALTER TABLE LEADS_ODS..PostCodeAssignments ADD FTE_MinCriteria Int
ALTER TABLE LEADS_ODS..PostCodeAssignments ADD FTE_MaxCriteria Int
ALTER TABLE LEADS_ODS..PostCodeAssignments ADD [Territory Type] VarChar(20)
ALTER TABLE LEADS_ODS..PostCodeAssignments ADD Region Varchar(16)
*/

-- Update Region

UPDATE LEADS_ODS..PostCodeAssignments
SET Region = 'Scotland', FTE_MinCriteria = 5
WHERE LEFT([PostCode Area],2) in
('AB','DD','DG','EH','FK','G1','G2','G3','G4','G5','G6','G7','G8','G9','HS','IV','KA','KW','KY','ML','PA','PH','TD','ZE')
and ISNULL(Region,'') <> 'Scotland'

UPDATE LEADS_ODS..PostCodeAssignments
SET Region = 'Northern Ireland', FTE_MinCriteria = 5
WHERE LEFT([PostCode Area],2) = 'BT'
and ISNULL(Region,'') <> 'Northern Ireland'

UPDATE LEADS_ODS..PostCodeAssignments
SET Region = 'North', FTE_MinCriteria = 6
WHERE
LEFT([PostCode Area] , 2) in 
(
'NE', 
'CA', 
'DH', 
'SR', 
'DL', 
'TS', 
'BD', 
'HG', 
'YO', 
'LA', 
'PR', 
'BB', 
'HX', 
'LS', 
'HD', 
'WF', 
'HU', 
'DN', 
'LN', 
'WN', 
'BL', 
'OL', 
'FY', 
'LL', 
'SK', 
'CH', 
'WA', 
'CW', 
'SY', 
'TF', 
'ST', 
'WV', 
'WS', 
'DE', 
'NG', 
'LE', 
'L1', 
'L2', 
'L3', 
'L4', 
'L5', 
'L6', 
'L7', 
'L8', 
'L9', 
'S1', 
'S2', 
'S3', 
'S4', 
'S5', 
'S6', 
'S7', 
'S8', 
'S9', 
'M1', 
'M2', 
'M3', 
'M4', 
'M5', 
'M6', 
'M7', 
'M8', 
'M9'
) and ISNULL(Region,'') <> 'North'

UPDATE LEADS_ODS..PostCodeAssignments
SET Region = 'South', FTE_MinCriteria = 6
WHERE
LEFT([PostCode Area] , 2) in 
(
'AL',
'B1',
'B2',
'B3',
'B4',
'B5',
'B6',
'B7',
'B8',
'B9',
'BA',
'BH',
'BN',
'BR',
'BS',
'CB',
'CF',
'CM',
'CO',
'CR',
'CT',
'CV',
'DA',
'DT',
'DY',
'E1',
'E2',
'E3',
'E4',
'E5',
'E6',
'E7',
'E8',
'E9',
'EC',
'EN',
'EX',
'GL',
'GU',
'GY',
'HA',
'HP',
'HR',
'IG',
'IM',
'IP',
'JE',
'KT',
'LD',
'LU',
'ME',
'MK',
'N1',
'N2',
'N3',
'N4',
'N5',
'N6',
'N7',
'N8',
'N9',
'NN',
'NP',
'NR',
'NW',
'OX',
'PE',
'PL',
'PO',
'RG',
'RH',
'RM',
'SA',
'SE',
'SG',
'SL',
'SM',
'SN',
'SO',
'SP',
'SS',
'SW',
'TA',
'TN',
'TQ',
'TR',
'TW',
'UB',
'W1',
'W2',
'W3',
'W4',
'W5',
'W6',
'W7',
'W8',
'W9',
'WC',
'WD',
'WR'
) and ISNULL(Region,'') <> 'South'

-- Update Max FTE

UPDATE LEADS_ODS..PostCodeAssignments
SET FTE_MaxCriteria = 225
WHERE FTE_MaxCriteria is null

-- Update Territory Type

UPDATE LEADS_ODS..PostCodeAssignments
SET [Territory Type] = 'Shared'
/*SELECT *
FROM LEADS_ODS..PostCodeAssignments*/
WHERE LEFT([PostCode Area], case when PATINDEX('%[0-9]%', [PostCode Area]) = 0 then 2 else PATINDEX('%[0-9]%', [PostCode Area])-1 end) in
(
	SELECT OutCode
	FROM
	(
		SELECT BDM, OutCode, ROW_NUMBER () OVER (PARTITION BY OutCode ORDER BY OutCode) rn
		FROM
		(
			SELECT 
			BDM,
			LEFT([PostCode Area], 
			case when PATINDEX('%[0-9]%', [PostCode Area]) = 0 then 2 else PATINDEX('%[0-9]%', [PostCode Area])-1 end) OutCode

			FROM 
			LEADS_ODS..PostCodeAssignments
			
			WHERE
			BDM <> 'Unassigned BDM'
			
			GROUP BY
			BDM,
			LEFT([PostCode Area], 
			case when PATINDEX('%[0-9]%', [PostCode Area]) = 0 then 2 else PATINDEX('%[0-9]%', [PostCode Area])-1 end)
		) detail
	) detail

	WHERE rn > 1

	GROUP BY OutCode
)

UPDATE LEADS_ODS..PostCodeAssignments
SET [Territory Type] = 'Individual'
WHERE ISNULL([Territory Type],'') <> 'Shared'