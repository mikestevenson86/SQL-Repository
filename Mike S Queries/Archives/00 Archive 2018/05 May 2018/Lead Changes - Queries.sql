--1.How much new data have we inserted into Salesforce yesterday?

SELECT COUNT(Id)
FROM LeadChangeReview..SFDC_Success
WHERE Record_Type = 'Insert' and CONVERT(date, Run_Date) = CONVERT(date, GETDATE()-1)



SELECT 'ML-API'

--2.How much of it is in criteria for CC Dialing yesterday?

SELECT COUNT(lss.Id)
FROM LeadChangeReview..SFDC_Success s
left outer join LeadChangeReview..Lead_SnapShots lss ON s.Market_Location_URN__c collate latin1_general_CI_AS = lss.Market_Location_URN__c
and CONVERT(date, lss.SnapShotDate) = CONVERT(date, s.Run_Date)
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

--3.Has data that was inserted on (date in the past) date been dialed?

SELECT COUNT(t.Id)
FROM LeadChangeReview..SFDC_Success s
left outer join Salesforce..Lead l ON s.Market_Location_URN__c collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join Salesforce..Task t ON l.Id = t.WhoId and t.CallType = 'Outbound' and t.CallObject is not null
WHERE CONVERT(date, s.Run_Date) = '2018-05-03' and s.Record_Type = 'Insert' and l.Id is not null
and CONVERT(date, t.CreatedDate) >= '2018-05-03'

--4.Has data that was inserted on (date in the past) date been dialed? unique records

SELECT COUNT(distinct l.Id)
FROM LeadChangeReview..SFDC_Success s
left outer join Salesforce..Lead l ON s.Market_Location_URN__c collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join Salesforce..Task t ON l.Id = t.WhoId and t.CallType = 'Outbound' and t.CallObject is not null
WHERE CONVERT(date, s.Run_Date) = '2018-05-03' and s.Record_Type = 'Insert' and l.Id is not null
and CONVERT(date, t.CreatedDate) >= '2018-05-03'

--5.How much of it is in criteria and has been dialed?

SELECT COUNT(t.Id)
FROM LeadChangeReview..SFDC_Success s
left outer join Salesforce..Lead lss ON s.Market_Location_URN__c collate latin1_general_CI_AS = lss.Market_Location_URN__c
left outer join Salesforce..Task t ON lss.Id = t.WhoId and t.CallType = 'Outbound' and t.CallObject is not null
left outer join Salesforce..[User] bdm ON lss.OwnerId = bdm.Id
WHERE CONVERT(date, s.Run_Date) = '2018-05-03' and s.Record_Type = 'Insert' and lss.Id is not null
and CONVERT(date, t.CreatedDate) >= '2018-05-03'
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

--Run 6,7,8, together to produce slide 2 of the Data Pack

--6.How many records in total did we receive from ML API yesterday?
Declare @INSERTML AS int
Declare @INSERTSF AS int

IF OBJECT_ID('tempdb..#INSERTML') IS NOT NULL
	BEGIN
		DROP TABLE #INSERTML
	END
IF OBJECT_ID('tempdb..#INSERTSF') IS NOT NULL
	BEGIN
		DROP TABLE #INSERTSF
	END

SELECT URN
INTO #INSERTML
FROM [LSAUTOMATION].LEADS_ODS.ml.MainDataSet
WHERE CONVERT(date, DateCreated) = CONVERT(date, GETDATE()-1)

SELECT @INSERTML = COUNT(URN) FROM #INSERTML

SELECT @INSERTML

--7.How many of these were NOT inserted into Salesforce?

SELECT Market_Location_URN__c
INTO #INSERTSF
FROM LeadChangeReview..SFDC_Success
WHERE Record_Type = 'Insert' and CONVERT(date, Run_Date) = CONVERT(date, GETDATE()-1)

SELECT @INSERTSF = COUNT(Market_Location_URN__c) FROM #INSERTSF

SELECT @INSERTML - @INSERTSF

--8.What are the exclusion reasons that stopped these from being inserted yesterday?

SELECT ml.URN, 
STUFF
	(
		(
				 SELECT ', ' + al2.AuditType + ' - ' + al2.NewReason
				 FROM 
					   LeadChangeReview..AuditLog al2
				 WHERE
					   al2.Source_Id collate latin1_general_ci_as =  ml.URN
					   and
					   al2.NewCrit = 'No'
					   and
					   convert (date, al2.CreatedDate) = CONVERT(date, GETDATE()-1)
				 ORDER BY al2.AuditType + ' - ' + al2.NewReason
				 FOR XML PATH ('')
		), 1, 1, ''
	) Reasons
FROM #INSERTML ml
left outer join #INSERTSF sf ON ml.URN = sf.Market_Location_URN__c
WHERE sf.Market_Location_URN__c is null
GROUP BY ml.URN


--9.How many data updates were made yesterday to records and fields in Salesforce?

SELECT COUNT(distinct Market_Location_URN__c)
FROM LeadChangeReview..SFDC_Success
WHERE Record_Type = 'Update' and CONVERT(date, Run_Date) = CONVERT(date, GETDATE()-1)

--10.Have these updates come from ML or another Source?

SELECT scd.[Source], COUNT(distinct Market_Location_URN__c)
FROM LeadChangeReview..SFDC_Success s
inner join LeadChangeReview..ML_SCDChanges_History scd ON s.Market_Location_URN__c = scd.URN
WHERE s.Record_Type = 'Update' and CONVERT(date, s.Run_Date) = CONVERT(date, GETDATE()-1)
GROUP BY scd.[Source]

--11.Of the total ML API updates made to records in Salesforce yesterday, how many were updates to ‘Decision Making’ fields? unique records count

SELECT Id, 
case when Position1 >= 2 or Position2 >= 2 then 'Yes' else 'No' end [Position],
case when [Address] >= 2 then 'Yes' else 'No' end [Address],
case when Sector >= 1 then 'Yes' else 'No' end [Sector],
case when FTE >= 1 then 'Yes' else 'No' end FTE,
case when Phone >= 1 then 'Yes' else 'No' end Phone
FROM
(
	SELECT l.Id, 
	SUM(case when Field in ('contact position','contact forename') then 1 else 0 end) Position1,
	SUM(case when Field in ('contact position','contact surname') then 1 else 0 end) Position2,
	SUM(case when Field in ('Address Line 1','Postcode') then 1 else 0 end) [Address],
	SUM(case when Field = 'UK 07 Sic Code' then 1 else 0 end) Sector,
	SUM(case when Field = 'Nat Employees' then 1 else 0 end) FTE,
	SUM(case when Field = 'Telephone Number' then 1 else 0 end) Phone
	FROM
	(
		SELECT 
		scd.[CreatedDate]
		,scd.[Source]
		,scd.[URN]
		,scd.[Field] 
		,scd.[OldValue] collate latin1_general_CI_AS OldValue
		,scd.[NewValue] collate latin1_general_CI_AS NewValue
		FROM LeadChangeReview..ML_SCDChanges_History scd
		left outer join LeadChangeReview..SFDC_Success s ON scd.URN = s.Market_Location_URN__c
																			and CONVERT(date, scd.CreatedDate) = CONVERT(date, s.Run_Date)
		WHERE 
		CONVERT(date, scd.CreatedDate) = CONVERT(date, GETDATE()-1)
		and
		Field in ('Contact forename','Contact surname','Contact position','Address Line 1','Postcode','Nat Employees','Telephone Number','UK 07 Sic Code') 
		and 
		NewValue <> OldValue
		UNION
		SELECT scd.[CreatedDate] ,scd.[Source] ,scd.[URN] ,scd.[Field] ,sco.CitationSector ,scn.CitationSector
		FROM LeadChangeReview..ML_SCDChanges_History scd
		left outer join LeadChangeReview..SFDC_Success s ON scd.URN = s.Market_Location_URN__c
																			and CONVERT(date, scd.CreatedDate) = CONVERT(date, s.Run_Date)
		left outer join SalesforceReporting..SIC2007Codes sco ON CONVERT(int, scd.NewValue) = CONVERT(int, sco.SIC3_Code) 
		left outer join SalesforceReporting..SIC2007Codes scn ON CONVERT(int, scd.OldValue) = CONVERT(int, scn.SIC3_Code)
		WHERE 
		CONVERT(date, scd.CreatedDate) = CONVERT(date, GETDATE()-1)
		and
		scd.Field = 'UK 07 Sic Code' 
		and 
		sco.CitationSector <> scn.CitationSector
	) detail
	left outer join Salesforce..Lead l ON detail.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
	GROUP BY l.ID
) detail

--12.How much data became part of our Open Dialable CC dialable data pot yesterday?

IF OBJECT_ID('tempdb..#DayBefore') IS NOT NULL
	BEGIN
		DROP TABLE #DayBefore
	END

IF OBJECT_ID('tempdb..#Yesterday') IS NOT NULL
	BEGIN
		DROP TABLE #Yesterday
	END
	
DECLARE @DayBefore as int
DECLARE @Yesterday as int
DECLARE @DB_Date as date
DECLARE @YD_Date as date

SELECT os.Id, CONVERT(date, SnapShotDate) SnapShotDate
INTO #DayBefore
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

SELECT @DB_Date = CONVERT(date, SnapShotDate), @DayBefore = COUNT(Id)
FROM #DayBefore
GROUP BY CONVERT(date, SnapShotDate)

SELECT os.Id, CONVERT(date, SnapShotDate) SnapShotDate
INTO #Yesterday 
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

SELECT @YD_Date = CONVERT(date, SnapShotDate), @Yesterday = COUNT(Id)
FROM #Yesterday
GROUP BY CONVERT(date, SnapShotDate)
		
SELECT 
@YD_Date Yesterday_Date, 
@Yesterday Yesterday_Diallable, 
@DB_Date DayBefore_Date, 
@DayBefore DayBefore_Diallable, 
@Yesterday - @DayBefore DiallableGained

--13.How many records were removed from Open Dialable yesterday?

IF OBJECT_ID('tempdb..#OutOfCrit') IS NOT NULL
	BEGIN
		DROP TABLE #OutOfCrit
	END

SELECT dbd.Id
INTO #OutOfCrit
FROM #DayBefore dbd
left outer join	#Yesterday y ON dbd.Id = y.Id
WHERE y.Id is null

SELECT COUNT(Id) OutOfCrit FROM #OutOfCrit

--a. Status Changed to Open

SELECT lss.Status, lss.Suspended_Closed_Reason__c, COUNT(lss.Id) IntoCrit_Opened
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE itc.Id is not null and CONVERT(date, lss.SnapShotDate) = @YD_Date and dbd.Status = 'Open' and lss.Status <> 'Open'
GROUP BY lss.Status, lss.Suspended_Closed_Reason__c

--b. Deleted / Merged

SELECT lss.[Source__c], COUNT(lss.Id) IntoCrit_New
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots yd ON lss.Id = yd.Id and CONVERT(date, yd.SnapShotDate)= @YD_Date
WHERE CONVERT(date, lss.SnapShotDate) = @DB_Date and yd.Id is null
GROUP BY lss.[Source__c]

--c. Updated by ML

SELECT lss.[Source__c], COUNT(lss.Id) IntoCrit_MLUpdated
FROM LeadChangeReview..Lead_SnapShots lss
inner join #OutOfCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) = @YD_Date
GROUP BY lss.[Source__c]

--14. How many records went into Open Diallable yesterday

IF OBJECT_ID('tempdb..#IntoCrit') IS NOT NULL
	BEGIN
		DROP TABLE #IntoCrit
	END

SELECT y.Id
INTO #IntoCrit
FROM #Yesterday y
left outer join #DayBefore dbd ON y.Id = dbd.Id
WHERE dbd.Id is null

SELECT COUNT(Id) IntoCrit FROM #IntoCrit

--a. Status Changed to Open

SELECT lss.Status, lss.Suspended_Closed_Reason__c, COUNT(lss.Id) IntoCrit_Opened
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #IntoCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE itc.Id is not null and CONVERT(date, lss.SnapShotDate) = @YD_Date and dbd.Status <> 'Open' and lss.Status = 'Open'
GROUP BY lss.Status, lss.Suspended_Closed_Reason__c

--b. Inserted / Newly Created

SELECT lss.[Source__c], COUNT(lss.Id) IntoCrit_New
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join Salesforce..Lead l ON lss.Id = l.Id
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and CONVERT(date, l.CreatedDate) = @YD_Date
GROUP BY lss.[Source__c]

--c. Updated by ML

SELECT lss.[Source__c], COUNT(lss.Id) IntoCrit_MLUpdated
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) = @YD_Date
GROUP BY lss.[Source__c]
