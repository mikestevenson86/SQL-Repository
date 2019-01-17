IF OBJECT_ID('tempdb..#Cancels') IS NOT NULL
	BEGIN
		DROP TABLE #Cancels
	END

IF OBJECT_ID('tempdb..#ExtraDue') IS NOT NULL
	BEGIN
		DROP TABLE #ExtraDue
	END

IF OBJECT_ID('tempdb..#SFDCContacts') IS NOT NULL
	BEGIN
		DROP TABLE #SFDCContacts
	END

IF OBJECT_ID('tempdb..#MissedVisits') IS NOT NULL
	BEGIN
		DROP TABLE #MissedVisits
	END

IF OBJECT_ID('tempdb..#Output') IS NOT NULL
	BEGIN
		DROP TABLE #Output
	END

	SELECT 
	siteID,
	cancellationdate,
	cancelReason,
	vt.visitType

	INTO
	#Cancels
	  
	FROM 
	(
		SELECT 
		siteID, 
		cancellationdate,
		reason,
		bookingtype,
		ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
		FROM cit_sh_HSCancellations
	) as t 
	inner join cit_sh_visitCancellationReasons AS r ON r.vcID = t.reason
	inner join cit_sh_visitType AS vt ON vt.vtID = t.bookingtype

	WHERE 
	rn = 1 
	and 
	r.cancelledBy = 1 

	SELECT 
	siteID,
	dueDate 

	INTO
	#ExtraDue

	FROM
	(
		SELECT 
		*, 
		ROW_NUMBER() over(partition by siteid order by duedate desc) rn 
		FROM 
		cit_sh_HSExtraVisits
	) T 

	WHERE 
	rn = 1

	SELECT 
	Id,
	firstname,
	lastname, 
	accountID, 
	email 

	INTO
	#SFDCContacts

	FROM 
	[db01].Salesforce.dbo.contact 

	WHERE 
	active__c = 'true' 
	and 
	isdeleted='false'

	SELECT 
	cl.clientID ShorthornId, 
	cl.companyName,
	d.dealLength, 
	ISNULL(mu.FullName, su.FullName) [Consultant Fullname], 
	t.title, 
	case when c.contactID is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end fullname, 
	case when c.contactID is null then c1.email else c.email end email, 
	s.siteID,
	s.postcode, 
	s.genTel,
	s.genEmail,
	d.signDate,
	d.renewDate,
	initialContact,
	firstVisit,
	dateInstalled,
	secVisit,
	thirVisit,
	fourthVisit,
	fifthVisit,
	sixthVisit, 
	visit1book,
	installdatebook,
	visit2book,
	visit3book,
	visit4book,
	visit5book,
	visit6book,
	d.cost DealValue, 
	bs.title Sector, 
	cl.SFDC_AccountId SalesforceId, 
	case when c.contactID is null then c1.contactID else c.contactID end ContactID,
	d.dealStatus, 
	a.S__c Segment

	INTO
	#MissedVisits

	FROM Shorthorn..cit_sh_dealsHS dhs
	left outer join Shorthorn..cit_sh_deals d ON dhs.dealID = d.dealID
	left outer join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
	left outer join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	left outer join [DB01].Salesforce.dbo.Account a ON cl.clientId = a.Shorthorn_Id__c
	left outer join cit_sh_dealStatus ds ON d.dealStatus = ds.dealStatusID
	left outer join cit_sh_contacts c ON s.mainContactHS = c.contactID 
	left outer join cit_sh_contacts c1 ON s.genContact = c1.contactID
	left outer join cit_sh_titles t ON c.title  = t.titleID
	left outer join cit_sh_users mu ON dhs.mainConsul = mu.userID
	left outer join cit_sh_users su ON dhs.subConsul = su.userID
	left outer join cit_sh_busType b ON cl.busType = b.busTypeID
	left outer join cit_sh_businessSectors bs ON bs.id = b.businessSectorID 

	WHERE
	(
		initialContact is null or 
		firstVisit is null or 
		dateInstalled is null or 
		secVisit is null or 
		thirVisit is null or 
		fourthVisit is null or 
		fifthVisit is null or 
		sixthVisit is null
	)
	and 
	cl.active = 1 
	and 
	s.active = 1 
	and 
	d.dealStatus not in (2, 5, 10, 18) 
	and
	d.dealType in (1, 3)
	and
	d.enabled = 1
	and 
	d.signDate < GETDATE() 
	and
	d.renewDate > GETDATE() 
	and 
	d.onHold = 0
	and 
	cl.clientID not in (76517, 68210, 79914) 
	and
	( 
		ISNULL(d.aiOnly, '') < GETDATE()
		or
		ISNULL(d.aiOnly, '') <> ''
	)

	SELECT 
	'H&S' as Dataset,
	case when DaysOverdue<=0 and DaysOverdue>-30 then 'Next 30 Days'
		when [Call Type] like 'Next 30 Day%' then 'Next 30 Days'
		when DaysOverdue between 1 and 14 then '> 1 Day'
		when DaysOverdue between 15 and 30 then '> 2 Weeks'
		when DaysOverdue between 31 and 55 then '> 1 Month'
		when DaysOverdue between 56 and 183 then '> 2 Months'
		when DaysOverdue>183 then '> 6 Months'
		else 'Other' end Category,
	case when DaysOverdue<=0 then 99
		when DaysOverdue between 1 and 14 then 1
		when DaysOverdue between 15 and 30 then 2
		when DaysOverdue between 31 and 55 then 3
		when DaysOverdue between 56 and 183 then 4
		when DaysOverdue>183 then 5
		else 99 end CategoryID,
	t.dueDate [Last Time Additional Visit],
	q.cancellationdate [Visit Cancelled],
	q.visitType [Action cancelled], 
	n.Id ContactSalesforceId,
	ShorthornId,
	companyName,
	dealLength,
	[Consultant Fullname],
	title,
	fullname,
	detail.email,
	detail.siteID,
	postcode,
	genTel,
	genEmail,
	signDate,
	renewDate,
	case when BookedAction = '1900-01-01 00:00:00.000' or BookedAction is null then 'Not Booked' else 'Booked' end BookedAction,
	case when BookedAction = '1900-01-01 00:00:00.000' or BookedAction is null then '' else BookedAction end BookedDate,
	[Call Type],
	DealValue,
	Sector,
	SalesforceId,
	ContactID,
	dealStatus,
	Segment,
	DateDue,
	DaysOverdue
	
	INTO
	#Output
	
	FROM
	(
		SELECT
		*,
		CAST(case when "Call Type"='First Contact' then signDate+10
			 when "Call Type"='First Visit Overdue' then signDate+28
			 when "Call Type"='Install Overdue' then signDate+98
			 when "Call Type"='Second Visit Overdue' then signDate+365
			 when "Call Type"='Third Visit Overdue' then signDate+730
			 when "Call Type"='Fourth Visit Overdue' then signDate+1095
			 when "Call Type"='Fifth Visit Overdue' then signDate+1460
			 when "Call Type"='Sixth Visit Overdue' then signDate+1825
			 else signDate
		end as date) DateDue,
		DATEDIFF
		(
		dd,
		CAST(case when "Call Type"='Next 30 Days - First Visit' then signDate+28
			 when "Call Type"='Next 30 Days - Install' then signDate+98
			 when "Call Type"='Next 30 Days - Second Visit' then signDate+365
			 when "Call Type"='Next 30 Days - Third Visit' then signDate+730
			 when "Call Type"='Next 30 Days - Fourth Visit' then signDate+1095
			 when "Call Type"='Next 30 Days - Fifth Visit' then signDate+1460
			 when "Call Type"='Next 30 Days - Sixth Visit' then signDate+1825
			 when "Call Type"='First Contact' then signDate+10
			 when "Call Type"='First Visit Overdue' then signDate+28
			 when "Call Type"='Install Overdue' then signDate+98
			 when "Call Type"='Second Visit Overdue' then signDate+365
			 when "Call Type"='Third Visit Overdue' then signDate+730
			 when "Call Type"='Fourth Visit Overdue' then signDate+1095
			 when "Call Type"='Fifth Visit Overdue' then signDate+1460
			 when "Call Type"='Sixth Visit Overdue' then signDate+1825
			 else signDate
		end as date),
		CAST(GETDATE() as date)
		)  DaysOverdue 
		
		FROM 
		(
			-- Overdue
			SELECT 'First Contact Overdue' [Call Type],
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			initialContact MissingAction, '' BookedAction, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment
			FROM #MissedVisits mv WHERE mv.initialContact is null and signdate + 10 < GETDATE()+30 
			UNION
			SELECT 'First Visit Overdue', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			firstVisit, visit1book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.firstVisit is null and signdate + 28 < GETDATE()
			UNION
			SELECT 'Install Overdue', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			dateInstalled, installdatebook, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.dateInstalled is null and signdate + 98 < GETDATE() +37
			UNION
			SELECT 'Second Visit Overdue', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			secVisit, visit2book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.secVisit is null and dealLength >= 24 and signDate + 365 < GETDATE() + 37
			UNION
			SELECT 'Third Visit Overdue', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			thirVisit, visit3book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.thirVisit is null and dealLength >= 36 and signDate + 730 < GETDATE() + 37
			UNION
			SELECT 'Fourth Visit Overdue', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			fourthVisit, visit4book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.fourthVisit is null and dealLength >= 48 and signDate + 1095 < GETDATE() + 37
			UNION
			SELECT 'Fifth Visit Overdue', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			fifthVisit, visit5book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.fifthVisit is null and dealLength >= 60 and signDate + 1460  < GETDATE() + 37
			UNION
			SELECT 'Sixth Visit Overdue', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			sixthVisit, visit6book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.sixthVisit is null and dealLength >= 72 and signDate + 1825 < GETDATE() + 37
			UNION
			--30 Days
			SELECT 'Next 30 Days - First Visit', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			firstVisit, visit1book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.firstVisit is null and signDate + 28 between GETDATE() and GETDATE()+ 30
			UNION
			SELECT 'Next 30 Days - Install', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			dateInstalled, installdatebook, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.dateInstalled is null and signDate + 98 between GETDATE() and GETDATE()+ 30
			UNION
			SELECT 'Next 30 Days - Second Visit', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			secVisit, visit2book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.secVisit is null and dealLength >= 24 and signDate + 365 between GETDATE() and GETDATE()+ 30
			UNION
			SELECT 'Next 30 Days - Third Visit', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			thirVisit, visit3book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.thirVisit is null and dealLength >= 36 and signDate + 730 between GETDATE() and GETDATE()+ 30
			UNION
			SELECT 'Next 30 Days - Fourth Visit', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			fourthVisit, visit4book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.fourthVisit is null and dealLength >= 48 and signDate + 1095 between GETDATE() and GETDATE()+ 30
			UNION
			SELECT 'Next 30 Days - Fifth Visit', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			fifthVisit, visit5book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.fifthVisit is null and dealLength >= 60 and signDate + 1460 between GETDATE() and GETDATE()+ 30
			UNION
			SELECT 'Next 30 Days - Sixth Visit', 
			ShorthornId, companyName, dealLength, [Consultant Fullname], title, fullname, email, siteID, postcode, genTel, genEmail, signDate, renewDate,
			sixthVisit, visit6book, DealValue, Sector, SalesforceId, ContactID, dealStatus, Segment 
			FROM #MissedVisits mv WHERE mv.sixthVisit is null and dealLength >= 72 and signDate + 1825 between GETDATE() and GETDATE()+ 30
		) detail
	) detail
	left outer join #Cancels q ON detail.siteID = q.siteID
	left outer join #ExtraDue t ON detail.siteID = t.siteID
	left outer join #SFDCContacts n ON detail.SalesforceId = n.accountID 
										and detail.genEmail = n.email 
										and detail.FullName = n.firstname + ' ' + n.lastname

	SELECT *
	FROM #Output
	WHERE Category <> 'Other'
	ORDER BY [Call Type], ShorthornId, signDate