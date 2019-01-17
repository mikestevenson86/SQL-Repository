/*IF OBJECT_ID('Salesforce..Lead_Load') IS NOT NULL 
BEGIN
	DROP TABLE Salesforce..Lead_Load
END*/
		
		-- Load Temp Table with Accounts with an Opportunity in the Pipeline
		
		SELECT a.Id
		INTO #Winning 
		FROM Salesforce..Account a with(nolock)
		inner join Salesforce..Opportunity o with(nolock) ON o.AccountId = a.Id
		WHERE StageName <> 'Closed Lost'

		-- Initial Load of Past Closed Lost Opportunities
		SELECT 
		*
		
		INTO
		#AccountDupe
		
		FROM
		(
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
		l.Sector__c, 
		l.Affinity_Cold__c,
		l.IsTPS__c,
		l.HasOptedOutOfEmail,
		l.LeadSource,
		ROW_NUMBER () OVER (PARTITION BY a.Id ORDER BY o.CreatedDate DESC) rn

		FROM 
		Salesforce..Account a with(nolock)
		left outer join Salesforce..Opportunity o with(nolock) ON A.Id = o.AccountId 
		left outer join Salesforce..[User] u with(nolock) ON o.BDC__c = u.Id
		left outer join Salesforce..[Profile] p with(nolock) ON u.ProfileId = P.Id
		left outer join Salesforce..Lead l with(nolock) ON a.Id = l.ConvertedAccountId
		left outer join #Winning w ON a.Id = w.Id

		WHERE 
		o.StageName = 'Closed Lost' 
		and 
		o.CloseDate <= '2015-09-01'
		and
		(a.Callback_Date_Time__c < GETDATE() or a.Callback_Date_Time__c is null)
		and
		(o.BDC_Manager__c = 'Kath Harkin' )
		and
		o.RecordTypeId = '012D0000000NaNlIAK'
		and
		o.LeadSource = 'Telemarketing'
		and
		l.Id is not null
		and
		w.Id is null
		) detail
		WHERE rn = 1
		
		-- Staging Temp Table 1
		
		SELECT 
		ad.*
		
		INTO 
		#LeadDupe
		
		FROM 
		#AccountDupe ad
		left outer join Salesforce..Account a2 with(nolock) ON REPLACE(case when ad.Phone like '0%' then ad.Phone else '0'+ad.Phone end,' ','')
													= REPLACE(case when a2.Phone like '0%' then a2.Phone else '0' + a2.Phone end,' ','')
													and	ad.Previous_Account__c <> a2.Id
		
		WHERE 
		a2.Id is null
		
		-- Final Output (Create new Lead_Load table)
												
		SELECT 
		CAST('' as NVarChar(20)) Id, 
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
		ld.Sector__c, 
		ld.Affinity_Cold__c,
		ld.IsTPS__c,
		ld.HasOptedOutOfEmail,
		ld.LeadSource, 
		'KH Marketing Lost' Source__c, 
		CAST('' as NVarChar(255)) Error
		
		/*INTO 
		Salesforce..Lead_Load*/
		
		FROM 
		#LeadDupe ld
		left outer join Salesforce..Lead l2 with(nolock) ON REPLACE(case when ld.Phone like '0%' then ld.Phone else '0' + ld.Phone end,' ','')
												= REPLACE(case when l2.Phone like '0%' then l2.Phone else '0' + l2.Phone end,' ','')
												and	l2.[Status] <> 'Approved'
		WHERE 
		l2.Id is null
		
		-- Upload Closed Lost to Salesforce Prospects
		
		/*exec Salesforce..SF_BulkOps 'Insert:batchsize(100)','Salesforce','Lead_Load'*/
		            
		DROP TABLE #winning
		DROP TABLE #AccountDupe
		DROP TABLE #LeadDupe 
