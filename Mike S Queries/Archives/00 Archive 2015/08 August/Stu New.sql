		DECLARE @StartDate as Date = '2015-07-25'
		DECLARE @EndDate as Date = '2015-08-25'
		
		SELECT
		Id,
		ConvertedOpportunityId,
		Date_Made__c
		INTO #Books
		FROM 
		Salesforce..Lead
		WHERE
		Date_Made__c between @StartDate and @EndDate
		
		SELECT
		u.Name,
		SUM(case when o.Original_1st_Visit_Date__c <= DATEADD(day,7,o.DateMade__c) and (RIGHT(o.MADE_Criteria__c, 1) in ('1','2') or o.MADE_Criteria__c = 'Seminars - Appointment') then 1 else 0 end) CritFirstVisitSeven
		INTO 
		#BookSeven
		FROM
		Salesforce..Opportunity o
		inner join Salesforce..[User] u ON o.BDC__c = u.Id
		inner join #Books b ON o.Id = b.ConvertedOpportunityId
		GROUP BY
		u.Name
		
		SELECT
		b.Id,
		SUM(case when ch.call_type in (0,2,4) and ch.act_date <= b.Date_Made__c then 1 else 0 end) CallsToApp
		INTO #AppCalls
		FROM
		SalesforceReporting..call_history ch
		inner join #Books b ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(b.Id, 15) collate latin1_general_CS_AS
		GROUP BY
		b.Id
		
		-- Collate Data Quality Occurrences
		
		SELECT 
		LeadId, 
		COUNT(Id) DQ,
		MIN(CreatedDate) MinDate

		INTO
		#DQ

		FROM 
		Salesforce..LeadHistory lh

		WHERE 
		NewValue = 'Data Quality'
		and
		lh.LeadId in
		(
		SELECT 
		LeadId
		
		FROM
		Salesforce..LeadHistory
		
		WHERE
		NewValue = 'Data Quality'
		and
		CreatedDate between @StartDate and @EndDate
		)
		and
		lh.LeadId not in
		(
		SELECT Id
		FROM Salesforce..Lead
		WHERE MADE_Criteria__c like '%seminar%' and MADE_Criteria__c <> 'Seminars - Appointment'
		)

		GROUP BY 
		lh.LeadId
		
		-- Collate Pended After DQ
    
		SELECT 
		lh.LeadId,
		MAX(lh.createdDate) CreatedDate
		
		INTO 
		#Pends
		
		FROM 
		Salesforce..LeadHistory lh
		inner join #DQ dq on lh.LeadId = dq.LeadId
		inner join Salesforce..Lead l ON lh.LeadId = l.Id
		
		WHERE  
		Field = 'Status' 
		and 
		NewValue = 'Pended' 
		and 
		lh.CreatedDate > dq.MinDate
		
		GROUP BY
		lh.LeadId
		
		SELECT
		u.Name,
		COUNT(l.Id) Booked,
		bs.CritFirstVisitSeven [Booked in Seven Day Window],
		SUM(case when p.LeadId is null and l.Approved_Date__c is not null then 1 else 0 end) [Approved First],
		(SUM(ac.CallstoApp)/COUNT(l.Id)) AverageCallsToAppt
		FROM
		Salesforce..Lead l
		inner join #Books b ON l.Id = b.Id
		inner join Salesforce..[User] u ON l.BDC__c = u.Id
		left outer join SalesforceReporting..call_history ch ON l.Id = ch.lm_filler2 and ch.call_type in (0,2,4) and ch.act_date <= b.Date_Made__c
		left outer join #Pends p ON l.Id = p.LeadId
		left outer join #BookSeven bs ON u.Name = bs.Name
		left outer join #AppCalls ac ON l.Id = ac.Id
		WHERE 
		u.Department = 'Telemarketing'
		GROUP BY
		u.Name,
		bs.CritFirstVisitSeven
		ORDER BY
		u.Name
		
		DROP TABLE #Books
		DROP TABLE #BookSeven
		DROP TABLE #DQ		
		DROP TABLE #Pends
		DROP TABLE #AppCalls