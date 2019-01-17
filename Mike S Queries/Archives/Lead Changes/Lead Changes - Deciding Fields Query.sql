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
		FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges scd
		left outer join [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Success_Log_MLAPI s ON scd.URN = s.Market_Location_URN__c
																			and CONVERT(date, scd.CreatedDate) = CONVERT(date, s.Run_Date)
		WHERE 
		CONVERT(date, scd.CreatedDate) = '2018-05-02'
		and
		Field in ('Contact forename','Contact surname','Contact position','Address Line 1','Postcode','Nat Employees','Telephone Number','UK 07 Sic Code') 
		and 
		NewValue <> OldValue
		UNION
		SELECT scd.[CreatedDate] ,scd.[Source] ,scd.[URN] ,scd.[Field] ,sco.CitationSector ,scn.CitationSector
		FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges scd
		left outer join [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Success_Log_MLAPI s ON scd.URN = s.Market_Location_URN__c
																			and CONVERT(date, scd.CreatedDate) = CONVERT(date, s.Run_Date)
		left outer join SalesforceReporting..SIC2007Codes sco ON CONVERT(int, scd.NewValue) = CONVERT(int, sco.SIC3_Code) 
		left outer join SalesforceReporting..SIC2007Codes scn ON CONVERT(int, scd.OldValue) = CONVERT(int, scn.SIC3_Code)
		WHERE 
		CONVERT(date, scd.CreatedDate) = '2018-05-02'
		and
		scd.Field = 'UK 07 Sic Code' 
		and 
		sco.CitationSector <> scn.CitationSector
	) detail
	left outer join Salesforce..Lead l ON detail.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
	GROUP BY l.ID
) detail