SELECT 
case when Process like 'TPS%New Phone' then 'TPS - New Phone'
when Process like 'TPS%Clear%' then 'TPS - Clear/Restore' else Process end Process, 
SUM(case when l.Status not in ('Approved','Data Quality') then 1 else 0 end) DiallableProspects,
SUM(case when l.Status in ('Approved','Data Quality') then 1 else 0 end) ConvertedProspects

FROM 
LeadChangeReview..Fallow_SFDCUpdates f
inner join Salesforce..Lead l ON f.LeadId = l.Id

WHERE 
Reason = 'Operation Successful.'
and
RecordTypeId = '012D0000000NbJsIAK'
	--and 
	--Status = 'Open'
	and 
	(
		Toxic_SIC__c <> 'true' 
		or 
		(
			Toxic_SIC__c = 'true' 
			and 
			CitationSector__c = 'ACCOMODATION' 
			and 
			SIC2007_Code3__c in ('55100','56101','26302') 
			and 
			FT_Employees__c between 10 and 225 	 
		)
	)
	and           
	(
		(
			FT_Employees__c < 225 
			and 
			CitationSector__c = 'CARE'
		)
        or 
        FT_Employees__c between 6 and 225
        or
        (
			FT_Employees__c between 5 and 225 
			and 
			TEXT_BDM__c in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
		)
        or 
        (
			FT_Employees__c between 10 and 225 
			and 
			SIC2007_Code3__c in (56101,55900,55100,56302)
		)
        or 
        (
			FT_Employees__c between 4 and 225 
			and 
			ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
		)
        or 
        (
			FT_Employees__c between 3 and 225 
			and 
			ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
		)
        or 
        (
			FT_Employees__c between 3 and 225 
			and 
			ISNULL(CitationSector__c, '') like '%FUNERAL%'
		)
    -- or ((isnull(CitationSector__c,'') = 'accomodation') and (SIC2007_Code3__c in ('55100','56101','26302') and (FT_Employees__c between 10 and 225)))
	)
	and 
	ISNULL(SIC2007_Code3__c, 0) <> 0
	and 
	ISNULL(l.Phone, '') not in (' ','')
	and 
	ISNULL(IsTPS__c, '') <> 'Yes'
	and 
	ISNULL(TEXT_BDM__c, '') not in 
	(
		'Unassigned BDM',
		'Salesforce Admin',
		'',
		'Jaquie Watt', 
		'Jo Brown', 
		'Justin Robinson', 
		'Louise Clarke', 
		'Mark Goodrum', 
		'Matthew Walker', 
		'Mike Stevenson', 
		'Peter Sherlock', 
		'Susan Turner', 
		'Tushar Sanghrajka'
	)
	and 
	ISNULL(LeadSource, '') not like '%cross sell%Citation%'
	and 
	ISNULL(LeadSource, '') not like '%cross sell%qms%'
	and 
	ISNULL(CitationSector__c, '') not in ('EDUCATION','PHARMACY','DENTAL PRACTICE')
	
GROUP BY 
case when Process like 'TPS%New Phone' then 'TPS - New Phone'
when Process like 'TPS%Clear%' then 'TPS - Clear/Restore' else Process end

ORDER BY 
Process