IF OBJECT_ID('tempdb..#First') IS NOT NULL
	BEGIN
		DROP TABLE #First
	END
IF OBJECT_ID('tempdb..#Last') IS NOT NULL
	BEGIN
		DROP TABLE #Last
	END
IF OBJECT_ID('tempdb..#Position') IS NOT NULL
	BEGIN
		DROP TABLE #Position
	END

SELECT l.Id, scd.CreatedDate
INTO #First
FROM Salesforce..Lead l
inner join [LSAUTOMATION].[LEADS_ODS].ml.SCDChanges scd ON l.Market_Location_URN__c collate latin1_general_CI_AS = scd.URN collate latin1_general_CI_AS
WHERE l.Status in ('Closed','Suspended') and l.Suspended_Closed_Reason__c = 'DM Refusal'
and scd.CreatedDate > l.Status_Changed_Date__c and scd.Field = 'Contact forename'

SELECT l.Id, scd.CreatedDate
INTO #Last
FROM Salesforce..Lead l
inner join [LSAUTOMATION].[LEADS_ODS].ml.SCDChanges scd ON l.Market_Location_URN__c collate latin1_general_CI_AS = scd.URN collate latin1_general_CI_AS
WHERE l.Status in ('Closed','Suspended') and l.Suspended_Closed_Reason__c = 'DM Refusal'
and scd.CreatedDate > l.Status_Changed_Date__c and scd.Field = 'Contact surname'

SELECT l.Id, scd.CreatedDate
INTO #Position
FROM Salesforce..Lead l
inner join [LSAUTOMATION].[LEADS_ODS].ml.SCDChanges scd ON l.Market_Location_URN__c collate latin1_general_CI_AS = scd.URN collate latin1_general_CI_AS
WHERE l.Status in ('Closed','Suspended') and l.Suspended_Closed_Reason__c = 'DM Refusal'
and scd.CreatedDate > l.Status_Changed_Date__c and scd.Field = 'Contact position'

SELECT f.Id, ld.Status_Changed_Date__c Status_Changed_Date, CONVERT(date, f.CreatedDate) Contact_Updated_Date
FROM #First f
inner join #Last l ON f.Id = l.Id and CONVERT(date, f.CreatedDate) = CONVERT(date, l.CreatedDate)
inner join #Position p ON f.Id = l.Id and CONVERT(date, p.CreatedDate) = CONVERT(date, l.CreatedDate)
inner join Salesforce..Lead ld ON f.Id = ld.Id