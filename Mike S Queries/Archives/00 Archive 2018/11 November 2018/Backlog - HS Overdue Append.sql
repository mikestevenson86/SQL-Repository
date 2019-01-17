INSERT INTO SalesforceReporting..Backlog_HS_Overdue
(
[DateStamp]
      ,[Company Name]
      ,[Sage Code]
      ,[Deal Length]
      ,[FullName]
      ,[Sub Consul]
      ,[Title]
      ,[Contact Id]
      ,[Full Name]
      ,[Site ID]
      ,[Post Code]
      ,[Gen Tel]
      ,[Gen Email]
      ,[Sign Date]
      ,[Renew Date]
      ,[Last Visit Date]
      ,[Booked Action]
      ,[Call Type]
      ,[DealValue]
      ,[Sector]
      ,[Segment]
      ,DaysOverdue
)

SELECT  CONVERT(date, GETDATE()) DateStamp, *
FROM
(
select  cl.companyName,cl.sageCode,d.dealLength, u.FullName, uSub.FullName SubConsul, t.title, 
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as contactfullname,s.siteID,
s.postcode, 
s.genTel,s.genEmail,d.signDate,d.renewDate,  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' , ' ' as BookedAction  ,'First Contact' as [Call Type], d.cost as DealValue, bs.title as Sector, a.S__c Segment  
--,d.onHold, d.onHoldSince, d.offHoldSince
, DATEDIFF(day,d.signdate + 10,GETDATE()) DaysOverdue
 from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where  ( d.signdate + 10 < GETDATE()  AND h.initialContact is NULL) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17))
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 

UNION ALL

select  cl.companyName,cl.sageCode,d.dealLength, u.FullName, uSub.FullName SubConsul, t.title, 
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID, s.postcode,
 s.genTel,s.genEmail,d.signDate,d.renewDate,  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' ,visit1book, 'First Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, a.S__c Segment
 --,d.onHold, d.onHoldSince, d.offHoldSince
 , DATEDIFF(day,d.signdate + 28 + 7,GETDATE()) DaysOverdue
   from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul 
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where  (d.signDate + 28 + 7 < GETDATE() AND (h.firstVisit is NULL )) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 

UNION ALL

select cl.companyName,cl.sageCode,d.dealLength, u.FullName, uSub.FullName SubConsul, t.title, 
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID, s.postcode, s.genTel,
s.genEmail,d.signDate,d.renewDate,  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' , h.installdatebook, 'Install Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, a.S__c Segment
 , DATEDIFF(day,d.signdate + 98 + 7,GETDATE()) DaysOverdue   	
 from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where   ((h.dateinstalled IS NULL) AND (d.signdate + 98 + 7 < GETDATE())) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17))
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate())  

UNION ALL

select cl.companyName,cl.sageCode, d.dealLength, u.FullName, uSub.FullName SubConsul, t.title,
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
	case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate,
	  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate', visit2book, 
	'Second Visit Overdue' as [Call Type]  , d.cost as DealValue, bs.title as Sector, a.S__c Segment
	, DATEDIFF(day,d.signdate + 365 + 7,GETDATE()) DaysOverdue
	from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.secVisit IS NULL) AND (d.dealLength >= 24) AND (d.signDate + 365 + 7 < GETDATE())) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 

UNION ALL

select   cl.companyName,cl.sageCode, d.dealLength, u.FullName, uSub.FullName SubConsul, t.title,
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
	case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate, 
	  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' ,visit3book ,
	'Third Visit Overdue' as [Call Type]  , d.cost as DealValue, bs.title as Sector, a.S__c Segment
	 , DATEDIFF(day,d.signdate + 730 + 7,GETDATE()) DaysOverdue
	from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.thirVisit IS NULL) AND (d.dealLength >= 36) AND (d.signDate + 730 + 7 < GETDATE())) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17))
AND (onHold = 0)   AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 

UNION ALL

select   cl.companyName,cl.sageCode, d.dealLength, u.FullName, uSub.FullName SubConsul, t.title,
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
	case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate, 
	  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' ,visit4book ,
	'Fourth Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, a.S__c Segment 
	, DATEDIFF(day,d.signdate + 1095 + 7,GETDATE()) DaysOverdue 
	from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.fourthVisit IS NULL) AND (d.dealLength >= 48) AND (d.signDate + 1095 + 7 < GETDATE())) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 

UNION ALL

select   cl.companyName,cl.sageCode,d.dealLength,  u.FullName, uSub.FullName SubConsul, t.title,
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
	case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate,  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' , visit5book ,
	'Fifth Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, a.S__c Segment  
	, DATEDIFF(day,d.signdate + 1460 + 7,GETDATE()) DaysOverdue
	from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.fifthVisit IS NULL) AND (d.dealLength >= 60) AND (d.signDate + 1460 + 7 < GETDATE())) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 

UNION ALL

select  cl.companyName,cl.sageCode, d.dealLength, u.FullName, uSub.FullName SubConsul, t.title,
case when c.contactID is null then c1.contactID else c.contactID end as ContactId,
	case when c.fname  is null then (c1.fname + '' + c1.sName) else (c.fname + '' + c.sName) end as fullname,s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate,
	  case when initialContact is not null and ((firstVisit is null OR firstVisit = '01-01-1980') and (dateInstalled is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then initialContact
	  when firstvisit is not null and ((dateInstalled  is null OR dateInstalled = '01-01-1980') and (secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980' )) then firstVisit  
	  when firstVisit is not null and dateInstalled is not null and ((secVisit is null OR secVisit = '01-01-1980') and (thirVisit is null OR thirVisit = '01-01-1980' ) and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then dateInstalled  
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and ((thirVisit is null OR thirVisit = '01-01-1980') and (fourthVisit is null OR fourthVisit = '01-01-1980' ) and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then secVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and ((fourthVisit is null OR fourthVisit = '01-01-1980')and (fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then thirVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and ((fifthVisit is null OR fifthVisit = '01-01-1980') and (sixthVisit is null OR sixthVisit = '01-01-1980')) then fourthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and (sixthVisit is null OR sixthVisit = '01-01-1980') then fifthVisit 
	  when firstVisit is not null and dateInstalled is not null and secVisit is not null and thirVisit is not null and fourthVisit is not null and fifthVisit is not null and sixthVisit is not null then sixthVisit
 else NULL end as 'LastVisitDate' , visit6book ,
	'Sixth Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, a.S__c Segment  
	, DATEDIFF(day,d.signdate + 1825 + 7,GETDATE()) DaysOverdue
	from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as uSub on uSub.userID = h.subConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.sixthVisit IS NULL) AND (d.dealLength >= 72) AND (d.signDate + 1825 + 7 < GETDATE())) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17))
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate())
) detail
 order by companyName