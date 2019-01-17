
IF OBJECT_ID('tempdb..#Pipeline') IS NOT NULL 
	BEGIN
		  DROP TABLE #Pipeline
	END

IF OBJECT_ID('tempdb..#RecentLost') IS NOT NULL 
	BEGIN
		  DROP TABLE #RecentLost
	END

IF OBJECT_ID('tempdb..#Recycled') IS NOT NULL 
	BEGIN
		  DROP TABLE #Recycled
	END

IF OBJECT_ID('tempdb..#NotAccount') IS NOT NULL 
	BEGIN
		  DROP TABLE #NotAccount
	END

IF OBJECT_ID('tempdb..#NotLead') IS NOT NULL 
	BEGIN
		  DROP TABLE #NotLead
	END
            
            -- Load Temp Table with Accounts with a worked/won Opportunity in the Pipeline
            
            SELECT a.Id
            INTO #Pipeline 
            FROM Salesforce..Account a with(nolock)
            inner join Salesforce..Opportunity o with(nolock) ON o.AccountId = a.Id
            WHERE StageName <> 'Closed Lost'
            
            -- Load Temp Table with Accounts with a Closed Lost Opportunity in the last 12 months
            
            SELECT a.Id
            INTO #RecentLost
            FROM Salesforce..Account a with(nolock)
            inner join Salesforce..Opportunity o with(nolock) ON o.AccountId = a.Id
            WHERE StageName = 'Closed Lost' and SAT_Date__c >= DATEADD(Month,-9,GETDATE())

            -- Initial Load of Past Closed Lost Opportunities

            SELECT  
            a.Id Previous_Account__c,
            a.Name Company,
            l.FirstName, 
            l.LastName, 
            l.Salutation,
            l.Street,
            l.City,
            l.[State],
            l.PostalCode,
            l.Phone,
            l.MobilePhone,
            l.Other_Phone__c,
            l.Email,
            l.Website,
            l.FT_Employees__c,
            l.PT_Employees__c,
            l.Directors__c,
            l.Subcontractors__c,
            l.SIC2007_Code__c,
            l.SIC2007_Code2__c, 
            l.SIC2007_Code3__c,
            l.SIC2007_Description__c,
            l.SIC2007_Description2__c,
            l.SIC2007_Description3__c,
            l.Affinity_Cold__c,
            l.IsTPS__c,
            l.HasOptedOutOfEmail,
            l.CreatedDate,
            o.SAT_Date__c,
            case when l.Country = 'Scotland' then 'AS Marketing Lost'
            when o.BDC_Manager__c = 'Alison Schillaci' then 'AS Marketing Lost'
			when o.BDC_Manager__c = 'Kath Harkin' then 'KH Marketing Lost'
			when o.BDC_Manager__c = 'Maureen Quinn' then 'MQ Marketing Lost'
			when o.BDC_Manager__c = 'Andrae Leon' then 'AL Marketing Lost'
			when o.BDC_Manager__c = 'Helen Astbury' then 'HA Marketing Lost'
			when o.BDC_Manager__c = 'Mansoor Kayani' then 'MK Marketing Lost'
			when o.BDC_Manager__c = 'Katie Cullen' then 'KC Events Lost' else '' end Manager
            
            INTO
            #Recycled

            FROM 
            Salesforce..Account a with(nolock)
            left outer join Salesforce..Opportunity o with(nolock) ON A.Id = o.AccountId 
            left outer join Salesforce..[User] u with(nolock) ON o.BDC__c = u.Id
            left outer join Salesforce..[Profile] p with(nolock) ON u.ProfileId = P.Id
            left outer join Salesforce..Lead l with(nolock) ON a.Id = l.ConvertedAccountId
            left outer join #Pipeline pl ON a.Id = pl.Id
            left outer join #RecentLost rc ON a.Id = rc.Id

            WHERE 
            o.StageName = 'Closed Lost' 
            and 
            (
				ISNULL(o.SAT_Date__c, GETDATE()) <= CONVERT(date, DATEADD(month,-9,GETDATE()))
				or
				(o.SAT_Date__c is null and o.DateMade__c <= CONVERT(date, DATEADD(month,-6,GETDATE())))
            )
            and
            (a.Callback_Date_Time__c < GETDATE() or a.Callback_Date_Time__c is null)
            and
            o.BDC_Manager__c in
				(
				'Kath Harkin',
				'Alison Schillaci',
				'Maureen Quinn',
				'Andrae Leon',
				'Helen Astbury',
				'Katie Cullen',
				'Mansoor Kayani'
				)
            and
            o.RecordTypeId = '012D0000000NaNlIAK'
            and
            o.LeadSource = 'Telemarketing'
            and
            l.Id is not null
            and
            pl.Id is null
            and
            rc.Id is null
            and
            o.Id in
            (
				SELECT Id
				FROM Salesforce..Opportunity o
				inner join	(
							SELECT AccountId, MAX(CreatedDate) LastCreated
							FROM Salesforce..Opportunity
							GROUP BY AccountId
							) lo ON o.AccountId = lo.AccountId and o.CreatedDate = lo.LastCreated
			)
            -- Staging 1 - de-dupe any that could be account duplicates
            
            SELECT 
            rc.*
            
            INTO 
            #NotAccount
            
            FROM 
            #Recycled rc
            left outer join Salesforce..Account a with(nolock) ON REPLACE(case when rc.Phone like '0%' then rc.Phone else '0'+rc.Phone end,' ','')
																	= REPLACE(case when a.Phone like '0%' then a.Phone else '0' + a.Phone end,' ','')
																	and 
																	rc.Previous_Account__c <> a.Id
            
            WHERE 
            a.Id is null
            
            -- Staging 2 - de-dupe any that could be lead duplicates
                                                                        
            SELECT 
            na.Previous_Account__c,
            na.Company,
            na.FirstName, 
            na.LastName, 
            na.Salutation,
            na.Street,
            na.City,
            na.[State],
            na.PostalCode,
            na.Phone,
            na.MobilePhone,
            na.Other_Phone__c,
            na.Email,
            na.Website,
            na.FT_Employees__c,
            na.PT_Employees__c,
            na.Directors__c,
            na.Subcontractors__c,
            na.SIC2007_Code__c,
            na.SIC2007_Code2__c, 
            na.SIC2007_Code3__c,
            na.SIC2007_Description__c,
            na.SIC2007_Description2__c,
            na.SIC2007_Description3__c,
            na.Affinity_Cold__c,
            na.IsTPS__c,
            na.HasOptedOutOfEmail,
            na.CreatedDate,
            na.Manager,
            na.SAT_Date__c
            
            INTO 
            #NotLead
            
            FROM 
            #NotAccount na
            left outer join Salesforce..Lead l with(nolock) ON REPLACE(case when na.Phone like '0%' then na.Phone else '0' + na.Phone end,' ','')
																= REPLACE(case when l.Phone like '0%' then l.Phone else '0' + l.Phone end,' ','')
																and l.[Status] <> 'Approved'
            WHERE 
            l.Id is null
            
            -- Final Output (Create new Lead_Load table)
            
            SELECT
            CAST('' as NVarChar(20)) Id,
            Previous_Account__c,
			Company,
			FirstName, 
			LastName, 
			Salutation,
			Street,
			City,
			[State],
			PostalCode,
			Phone,
			MobilePhone,
			Other_Phone__c,
			Email,
			Website,
			FT_Employees__c,
			PT_Employees__c,
			Directors__c,
			Subcontractors__c,
			SIC2007_Code__c,
			SIC2007_Code2__c, 
			SIC2007_Code3__c,
			SIC2007_Description__c,
			SIC2007_Description2__c,
			SIC2007_Description3__c,
			Affinity_Cold__c,
			IsTPS__c,
			HasOptedOutOfEmail,
            Manager Source__c, 
            SAT_Date__c,
            CAST('' as NVarChar(255)) Error
            
            FROM
            (
				SELECT 
				ld.Previous_Account__c,
				ld.Company,
				ld.FirstName, 
				ld.LastName, 
				ld.Salutation,
				ld.Street,
				ld.City,
				ld.[State],
				ld.PostalCode,
				ld.Phone,
				ld.MobilePhone,
				ld.Other_Phone__c,
				ld.Email,
				ld.Website,
				ld.FT_Employees__c,
				ld.PT_Employees__c,
				ld.Directors__c,
				ld.Subcontractors__c,
				ld.SIC2007_Code__c,
				ld.SIC2007_Code2__c, 
				ld.SIC2007_Code3__c,
				ld.SIC2007_Description__c,
				ld.SIC2007_Description2__c,
				ld.SIC2007_Description3__c,
				ld.Affinity_Cold__c,
				ld.IsTPS__c,
				ld.HasOptedOutOfEmail,
				ld.Manager,
				ld.SAT_Date__c,
				ROW_NUMBER() OVER (PARTITION BY ld.Previous_Account__c ORDER BY ld.CreatedDate DESC) rn
	           
				FROM
				#NotLead ld
	            
	            -- De-dupe any lead duplicates by company and postcode
				left outer join Salesforce..Lead L2 with(nolock) ON REPLACE(REPLACE(ld.company, 'ltd',''),'limited','') 
																	= REPLACE (Replace (l2.company, 'ltd',''),'limited','') 
																	and 
																	REPLACE (ld.postalcode, ' ','') = REPLACE (L2.postalcode, ' ','')
																	and 
																	l2.Status <> 'Approved'
	            
				WHERE
				l2.Id is null
            ) detail
            
            WHERE rn = 1