--How much new data have we inserted into Salesforce yesterday?

SELECT COUNT(Id)
FROM LeadChangeReview..SFDC_Success
WHERE Record_Type = 'Insert' and CONVERT(date, Run_Date) = CONVERT(date, GETDATE()-1)

--What Source is this from?

SELECT 'ML-API'

--How much of it is in criteria for CC Dialing yesterday?

SELECT COUNT(lss.Id)
FROM LeadChangeReview..SFDC_Success s
left outer join LeadChangeReview..Lead_SnapShots lss ON s.Market_Location_URN__c collate latin1_general_CI_AS = lss.Market_Location_URN__c
left outer join Salesforce..[User] bdm ON lss.OwnerId = bdm.Id
WHERE s.Record_Type = 'Insert' and CONVERT(date, s.Run_Date) = CONVERT(date, GETDATE()-1)
and
CONVERT(date, SnapShotDate) = CONVERT(date, s.Run_Date)
and
lss.RecordTypeId = '012D0000000NbJsIAK'
		and
		Status = 'Open'
		and 
		(
			Toxic_SIC__c <> 'true' 
			or 
			(
				Toxic_SIC__c = 'true' 
				and 
				CitationSector__c = 'ACCOMODATION' 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (55100,56101,26302) 
				and 
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 	 
			)
		)
		and           
		(
			(
				CONVERT(decimal(18,0), FT_Employees__c) < 225 
				and 
				CitationSector__c = 'CARE'
			)
			or 
			CONVERT(decimal(18,0), FT_Employees__c) between 6 and 225
			or
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 5 and 225 
				and 
				bdm.Name in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (56101,55900,55100,56302)
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 4 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') like '%FUNERAL%'
			)
		-- or ((isnull(CitationSector__c,'') = 'accomodation') and (SIC2007_Code3__c in ('55100','56101','26302') and (FT_Employees__c between 10 and 225)))
		)
		and 
		ISNULL(CONVERT(decimal(18,0), SIC2007_Code3__c), 0) <> 0
		and 
		ISNULL(lss.Phone, '') not in (' ','')
		and 
		ISNULL(IsTPS__c, '') <> 'Yes'
		and 
		ISNULL(bdm.Name, '') not in 
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

--Has data that was inserted on (date in the past) date been dialed?

SELECT COUNT(t.Id)
FROM LeadChangeReview..SFDC_Success s
left outer join Salesforce..Lead l ON s.Market_Location_URN__c collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join Salesforce..Task t ON l.Id = t.WhoId and t.CallType = 'Outbound' and t.CallObject is not null
WHERE CONVERT(date, s.Run_Date) = '2018-04-30' and s.Record_Type = 'Insert' and l.Id is not null

--How much of it is in criteria and has been dialed?

SELECT COUNT(t.Id)
FROM LeadChangeReview..SFDC_Success s
left outer join Salesforce..Lead lss ON s.Market_Location_URN__c collate latin1_general_CI_AS = lss.Market_Location_URN__c
left outer join Salesforce..Task t ON lss.Id = t.WhoId and t.CallType = 'Outbound' and t.CallObject is not null
left outer join Salesforce..[User] bdm ON lss.OwnerId = bdm.Id
WHERE CONVERT(date, s.Run_Date) = '2018-04-30' and s.Record_Type = 'Insert' and lss.Id is not null
and
lss.RecordTypeId = '012D0000000NbJsIAK'
		and
		lss.Status = 'Open'
		and 
		(
			Toxic_SIC__c <> 'true' 
			or 
			(
				Toxic_SIC__c = 'true' 
				and 
				CitationSector__c = 'ACCOMODATION' 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (55100,56101,26302) 
				and 
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 	 
			)
		)
		and           
		(
			(
				CONVERT(decimal(18,0), FT_Employees__c) < 225 
				and 
				CitationSector__c = 'CARE'
			)
			or 
			CONVERT(decimal(18,0), FT_Employees__c) between 6 and 225
			or
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 5 and 225 
				and 
				bdm.Name in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (56101,55900,55100,56302)
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 4 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') like '%FUNERAL%'
			)
		-- or ((isnull(CitationSector__c,'') = 'accomodation') and (SIC2007_Code3__c in ('55100','56101','26302') and (FT_Employees__c between 10 and 225)))
		)
		and 
		ISNULL(CONVERT(decimal(18,0), SIC2007_Code3__c), 0) <> 0
		and 
		ISNULL(lss.Phone, '') not in (' ','')
		and 
		ISNULL(IsTPS__c, '') <> 'Yes'
		and 
		ISNULL(bdm.Name, '') not in 
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

--How many records in total did we receive from ML API yesterday?

SELECT COUNT(distinct Source_Id)
FROM LeadChangeReview..AuditLog
WHERE LoadType = 'Insert' and CONVERT(date, CreatedDate) = CONVERT(date, GETDATE()-1)

--How many of these were NOT inserted into Salesforce?

--What are the exclusion reasons that stopped these from being inserted yesterday?

--How many data updates were made yesterday to records and fields in Salesforce?

--Have these updates come from ML or another Source?

--Of the total ML API updates made to records in Salesforce yesterday, how many were updates to ‘Decision Making’ fields?

--How much data became part of our Open Dialable CC dialable data pot yesterday?

DECLARE @DayBefore as int
DECLARE @Yesterday as int
DECLARE @DB_Date as date
DECLARE @YD_Date as date

SELECT @DayBefore = COUNT(os.Id), @DB_Date = CONVERT(date, SnapShotDate)
FROM LeadChangeReview..Lead_SnapShots os
left outer join Salesforce..[User] bdm ON os.OwnerId = bdm.Id
WHERE CONVERT(date, SnapShotDate) = CONVERT(date, GETDATE()-2)
and
os.RecordTypeId = '012D0000000NbJsIAK'
		and
		Status = 'Open'
		and 
		(
			Toxic_SIC__c <> 'true' 
			or 
			(
				Toxic_SIC__c = 'true' 
				and 
				CitationSector__c = 'ACCOMODATION' 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (55100,56101,26302) 
				and 
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 	 
			)
		)
		and           
		(
			(
				CONVERT(decimal(18,0), FT_Employees__c) < 225 
				and 
				CitationSector__c = 'CARE'
			)
			or 
			CONVERT(decimal(18,0), FT_Employees__c) between 6 and 225
			or
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 5 and 225 
				and 
				bdm.Name in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (56101,55900,55100,56302)
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 4 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') like '%FUNERAL%'
			)
		-- or ((isnull(CitationSector__c,'') = 'accomodation') and (SIC2007_Code3__c in ('55100','56101','26302') and (FT_Employees__c between 10 and 225)))
		)
		and 
		ISNULL(CONVERT(decimal(18,0), SIC2007_Code3__c), 0) <> 0
		and 
		ISNULL(os.Phone, '') not in (' ','')
		and 
		ISNULL(IsTPS__c, '') <> 'Yes'
		and 
		ISNULL(bdm.Name, '') not in 
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
GROUP BY CONVERT(date, SnapShotDate)

SELECT @Yesterday = COUNT(os.Id), @YD_Date = CONVERT(date, SnapShotDate) 
FROM LeadChangeReview..Lead_SnapShots os
left outer join Salesforce..[User] bdm ON os.OwnerId = bdm.Id
WHERE CONVERT(date, SnapShotDate) = CONVERT(date, GETDATE()-1)
and
os.RecordTypeId = '012D0000000NbJsIAK'
		and
		Status = 'Open'
		and 
		(
			Toxic_SIC__c <> 'true' 
			or 
			(
				Toxic_SIC__c = 'true' 
				and 
				CitationSector__c = 'ACCOMODATION' 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (55100,56101,26302) 
				and 
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 	 
			)
		)
		and           
		(
			(
				CONVERT(decimal(18,0), FT_Employees__c) < 225 
				and 
				CitationSector__c = 'CARE'
			)
			or 
			CONVERT(decimal(18,0), FT_Employees__c) between 6 and 225
			or
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 5 and 225 
				and 
				bdm.Name in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (56101,55900,55100,56302)
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 4 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') like '%FUNERAL%'
			)
		-- or ((isnull(CitationSector__c,'') = 'accomodation') and (SIC2007_Code3__c in ('55100','56101','26302') and (FT_Employees__c between 10 and 225)))
		)
		and 
		ISNULL(CONVERT(decimal(18,0), SIC2007_Code3__c), 0) <> 0
		and 
		ISNULL(os.Phone, '') not in (' ','')
		and 
		ISNULL(IsTPS__c, '') <> 'Yes'
		and 
		ISNULL(bdm.Name, '') not in 
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
GROUP BY CONVERT(date, SnapShotDate)
		
SELECT 
@YD_Date Yesterday_Date, 
@Yesterday Yesterday_Diallable, 
@DB_Date DayBefore_Date, 
@DayBefore DayBefore_Diallable, 
@Yesterday - @DayBefore DiallableGained

--How many records were removed from Open Dialable yesterday?
--How much of that was newly inserted data, breakdown Source?
--How much of that was Opened up by Fallow Strategy rules?

/*
SELECT CONVERT(date, SnapShotDate) FROM LeadChangeReview..Lead_SnapShots GROUP BY CONVERT(date, SnapShotDate)

		SELECT CONVERT(date, SnapShotDate) SnapShotDate, COUNT(distinct os.Id) Diallable_Prospects
		FROM LeadChangeReview..Lead_SnapShots os
		left outer join Salesforce..[User] bdm ON os.OwnerId = bdm.Id
		WHERE
		os.RecordTypeId = '012D0000000NbJsIAK'
		and
		Status = 'Open'
		and 
		(
			Toxic_SIC__c <> 'true' 
			or 
			(
				Toxic_SIC__c = 'true' 
				and 
				CitationSector__c = 'ACCOMODATION' 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (55100,56101,26302) 
				and 
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 	 
			)
		)
		and           
		(
			(
				CONVERT(decimal(18,0), FT_Employees__c) < 225 
				and 
				CitationSector__c = 'CARE'
			)
			or 
			CONVERT(decimal(18,0), FT_Employees__c) between 6 and 225
			or
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 5 and 225 
				and 
				bdm.Name in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 
				and 
				CONVERT(decimal(18,0), SIC2007_Code3__c) in (56101,55900,55100,56302)
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 4 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
			)
			or 
			(
				CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
				and 
				ISNULL(CitationSector__c, '') like '%FUNERAL%'
			)
		-- or ((isnull(CitationSector__c,'') = 'accomodation') and (SIC2007_Code3__c in ('55100','56101','26302') and (FT_Employees__c between 10 and 225)))
		)
		and 
		ISNULL(CONVERT(decimal(18,0), SIC2007_Code3__c), 0) <> 0
		and 
		ISNULL(os.Phone, '') not in (' ','')
		and 
		ISNULL(IsTPS__c, '') <> 'Yes'
		and 
		ISNULL(bdm.Name, '') not in 
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
*/