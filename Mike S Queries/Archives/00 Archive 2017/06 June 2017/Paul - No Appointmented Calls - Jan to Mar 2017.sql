IF OBJECT_ID('SalesforceReporting..PaulReport_CallStats') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..PaulReport_CallStats
	END
	
IF OBJECT_ID('SalesforceReporting..PaulReport_ListStats') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..PaulReport_ListStats
	END

IF OBJECT_ID('SalesforceReporting..PaulReport_CallHistory') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..PaulReport_CallHistory
	END

-- Create Call stats table

		CREATE TABLE SalesforceReporting..PaulReport_CallStats
		(
		Id VarChar(20), 
		DeviceType VarChar(200),
		[Last Call To Date] int, 
		[0 - 30 Days Dials] int, 
		[30 - 60 Days Dials] int, 
		[60 - 90 Days Dials] int, 
		[90 - 120 Days Dials] int, 
		[120 - 365 Days Dials] int,
		[365+ Days Dials] int,
		[Calls] int
		)

-- Populate Call stats table - Dialler

		INSERT INTO SalesforceReporting..PaulReport_CallStats
		(
		Id, 
		DeviceType,
		[Last Call To Date], 
		[0 - 30 Days Dials], 
		[30 - 60 Days Dials], 
		[60 - 90 Days Dials], 
		[90 - 120 Days Dials], 
		[120 - 365 Days Dials],
		[365+ Days Dials],
		Calls
		)

		SELECT 
		l.Id,
		'Dialler' DeviceType,
		DATEDIFF(day, MAX(ch.act_date), MAX(GETDATE())) [Last Call To Date],
		SUM(case when ch.act_date between DATEADD(day, -30, GETDATE()) and GETDATE() then 1 else 0 end) [0 - 30 Days Dials],
		SUM(case when ch.act_date between DATEADD(day, -60, GETDATE()) and DATEADD(day, -30, GETDATE()) then 1 else 0 end) [30 - 60 Days Dials],
		SUM(case when ch.act_date between DATEADD(day, -90, GETDATE()) and DATEADD(day, -60, GETDATE()) then 1 else 0 end) [60 - 90 Days Dials],
		SUM(case when ch.act_date between DATEADD(day, -120, GETDATE()) and DATEADD(day, -90, GETDATE()) then 1 else 0 end) [90 - 120 Days Dials],
		SUM(case when ch.act_date between DATEADD(year, -1, GETDATE()) and DATEADD(day, -120, GETDATE()) then 1 else 0 end) [120 - 365 Days Dials],
		SUM(case when ch.act_date < DATEADD(year, -1, GETDATE()) then 1 else 0 end) [365+ Days Dials],
		COUNT(ch.seqno) Calls

		FROM 
		SalesforceReporting..call_history ch
		left outer join Salesforce..Lead l ON LEFT(l.ID, 15) collate latin1_general_CS_AS = LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS
		left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id

		WHERE 
		(
			Date_Made__c is null 
			or 
			(
				Date_Made__c >= '2017-04-01' and l.Seminar_Status__c is null and o.BDC_Manager__c is not null
			)
			or 
			(
				Date_Made__c is not null and l.Seminar_Status__c not like '%appointment%'
			)
			or
			(
				Date_Made__c is not null and o.BDC_Manager__c is null
			)
		)
		and
		ch.act_date between '2017-01-01' and '2017-03-31'
		and 
		ISNULL(rt.Name,'') <> 'QMS Record Type'
		and
		l.Id is not null

		GROUP BY
		l.Id

-- Populate Call stats table - Outbound Cisco

		INSERT INTO SalesforceReporting..PaulReport_CallStats
		(
		Id, 
		DeviceType,
		[Last Call To Date], 
		[0 - 30 Days Dials], 
		[30 - 60 Days Dials], 
		[60 - 90 Days Dials], 
		[90 - 120 Days Dials], 
		[120 - 365 Days Dials],
		[365+ Days Dials],
		Calls
		)

		SELECT 
		l.Id,
		'Cisco - Outbound' DeviceType,
		DATEDIFF(day, MAX(CONVERT(date, StartDateTime, 103)), MAX(GETDATE())) [Last Call To Date],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -30, GETDATE()) and GETDATE() then 1 else 0 end) [0 - 30 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -60, GETDATE()) and DATEADD(day, -30, GETDATE()) then 1 else 0 end) [30 - 60 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -90, GETDATE()) and DATEADD(day, -60, GETDATE()) then 1 else 0 end) [60 - 90 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -120, GETDATE()) and DATEADD(day, -90, GETDATE()) then 1 else 0 end) [90 - 120 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(year, -1, GETDATE()) and DATEADD(day, -120, GETDATE()) then 1 else 0 end) [120 - 365 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) < DATEADD(year, -1, GETDATE()) then 1 else 0 end) [365+ Days Dials],
		COUNT(ch.Id) Calls

		FROM 
		SalesforceReporting..Contact_Centre ch
		left outer join Salesforce..Lead l ON CalledId = l.Id
		left outer join SalesforceReporting..BDC_Cisco el ON REPLACE(case when ch.CallingPhone like '0%' then ch.CallingPhone else '0'+ch.CallingPhone end,' ','') = REPLACE(el.DirectDial,' ','')
		left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id

		WHERE 
		(
			Date_Made__c is null 
			or 
			(
				Date_Made__c >= '2017-04-01' and l.Seminar_Status__c is null and o.BDC_Manager__c is not null
			)
			or 
			(
				Date_Made__c is not null and l.Seminar_Status__c not like '%appointment%'
			)
			or
			(
				Date_Made__c is not null and o.BDC_Manager__c is null
			)
		)
		and
		CONVERT(date, StartDateTime, 103) between '2017-01-01' and '2017-03-31'
		and 
		ISNULL(rt.Name,'') <> 'QMS Record Type'
		and
		l.Id is not null
		and
		ch.[Type] = 'Ext/Out'
		and
		el.Id is not null

		GROUP BY
		l.Id

-- Populate Call stats table - Inbound Cisco

		INSERT INTO SalesforceReporting..PaulReport_CallStats
		(
		Id, 
		DeviceType,
		[Last Call To Date], 
		[0 - 30 Days Dials], 
		[30 - 60 Days Dials], 
		[60 - 90 Days Dials], 
		[90 - 120 Days Dials], 
		[120 - 365 Days Dials],
		[365+ Days Dials],
		Calls
		)

		SELECT 
		l.Id,
		'Cisco - Inbound' DeviceType,
		DATEDIFF(day, MAX(CONVERT(date, StartDateTime, 103)), MAX(GETDATE())) [Last Call To Date],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -30, GETDATE()) and GETDATE() then 1 else 0 end) [0 - 30 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -60, GETDATE()) and DATEADD(day, -30, GETDATE()) then 1 else 0 end) [30 - 60 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -90, GETDATE()) and DATEADD(day, -60, GETDATE()) then 1 else 0 end) [60 - 90 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(day, -120, GETDATE()) and DATEADD(day, -90, GETDATE()) then 1 else 0 end) [90 - 120 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) between DATEADD(year, -1, GETDATE()) and DATEADD(day, -120, GETDATE()) then 1 else 0 end) [120 - 365 Days Dials],
		SUM(case when CONVERT(date, StartDateTime, 103) < DATEADD(year, -1, GETDATE()) then 1 else 0 end) [365+ Days Dials],
		COUNT(ch.Id) Calls

		FROM 
		SalesforceReporting..Contact_Centre ch
		left outer join Salesforce..Lead l ON CallingId = l.Id
		left outer join SalesforceReporting..BDC_Cisco el ON REPLACE(case when ch.CalledPhone like '0%' then ch.CalledPhone else '0'+ch.CalledPhone end,' ','') = REPLACE(el.DirectDial,' ','')
		left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id

		WHERE 
		(
			Date_Made__c is null 
			or 
			(
				Date_Made__c >= '2017-04-01' and l.Seminar_Status__c is null and o.BDC_Manager__c is not null
			)
			or 
			(
				Date_Made__c is not null and l.Seminar_Status__c not like '%appointment%'
			)
			or
			(
				Date_Made__c is not null and o.BDC_Manager__c is null
			)
		)
		and
		CONVERT(date, StartDateTime, 103) between '2017-01-01' and '2017-03-31'
		and 
		ISNULL(rt.Name,'') <> 'QMS Record Type'
		and
		l.Id is not null
		and
		ch.[Type] = 'Ext/In'
		and
		el.Id is not null

		GROUP BY
		l.Id

-- Populate List stats table

		SELECT l.Id, COUNT(c.Id)TimesImported, MAX(c.CreatedDate) LastImported
		INTO SalesforceReporting..PaulReport_ListStats
		FROM Salesforce..Lead l
		inner join SalesforceReporting..PaulReport_CallStats cs ON l.Id = cs.Id
		inner join Salesforce..CampaignMember cm ON l.Id = cm.LeadId
		inner join Salesforce..Campaign c ON cm.CampaignId = c.Id
		GROUP BY l.Id

-- Populate Call history table

		SELECT seqno, act_date, act_time, l.Id, CONVERT(VarChar, ch.call_type) + ' - ' + Enterprise.dbo.udf_TranslateCallType(ch.call_type) [Call Type]
		INTO SalesforceReporting..PaulReport_CallHistory
		FROM SalesforceReporting..call_history ch
		inner join Salesforce..Lead l ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(l.ID, 15) collate latin1_general_CS_AS
		WHERE YEAR(act_date) = YEAR(GETDATE())
		
		INSERT INTO SalesforceReporting..PaulReport_CallHistory
		(seqno, act_date, act_time, Id, [Call Type])
		SELECT seqno, act_date, act_time, l.Id, CONVERT(VarChar, ch.call_type) + ' - ' + Enterprise.dbo.udf_TranslateCallType(ch.call_type) [Call Type]
		FROM Enterprise..call_history ch
		inner join Salesforce..Lead l ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(l.ID, 15) collate latin1_general_CS_AS
		WHERE YEAR(act_date) = YEAR(GETDATE())

-- Final Output

		SELECT
		ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY (SELECT NULL)) Id,
		l.Id SFDC_Id,
		l.Company,
		Date_Made__c [Booked Date],
		l.CreatedDate [Created Date],
		ls.LastImported [Last Imported],
		ls.TimesImported [Times Imported],
		ISNULL(l.Source__c, '') [Source],
		ISNULL(l.Data_Supplier__c, '') [Data Supplier],
		ISNULL(l.LeadSource, '') [Prospect Source],
		ISNULL(l.Prospect_Channel__c, '') [Prospect Channel],
		ch.seqno [Call History ID],
		ch.act_date [Call Date],
		ch.[Call Type],
		cs.[Last Call To Date],
		cs.[0 - 30 Days Dials],
		cs.[30 - 60 Days Dials],
		cs.[60 - 90 Days Dials],
		cs.[90 - 120 Days Dials],
		cs.[120 - 365 Days Dials],
		cs.[365+ Days Dials],
		case when cs.DeviceType like '%Dialler%' then cs.Calls else 0 end [Dialler CTA],
		case when cs.DeviceType like '%cisco%' then cs.Calls else 0 end [Cisco CTA]
		
		INTO
		SalesforceReporting..PaulReport_NoAppoints

		FROM
		Salesforce..Lead l
		left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
		left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		left outer join SalesforceReporting..PaulReport_CallStats cs ON l.Id = cs.Id
		left outer join SalesforceReporting..PaulReport_ListStats ls ON l.Id = ls.Id
		left outer join	SalesforceReporting..PaulReport_CallHistory ch ON l.Id = ch.Id
		
		WHERE
		cs.Id is not null

		ORDER BY
		l.Company, l.Id, [Call Date] desc