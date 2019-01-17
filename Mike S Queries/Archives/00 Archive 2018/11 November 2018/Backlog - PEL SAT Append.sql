INSERT INTO SalesforceReporting..Backlog_PEL_SAT
(
[DateStamp]
      ,[Company Name]
      ,[Sage Code]
      ,[Site Name]
      ,[Post Code]
      ,[Consultant Name]
      ,[Sign Date]
      ,[Deal Length]
      ,[On Hold]
      ,[OnHold Since]
      ,[Off Hold Since]
      ,[Last Action Type Sat]
      ,[Last Visit Date]
      ,[Segment]
      ,[InitialContact]
      ,[First Visit Booked]
      ,[First Visit]
      ,[Install Booked]
      ,[Installed]
      ,[Follow Up3]
      ,[Follow Up12]
      ,[Follow Up24]
      ,[Follow Up36]
      ,[Mid Term Review]
      ,[Doc Review Booked]
      ,[Doc Review]
      ,[Doc Review Plus12]
      ,[Doc Review Plus24]
      ,[Doc Review Plus36]
      ,[Pel Deal Service Type]
)

SELECT CONVERT(date, GETDATE()) DateStamp, *
FROM
(
select cl.companyName, cl.sageCode, s.siteName, s.postcode, u.FullName as 'Consultant Name', d.signDate, dealLength, d.onHold, d.onHoldSince, d.offHoldSince
,case when initialContact is not null and firstVisit is null then 'Initial Contact'
	  when firstvisit is not null and installed  is null then 'First Visit Sat'
	  when firstVisit is not null and installed is not null  then 'Installed Sat'  
	  else NULL end as 'Last Action Type Sat'
,case when initialContact is not null and (firstVisit is null OR firstVisit = '01-01-1980') then initialContact 
	  when firstvisit is not null and (installed  is null OR installed = '01-01-1980') then firstVisit 
	  when firstVisit is not null and installed is not null  then installed   
	  else NULL end as 'Last Visit Date', a.S__c Segment
 ,pel.initialContact,pel.firstVisitBooked, pel.firstVisit, pel.installBooked, pel.installed, pel.followUp3,pel.followUp12, pel.followUp24,pel.followUp36,
pel.midtermreview, pel.docReviewBooked, pel.docReview,pel.docReviewplus12, pel.docReviewplus24,pel.docReviewplus36, pel.pelDealServiceType 
    from [database].shorthorn.dbo.cit_sh_clients as cl
INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d on d.clientID = cl.clientID and d.enabled = 1
LEFT JOIN Salesforce.dbo.Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealsPEL as pel on pel.dealID = d.dealID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.siteID = pel.siteID
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = pel.mainConsul 
WHERE (d.dealType IN (2, 3, 6, 12, 15)) AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d.enabled = 1)
	AND (onHold = 0) AND (d.aiOnly IS NULL OR d.aiOnly <= GETDATE()) 	AND (d.renewDate >= GETDATE()) AND (d.signDate <= GETDATE()) 	
) detail
order by companyName 