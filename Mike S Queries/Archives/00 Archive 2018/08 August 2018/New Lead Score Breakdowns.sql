      
DECLARE @DayBefore as int
DECLARE @Yesterday as int
DECLARE @DB_Date as date
DECLARE @YD_Date as date

SELECT @DB_Date = CONVERT(date, SnapShotDate), @DayBefore = COUNT(Id)
FROM SalesforceReporting..Temp_DayBefore
GROUP BY CONVERT(date, SnapShotDate)

SELECT @YD_Date = CONVERT(date, SnapShotDate), @Yesterday = COUNT(Id)
FROM SalesforceReporting..Temp_Yesterday
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
FROM SalesforceReporting..Temp_DayBefore dbd
left outer join SalesforceReporting..Temp_Yesterday y ON dbd.Id = y.Id
WHERE y.Id is null

SELECT COUNT(Id) OutOfCrit FROM #OutOfCrit

--a. Status Changed from Open

SELECT lss.Status, lss.Suspended_Closed_Reason__c, COUNT(lss.Id) OutOfCrit_FromOpen
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE itc.Id is not null and CONVERT(date, lss.SnapShotDate) = @YD_Date and dbd.Status = 'Open' and lss.Status <> 'Open'
GROUP BY lss.Status, lss.Suspended_Closed_Reason__c

--a1. Status Changed from Open - Old values

SELECT dbd.Status, dbd.Suspended_Closed_Reason__c, COUNT(lss.Id) OutOfCrit_FromOpen
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE itc.Id is not null and CONVERT(date, lss.SnapShotDate) = @YD_Date and dbd.Status = 'Open' and lss.Status <> 'Open'
GROUP BY dbd.Status, dbd.Suspended_Closed_Reason__c

--b. Deleted / Merged

SELECT lss.[Source__c], COUNT(lss.Id) OutOfCrit_Delete
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots yd ON lss.Id = yd.Id and CONVERT(date, yd.SnapShotDate)= @YD_Date
WHERE CONVERT(date, lss.SnapShotDate) = @DB_Date and yd.Id is null
GROUP BY lss.[Source__c]

--b1. Deleted / Merged by Data Supplier

SELECT lss.Data_Supplier__c, COUNT(lss.Id) OutOfCrit_Delete
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #OutOfCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots yd ON lss.Id = yd.Id and CONVERT(date, yd.SnapShotDate)= @YD_Date
WHERE CONVERT(date, lss.SnapShotDate) = @DB_Date and yd.Id is null
GROUP BY lss.Data_Supplier__c

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

--c1. Updated by ML - Supplier and Key Crit

SELECT Data_Supplier__c, COUNT(distinct Id) OutOfCrit_MLUpdated
FROM
(
      SELECT lss.Data_Supplier__c, lss.Id 
      FROM LeadChangeReview..Lead_SnapShots lss
      inner join #OutOfCrit itc ON lss.Id = itc.Id
      inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
      WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
      GROUP BY lss.Data_Supplier__c, lss.Id
) detail
GROUP BY Data_Supplier__c

-- Name and Position

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #OutOfCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.Position__c <> lss.Position__c and dbd.FirstName <> lss.FirstName and dbd.LastName <> lss.LastName

-- Address

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #OutOfCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.Street <> lss.Street and dbd.PostalCode <> lss.PostalCode

-- Citation Sector

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #OutOfCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.CitationSector__c <> lss.CitationSector__c

-- FTE

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #OutOfCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.FT_Employees__c <> lss.FT_Employees__c

-- Phone

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #OutOfCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.Phone <> lss.Phone

--14. How many records went into Open Diallable yesterday

IF OBJECT_ID('tempdb..#IntoCrit') IS NOT NULL
       BEGIN
              DROP TABLE #IntoCrit
       END

SELECT y.Id
INTO #IntoCrit
FROM SalesforceReporting..Temp_Yesterday y
left outer join SalesforceReporting..Temp_DayBefore dbd ON y.Id = dbd.Id
WHERE dbd.Id is null

SELECT COUNT(Id) IntoCrit FROM #IntoCrit

--a. Status Changed to Open

SELECT lss.Status, lss.Suspended_Closed_Reason__c, COUNT(lss.Id) IntoCrit_Opened
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #IntoCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE itc.Id is not null and CONVERT(date, lss.SnapShotDate) = @YD_Date and dbd.Status <> 'Open' and lss.Status = 'Open'
GROUP BY lss.Status, lss.Suspended_Closed_Reason__c

--a1. Status Changed to Open - Old Values

SELECT dbd.Status, dbd.Suspended_Closed_Reason__c, COUNT(lss.Id) IntoCrit_Opened
FROM LeadChangeReview..Lead_SnapShots lss
left outer join #IntoCrit itc ON lss.Id = itc.Id
left outer join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE itc.Id is not null and CONVERT(date, lss.SnapShotDate) = @YD_Date and dbd.Status <> 'Open' and lss.Status = 'Open'
GROUP BY dbd.Status, dbd.Suspended_Closed_Reason__c

--b. Inserted / Newly Created

SELECT lss.[Source__c], COUNT(lss.Id) IntoCrit_New
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join Salesforce..Lead l ON lss.Id = l.Id
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and CONVERT(date, l.CreatedDate) >= @DB_Date and CONVERT(date, l.CreatedDate) <= @YD_Date
GROUP BY lss.[Source__c]

--b1. Inserted / Newly Created by Data Supplier

SELECT lss.Data_Supplier__c, COUNT(lss.Id) IntoCrit_New
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join Salesforce..Lead l ON lss.Id = l.Id
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and CONVERT(date, l.CreatedDate) >= @DB_Date and CONVERT(date, l.CreatedDate) <= @YD_Date
GROUP BY lss.Data_Supplier__c

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

--c1. Updated by ML by Data Supplier and Key Crit Fields
SELECT Data_Supplier__c, COUNT(distinct Id) IntoCrit_MLUpdated
FROM
( 
      SELECT lss.Data_Supplier__c, lss.Id 
      FROM LeadChangeReview..Lead_SnapShots lss
      inner join #IntoCrit itc ON lss.Id = itc.Id
      inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
      WHERE s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
      GROUP BY lss.Data_Supplier__c, lss.Id
) detail
GROUP BY Data_Supplier__c

-- Name and Position

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.Position__c <> lss.Position__c and dbd.FirstName <> lss.FirstName and dbd.LastName <> lss.LastName

-- Address

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.Street <> lss.Street and dbd.PostalCode <> lss.PostalCode

-- Citation Sector

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.CitationSector__c <> lss.CitationSector__c

-- FTE

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.FT_Employees__c <> lss.FT_Employees__c

-- Phone

SELECT COUNT(lss.Id)
FROM LeadChangeReview..Lead_SnapShots lss
inner join #IntoCrit itc ON lss.Id = itc.Id
inner join LeadChangeReview..SFDC_Success s ON lss.Market_Location_URN__c = s.Market_Location_URN__c collate latin1_general_ci_as
inner join LeadChangeReview..Lead_SnapShots dbd ON itc.Id = dbd.Id and dbd.SnapShotDate = @DB_Date
WHERE CONVERT(date, lss.SnapShotDate) = @YD_Date and s.Record_Type = 'Update' and CONVERT(Date, s.Run_Date) >= @DB_Date and CONVERT(Date, s.Run_Date) <= @YD_Date
and dbd.Phone <> lss.Phone