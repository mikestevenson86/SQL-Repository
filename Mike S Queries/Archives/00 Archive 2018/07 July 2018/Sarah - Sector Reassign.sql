IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL 
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END

-- Residential Care NO Sector

SELECT 
Id
,'CARE' CitationSector
,'87900' SIC2007_Code3__c
,'Other residential care activities n.e.c.' SIC2007_Description3__c

INTO
Salesforce..Lead_Update

FROM 
Salesforce..Lead

WHERE 
RecordTypeId = '012D0000000NbJsIAK'
and 
Status not in ('Approved','Pended','Data Quality') 
and 
IsConverted = 'FALSE'
and 
CitationSector__c is null
and 
(
	ISNULL(ML_Business_Type__c, '') in 
	(
		'Nursing Homes'
		,'Residential Care Establishments'
		,'Rest and Retirement Homes'
		,'Day and Care Centres'
	)
	or 
	(
		Company like '%care home%' 
		or 
		Company like '% rest home%' 
		or 
		Company like '%retirement home%' 
		or 
		Company like '%nursing home%' 
		or 
		Company like '%residential care%'
	)
)
and 
Company not like '%nursery%' 
and 
Company not like '%horse%' 
and 
Company not like '%vet%' 
and 
Company not like '%appliance%'

UNION
-- Domicillary Care NO Sector

SELECT 
Id
,'CARE' CitationSector__c
,'88990' SIC2007_Code3__c
,'Other social work activities without accommodation n.e.c.' SIC2007_Description3__c

FROM 
Salesforce..Lead

WHERE 
RecordTypeId = '012D0000000NbJsIAK'
and 
Status not in ('Approved','Pended','Data Quality') 
and 
IsConverted = 'FALSE'
and 
CitationSector__c is null
and 
(
	
	ISNULL(ML_Business_Type__c,'') in ('Home Care Service Providers','Home Care and Help Services')
	or 
	(
		Company like '%homecare%' 
		or 
		Company like '%home care%' 
		or 
		Company like '%domiciliary%'
	)
)
and 
Company not like '%nursery%' 
and 
Company not like '%horse%' 
and 
Company not like '%vet%' 
and 
Company not like '%appliance%'

UNION
-- Residential Care NOT CARE Sector

SELECT 
Id
,'CARE' CitationSector
,'87900' SIC2007_Code3__c 
,'Other residential care activities n.e.c.' SIC2007_Description3__c

FROM 
Salesforce..Lead

WHERE 
RecordTypeId = '012D0000000NbJsIAK'
and 
Status not in ('Approved','Pended','Data Quality') 
and 
IsConverted = 'FALSE'
and 
ISNULL(CitationSector__c, '') not in 
(
	''
	,'CARE'
	,'CONSTRUCTION'
	,'CLEANING'
	,'GLASS & GLAZING'
	,'MANUFACTURING'
	,'REAL ESTATE ACTIVITIES'
	,'RENTING & LEASING'
)
and 
(
	ISNULL(ML_Business_Type__c,'') in 
	(
		'Nursing Homes'
		,'Residential Care Establishments'
		,'Rest and Retirement Homes'
		,'Day and Care Centres'
	)
	or 
	(
		Company like '%care home%' 
		or 
		Company like '% rest home%' 
		or 
		Company like '%retirement home%' 
		or 
		Company like '%nursing home%' 
		or 
		Company like '%residential care%'
	)
)
and 
Company not like '%nursery%' 
and 
Company not like '%horse%' 
and 
Company not like '%vet%' 
and 
Company not like '%appliance%'

UNION
-- Domicillary Care NOT CARE Sector

SELECT
Id
,'CARE' CitationSector__c
,'88990' SIC2007_Code3__c
,'Other social work activities without accommodation n.e.c.' SIC2007_Description3__c

FROM 
Salesforce..Lead

WHERE 
RecordTypeId = '012D0000000NbJsIAK'
and 
Status not in ('Approved','Pended','Data Quality') 
and 
IsConverted = 'FALSE'
and 
ISNULL(CitationSector__c, '') in 
(
	'HUMAN HEALTH ACTIVITIES'
	,'OTHER'
	,'ADMINISTRATIVE AND SUPPORT SERVICE ACTIVITIES'
)
and 
(
	ML_Business_Type__c in ('Home Care Service Providers','Home Care and Help Services')
	or 
	(
		Company like '%homecare%' 
		or 
		Company like '%home care%' 
		or 
		Company like '%domiciliary%'
	)
)
and 
Company not like '%nursery%' 
and 
Company not like '%horse%' 
and 
Company not like '%vet%' 
and 
Company not like '%appliance%'

UNION
-- Day Nursery NO Sector

SELECT 
Id
,'DAY NURSERY' CitationSector__c
,'85100' SIC2007_Code3__c
,'Pre-primary education' SIC2007_Description3__c

FROM 
Salesforce..Lead

WHERE 
RecordTypeId = '012D0000000NbJsIAK'
and 
Status not in ('Approved','Pended','Data Quality') 
and 
IsConverted = 'FALSE'
and 
CitationSector__c is null
and 
(
	ISNULL(ML_Business_Type__c,'') in 
	(
		'Nursery Schools'
		,'Organised Childrens Play Schemes'
		,'Childcare Services'
		,'Pre School Education'
		,'Creches'
	)
	or 
	(
		Company like '%playgroup%' 
		or 
		Company like '%nursery school%' 
		or 
		Company like '% nursery%' 
		or 
		Company like '%nursey%' 
		or 
		Company like '%nurseries%' 
		or 
		Company like '%day nurse%' 
		or 
		Company like '%kindergarte%' 
		or 
		Company like '%CHILDCARE%'
		or 
		Company like '%creche%' 
		or 
		Company like '%pre-school%' 
		or 
		Company like '%pre school%' 
		or 
		Company like '%preschool%' 
		or 
		Company like '%montessori%')
	)
and 
Company not like '%primary%' 
and 
Company not like '%junior%' 
and 
Company not like '%CHURCH%' 
and 
Company not like '%FAMILY CENTRE%' 
and 
Company not like '%COMMUNITY%' 
and 
Company not like '%PLAYGROUP%'
and 
ISNULL(ML_Business_Type__c,'') not in 
(
	'Primary and Junior Schools (Foundation)'
	,'Primary and Junior Schools (Local Authority)'
	,'garden centres'
	,'nurserymen'
)

UNION
-- Day Nursery EDUCATION Sector

SELECT
Id
,'DAY NURSERY' CitationSector__c
,'85100' SIC2007_Code3__c
,'Pre-primary education' SIC2007_Description3__c

FROM Salesforce..Lead

WHERE  
RecordTypeId = '012D0000000NbJsIAK'
and 
Status not in ('Approved','Pended','Data Quality') 
and 
IsConverted = 'FALSE'
and
CitationSector__c = 'EDUCATION'
and 
(
	ISNULL(ML_Business_Type__c,'') in 
	(
		'Nursery Schools'
		,'Organised Childrens Play Schemes'
		,'Childcare Services'
		,'Pre School Education'
		,'Creches'
	)
	or 
	(
		Company like '%playgroup%' 
		or 
		Company like '%nursery school%' 
		or 
		Company like '% nursery%' 
		or 
		Company like '%nursey%' 
		or 
		Company like '%nurseries%' 
		or 
		Company like '%day nurse%' 
		or 
		Company like '%kindergarte%' 
		or 
		Company like '%CHILDCARE%'
		or 
		Company like '%creche%' 
		or 
		Company like '%pre-school%' 
		or 
		Company like '%pre school%' 
		or 
		Company like '%preschool%' 
		or 
		Company like '%montessori%'
	)
)
and 
Company not like '%primary%' 
and 
Company not like '%junior%' 
and 
Company not like '%CHURCH%' 
and 
Company not like '%FAMILY CENTRE%' 
and 
Company not like '%COMMUNITY%' 
and 
Company not like '%PLAYGROUP%'
and 
ISNULL(ML_Business_Type__c, '') not in 
(
	'Primary and Junior Schools (Foundation)'
	,'Primary and Junior Schools (Local Authority)'
	,'garden centres','nurserymen'
)

UNION
-- Day Nursery OTHER Sector

SELECT
Id
,'DAY NURSERY' CitationSector__c
,'85100' SIC2007_Code3__c
,'Pre-primary education' SIC2007_Description3__c

FROM 
Salesforce..Lead

WHERE
RecordTypeId = '012D0000000NbJsIAK'
and 
Status not in ('Approved','Pended','Data Quality') 
and 
IsConverted = 'FALSE'
and 
ISNULL(CitationSector__c, '') not in ('','DAY NURSERY','EDUCATION')
and 
ISNULL(ML_Business_Type__c,'') in 
(
	'Nursery Schools' 
	,'Organised Childrens Play Schemes' 
	,'Childcare Services' 
	,'Pre School Education'
	,'Creches'
)
and 
(
	Company like '%playgroup%' 
	or 
	Company like '%nursery school%' 
	or 
	Company like '% nursery%' 
	or 
	Company like '%nursey%' 
	or 
	Company like '%nurseries%' 
	or 
	Company like '%day nurse%' 
	or 
	Company like '%kindergarte%' 
	or 
	Company like '%CHILDCARE%'
	or 
	Company like '%creche%' 
	or 
	Company like '%pre-school%' 
	or
	Company like '%pre school%' 
	or 
	Company like '%preschool%' 
	or 
	Company like '%montessori%'
)
and 
Company not like '%primary%' 
and 
Company not like '%junior%' 
and 
Company not like '%CHURCH%' 
and 
Company not like '%FAMILY CENTRE%' 
and 
Company not like '%COMMUNITY%' 
and 
Company not like '%PLAYGROUP%'
and 
ISNULL(ML_Business_Type__c, '') not in 
(
	'Primary and Junior Schools (Foundation)'
	,'Primary and Junior Schools (Local Authority)'
	,'garden centres'
	,'nurserymen'
)

-- Load to Salesforce

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'