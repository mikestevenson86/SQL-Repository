-- Declare date variable

DECLARE @RunDate as Date
SET @RunDate = '2016-01-01'

WHILE @RunDate < GETDATE()
	BEGIN

	-- Drop temporary tables if they exist

	IF OBJECT_ID('tempdb..#LastChanges') IS NOT NULL
		BEGIN
			DROP TABLE #LastChanges
		END

	IF OBJECT_ID('tempdb..#OldValue') IS NOT NULL
		BEGIN
			DROP TABLE #OldValue
		END
		
	IF OBJECT_ID('tempdb..#ST') IS NOT NULL
		BEGIN
			DROP TABLE #ST
		END
				
	IF OBJECT_ID('tempdb..#CS') IS NOT NULL
		BEGIN
			DROP TABLE #CS
		END	
			
	IF OBJECT_ID('tempdb..#FT') IS NOT NULL
		BEGIN
			DROP TABLE #FT
		END	
			
	IF OBJECT_ID('tempdb..#LS') IS NOT NULL
		BEGIN
			DROP TABLE #LS
		END
				
	IF OBJECT_ID('tempdb..#OW') IS NOT NULL
		BEGIN
			DROP TABLE #OW
		END
				
	IF OBJECT_ID('tempdb..#PH') IS NOT NULL
		BEGIN
			DROP TABLE #PH
		END	
			
	IF OBJECT_ID('tempdb..#RT') IS NOT NULL
		BEGIN
			DROP TABLE #RT
		END
				
	IF OBJECT_ID('tempdb..#SC') IS NOT NULL
		BEGIN
			DROP TABLE #SC
		END
				
	IF OBJECT_ID('tempdb..#TP') IS NOT NULL
		BEGIN
			DROP TABLE #TP
		END
				
	IF OBJECT_ID('tempdb..#TS') IS NOT NULL
		BEGIN
			DROP TABLE #TS
		END
				
	IF OBJECT_ID('tempdb..#OldState') IS NOT NULL
		BEGIN
			DROP TABLE #OldState
		END

	-- Build table for last new values before variable date

	SELECT *
	INTO #LastChanges
	FROM
	(
	SELECT LeadId, Field, NewValue, CreatedDate, ROW_NUMBER () OVER (PARTITION BY LeadId, Field ORDER BY CreatedDate desc) rn
	FROM Salesforce..LeadHistory
	WHERE 
	Field in ('Status','RecordType','SIC2007_Code3__c','CitationSector__c','FT_Employees__c','Owner','ownerAssignment','Phone','IsTPS__c','LeadSource')
	and case when Field in ('Owner','ownerAssignment') then LEFT(NewValue, 5) else '1' end = case when Field in ('Owner','ownerAssignment') then '005D0' else '1' end
	and CreatedDate < @RunDate 
	-- Optional Id refinement
	--and LeadId = '00QD000000fQoXYMA0'
	) detail
	WHERE rn=1

	-- Build table for last old value EVER

	SELECT *
	INTO #OldValue
	FROM
	(
	SELECT LeadId, Field, OldValue, CreatedDate, ROW_NUMBER () OVER (PARTITION BY LeadId, Field ORDER BY CreatedDate desc) rn
	FROM Salesforce..LeadHistory
	WHERE Field in ('Status','RecordType','SIC2007_Code3__c','CitationSector__c','FT_Employees__c','Owner','ownerAssignment','Phone','IsTPS__c','LeadSource')
	and case when Field in ('Owner','ownerAssignment') then LEFT(NewValue, 5) else '1' end = case when Field in ('Owner','ownerAssignment') then '005D0' else '1' end
	-- Optional Id refinement
	--and LeadId = '00QD000000fQoXYMA0'
	) detail
	WHERE rn=1

	-- Old States Table

	-- Status
	SELECT 
	cs.Id,
	case when cs.Status <> 
	ISNULL(
		(
		SELECT NewValue 
		FROM #LastChanges lc 
		WHERE lc.LeadId = cs.Id and lc.Field = 'Status'
		),
		ISNULL(
			(
				SELECT OldValue 
				FROM #OldValue ov 
				WHERE ov.LeadId = cs.Id and ov.Field = 'Status'
			), 
		cs.Status
		)
	)
	then
	ISNULL(
		(
		SELECT NewValue 
		FROM #LastChanges lc 
		WHERE lc.LeadId = cs.Id and lc.Field = 'Status'
		),
		ISNULL(
			(
				SELECT OldValue 
				FROM #OldValue ov 
				WHERE ov.LeadId = cs.Id and ov.Field = 'Status'
			), 
		cs.Status
		)
	)
	else
	cs.Status end Status

	INTO
	#ST

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- Record Type
	SELECT 
	cs.Id,
	case when cs.RecordType <> 
	ISNULL(
		(
		SELECT NewValue 
		FROM #LastChanges lc 
		WHERE lc.LeadId = cs.Id and lc.Field = 'RecordType'
		),
		ISNULL(
			(
				SELECT OldValue 
				FROM #OldValue ov 
				WHERE ov.LeadId = cs.Id and ov.Field = 'RecordType'
			), 
		cs.RecordType
		)
	)
	then
	ISNULL(
		(
		SELECT NewValue 
		FROM #LastChanges lc 
		WHERE lc.LeadId = cs.Id and lc.Field = 'RecordType'
		),
		ISNULL(
			(
				SELECT OldValue 
				FROM #OldValue ov 
				WHERE ov.LeadId = cs.Id and ov.Field = 'RecordType'
			), 
		cs.RecordType
		)
	)
	else
	cs.RecordType end RecordType

	INTO
	#RT

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- SIC Code 3

	SELECT 
	cs.Id,
	case when CONVERT(VarChar, cs.SIC2007_Code3__c) <> 
	ISNULL(
		(
			SELECT CONVERT(VarChar, NewValue) 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'SIC2007_Code3__c'
		), 
		ISNULL(
			(
				SELECT CONVERT(VarChar, OldValue) 
				FROM #OldValue ov 
				WHERE ov.LeadId = cs.Id and ov.Field = 'SIC2007_Code3__c'
			), 
		cs.SIC2007_Code3__c
		)
	)
	then
	ISNULL(
		(
			SELECT CONVERT(VarChar, NewValue) 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'SIC2007_Code3__c'
		), 
		ISNULL(
			(
				SELECT CONVERT(VarChar, OldValue) 
				FROM #OldValue ov 
				WHERE ov.LeadId = cs.Id and ov.Field = 'SIC2007_Code3__c'
			), 
		cs.SIC2007_Code3__c
		)
	)
	else 
	CONVERT(VarChar, cs.SIC2007_Code3__c) end SIC2007_Code3__c

	INTO
	#SC

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- Citation Sector

	SELECT cs.Id,
	case when cs.CitationSector__c <> 
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'CitationSector__c'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'CitationSector__c'
			),
		cs.CitationSector__c
		)
	)
	then
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'CitationSector__c'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'CitationSector__c'
			),
		cs.CitationSector__c
		)
	)
	else
	cs.CitationSector__c end CitationSector__c

	INTO
	#CS

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- FT Employees

	SELECT 
	cs.Id,
	case when CONVERT(VarChar, cs.FT_Employees__c) <> 
	ISNULL(
	(
	SELECT CONVERT(VarChar, NewValue) 
	FROM #LastChanges lc 
	WHERE lc.LeadId = cs.Id and lc.Field = 'FT_Employees__c'
	), 
		ISNULL(
			(
				SELECT CONVERT(VarChar, OldValue)
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'FT_Employees__c'
			),
		cs.FT_Employees__c
		)
	)
	then
	(SELECT CONVERT(VarChar, NewValue) FROM #LastChanges lc WHERE lc.LeadId = cs.Id and lc.Field = 'FT_Employees__c')
	else
	CONVERT(VarChar, cs.FT_Employees__c)
	end FT_Employees__c

	INTO
	#FT

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- Is TPS

	SELECT 
	cs.Id,
	case when cs.IsTPS__c <> 
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'IsTPS__c'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'IsTPS__c'
			),
		cs.IsTPS__c
		)
	)
	then
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'IsTPS__c'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'IsTPS__c'
			),
		cs.IsTPS__c
		)
	)
	else
	cs.IsTPS__c end IsTPS__c

	INTO
	#TP

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- Phone

	SELECT cs.Id, 
	case when cs.Phone <> 
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'Phone'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'Phone'
			),
		cs.Phone
		)
	)
	then
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'Phone'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'Phone'
			),
		cs.Phone
		)
	)
	else
	cs.Phone end Phone

	INTO
	#PH

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- Toxic SIC
	SELECT 
	cs.Id, 
	case when cs.ToxicSIC <> 
	ISNULL(
		(
			SELECT case when ISNULL(NewValue, '0')  in 
			(
			'1629','20130','20140','20150','20160','20200','20301','42120','43110','47300','49100','49200','64910','49311','64921','49319','64922','49320','64192','64110','64205','64191','69101','69102','69109','
			80300','81223','86101','86210','94910','50100','50200','50300','50400','51220','9100','52211','99999','84210','84220','84230','84240','84250','84300','86220','90040','91011','91012','91020','91030','
			91040','93120','93130','93191','93199','93210','93290','5101','5102','5200','6100','6200','7100','7210','7290','8110','8120','8910','8920','8930','8990','9100','9900','35110','35120','35130','35140','
			35210','35220','35230','35300','36000','37000','38110','38120','38210','38220','38310','38320','39000','55100','55201','55202','55209','55300','55900','56101','56102','56103','56210','56290','56301','
			56302','64110','64191','64192','64201','64202','64203','64204','64205','64209','64301','64302','64303','64304','64305','64306','64910','64921','64922','64929','64991','64992','64999','65110','65120','
			65201','65202','65300','66110','66120','66190','66210','66220','66290','66300'
			) then 'Yes' else 'No' end ToxicSIC
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'SIC2007_Code3__c'
		), 
		ISNULL(
			(
				SELECT case when ISNULL(OldValue, '0')  in 
				(
				'1629','20130','20140','20150','20160','20200','20301','42120','43110','47300','49100','49200','64910','49311','64921','49319','64922','49320','64192','64110','64205','64191','69101','69102','69109','
				80300','81223','86101','86210','94910','50100','50200','50300','50400','51220','9100','52211','99999','84210','84220','84230','84240','84250','84300','86220','90040','91011','91012','91020','91030','
				91040','93120','93130','93191','93199','93210','93290','5101','5102','5200','6100','6200','7100','7210','7290','8110','8120','8910','8920','8930','8990','9100','9900','35110','35120','35130','35140','
				35210','35220','35230','35300','36000','37000','38110','38120','38210','38220','38310','38320','39000','55100','55201','55202','55209','55300','55900','56101','56102','56103','56210','56290','56301','
				56302','64110','64191','64192','64201','64202','64203','64204','64205','64209','64301','64302','64303','64304','64305','64306','64910','64921','64922','64929','64991','64992','64999','65110','65120','
				65201','65202','65300','66110','66120','66190','66210','66220','66290','66300'
				) then 'Yes' else 'No' end ToxicSIC
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'SIC2007_Code3__c'
			),
		cs.ToxicSIC
		)
	)
	then
	ISNULL(
		(
			SELECT case when ISNULL(NewValue, '0')  in 
			(
			'1629','20130','20140','20150','20160','20200','20301','42120','43110','47300','49100','49200','64910','49311','64921','49319','64922','49320','64192','64110','64205','64191','69101','69102','69109','
			80300','81223','86101','86210','94910','50100','50200','50300','50400','51220','9100','52211','99999','84210','84220','84230','84240','84250','84300','86220','90040','91011','91012','91020','91030','
			91040','93120','93130','93191','93199','93210','93290','5101','5102','5200','6100','6200','7100','7210','7290','8110','8120','8910','8920','8930','8990','9100','9900','35110','35120','35130','35140','
			35210','35220','35230','35300','36000','37000','38110','38120','38210','38220','38310','38320','39000','55100','55201','55202','55209','55300','55900','56101','56102','56103','56210','56290','56301','
			56302','64110','64191','64192','64201','64202','64203','64204','64205','64209','64301','64302','64303','64304','64305','64306','64910','64921','64922','64929','64991','64992','64999','65110','65120','
			65201','65202','65300','66110','66120','66190','66210','66220','66290','66300'
			) then 'Yes' else 'No' end ToxicSIC
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'SIC2007_Code3__c' --and ISNUMERIC(NewValue) = 'true'
		), 
		ISNULL(
			(
				SELECT case when ISNULL(OldValue, '0')  in 
				(
				'1629','20130','20140','20150','20160','20200','20301','42120','43110','47300','49100','49200','64910','49311','64921','49319','64922','49320','64192','64110','64205','64191','69101','69102','69109','
				80300','81223','86101','86210','94910','50100','50200','50300','50400','51220','9100','52211','99999','84210','84220','84230','84240','84250','84300','86220','90040','91011','91012','91020','91030','
				91040','93120','93130','93191','93199','93210','93290','5101','5102','5200','6100','6200','7100','7210','7290','8110','8120','8910','8920','8930','8990','9100','9900','35110','35120','35130','35140','
				35210','35220','35230','35300','36000','37000','38110','38120','38210','38220','38310','38320','39000','55100','55201','55202','55209','55300','55900','56101','56102','56103','56210','56290','56301','
				56302','64110','64191','64192','64201','64202','64203','64204','64205','64209','64301','64302','64303','64304','64305','64306','64910','64921','64922','64929','64991','64992','64999','65110','65120','
				65201','65202','65300','66110','66120','66190','66210','66220','66290','66300'
				) then 'Yes' else 'No' end ToxicSIC
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'SIC2007_Code3__c' --and ISNUMERIC(OldValue) = 'true'
			),
		cs.ToxicSIC
		)
	)
	else
	cs.ToxicSIC end Toxic_SIC__c

	INTO
	#TS

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- OwnerId
	SELECT cs.Id, 
	case when cs.OwnerId <> 
	ISNULL(
		(
			SELECT TOP 1 NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field in ('Owner','ownerAssignment')
			ORDER BY lc.CreatedDate desc
		), 
		ISNULL(
			(
				SELECT TOP 1 OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field in ('Owner','ownerAssignment')
				ORDER BY ov.CreatedDate desc
			),
		cs.OwnerId
		)
	)
	then
	ISNULL(
		(
			SELECT TOP 1 NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field in ('Owner','ownerAssignment')
			ORDER BY lc.CreatedDate desc
		), 
		ISNULL(
			(
				SELECT TOP 1 OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field in ('Owner','ownerAssignment')
				ORDER BY ov.CreatedDate desc
			),
		cs.OwnerId
		)
	)
	else
	cs.OwnerId end OwnerId

	INTO
	#OW

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- LeadSource

	SELECT cs.Id,
	case when cs.LeadSource <> 
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'LeadSource'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'LeadSource'
			),
		cs.LeadSource
		)
	)
	then
	ISNULL(
		(
			SELECT NewValue 
			FROM #LastChanges lc 
			WHERE lc.LeadId = cs.Id and lc.Field = 'LeadSource'
		), 
		ISNULL(
			(
				SELECT OldValue
				FROM #OldValue ov
				WHERE ov.LeadId = cs.Id and ov.Field = 'LeadSource'
			),
		cs.LeadSource
		)
	)
	else
	cs.LeadSource end LeadSource

	INTO
	#LS

	FROM 
	SalesforceReporting..CurrentState cs
	left outer join Salesforce..Lead l ON cs.Id = l.Id

	WHERE
	l.CreatedDate <= @RunDate
	-- Optional Id refinement
	-- and cs.Id = '00QD000000fQoXYMA0'

	-- Join Table

	SELECT l.ID, st.[Status], rt.RecordType, sc.SIC2007_Code3__C, cs.CitationSector__c, ft.FT_Employees__c, tp.IsTPS__c, ph.Phone, ts.Toxic_SIC__c, ow.OwnerId, ls.LeadSource
	INTO #OldState
	FROM Salesforce..Lead l
	left outer join #CS cs ON l.Id = cs.Id
	left outer join #FT ft ON l.Id = ft.Id
	left outer join #LS ls ON l.Id = ls.Id
	left outer join #OW ow ON l.Id = ow.Id
	left outer join #PH ph ON l.Id = ph.Id
	left outer join #RT rt ON l.Id = rt.Id
	left outer join #SC sc ON l.Id = sc.Id
	left outer join #TP tp ON l.Id = tp.Id
	left outer join #TS ts ON l.Id = ts.Id
	left outer join #ST st ON l.Id = st.Id

	-- Days Diallable Count
	INSERT INTO SalesforceReporting..DiallableHistory (CaptureDate, Diallable)
	SELECT @RunDate CaptureDate, COUNT(distinct os.Id) Diallable_Prospects
	FROM #OldState os
	left outer join Salesforce..[User] bdm ON os.OwnerId = bdm.Id
	WHERE
	os.RecordType = 'Default Citation Record Type'
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

	SET @RunDate = DATEADD(month,1,@RunDate)

	-- Drop temporary tables

	DROP TABLE #LastChanges
	DROP TABLE #OldValue
	DROP TABLE #CS
	DROP TABLE #FT
	DROP TABLE #LS
	DROP TABLE #OW
	DROP TABLE #PH
	DROP TABLE #RT
	DROP TABLE #SC
	DROP TABLE #TP
	DROP TABLE #TS
	DROP TABLE #ST
	DROP TABLE #OldState
	
END