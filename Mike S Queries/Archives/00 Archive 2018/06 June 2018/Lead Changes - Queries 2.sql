
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
WHERE CONVERT(date, SnapShotDate) = '2018-05-21'
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
WHERE CONVERT(date, SnapShotDate) = '2018-06-04'
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
left outer join      #Yesterday y ON dbd.Id = y.Id
WHERE y.Id is null

SELECT COUNT(Id) OutOfCrit FROM #OutOfCrit

--a. Status Changed from Open

SELECT lss.Status, lss.Suspended_Closed_Reason__c, COUNT(lss.Id) OutOfCrit_FromOpen
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE itc.Id is not null and CONVERT(date, lss.SnapShotDate) = @YD_Date and dbd.Status = 'Open' and lss.Status <> 'Open'
GROUP BY lss.Status, lss.Suspended_Closed_Reason__c

--b. Deleted / Merged

SELECT lss.[Source__c], COUNT(lss.Id) OutOfCrit_Delete
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots yd ON lss.Id = yd.Id and CONVERT(date, yd.SnapShotDate)= @YD_Date
WHERE CONVERT(date, lss.SnapShotDate) = @DB_Date and yd.Id is null
GROUP BY lss.[Source__c]

--c. Updated by ML

SELECT [Source__c], COUNT(distinct Id) OutOfCrit_MLUpdated
FROM
(
	SELECT lss.[Source__c], lss.Id 
	FROM LeadChangeReview..Lead_SnapShots lss
	inner join #OutOfCrit itc ON lss.Id = itc.Id
	inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
	WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
	GROUP BY lss.[Source__c], lss.Id
) detail
GROUP BY [Source__c]

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
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and CONVERT(date, l.CreatedDate) >= @DB_Date and CONVERT(date, l.CreatedDate) <= @YD_Date
GROUP BY lss.[Source__c]

--c. Updated by ML
SELECT [Source__c], COUNT(distinct Id) IntoCrit_MLUpdated
FROM
( 
	SELECT lss.[Source__c], lss.Id 
	FROM LeadChangeReview..Lead_SnapShots lss
	inner join #IntoCrit itc ON lss.Id = itc.Id
	inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
	WHERE s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
	GROUP BY lss.[Source__c], lss.Id
) detail
GROUP BY [Source__c]