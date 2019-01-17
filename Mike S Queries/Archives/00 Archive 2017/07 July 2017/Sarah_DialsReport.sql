IF OBJECT_ID('tempdb..#Crit') IS NOT NULL
	BEGIN
		DROP TABLE #Crit
	END

IF OBJECT_ID('tempdb..#Calls') IS NOT NULL
	BEGIN
		DROP TABLE #Calls
	END

IF OBJECT_ID('tempdb..#PrevStat') IS NOT NULL
	BEGIN
		DROP TABLE #PrevStat
	END

IF OBJECT_ID('SalesforceReporting..DiallerActivity') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..DiallerActivity
	END

	SELECT 
	l.Id, 
	DATENAME(Month, ch.act_date) [Month Dialled], 
	COUNT(Id) Dials, 
	SUM(case when ch.call_type in (0,2,4) then 1 else 0 end) Connects,
	tsr,
	call_type,
	ch.[status],
	ch.addi_status

	INTO 
	#Calls

	FROM 
	SalesforceReporting..call_history ch
	inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.ID, 15) collate latin1_general_CS_AS

	WHERE 
	DATEPART(Year, ch.act_date) >= DATEPART(Year, GETDATE())

	GROUP BY 
	l.Id, 
	DATENAME(Month, ch.act_date),
	tsr,
	call_type,
	ch.[status],
	ch.addi_status

	-- Find Leads that meet criteria

	SELECT 
	l.Id
	
	INTO 
	#Crit
	
	FROM 
	Salesforce..Lead l
	inner join Salesforce..[User] u ON l.OwnerId = u.Id
	inner join Salesforce..[Profile] p ON u.ProfileId = p.Id
	
	WHERE 
	SIC2007_Code3__c is not null and 
	ISNULL(l.Phone,'') <> '' and 
	Source__c not like 'LB%' and
	Source__c not like 'Closed%' and
	Source__c not like 'marketing%' and
	Source__c not like 'toxic%' and
	Source__c not like 'welcome%' and
	p.Name like '%BDM%' and 
	l.RecordTypeId = '012D0000000NbJsIAK' and 
	IsTPS__c = 'No' and 
	Toxic_SIC__c = 'false' and
	(
		CitationSector__c = 'CARE'
		or
		(
			l.FT_Employees__c between 6 and 225 
			or 
			(l.FT_Employees__c = 5 and l.Country in ('Scotland','Northern Ireland'))
			or
			(CitationSector__c in ('CLEANING','HORTICULTURE') and l.FT_Employees__c between 4 and 225)
			or
			(CitationSector__c in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY','FUNERAL SERVICES') and l.FT_Employees__c between 3 and 225)
		)
	) and 
	ISNULL(CitationSector__c,'') <> 'EDUCATION' 

	-- Find previous status of Leads

	SELECT 
	LeadId, 
	OldValue
	
	INTO 
	#PrevStat
	
	FROM 
	Salesforce..LeadHistory lh
	inner join	(
				SELECT LeadId Id, MAX(CreatedDate) CreatedDate, MAX(Id) lh_Id
				FROM Salesforce..LeadHistory
				WHERE Field = 'Status'
				GROUP BY LeadId
				) detail ON lh.LeadId = detail.Id and lh.CreatedDate = detail.CreatedDate and detail.lh_Id = lh.Id
	
	WHERE 
	Field = 'Status'
	
	GROUP BY 
	LeadId, 
	OldValue

	-- Final Results

	SELECT 
	ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY [Month Dialled]) DA_Id,
	l.Id,
	ch.[Month Dialled], 
	case when cr.Id is not null then 'Yes' else 'No' end [In Crit],
	ch.Dials,
	ch.Connects [Dialler Connected Calls],
	case when call_type = 0 then 'Outbound call passed to an agent'
	when call_type = 1 then 'Outbound call which was not passed to an agent (e.g. Busy, No Answer and so on)'
	when call_type = 2 then 'A transferred call which was successfully connected'
	when call_type = 3 then 'A transferred call which failed'
	when call_type = 4 then 'A callback which was passed to an agent'
	when call_type = 5 then 'A callback that was not passed to an agent (E.g. Busy, No Answer etc.)'
	when call_type = 6 then 'A dropped outbound call' 
	end [Call Status - Start],
	case when ch.status in ('AP') then 'Appointment'
	when ch.status = 'B' then 'Busy'
	when ch.status = 'CC' then 'Call Completed'
	when ch.status = 'CL' then 'Closed'
	when ch.status = 'CS' then 'Callback Scheduled'
	when ch.status = 'D' then 'Disconnect'
	when ch.status = 'N' then 'No Answer'
	when ch.status = 'NC' then 'Never Called'
	when ch.status in ('AM','A','OP') then 'Open'
	else ch.status end + ' - ' + 
	case when ch.status in ('AM','A') then 'Answer Machine' else ad.description end [Call Status - End],
	case when l.Date_Made__c is not null then 1 else 0 end Appointment,
	case when o.SAT__c = 'true' then 1 else 0 end SAT,
	case when o.Deal_Start_Date__c is not null or o.StageName = 'Closed Won' then 1 else 0 end Deals,
	case when o.Deal_Start_Date__c is not null or o.StageName = 'Closed Won' then o.Amount else 0 end Revenue,
	l.Status,
	ISNULL(l.Suspended_Closed_Reason__c, 'No Reason Given') StatusReason,
	l.FT_Employees__c,
	CitationSector__c,
	case when ISNULL(l.FT_Employees__c,'0') = '0' then 'Zero'
	when l.FT_Employees__c between '1' and '2' then '1 to 2' 
	when l.FT_Employees__c between '3' and '5' then '3 to 5'
	when l.FT_Employees__c between '6' and '10' then '6 to 10'
	when l.FT_Employees__c between '11' and '50' then '11 to 50'
	when l.FT_Employees__c between '51' and '100' then '51 to 100'
	when l.FT_Employees__c between '101' and '225' then '101 to 225'
	when l.FT_Employees__c > '225' then '226 +'
	else '' end CritFTERange,
	bdc.Name BDC,
	bdm.Name BDM,
	l.Data_Supplier__c [Data Supplier],
	l.Source__c [Data Source],
	l.LeadSource [Prospect Source],
	l.Prospect_Channel__c [Prospect Channel],
	ps.OldValue [Previous Status]

	INTO
	SalesforceReporting..DiallerActivity

	FROM 
	Salesforce..Lead l
	left outer join #Calls ch ON l.Id = ch.Id
	left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id and o.MADE_Criteria__c like '%Outbound%'
	left outer join Salesforce..[User] u ON l.OwnerId = u.Id
	left outer join Salesforce..[Profile] p ON u.ProfileId = p.Id
	left outer join #Crit cr ON l.Id = cr.Id
	left outer join Salesforce..[User] bdc ON ch.tsr = bdc.Id
	left outer join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
	left outer join #PrevStat ps ON l.Id = ps.LeadId
	left outer join SalesforceReporting..addistats ad ON ch.addi_status = ad.addistatus
															and ch.status = ad.pstatus
															and ad.pappl = 'AFF1'

	WHERE  
	ch.ID is not null

	ORDER BY 
	l.CreatedDate