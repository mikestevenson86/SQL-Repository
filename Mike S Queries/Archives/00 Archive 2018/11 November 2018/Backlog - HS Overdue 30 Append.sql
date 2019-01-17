INSERT INTO [SalesforceReporting].[dbo].[Backlog_HS_Overdue_ThirtyDays]
(
[DateStamp]
      ,[ShorthornId]
      ,[Sage Code]
      ,[companyName]
      ,[dealLength]
      ,[Consultant Fullname]
      ,[title]
      ,[fullname]
      ,[email]
      ,[siteID]
      ,[postcode]
      ,[genTel]
      ,[genEmail]
      ,[signDate]
      ,[renewDate]
      ,[BookedAction]
      ,[Call Type]
      ,[DealValue]
      ,[Sector]
      ,[SalesforceId]
      ,[Segment]
      ,[ContactID]
      ,[dealStatus]
      ,[Last Time Additional Visit]
      ,[Visit Cancelled]
      ,[Action cancelled]
      ,[ContactSalesforceId]
      ,[DaysOverdue]
)
SELECT CONVERT(date, GETDATE()) DateStamp, *
FROM
(
SELECT M.*,N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 10), GETDATE()) as DaysOverdue FROM (
select p.*, t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(select cl.clientID as ShorthornId, cl.sageCode, cl.companyName,d.dealLength, u.FullName as 'Consultant Fullname', t.title, 
case when c.fname is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname, case when c.fname is null then c1.email else c.email end as email, 
 s.siteID, s.postcode,s.genTel,s.genEmail,d.signDate,d.renewDate,' ' as BookedAction, 'First Contact' as [Call Type], d.cost as DealValue, bs.title as Sector, 
cl.SFDC_AccountId as SalesforceId, a.S__c Segment,
CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID, d1.dealStatus
 from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul 
LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where  ( d.signdate + 10 < GETDATE()+30  AND h.initialContact is NULL) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate())) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname
UNION ALL



SELECT M.*,N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 28 + 7), GETDATE()) FROM (
select p.*,t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(
select cl.clientID as ShorthornId, cl.sageCode, cl.companyName,d.dealLength, u.FullName as 'Consultant Fullname', t.title, 
case when c.fname  is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname, case when c.fname  is null then c1.email else c.email end as email, 
s.siteID,s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate, visit1book ,'First Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, 
 cl.SFDC_AccountId as SalesforceId, a.S__c Segment,
 CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID, d1.dealStatus
 from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul 
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where  ((d.signDate + 28 + 7 < GETDATE() + 30) AND h.firstVisit is NULL) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0) AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 
) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname

UNION ALL

SELECT M.*, N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 98 + 7), GETDATE()) from(
select p.*,t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(
select cl.clientID as ShorthornId, cl.sageCode, cl.companyName,d.dealLength, u.FullName as 'Consultant Fullname', t.title, 
case when c.fname  is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname, case when c.fname  is null then c1.email else c.email end as email,
s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate, installdatebook ,'Install Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, 
cl.SFDC_AccountId as SalesforceId, a.S__c,
CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID, d1.dealStatus
 from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus 
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where   ((h.dateinstalled IS NULL) AND ( d.signdate + 98 + 7 < GETDATE() +30)) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0) AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate())  
) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname

UNION ALL

SELECT M.*, N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 365 + 7), GETDATE()) from(
select p.*,t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(
select cl.clientID as ShorthornId, cl.sageCode, cl.companyName, d.dealLength, u.FullName as 'Consultant Fullname', t.title,
case when c.fname  is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname,case when c.fname  is null then c1.email else c.email end as email,
s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate,visit2book, 'Second Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, cl.SFDC_AccountId as SalesforceId, a.S__c Segment,
CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID,	d1.dealStatus
from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus 
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.secVisit IS NULL) AND (d.dealLength >= 24) AND (d.signDate + 365 + 7 < GETDATE() + 30)) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0) AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 
) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname

UNION ALL

SELECT M.*, N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 730 + 7), GETDATE()) from(
select p.*,t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(
select cl.clientID as ShorthornId, cl.sageCode, cl.companyName, d.dealLength, u.FullName as 'Consultant Fullname', t.title,
case when c.fname  is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname,case when c.fname  is null then c1.email else c.email  end as email,
s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate, visit3book ,'Third Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, cl.SFDC_AccountId as SalesforceId, a.S__c Segment,
CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID, d1.dealStatus
from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.thirVisit IS NULL) AND (d.dealLength >= 36) AND (d.signDate + 730 + 7 < GETDATE() + 30)) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 
) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname

UNION ALL

SELECT M.*, N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 1095 + 7 ), GETDATE()) from(
select p.*,t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(
select cl.clientID as ShorthornId, cl.sageCode, cl.companyName, d.dealLength, u.FullName as 'Consultant Fullname', t.title,
case when c.fname  is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname, case when c.fname  is null then c1.email else c.email end as email, 
s.siteID, s.postcode,s.genTel,s.genEmail,d.signDate,d.renewDate, visit4book,'Fourth Visit Overdue' as [Call Type]  , d.cost as DealValue, bs.title as Sector, cl.SFDC_AccountId as SalesforceId, a.S__c Segment,
CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID, d1.dealStatus
from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.fourthVisit IS NULL) AND (d.dealLength >= 48) AND (d.signDate + 1095 + 7 < GETDATE() + 30)) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 
) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname

UNION ALL

SELECT M.*, N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 1460 + 7 ), GETDATE()) from(
select p.*,t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(
select cl.clientID as ShorthornId, cl.sageCode, cl.companyName,d.dealLength,  u.FullName as 'Consultant Fullname', t.title,
case when c.fname  is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname, case when c.fname  is null then c1.email else c.email end as email, 
s.siteID, s.postcode, s.genTel,s.genEmail,d.signDate,d.renewDate, visit5book, 'Fifth Visit Overdue' as [Call Type], d.cost as DealValue, bs.title as Sector, cl.SFDC_AccountId as SalesforceId, a.S__c Segment,
CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID, d1.dealStatus
from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.fifthVisit IS NULL) AND (d.dealLength >= 60) AND (d.signDate + 1460 + 7 < GETDATE() + 30)) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0)  AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 
) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname

UNION ALL

SELECT M.*, N.Id as ContactSalesforceId, DATEDIFF(day,( signdate + 1825 + 7 ), GETDATE()) from(
select p.*,t.dueDate as 'Last Time Additional Visit',Q.cancellationdate as 'Visit Cancelled',Q.visitType as 'Action cancelled' from 
(
select cl.clientID as ShorthornId, cl.sageCode, cl.companyName, d.dealLength, u.FullName as 'Consultant Fullname', t.title,
case when c.fname  is null then (c1.fname + ' ' + c1.sName) else (c.fname + ' ' + c.sName) end as fullname, case when c.fname  is null then c1.email else c.email end as email, 
s.siteID, s.postcode,s.genTel,s.genEmail,d.signDate,d.renewDate, visit6book, 'Sixth Visit Overdue' as [Call Type] , d.cost as DealValue, bs.title as Sector, cl.SFDC_AccountId as SalesforceId, a.S__c Segment,
CASE WHEN c.contactID is null THEN c1.contactID else c.contactID END as ContactID, d1.dealStatus 
from [database].shorthorn.dbo.cit_sh_dealsHS as h
INNER JOIN [database].shorthorn.dbo.cit_sh_clients as cl on cl.clientID = h.clientID 
INNER JOIN [database].shorthorn.dbo.cit_sh_deals as d on d.dealID = h.dealID 
LEFT JOIN Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
LEFT JOIN [database].shorthorn.dbo.cit_sh_dealStatus as d1 on d1.dealStatusID = d.dealStatus
LEFT JOIN [database].shorthorn.dbo.cit_sh_sites as s on s.clientID = h.clientID and s.siteID = h.siteID 
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s.mainContactHS = c.contactID  and c.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c1 on (s.genContact = c1.contactID) and c1.enabled = 1
LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = h.mainConsul
LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = cl.busType
LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
where    ((h.sixthVisit IS NULL) AND (d.dealLength >= 72) AND (d.signDate + 1825 + 7 < GETDATE() + 30)) AND
(d.dealType IN (1, 3))
AND (cl.active = 1) AND (s.active = 1) AND (d.dealStatus IN (1, 3, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)) 
AND (onHold = 0) AND (d.enabled = 1) AND (cl.clientID NOT IN (76517,68210,79914)) 
AND (d.aiOnly IS NULL OR d.aiOnly = '' OR d.aiOnly < GetDate()) 
AND (d.signdate <= GetDate() AND d.renewdate >= GetDate()) 
) as p
left join
(select siteID,dueDate from
(select *, ROW_NUMBER() over(partition by siteid order by duedate desc) rn from [database].shorthorn.dbo.cit_sh_HSExtraVisits)T where rn=1) as t on t.siteID = p.siteID
LEFT JOIN 
 (SELECT siteID,cancellationdate,cancelReason,vt.visitType   FROM 
(
	select siteID, cancellationdate,reason,bookingtype,ROW_NUMBER() over(partition by siteid order by cancellationdate desc) rn 
	from [database].shorthorn.dbo.cit_sh_HSCancellations) as T 
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitCancellationReasons AS r ON r.vcID = T.reason
	INNER JOIN [database].shorthorn.dbo.cit_sh_visitType AS vt ON vt.vtID = T.bookingtype
	where rn=1 and r.cancelledBy = 1 ) as Q on Q.siteID = p.siteID
--order by companyName
 ) as M
left join (
SELECT Id,firstname,lastname, accountID, email FROM Salesforce..contact where active__c = 'true' and isdeleted='false') as N on M.SalesforceId = N.accountID and M.genEmail = N.email and M.FullName = N.firstname + ' ' + N.lastname
) detail
order by companyName