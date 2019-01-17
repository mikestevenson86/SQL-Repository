DECLARE		@Reasons AS VarChar(50) = 'All Reasons'
DECLARE		@TM AS VarChar(50) = 'All Managers'
DECLARE		@BDC AS VarChar(50) = 'All Agents'

		-- Drop temporary tables

		IF OBJECT_ID('tempdb..#DQ') IS NOT NULL DROP TABLE #DQ
		IF OBJECT_ID('tempdb..#Pends') IS NOT NULL DROP TABLE #Pends
		IF OBJECT_ID('tempdb..#Rejects') IS NOT NULL DROP TABLE #Rejects
		IF OBJECT_ID('tempdb..#UN24') IS NOT NULL DROP TABLE #UN24
		IF OBJECT_ID('tempdb..#UN48') IS NOT NULL DROP TABLE #UN48

		SELECT 
		LeadId, 
		COUNT(Id) DQ,
		MIN(CreatedDate) MinDate

		INTO
		#DQ

		FROM 
		Salesforce..LeadHistory lh

		WHERE 
		lh.LeadId in
		(
		SELECT 
		LeadId
		
		FROM
		Salesforce..LeadHistory
		
		WHERE
		(NewValue = 'Data Quality' or (OldValue = 'Data Quality' and NewValue in ('Approved','Pended','Rejected')))
		and
		CreatedDate between '2018-12-31' and '2019-01-04'
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
		
		-- Collate Rejected After DQ
    
		SELECT 
		lh.LeadId,
		MAX(lh.createdDate) CreatedDate
		
		INTO 
		#Rejects
		
		FROM 
		Salesforce..LeadHistory lh
		inner join #DQ dq on lh.LeadId = dq.LeadId
		inner join Salesforce..Lead l ON lh.LeadId = l.Id
		
		WHERE  
		Field = 'Status' 
		and 
		NewValue = 'Rejected' 
		and 
		lh.CreatedDate > dq.MinDate
		and
		l.Approved_Date__c is null
		
		GROUP BY
		lh.LeadId
				
		-- Collate pended leads that were closed under one day

		SELECT 
		CONVERT(date, MAX(lh.CreatedDate)) MaxDate,
		lh.LeadId
		
		INTO 
		#UN24
		
		FROM 
		Salesforce..LeadHistory lh
		
		inner join #Pends p ON lh.LeadId collate latin1_general_CS_AS = p.LeadId collate latin1_general_CS_AS
		
		WHERE
		Field = 'Status'
		and
		OldValue = 'Pended'
		and
		lh.CreatedDate < DATEADD(hh,24,p.CreatedDate)
		
		GROUP BY
		lh.LeadId

		-- Collate pended leads that were opened over two days but closed under 5

		SELECT 
		MAX(lh.CreatedDate) MaxDate,
		lh.LeadId
		
		INTO 
		#UN48
		
		FROM 
		Salesforce..LeadHistory lh
		
		inner join #Pends p ON lh.LeadId collate latin1_general_CS_AS = p.LeadId collate latin1_general_CS_AS
		
		WHERE
		Field = 'Status'
		and
		OldValue = 'Pended'
		and
		lh.CreatedDate < DATEADD(hh,48,p.CreatedDate) and lh.CreatedDate >= DATEADD(hh,24,p.CreatedDate)
		
		GROUP BY
		lh.LeadId
			
		SELECT 
		CONVERT(date, DATEADD(dd, -(DATEPART(dw, l.Date_Made__c)-2), l.Date_Made__c)) PendDate,
		ISNULL(u.Name, 'No BDC') BDC,
		ISNULL(uMan.Name, 'No Manager') TM,
		'https://eu1.salesforce.com/'+l.Id SFDC_Id,
		bdm.Name BDM,
		case when p.LeadId is not null and l.Approved_Date__c is null and r.LeadId is null then 1 else 0 end Pended,
		case when p.LeadId is not null then 1 else 0 end TotalPended,
		case when r.LeadId is not null then 1 else 0 end Rejected,
		case when l.Approved_Date__c is not null then 1 else 0 end Approved,
		case when p.LeadId is null and l.Approved_Date__c is not null then 1 else 0 end ApprovedFirst,
		case when p.LeadId is not null and l.Approved_Date__c is not null then 1 else 0 end ApprovedAfter,
		case 
		when p.LeadId is not null and l.Approved_Date__c is null and r.LeadId is null then 'Pended'
		when r.LeadId is not null then 'Rejected'
		when p.LeadId is null and l.Approved_Date__c is not null then 'Approved First'
		when p.LeadId is not null and l.Approved_Date__c is not null then 'Approved After'
		when l.Approved_Date__c is not null then 'Approved' end Reason,
		case when u24.LeadId is not null then 'Yes' else 'No' end UN2,
		case when u48.LeadId is not null then 'Yes' else 'No' end Two,
		l.Company,
		l.MADE_Criteria__c,
		l.Full_name_and_position__c FullNamePosition,
		l.Company_name__c CompanyNameCheck,
		l.Full_Address__c AddressCheck,
		l.Emails__c EmailCheck,
		l.MobileDQ__c MobCheck,
		l.Staff_numbers_ft_pt_split__c StaffSplit,
		l.Diary_placement_considered__c DiaryPlacement,
		l.How_they_deal_with_HS_PEL_currently__c HowTheyDeal,
		l.Third_party_renewal_date__c ThirdPartyRenewal,
		l.Need_identified__c NeedIdentified,
		l.Introincludesthe4ws__c IntroIncludes4w,
		l.Setagendaforthecall__c SetAgendaCall,
		l.ConfirmspeakingtoDM__c ConfirmDMSpeak,
		l.IdentifyInHouse3rdPartyBoth__c InHouseThirdParty,
		l.Q5HSLegalObligations__c QuestionHSLaw,
		l.Q5KeyPELAreas__c QuestionHRLaw,
		l.Needssummarised__c NeedSum,
		l.CorrectNeedCalledOut__c CorrectNeedCOut,
		l.SetAgendaForTheProductPresentation__c SetAgendaProdPres,
		l.Pitched2Products__c Pitch2Prod,
		l.PitchedRelevantProducts__c PitchRelevant,
		l.X7DayAppointmentUrgency__c SevenDayAppUrg,
		l.AssumptiveCloseOfAppointment__c AssumpClose
			
		FROM 
		Salesforce..Lead l
		inner join #DQ dq ON l.Id = dq.LeadId
		left outer join #Pends p ON l.Id = p.LeadId
		left outer join #Rejects r ON l.Id = r.LeadId
		left outer join Salesforce..[User] u ON l.BDC__c = u.Id
		left outer join Salesforce..[User] BDM ON l.OwnerId = BDM.Id
		left outer join Salesforce..[User] uMan on u.ManagerId = uMan.Id
		left outer join Salesforce..[Profile] pr ON uMan.ProfileId = pr.Id
		left outer join Salesforce..[Profile] pro ON u.ProfileId = pro.Id
		left outer join Salesforce..[UserRole] ur ON u.UserRoleId = ur.Id
		left outer join #UN24 u24 on l.Id = u24.LeadId
		left outer join #UN48 u48 on l.Id = u48.LeadId
			
		WHERE
		(pro.Name in ('Citation Contact Centre BDC','CC Sector Specific Team','Business Solutions Team','New BDC Profile') or ur.Name = 'BDM/BDC')
		and
		(MADE_Criteria__c like '%1%' or MADE_Criteria__c like '%2%' or MADE_Criteria__c like '%4%' or MADE_Criteria__c in ('Seminars - Appointment','Outbound - 3'))
		and
		/*
		(
			case when @BDM = 'All BDM' then bdm.Name end = bdm.Name
			or
			case when @BDM = 'Scotland' then bdm.Name end in ('John McCaffrey','William McFaulds') 
			or
			case when @BDM = 'NorthSouth' then bdm.Name end NOT in ('John McCaffrey','William McFaulds') 
		)
		and
		*/
		case when @TM = 'All Managers' then uMan.Name else @TM end = uMan.Name
		and
		case when @BDC = 'All Agents' then u.Name else @BDC end = u.Name
		and
		case when @Reasons = 'All Reasons' then 'false'
		when @Reasons like '%Diary Placement%' then Diary_placement_considered__c
		when @Reasons like '%Need Identified%' then Need_identified__c
		when @Reasons like '%Third Party Renewal%' then Third_party_renewal_date__c
		when @Reasons like '%How They Deal%' then How_they_deal_with_HS_PEL_currently__c
		when @Reasons like '%Staff Split%' then Staff_numbers_ft_pt_split__c
		when @Reasons like '%Full Name Position%' then Full_name_and_position__c
		when @Reasons like '%Address Check%' then Full_Address__c
		when @Reasons like '%Company Name Check%' then Company_name__c
		when @Reasons like '%Email Check%' then Emails__c end = 'false'	