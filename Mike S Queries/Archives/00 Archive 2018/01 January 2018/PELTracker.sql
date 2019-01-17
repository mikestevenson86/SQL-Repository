SELECT [t0].[pelID], [t0].[clientID], [t0].[dealID], [t0].[siteID], [t0].[dsID], [t0].[pelDealServiceType], [t0].[sysRequired], 
	[t0].[mainConsul], [t0].[siteContact], [t0].[agreeRecvd], [t0].[agreeToConsul], [t0].[initialContact], [t0].[initialContactLength], 
	[t0].[contactProbs], [t0].[cons1Date], [t0].[cons1User], [t0].[cons2Date], [t0].[cons2User], [t0].[firstVisit], [t0].[firstVisitLength], 
	[t0].[firstVisitBooked], [t0].[firstVisitBookedLength], [t0].[firstVisitClientLetterID], [t0].[firstVisitExchCalItemID], [t0].[firstVisitConsultantID], 
	[t0].[firstVisitComments], [t0].[firstVisitHandbookID], [t0].[writtenBy], [t0].[firstDraft], [t0].[firstDraftToClient], [t0].[firstAdmin],
	[t0].[firstDraftReturned], [t0].[firstDraftRetrievalBooked], [t0].[firstDraftRetrievalBookedLength], [t0].[firstDraftRetrievalDone],
	[t0].[firstDraftRetrievalDoneLength], [t0].[FirstDraftRetrievalClientLetterID], [t0].[FirstDraftRetrievalExchCalItemID], 
	[t0].[FirstDraftRetrievalConsultantID], [t0].[FirstDraftRetrievalComments], [t0].[draftRetrieval], [t0].[draftConsultant], 
	[t0].[secDraftToClient], [t0].[secDraftAdmin], [t0].[secDraftReturned], [t0].[secondDraftRetrievalBooked], 
	[t0].[secondDraftRetrievalBookedLength], [t0].[secondDraftRetrievalDone], [t0].[secondDraftRetrievalDoneLength], 
	[t0].[secondDraftRetrievalClientLetterID], [t0].[secondDraftRetrievalExchCalItemID], [t0].[secondDraftRetrievalConsultantID],
	[t0].[secondDraftRetrievalComments], [t0].[thirDraftToClient], [t0].[thirDraftReturned], [t0].[thirDraftAdmin], 
	[t0].[thirdDraftRetrievalBooked], [t0].[thirdDraftRetrievalBookedLength], [t0].[thirdDraftRetrievalDone], 
	[t0].[thirdDraftRetrievalDoneLength], [t0].[thirdDraftRetrievalClientLetterID], [t0].[thirdDraftRetrievalExchCalItemID], 
	[t0].[thirdDraftRetrievalConsultantID], [t0].[thirdDraftRetrievalComments], [t0].[chaseLtr1], [t0].[chaseLtr2], [t0].[chaseLtr3], 
	[t0].[blackHoleLtr], [t0].[finalAmends], [t0].[finalAmendsAdmin], [t0].[mkApproved], [t0].[inMakeUp], [t0].[makeUpAdmin], 
	[t0].[ready], [t0].[deliveredTo], [t0].[deliveredDate], [t0].[installed], [t0].[installedType], [t0].[installedLength], 
	[t0].[installBooked], [t0].[installBookedLength], [t0].[InstallClientLetterID], [t0].[InstallExchCalItemID], 
	[t0].[installConsul], [t0].[InstallComments], [t0].[reminder1], [t0].[reminder2], [t0].[followUp3], [t0].[followUp3Length], 
	[t0].[followUp12], [t0].[followUp12Length], [t0].[followUp24], [t0].[followUp24Length], [t0].[followUp36], [t0].[followUp36Length], 
	[t0].[docReview], [t0].[docReviewLength], [t0].[docReviewBooked], [t0].[docReviewBookedLength], [t0].[docReviewClientLetterID], 
	[t0].[docReviewExchCalItemID], [t0].[docReviewConsultantID], [t0].[docReviewComments], [t0].[docReviewplus12], [t0].[docReviewplus12Length],
    [t0].[docReviewplus24], [t0].[docReviewplus24Length], [t0].[docReviewplus36], [t0].[docReviewplus36Length], [t0].[docReviewType], 
    [t0].[comments], [t0].[newsletters], [t0].[enabled], [t0].[qualMark], [t0].[qualMarkIssued], [t0].[issPaper], [t0].[issElec], 
    [t0].[midTermReview], [t0].[midTermLength], [t0].[hideDraftChaseLetters]
FROM [dbo].[cit_sh_dealsPEL] AS [t0]
	INNER JOIN [dbo].[cit_sh_deals] AS [t1] ON [t1].[dealID] = [t0].[dealID]
	INNER JOIN [dbo].[cit_sh_clients] AS [t2] ON [t2].[clientID] = [t0].[clientID]
	INNER JOIN [dbo].[cit_sh_sites] AS [t3] ON [t3].[siteID] = [t0].[siteID]
WHERE ([t1].[signDate] <= GETDATE()) AND ([t1].[renewDate] >= GETDATE()) 
		AND ([t0].[sysRequired] = 1) AND ([t1].[dealType] IN (2, 3, 7, 12, 14, 15)) 
		AND ([t2].[active] = 1) AND ([t3].[active] = 1) 
		AND (([t1].[dealStatus]) IN (1, 6, 9, 11, 12, 13, 14, 15, 16)) 
		AND ([t1].[enabled] = 1) 
		AND ((NOT ([t1].[aiOnly] IS NOT NULL)) OR (([t1].[aiOnly]) <= GETDATE())) 
		AND ([t1].[renewDate] >= GETDATE()) AND ([t1].[signDate] <= GETDATE()) AND ([t0].[sysRequired] = 1)
