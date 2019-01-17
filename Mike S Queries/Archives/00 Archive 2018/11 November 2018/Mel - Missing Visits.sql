SELECT 
mv.CompanyName, 
cl.clientID [Shorthorn ID], 
cl.SFDC_AccountId [Shorthorn SFDC ID], 
a.Shorthorn_Id__c [SFDC Shorthorn ID], 
a.Id [SFDC ID], 
sv.Id [SFDC Site Visit ID], 
mv.VisitDate [Shorthorn Visit Date], 
sv.VisitDate__c [SFDC Visit Date], 
mv.VisitType [Shorthorn Visit Type], 
sv.VisitNumber__c [SFDC Visit Type],
svh.Error,
svh.DateAdded

FROM 
SalesforceReporting..MissingVisits mv
left outer join [database].shorthorn.dbo.cit_sh_clients cl ON mv.CompanyName = cl.companyName
left outer join Salesforce..Account a ON cl.clientID = a.Shorthorn_Id__c or cl.SFDC_AccountID = a.Id
left outer join Salesforce..SiteVisit__c sv ON a.Id = sv.Account__c
											and mv.VisitDate = sv.VisitDate__c
											and case when mv.VisitType = 'Installed' then 'Install'
											when mv.VisitType = 'Renewal Reviewed' then 'Renewal'
											when mv.VisitType = 'First Visit Sat' then 'First' end
											=
											case when sv.VisitNumber__c like '%Install%' then 'Install'
											when sv.VisitNumber__c like '%Renewal%' then 'Renewal'
											when sv.VisitNumber__c = '1st Visit' then 'First' end
											and sv.TypeOfVisit__c = 'PEL'
left outer join SalesforceReporting..SiteVisitHistory svh ON a.Id = svh.Account__c
																and mv.VisitDate = svh.VisitDate__c
																and case when mv.VisitType = 'Installed' then 'Install'
																when mv.VisitType = 'Renewal Reviewed' then 'Renewal'
																when mv.VisitType = 'First Visit Sat' then 'First' end
																=
																case when svh.VisitNumber__c like '%Install%' then 'Install'
																when svh.VisitNumber__c like '%Renewal%' then 'Renewal'
																when svh.VisitNumber__c = '1st Visit' then 'First' end
																and svh.TypeOfVisit__c = 'PEL'
WHERE 
a.Id is not null

GROUP BY
mv.CompanyName, 
cl.clientID, 
cl.SFDC_AccountId, 
a.Shorthorn_Id__c, 
a.Id, 
sv.Id, 
mv.VisitDate, 
sv.VisitDate__c, 
mv.VisitType, 
sv.VisitNumber__c,
svh.Error,
svh.DateAdded