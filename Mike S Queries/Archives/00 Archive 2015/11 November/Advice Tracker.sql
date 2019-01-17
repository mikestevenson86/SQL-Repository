SELECT u.FullName Advisor, em.fName + ' ' + em.sName [Contact Name], cl.companyName [Company Name], s.postcode [Site Postcode],
case when cl.vip = 0 then 'No' else 'Yes' end VIP, 
a.s__c Segment,
CASE WHEN ad.adviceTypeID = 1 THEN 'Incoming Call'
WHEN ad.adviceTypeID = 2 THEN 'Outgoing Call'
WHEN ad.adviceTypeID = 3 THEN 'Email'
WHEN ad.adviceTypeID = 4 THEN 'CallBack Message'
WHEN ad.adviceTypeID = 5 THEN 'Internal Note'
WHEN ad.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type],
CONVERT(date, ad.dateOfCall) [Call Date], CONVERT(time, ad.dateOfCall) [Call Start], CONVERT(time, ad.endOfCall) [Call End],
case when DATEDIFF(SECOND, ad.dateOfCall, ad.endOfCall)-(DATEDIFF(N,ad.dateOfCall, ad.endOfCall)*60) < 0 then
CONVERT(varchar, DATEDIFF(n, ad.dateOfCall, ad.endOfCall)-1) + ' minutes ' +
CONVERT(varchar, DATEDIFF(SECOND, ad.dateOfCall, ad.endOfCall)-(DATEDIFF(N,ad.dateOfCall, ad.endOfCall)*60)+60) + ' seconds' else 
CONVERT(varchar, DATEDIFF(n, ad.dateOfCall, ad.endOfCall)) + ' minutes ' + 
CONVERT(varchar, DATEDIFF(SECOND, ad.dateOfCall, ad.endOfCall)-(DATEDIFF(N,ad.dateOfCall, ad.endOfCall)*60)) + ' seconds' end Duration
FROM Shorthorn..cit_sh_advice ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID
inner join Shorthorn..cit_sh_employees em ON ad.empID = em.empID
inner join Shorthorn..cit_sh_sites s ON em.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
left outer join [DB01].Salesforce.dbo.Account a ON cl.clientId = a.Shorthorn_Id__c
WHERE u.FullName = 'Linda Thornton' and dateOfCall > '2016-03-23'

SELECT u.FullName Advisor, em.fName + ' ' + em.sName [Contact Name], cl.companyName [Company Name], s.postcode [Site Postcode],
case when cl.vip = 0 then 'No' else 'Yes' end VIP, 
a.s__c Segment,
CASE WHEN ad.adviceTypeID = 1 THEN 'Incoming Call'
WHEN ad.adviceTypeID = 2 THEN 'Outgoing Call'
WHEN ad.adviceTypeID = 3 THEN 'Email'
WHEN ad.adviceTypeID = 4 THEN 'CallBack Message'
WHEN ad.adviceTypeID = 5 THEN 'Internal Note'
WHEN ad.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type], 
CONVERT(date, ad.dateOfCall) [Call Date], CONVERT(time, ad.dateOfCall) [Call Start], CONVERT(time, ad.endOfCall) [Call End],
case when DATEDIFF(SECOND, ad.dateOfCall, ad.endOfCall)-(DATEDIFF(N,ad.dateOfCall, ad.endOfCall)*60) < 0 then
CONVERT(varchar, DATEDIFF(n, ad.dateOfCall, ad.endOfCall)-1) + ' minutes ' +
CONVERT(varchar, DATEDIFF(SECOND, ad.dateOfCall, ad.endOfCall)-(DATEDIFF(N,ad.dateOfCall, ad.endOfCall)*60)+60) + ' seconds' else 
CONVERT(varchar, DATEDIFF(n, ad.dateOfCall, ad.endOfCall)) + ' minutes ' + 
CONVERT(varchar, DATEDIFF(SECOND, ad.dateOfCall, ad.endOfCall)-(DATEDIFF(N,ad.dateOfCall, ad.endOfCall)*60)) + ' seconds' end Duration
FROM Shorthorn..cit_sh_advice ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID
inner join Shorthorn..cit_sh_employees em ON ad.empID = em.empID
inner join Shorthorn..cit_sh_sites s ON em.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
left outer join [DB01].Salesforce.dbo.Account a ON cl.clientId = a.Shorthorn_Id__c
left outer join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.dealID and ds.signDate < ad.dateOfCall and ds.renewDate > ad.dateOfCall
WHERE u.FullName = 'Isobel  Washington' and dateOfCall > '2016-03-23'