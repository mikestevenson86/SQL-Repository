IF OBJECT_ID('tempdb..#SIC1') IS NOT NULL
	BEGIN
		DROP TABLE #SIC1
	END

IF OBJECT_ID('tempdb..#SIC2') IS NOT NULL
	BEGIN
		DROP TABLE #SIC2
	END

IF OBJECT_ID('tempdb..#SIC3') IS NOT NULL
	BEGIN
		DROP TABLE #SIC3
	END

IF OBJECT_ID('tempdb..#Starts') IS NOT NULL
	BEGIN
		DROP TABLE #Starts
	END

IF OBJECT_ID('tempdb..#LastDate') IS NOT NULL
	BEGIN
		DROP TABLE #LastDate
	END

IF OBJECT_ID('tempdb..#StartDate') IS NOT NULL
	BEGIN
		DROP TABLE #StartDate
	END

IF OBJECT_ID('tempdb..#FirstChanges') IS NOT NULL
	BEGIN
		DROP TABLE #FirstChanges
	END

IF OBJECT_ID('tempdb..#OrigDeal') IS NOT NULL
	BEGIN
		DROP TABLE #OrigDeal
	END

IF OBJECT_ID('tempdb..#DealNumbers') IS NOT NULL
	BEGIN
		DROP TABLE #DealNumbers
	END

IF OBJECT_ID('tempdb..#SignReasons') IS NOT NULL
	BEGIN
		DROP TABLE #SignReasons
	END

IF OBJECT_ID('tempdb..#ClientSites') IS NOT NULL
	BEGIN
		DROP TABLE #ClientSites
	END

IF OBJECT_ID('tempdb..#ClientSitesPostCode') IS NOT NULL
	BEGIN
		DROP TABLE #ClientSitesPostCode
	END

IF OBJECT_ID('tempdb..#County') IS NOT NULL
	BEGIN
		DROP TABLE #County
	END

IF OBJECT_ID('tempdb..#DealServices') IS NOT NULL
	BEGIN
		DROP TABLE #DealServices
	END

IF OBJECT_ID('tempdb..#LastConvert') IS NOT NULL
	BEGIN
		DROP TABLE #LastConvert
	END

	SELECT SIC_Code, SIC_Description
	INTO #SIC1
	FROM [DB01].SalesforceReporting.dbo.SIC2007Codes
	GROUP BY SIC_Code, SIC_Description

	SELECT cl.clientId, COUNT(s.siteId) NoofSites, '' PostCode
	INTO #ClientSites
	FROM Shorthorn..cit_sh_clients cl
	inner join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID
	GROUP BY cl.clientID

	SELECT cl.clientId, MAX(s.postcode) PostCode --COUNT(s.siteId) NoofSites
	INTO #ClientSitesPostCode
	FROM Shorthorn..cit_sh_clients cl
	inner join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID
	where s.HeadOffice = 1
	GROUP BY cl.clientID

	SELECT SIC2_Code, SIC2_Description
	INTO #SIC2
	FROM [DB01].SalesforceReporting.dbo.SIC2007Codes
	GROUP BY SIC2_Code, SIC2_Description

	SELECT SIC3_Code, SIC3_Description
	INTO #SIC3
	FROM [DB01].SalesforceReporting.dbo.SIC2007Codes

	SELECT clientId, MAX(signdate) Start
	INTO #Starts
	FROM shorthorn..cit_sh_deals
	GROUP BY clientID

	SELECT clientId, MAX(renewDate) LastDate
	INTO #LastDate
	FROM shorthorn..cit_sh_deals
	GROUP BY clientID

	SELECT clientId, MIN(signDate) StartDate
	INTO #StartDate
	FROM shorthorn..cit_sh_deals
	GROUP BY clientID

	SELECT IDValue ,MIN([editDate]) FirstChange
	INTO #FirstChanges
	FROM [Shorthorn].[dbo].[cit_sh_auditTrail]
	WHERE tableName = 'cit_sh_deals' and dataField = 'dealStatus'
	GROUP BY IDValue
	  
	SELECT ad.IDValue dealID, ds.dealStatus
	INTO #OrigDeal
	FROM Shorthorn..cit_sh_auditTrail ad
	inner join #FirstChanges fc ON ad.IDValue = fc.IDValue and ad.editDate = fc.FirstChange
	inner join Shorthorn..cit_sh_dealStatus ds ON ad.oldValue = ds.dealStatusID and ad.dataField = 'dealStatus'

	SELECT clientId, dealID, signDate, renewDate, originalrenewdate, dealstatus, dealtype, ROW_NUMBER () OVER (PARTITION BY clientId ORDER BY signDate) rn
	INTO #DealNumbers
	FROM Shorthorn..cit_sh_deals

	SELECT
	Id,
	LEFT(
	case when Services_Taken_AI_Only_HS__c = 'true' then 'A&I Only - Health & Safety, ' else '' end +
	case when Services_Taken_AI_Only__c = 'true' then 'A&I only - EL & HR, ' else '' end +
	case when Services_Taken_Advice_Only_HS__c = 'true' then 'Advice Only - Health & Safety, ' else '' end +
	case when Services_Taken_Advice_Only__c = 'true' then 'Advice Only - EL & HR, ' else '' end +
	case when Services_Taken_Consultancy__c = 'true' then 'Consultancy, ' else '' end +
	case when Services_Taken_EL__c = 'true' then 'EL & HR, ' else '' end +
	case when Services_Taken_Env__c = 'true' then 'Environmental, ' else '' end +
	case when Services_Taken_FRA__c = 'true' then 'Fire Risk Assessment, ' else '' end +
	case when Services_Taken_Franchise_Comp_EL__c = 'true' then 'Franchise - Comprehensive - EL & HR, ' else '' end +
	case when Services_Taken_Franchise_Comp_HS__c = 'true' then 'Franchise - Comprehensive - Health & Safety, ' else '' end +
	case when Services_Taken_Franchise_Entry_EL__c = 'true' then 'Franchise - Entry Level - EL & HR, ' else '' end +
	case when Services_Taken_Franchise_Entry_HS__c = 'true' then 'Franchise - Entry Level - Health & Safety, ' else '' end +
	case when Services_Taken_HS__c = 'true' then 'Health & Safety, ' else '' end +
	case when Services_Taken_JIT__c = 'true' then 'JIT Tribunal, ' else '' end +
	case when Services_Taken_SBP__c = 'true' then 'Small Business Package, ' else '' end +
	case when Services_Taken_Training__c = 'true' then 'Training, ' else '' end +
	case when Services_Taken_eRAMS__c = 'true' then 'eRAMs, ' else '' end, 
	LEN(
	case when Services_Taken_AI_Only_HS__c = 'true' then 'A&I Only - Health & Safety, ' else '' end +
	case when Services_Taken_AI_Only__c = 'true' then 'A&I only - EL & HR, ' else '' end +
	case when Services_Taken_Advice_Only_HS__c = 'true' then 'Advice Only - Health & Safety, ' else '' end +
	case when Services_Taken_Advice_Only__c = 'true' then 'Advice Only - EL & HR, ' else '' end +
	case when Services_Taken_Consultancy__c = 'true' then 'Consultancy, ' else '' end +
	case when Services_Taken_EL__c = 'true' then 'EL & HR, ' else '' end +
	case when Services_Taken_Env__c = 'true' then 'Environmental, ' else '' end +
	case when Services_Taken_FRA__c = 'true' then 'Fire Risk Assessment, ' else '' end +
	case when Services_Taken_Franchise_Comp_EL__c = 'true' then 'Franchise - Comprehensive - EL & HR, ' else '' end +
	case when Services_Taken_Franchise_Comp_HS__c = 'true' then 'Franchise - Comprehensive - Health & Safety, ' else '' end +
	case when Services_Taken_Franchise_Entry_EL__c = 'true' then 'Franchise - Entry Level - EL & HR, ' else '' end +
	case when Services_Taken_Franchise_Entry_HS__c = 'true' then 'Franchise - Entry Level - Health & Safety, ' else '' end +
	case when Services_Taken_HS__c = 'true' then 'Health & Safety, ' else '' end +
	case when Services_Taken_JIT__c = 'true' then 'JIT Tribunal, ' else '' end +
	case when Services_Taken_SBP__c = 'true' then 'Small Business Package, ' else '' end +
	case when Services_Taken_Training__c = 'true' then 'Training, ' else '' end +
	case when Services_Taken_eRAMS__c = 'true' then 'eRAMs, ' else '' end
	) - 1) [Services]
	INTO
	#DealServices
	FROM
	[DB01].Salesforce.dbo.[Contract]
	WHERE
	Services_Taken_AI_Only_HS__c = 'true' or
	Services_Taken_AI_Only_HS__c = 'true' or
	Services_Taken_AI_Only__c = 'true' or
	Services_Taken_Advice_Only_HS__c = 'true' or
	Services_Taken_Advice_Only__c = 'true' or
	Services_Taken_Consultancy__c = 'true' or
	Services_Taken_EL__c = 'true' or
	Services_Taken_Env__c = 'true' or
	Services_Taken_FRA__c = 'true' or
	Services_Taken_Franchise_Comp_EL__c = 'true' or
	Services_Taken_Franchise_Comp_HS__c = 'true' or
	Services_Taken_Franchise_Entry_EL__c = 'true' or
	Services_Taken_Franchise_Entry_HS__c = 'true' or
	Services_Taken_HS__c = 'true' or
	Services_Taken_JIT__c = 'true' or
	Services_Taken_SBP__c = 'true' or
	Services_Taken_Training__c = 'true' or
	Services_Taken_eRAMS__c = 'true'

	SELECT dn1.dealID, 
	case when dn2.renewDate >= dn2.OriginalRenewDate and dn2.dealType <> dn1.dealType and dn2.signDate <= GETDATE() and dn2.renewDate > GETDATE() and dn2.dealStatus not in (2,5,10,18) then 'Upsell'
	when dn1.rn = 1 and dn1.dealStatus not in (12,15) then 'New'
	when dn2.renewDate < dn2.OriginalRenewDate and dn2.dealType <> dn1.dealType then 'Early Renewal_Upsell'
	when dn2.renewDate < dn2.OriginalRenewDate then 'Early Renewal' else 'Renewal' end SignReason
	INTO #SignReasons
	FROM #DealNumbers dn1
	LEFT outer join #DealNumbers dn2 ON dn1.clientId = dn2.clientId and dn1.rn-1 = dn2.rn

	SELECT detail.clientId, detail.siteId siteId, case when c.county is null then 'No County Info' else c.county end County
	INTO #County
	FROM
	(
		SELECT clientId, siteID
		FROM Shorthorn..cit_sh_sites
		WHERE clientID in
		(
			SELECT clientId
			FROM Shorthorn..cit_sh_sites
			GROUP BY clientId
			HAVING COUNT(siteID) = 1
		)
		UNION
		SELECT clientId, MIN(siteId) siteID
		FROM Shorthorn..cit_sh_sites
		WHERE HeadOffice = 1
		GROUP BY clientID
	) detail
	left outer join Shorthorn..cit_sh_sites s ON detail.siteID = s.siteID
	left outer join Shorthorn..cit_sh_county c ON s.county = c.countyID

	SELECT detail.Id AccountId, l.Id LeadId
	INTO #LastConvert
	FROM [DB01].Salesforce.dbo.Lead l
	inner join [DB01].Salesforce.dbo.LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'leadConverted'
	inner join	(
				SELECT a.Id, MAX(lh.CreatedDate) LastConvert
				FROM [DB01].Salesforce.dbo.Account a 
				inner join [DB01].Salesforce.dbo.Lead l ON a.Id = l.ConvertedAccountId
				inner join [DB01].Salesforce.dbo.LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'leadConverted'
				GROUP BY a.Id
				) detail ON l.ConvertedAccountId = detail.Id and lh.CreatedDate = detail.LastConvert
	GROUP BY detail.Id, l.Id

	SELECT *, 
	case when Status = 'InActive' and [Renew Date] >= [Original Renew Date] then 'Expired'
	when Status = 'InActive' and [Renew Date] < [Original Renew Date] and [Renew Date] < LastDate then 'Early Renewal'
	when Status = 'InActive' and (([Renew Date] < [Original Renew Date] and [Renew Date] = LastDate) or [Deal Status] in ('Cancellation','Liquidation','Written-Off bad debt','see new deal')) then 'Cancelled'
	when Status = 'Active' then 'Active'
	end [Reason Code],
	case when ContractNo = 1 then 'New' else 'Renewal ' + CONVERT(varchar, ContractNo-1) end [New or Renewal],
	case when Status = 'InActive' then [Renew Date] else null end [Service Termination Date],
	case when Status = 'InActive' then CONVERT(date, DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,[Renew Date])+1,0))) else null 
	end [Service Termination Month],
	case when clienttype like '%BCAS%' then 'BCAS' else 'Citation' end [Citation / BCAS],
	case when ContractNo = 1 then 'New' else 'Renewal' end [New / Renewal],
	case when clienttype like '%BCAS%' then 'BCAS'
	when [Original Deal Status] like '%Non-Auto%' then 'Manual' else 'Auto' end [Deal Type]
	FROM
	(
		SELECT 
		ISNULL(ISNULL(SAGE_ContractId, c.Sage_Contract_Number__c),'No SageCode') [Contract SageCode],
		cl.SageCode [Client SageCode],
		c.Id [Contract SFDC ID],
		a.Id [Client SFDC ID],
		ISNULL(cspc.PostCode, a.BillingPostalCode) as PostCode,
		d.dealID [Contract Shorthorn ID],
		cl.clientID [Client Shorthorn ID],
		cl.companyName [Company Name], 
		cl.clienttype, 
		d.noticeDate [Notice Given],
		CONVERT(date, d.signDate) [Sign Date], 
		CONVERT(date, DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,d.signDate)+1,0))) [Sign Month],
		CONVERT(date, d.renewDate) [Renew Date],
		CONVERT(date, DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,d.renewDate)+1,0))) [Renew Month],
		CONVERT(date, d.OriginalRenewDate) [Original Renew Date],
		CONVERT(date, DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,d.OriginalRenewDate)+1,0))) [Original Renew Month],
		ld.LastDate,
		ROW_NUMBER () OVER (PARTITION BY cl.clientID ORDER BY d.dealId) ContractNo, 
		case when st.Start is not null then 'Yes' else 'No' end Renewed,
		case when d.signDate <= GETDATE() and d.renewDate > GETDATE() and d.dealStatus not in (2,5,10,18) then 'Active' else 'InActive' end Status,
		d.dealLength [Deal Length], 
		d.cost [Deal Value], 
		cl.totEmployees [No. of Employees], 
		d.payroll payroll,
		dt.dealType [Service Type], 
		dls.[Services] [Deal Services],
		ds.dealStatus [Deal Status],
		ISNULL(od.[Original Deal Status], ds.dealStatus) [Original Deal Status],
		ds.dealStatus,
		d.enabled,
		cl.active, 
		ISNULL(a.SIC2007_Code__c, SIC_Code) [SIC Code 1],
		CONVERT(varchar(255),ISNULL(a.SIC2007_Description__c, sc.SIC_Description)) [SIC Description 1],
		ISNULL(a.SIC2007_Code2__c, sc.SIC2_Code) [SIC Code 2],
		CONVERT(varchar(255),ISNULL(a.SIC2007_Description2__c, sc.SIC2_Description)) [SIC Description 2],
		ISNULL(a.SIC2007_Code3__c, sh.COMPANY_SIC_2007_5) [SIC Code 3],
		CONVERT(varchar(255),ISNULL(a.SIC2007_Description3__c, sc.SIC3_Description)) [SIC Description 3],
		bs.title [Business Sector],
		bt.busType [Business Type],
		CONVERT(date, sd.StartDate) [Original Start Date],
		DATEDIFF(day,sd.StartDate, GETDATE()) [Client Days in Service],
		sr.SignReason,
		sm.FullName Salesman,
		bdc.Name BDC,
		cs.NoofSites,
		ct.County
		
		FROM Shorthorn..cit_sh_deals d
		left outer join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
		left outer join [DB01].Salesforce.dbo.Contract c ON d.SFDC_ContractId = c.Id
		left outer join [DB01].Salesforce.dbo.Account a ON c.AccountId = a.Id
		left outer join #LastConvert lc ON a.Id = lc.AccountId
		left outer join [DB01].Salesforce.dbo.Lead l ON lc.LeadId = l.Id
		left outer join [DB01].Salesforce.dbo.[User] bdc ON l.BDC__c = bdc.Id
		left outer join Shorthorn..cit_sh_dealTypes dt ON d.dealType = dt.dealTypeID
		left outer join Shorthorn..cit_sh_dealStatus ds ON d.dealStatus = ds.dealStatusID
		left outer join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
		left outer join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
		left outer join [DB01].SalesforceReporting.dbo.SHContracts sh ON cl.clientID = sh.clientID
		left outer join [DB01].SalesforceReporting.dbo.SIC2007Codes sc ON sh.[COMPANY_SIC_2007_5] = sc.SIC3_Code
		left outer join #Starts st ON d.clientID = st.clientID 
									and d.renewDate <= st.Start
		left outer join #LastDate ld ON d.clientID = ld.clientID
		left outer join #StartDate sd ON d.clientID = sd.clientID
		left outer join Shorthorn..cit_sh_OriginalDealStatus od ON d.dealID = od.[Contract Shorthorn ID]
		left outer join #SignReasons sr ON d.dealID = sr.dealID
		left outer join Shorthorn..cit_sh_users sm ON d.salesRep = sm.userID
		left outer join #ClientSites cs ON cl.clientID = cs.clientID
		left outer join #ClientSitesPostCode cspc ON cl.clientID = cspc.clientID
		left outer join #County ct ON cl.clientID = ct.clientID
		left outer join #DealServices dls ON c.Id = dls.Id
		WHERE d.signDate <> d.renewDate and cl.clientID is not null and d.clientID <> '79914' and cl.active = 1 and d.enabled = 1
	) detail

	ORDER BY [Company Name], [Sign Date]