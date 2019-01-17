SELECT 
COUNT(l.Id) Total,
SUM(case when Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225) then 1 else 0 end) [No Toxic SIC],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 then 1 else 0 end) [No Blank SIC],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' then 1 else 0 end)[Is NOT CTPS],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' and ISNULL(Phone, '') <> '' then 1 else 0 end) [No Blank Phone],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' and ISNULL(Phone, '') <> ''
and RecordTypeId = '012D0000000NbJsIAK' then 1 else 0 end) [Record Type = Default Citation],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' and ISNULL(Phone, '') <> ''
and RecordTypeId = '012D0000000NbJsIAK' and l.Status = 'Open' then 1 else 0 end) [Open Status],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' and ISNULL(Phone, '') <> ''
and RecordTypeId = '012D0000000NbJsIAK' and l.Status = 'Open' and( (FT_Employees__c < 225 and CitationSector__c = 'CARE')
			or 
			FT_Employees__c between 6 and 225
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c in ('WILLIAM MCFAULDS', 'SCOTT ROBERTS', 'DOMINIC MILLER'))
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c = 'GARY SMITH')
			or 
			(FT_Employees__c between 10 and 225 and SIC2007_Code3__c in (56101,55900,55100,56302))
			or 
			(FT_Employees__c between 4 and 225 and ISNULL(CitationSector__c,'') in ('CLEANING','HORTICULTURE'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') like '%FUNERAL%')) then 1 else 0 end) [FTE Criteria],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' and ISNULL(Phone, '') <> ''
and RecordTypeId = '012D0000000NbJsIAK' and l.Status = 'Open' and( (FT_Employees__c < 225 and CitationSector__c = 'CARE')
			or 
			FT_Employees__c between 6 and 225
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c in ('WILLIAM MCFAULDS', 'SCOTT ROBERTS', 'DOMINIC MILLER'))
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c = 'GARY SMITH')
			or 
			(FT_Employees__c between 10 and 225 and SIC2007_Code3__c in (56101,55900,55100,56302))
			or 
			(FT_Employees__c between 4 and 225 and ISNULL(CitationSector__c,'') in ('CLEANING','HORTICULTURE'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') like '%FUNERAL%')) and LeadSource not like '%Cross%Sell%' then 1 else 0 end) [No Cross Sell],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' and ISNULL(Phone, '') <> ''
and RecordTypeId = '012D0000000NbJsIAK' and l.Status = 'Open' and( (FT_Employees__c < 225 and CitationSector__c = 'CARE')
			or 
			FT_Employees__c between 6 and 225
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c in ('WILLIAM MCFAULDS', 'SCOTT ROBERTS', 'DOMINIC MILLER'))
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c = 'GARY SMITH')
			or 
			(FT_Employees__c between 10 and 225 and SIC2007_Code3__c in (56101,55900,55100,56302))
			or 
			(FT_Employees__c between 4 and 225 and ISNULL(CitationSector__c,'') in ('CLEANING','HORTICULTURE'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') like '%FUNERAL%')) and LeadSource not like '%Cross%Sell%' 
			and TEXT_BDM__c not in ('', 'Salesforce Admin', 'Unassigned BDM') then 1 else 0 end) [No Unassigned BDM],
SUM(case when (Toxic_SIC__c <> 'true' or (Toxic_SIC__c = 'true' and CitationSector__c = 'ACCOMODATION' and SIC2007_Code3__c in ('55100','56101','26302') 
and	FT_Employees__c between 10 and 225)) and ISNULL(SIC2007_Code3__c, 0) <> 0 and ISNULL(IsTPS__c, '') <> 'Yes' and ISNULL(Phone, '') <> ''
and RecordTypeId = '012D0000000NbJsIAK' and l.Status = 'Open' and( (FT_Employees__c < 225 and CitationSector__c = 'CARE')
			or 
			FT_Employees__c between 6 and 225
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c in ('WILLIAM MCFAULDS', 'SCOTT ROBERTS', 'DOMINIC MILLER'))
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c = 'GARY SMITH')
			or 
			(FT_Employees__c between 10 and 225 and SIC2007_Code3__c in (56101,55900,55100,56302))
			or 
			(FT_Employees__c between 4 and 225 and ISNULL(CitationSector__c,'') in ('CLEANING','HORTICULTURE'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') like '%FUNERAL%')) and LeadSource not like '%Cross%Sell%' 
			and ISNULL(TEXT_BDM__c, '') not in ('', 'Salesforce Admin', 'Unassigned BDM')
			and ISNULL(CitationSector__c, '') not in ('EDUCATION', 'DENTAL PRACTICE', 'PHARMACY') then 1 else 0 end) [No Bad Sectors]

FROM Salesforce..Lead l
WHERE Id in
(
	SELECT Id 
	FROM Salesforce..Lead l
	left outer join SalesforceReporting..PostCodeAssignments pca ON LEFT(l.PostalCode, 2) = pca.AreaCode and pca.Length = 2
	left outer join SalesforceReporting..PostCodeAssignments pcb ON LEFT(l.PostalCode, 3) = pcb.AreaCode and pcb.Length = 3
	left outer join SalesforceReporting..PostCodeAssignments pcc ON LEFT(l.PostalCode, 4) = pcc.AreaCode and pcc.Length = 4
	WHERE pca.BDM is not null or pcb.BDM is not null or pcc.BDM is not null
)