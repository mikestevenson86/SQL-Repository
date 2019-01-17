
INSERT INTO SalesforceReporting..Backlog_HS_SAT
(
[DateStamp]
,[Company Name]
,[Sage Code]
,[Site Name]
,[Post Code]
,[Consultant Name]
,[Sub Consultant Name]
,[Sign Date]
,[Deal Length]
,[OnHold]
,[OnHold Since]
,[Off HoldSince]
,[Last Action Type Sat]
,[Last Visit Date]
,[Initial Contact]
,[Visit 1 Book]
,[First Visit]
,[Install Date Book]
,[Date Installed]
,[Visit 2 Book]
,[Sec Visit]
,[Visit 3 Book]
,[Thir Visit]
,[Visit 4 Book]
,[Fourth Visit]
,[Visit 5 Book]
,[Fifth Visit]
,[Visit 6 Book]
,[Sixth Visit]
,[Sector]
,[Segment]
,[Contact ID]
,[Contact Full Name]
,[Site ID]
)

SELECT CONVERT(date, GETDATE()) DateStamp, *
FROM
(
SELECT 
cl.companyName,cl.sageCode,s.siteName, s.postcode, u.FullName as 'Consultant Name', uSub.FullName as 'Sub Consultant Name', d.signDate, dealLength,  d.onHold, d.onHoldSince, d.offHoldSince 
,case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then 'Initial contact'
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then 'First Visit Sat' 
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then 'Installed Sat'
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then 'Second Visit Sat'
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then 'Thrid Visit Sat'
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then 'Fourth Visit Sat'
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then 'Fifth Visit Sat'
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then 'Sixth Visit Sat'
 else ' ' end as 'Last Action Type Sat',
  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' 
 ,hs.initialContact, hs.visit1book,hs.firstVisit, hs.installdatebook,hs.dateInstalled,  hs.visit2book,  hs.secVisit, hs.visit3book, hs.thirVisit, hs.visit4book, hs.fourthVisit
,hs.visit5book, hs.fifthVisit, hs.visit6book, hs.sixthVisit, bs.title as Sector, a.S__c Segment
,case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID      
FROM [database].shorthorn.dbo.cit_sh_clients AS cl
INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d on d.clientID = cl.clientID and d.enabled = 1
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealsHS as hs on hs.dealID = d.dealID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.siteID = hs.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = hs.mainConsul 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub ON uSub.userID = hs.subConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID
WHERE (d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17))
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) --) as T where T.[LastVisitDate] = '01-01-1980'
) detail
order by companyName
