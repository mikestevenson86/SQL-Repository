IF OBJECT_ID('tempdb..#SiteCount') IS NOT NULL
	BEGIN
		DROP TABLE #SiteCount
	END

SELECT clientId, COUNT(siteId) Sites
INTO #SiteCount
FROM Shorthorn..cit_sh_sites
GROUP BY clientID

SELECT 
BookedDate [Date Booked], 
VisitType [Visit Type], 
companyName Company, 
siteName [Site Name], 
s.postcode [Site Postcode], 
ISNULL(u.FullName, u2.FullName) Consultant

FROM
(
	SELECT 'First Visit' VisitType, clientID, dealID, firstVisitBooked BookedDate, firstVisitConsultantID ConsultantID
	FROM Shorthorn..cit_sh_dealsPEL
	WHERE firstVisitBooked < GETDATE() and firstVisit is null
	UNION
	SELECT 'Install', clientID, dealID, installBooked, installConsul
	FROM Shorthorn..cit_sh_dealsPEL
	WHERE installBooked < GETDATE() and installed is null
	UNION
	SELECT 'Renewal Review', clientID, dealID, docReviewBooked, docReviewConsultantID
	FROM Shorthorn..cit_sh_dealsPEL
	WHERE docReviewBooked < GETDATE() and docReview is null
	UNION
	SELECT 'Retrieval Visit', clientID, dealID,
	case when firstDraftRetrievalBooked is not null and firstDraftRetrievalDone is null then firstDraftRetrievalBooked 
	 when secondDraftRetrievalBooked is not null and secondDraftRetrievalDone is null then secondDraftRetrievalBooked 
	  when thirdDraftRetrievalBooked is not null and thirdDraftRetrievalDone is null then thirdDraftRetrievalBooked end,
	NULL
	FROM Shorthorn..cit_sh_dealsPEL pel
	WHERE 
	(firstDraftRetrievalBooked < GETDATE() and firstDraftRetrievalDone is null)
	or
	(secondDraftRetrievalBooked < GETDATE() and secondDraftRetrievalDone is null)
	or
	(thirdDraftRetrievalBooked < GETDATE() and thirdDraftRetrievalDone is null)
) detail
left outer join Shorthorn..cit_sh_clients cl ON detail.clientID = cl.clientID
left outer join Shorthorn..cit_sh_deals dl ON detail.dealID = dl.dealID
left outer join Shorthorn..cit_sh_dealsPEL dhr ON dl.dealID = dhr.dealID
left outer join Shorthorn..cit_sh_sites s ON dhr.siteID = s.siteID
left outer join Shorthorn..cit_sh_users u ON detail.ConsultantID = u.userID
left outer join Shorthorn..cit_sh_users u2 ON dhr.mainConsul = u2.userID
left outer join #SiteCount sc ON cl.clientID = sc.clientID
WHERE dl.signDate < GETDATE() and dl.renewDate > GETDATE() and dl.dealStatus not in (2,5,10,18) and (s.HeadOffice = 1 or sc.Sites = 1)
ORDER BY BookedDate, VisitType