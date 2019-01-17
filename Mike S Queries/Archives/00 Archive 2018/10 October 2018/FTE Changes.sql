SELECT l.Id, scdh.CreatedDate, scdh.NewValue
FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scdh
inner join Salesforce..Lead l ON scdh.URN collate latin1_general_CI_AS = l.Market_Location_URN__c collate latin1_general_CI_AS
inner join [LSAUTOMATION].LEADS_ODS.[dbo].[SFDC_Success_Log_MLAPI] sfs ON CONVERT(date, scdh.CreatedDate) = CONVERT(date, sfs.Run_Date)
																			and scdh.URN = sfs.Market_Location_URN__c
																			and CONVERT(int, scdh.NewValue) = CONVERT(int, sfs.SF_FT_Employees__c)
WHERE Field = 'Nat Employees'
and
(
		(
			Toxic_SIC__c = 'true' 
			and 
			CitationSector__c = 'ACCOMODATION' 
			and 
			SIC2007_Code3__c in ('55100','56101','26302') 
			and 
			(scdh.NewValue < 10 or scdh.NewValue > 225) 	 
		)
	or           
		(
			scdh.NewValue > 225 
			and 
			CitationSector__c = 'CARE'
		)
        or 
        (
			(scdh.NewValue < 6 or scdh.NewValue > 225)
			and
			Toxic_SIC__c <> 'true'
			and
			TEXT_BDM__c not in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
			and
			ISNULL(SIC2007_Code3__c, 0) not in (56101,55900,55100,56302)
			and
			ISNULL(CitationSector__c, '') not in ('CARE','CLEANING','HORTICULTURE','DENTAL PRACTICE','DAY NURSERY','PHARMACY')
			and
			ISNULL(CitationSector__c, '') not like '%FUNERAL%'
        )
        or
        (
			(scdh.NewValue < 5 or scdh.NewValue > 225)
			and 
			TEXT_BDM__c in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
		)
        or 
        (
			(scdh.NewValue < 10 or scdh.NewValue > 225) 
			and 
			SIC2007_Code3__c in (56101,55900,55100,56302)
		)
        or 
        (
			(scdh.NewValue < 4 or scdh.NewValue > 225)
			and 
			ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
		)
        or 
        (
			(scdh.NewValue < 3 or scdh.NewValue > 225)
			and 
			ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
		)
        or 
        (
			(scdh.NewValue < 3 or scdh.NewValue > 225)
			and 
			ISNULL(CitationSector__c, '') like '%FUNERAL%'
		)
	)