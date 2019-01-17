		IF OBJECT_ID('LeadChangeReview..Fallow_DMRefusal') IS NOT NULL DROP TABLE LeadChangeReview..Fallow_DMRefusal
		IF OBJECT_ID('tempdb..#NewFirst') IS NOT NULL DROP TABLE #NewFirst
		IF OBJECT_ID('tempdb..#NewLast') IS NOT NULL DROP TABLE #NewLast
		IF OBJECT_ID('tempdb..#NewPos') IS NOT NULL DROP TABLE #NewPos
		IF OBJECT_ID('tempdb..#MaxDate') IS NOT NULL DROP TABLE #MaxDate
		IF OBJECT_ID('tempdb..#SCDChanges') IS NOT NULL DROP TABLE #SCDChanges

		SELECT scd.URN, scd.CreatedDate, scd.OldValue, scd.NewValue
		INTO #NewFirst
		FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd with(nolock)
		inner join Salesforce..Lead l with(nolock) ON scd.URN collate latin1_general_CI_AS = l.Market_Location_URN__c collate latin1_general_CI_AS	
		WHERE scd.OldValue <> scd.NewValue 
		and	scd.Field = 'contact forename' 
		and scd.NewValue collate latin1_general_CI_AS = l.FirstName collate latin1_general_CI_AS

		SELECT scd.URN, scd.CreatedDate, scd.OldValue, scd.NewValue
		INTO #NewLast
		FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd with(nolock)
		inner join Salesforce..Lead l with(nolock) ON scd.URN collate latin1_general_CI_AS = l.Market_Location_URN__c collate latin1_general_CI_AS
		inner join #NewFirst nf ON scd.URN = nf.URN and scd.CreatedDate = nf.CreatedDate
		WHERE scd.OldValue <> scd.NewValue 
		and	scd.Field = 'contact surname' 
		and scd.NewValue collate latin1_general_CI_AS = l.LastName collate latin1_general_CI_AS

		SELECT scd.URN, scd.CreatedDate, scd.OldValue, scd.NewValue
		INTO #NewPos
		FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd with(nolock)
		inner join Salesforce..Lead l with(nolock) ON scd.URN collate latin1_general_CI_AS = l.Market_Location_URN__c collate latin1_general_CI_AS	
		--inner join #NewFirst nf ON scd.URN = nf.URN and scd.CreatedDate = nf.CreatedDate
		inner join #NewLast nl ON scd.URN = nl.URN and scd.CreatedDate = nl.CreatedDate
		WHERE scd.Field = 'contact position' 
		and scd.OldValue <> scd.NewValue 
		and scd.NewValue collate latin1_general_CI_AS = l.Position__c collate latin1_general_CI_AS

		SELECT URN, MAX(CreatedDate) MaxDate
		INTO #MaxDate
		FROM #NewPos
		GROUP BY URN

		SELECT 
		cp.CreatedDate, 
		cp.URN, 
		cf.OldValue + ' ' + cs.OldValue + ', ' + cp.OldValue NameAndPosition_Old, 
		cf.NewValue + ' ' + cs.NewValue + ', ' + cp.NewValue NameAndPosition_New
		INTO #SCDChanges
		FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History cp
		left outer join Salesforce..Lead l ON cp.URN collate latin1_general_CI_AS = l.Market_Location_URN__c collate latin1_general_CI_AS
		left outer join #MaxDate md ON cp.URN = md.URN and CONVERT(date, cp.CreatedDate) = CONVERT(date, md.MaxDate)
		left outer join #NewFirst cf ON cp.URN = cf.URN 
										and CONVERT(date, cp.CreatedDate) = CONVERT(date, cf.CreatedDate)
		left outer join #NewLast cs ON cp.URN = cs.URN 
										and CONVERT(date, cp.CreatedDate) = CONVERT(date, cs.CreatedDate)
		WHERE cp.Field in ('contact position') and cp.OldValue <> cp.NewValue and md.MaxDate is not null
		GROUP BY
		cp.CreatedDate, 
		cp.URN, 
		cf.OldValue + ' ' + cs.OldValue + ', ' + cp.OldValue, 
		cf.NewValue + ' ' + cs.NewValue + ', ' + cp.NewValue 

		SELECT 
		l.Id
		,l.Status
		,Suspended_Closed_Reason__c [Suspended/Closed Reason]
		,l.FirstName + ' ' + l.LastName + ', ' + l.Position__c [Name and Position]
		,CitationSector__c [Citation Sector]
		,l.Status_Changed_Date__c [Status Changed Date]
		,scd.CreatedDate [Name And Position Updated]
		,scd.NameAndPosition_Old [Old Name And Position]
		,scd.NameAndPosition_New [New Name And Position]
		INTO 
		LeadChangeReview..Fallow_DMRefusal
		FROM 
		Salesforce..Lead l
		left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		left outer join #SCDChanges scd ON l.Market_Location_URN__c collate latin1_general_CI_AS = scd.URN collate latin1_general_CI_AS 
		WHERE
		CONVERT(date, scd.CreatedDate) > CONVERT(date, l.Status_Changed_Date__c) 
		and Status in ('Closed','Suspended')
		and Suspended_Closed_Reason__c = 'DM Refusal'
		and Status_Changed_Date__c < DATEADD(day,-90,GETDATE())
		and rt.Name = 'Default Citation Record Type'
		and IsConverted = 'false'