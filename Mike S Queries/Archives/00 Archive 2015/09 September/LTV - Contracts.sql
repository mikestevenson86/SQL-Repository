SELECT SIC_Code, SIC_Description
INTO #SIC1
FROM [DB01].SalesforceReporting.dbo.SIC2007Codes
GROUP BY SIC_Code, SIC_Description

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

SELECT clientId, dealID, signDate, renewDate, originalrenewdate, ROW_NUMBER () OVER (PARTITION BY clientId ORDER BY signDate) rn
INTO #DealNumbers
FROM Shorthorn..cit_sh_deals

SELECT dn1.dealID, 
case when dn1.rn = 1 then 'New'
when dn2.renewDate < dn2.OriginalRenewDate then 'Early Renewal' else 'Renewal' end SignReason
INTO #SignReasons
FROM #DealNumbers dn1
LEFT outer join #DealNumbers dn2 ON dn1.clientId = dn2.clientId and dn1.rn-1 = dn2.rn

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
d.SFDC_ContractId [Contract SFDC ID],
cl.SFDC_AccountId [Client SFDC ID],
d.dealID [Contract Shorthorn ID],
cl.clientID [Client Shorthorn ID],
cl.companyName [Company Name], 
cl.clienttype, d.noticeDate [Notice Given],
CONVERT(date, d.signDate) [Sign Date], 
CONVERT(date, DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,d.signDate)+1,0))) [Sign Month],
CONVERT(date, d.renewDate) [Renew Date],
CONVERT(date, DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,d.renewDate)+1,0))) [Renew Month],
CONVERT(date, d.OriginalRenewDate) [Original Renew Date],
CONVERT(date, DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,d.OriginalRenewDate)+1,0))) [Original Renew Month],
ld.LastDate,
ROW_NUMBER () OVER (PARTITION BY cl.clientID ORDER BY d.dealId) ContractNo, 
case when st.Start is not null then 'Yes' else 'No' end Renewed,
case when d.signDate <= GETDATE() and d.renewDate > GETDATE() then 'Active' else 'InActive' end Status,
d.dealLength [Deal Length], 
d.cost [Deal Value], 
cl.totEmployees [No. of Employees], 
d.payroll payroll,
dt.dealType [Deal Type], 
ds.dealStatus [Deal Status],
ISNULL(od.[Original Deal Status], ds.dealStatus) [Original Deal Status],
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
sr.SignReason
FROM Shorthorn..cit_sh_deals d
left outer join [DB01].Salesforce.dbo.Contract c ON d.SFDC_ContractId = c.Id
left outer join [DB01].Salesforce.dbo.Account a ON c.AccountId = a.Id
left outer join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
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
WHERE d.signDate <> d.renewDate and cl.clientID is not null and d.clientID <> '79914' and cl.active = 1 and d.enabled = 1
) detail

ORDER BY [Company Name], [Sign Date]

DROP TABLE #SIC1
DROP TABLE #SIC2
DROP TABLE #SIC3
DROP TABLE #Starts
DROP TABLE #LastDate
DROP TABLE #StartDate
DROP TABLE #FirstChanges
DROP TABLE #OrigDeal
DROP TABLE #DealNumbers
DROP TABLE #SignReasons