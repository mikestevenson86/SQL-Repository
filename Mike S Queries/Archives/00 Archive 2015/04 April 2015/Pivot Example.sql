			SELECT 
			SUM(case when l.Full_name_and_position__c = 'false' then 1 else 0 end) FullNamePosition,
			SUM(case when l.Company_name__c = 'false' then 1 else 0 end) CompanyNameCheck,
			SUM(case when l.Full_Address__c = 'false' then 1 else 0 end) AddressCheck,
			SUM(case when l.Emails__c = 'false' then 1 else 0 end) EmailCheck,
			SUM(case when l.Staff_numbers_ft_pt_split__c = 'false' then 1 else 0 end) StaffSplit,
			SUM(case when l.PAYE__c = 'false' then 1 else 0 end) PAYE,
			SUM(case when l.Time_and_date_of_the_appointment__c = 'false' then 1 else 0 end) TimeDateAppt,
			SUM(case when l.Diary_placement_considered__c = 'false' then 1 else 0 end) DiaryPlacement,
			SUM(case when l.How_they_deal_with_HS_PEL_currently__c = 'false' then 1 else 0 end) HowTheyDeal,
			SUM(case when l.Third_party_renewal_date__c = 'false' then 1 else 0 end) ThirdPartyRenewal,
			SUM(case when l.Need_identified__c = 'false' then 1 else 0 end) NeedIdentified,
			SUM(case when l.More_notes_required__c = 'false' then 1 else 0 end) MoreNotesRequired
			INTO #Temp
			FROM
			Salesforce..Lead l
			left outer join Salesforce..[User] u ON l.BDC__c = u.Id
			left outer join Salesforce..[User] BDM ON l.OwnerId = BDM.Id
			left outer join Salesforce..[User] uMan on u.ManagerId = uMan.Id
			left outer join Salesforce..[Profile] pr ON uMan.ProfileId = pr.Id
			WHERE
			Date_Made__c between '2015-04-01' and '2015-04-30'
			and
			pr.Name = 'Citation Contact Centre Manager'
			and
			MADE_Criteria__c in ('Outbound - 1','Outbound - 2','Outbound - 4')
			and
			u.Name not in ('Simon Burlison')
			and
			BDM.Name not in ('John McCaffrey','William McFaulds')
			
			SELECT Name, Value
			FROM #Temp
			unpivot
			(
			value for name in (FullNamePosition, CompanyNameCheck, AddressCheck, EmailCheck, StaffSplit, PAYE,TimeDateAppt, DiaryPlacement, HowTheyDeal, ThirdPartyRenewal, NeedIdentified,MoreNotesRequired)
			) unpiv