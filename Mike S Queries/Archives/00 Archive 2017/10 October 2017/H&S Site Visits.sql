SELECT sv.Id, u.Name, sv.VisitDate__c, sv.VisitNumber__c, a.Name + ' (' + s.PostCode__c + ')' SiteName, ROW_NUMBER () OVER (PARTITION BY u.Name, sv.VisitDate__c ORDER BY (SELECT NULL)) VisitForDay
FROM Salesforce..SiteVisit__c sv
inner join Salesforce..[User] u ON sv.Consultant__c = u.Id and u.IsActive = 'true'
inner join Salesforce..Account a ON sv.Account__c = a.Id
inner join Salesforce..Site__c s ON sv.AccountSite__c = s.Id
WHERE sv.TypeOfVisit__c = 'H&S' and YEAR(VisitDate__c) = YEAR(GETDATE())
ORDER BY u.Name, sv.VisitDate__c

SELECT * 
FROM [database].shorthorn.dbo.cit_sh_dealsHS dhs 
inner join [database].shorthorn.dbo.cit_sh_users u ON dhs.secConsul = u.userID 
WHERE SecVisit = '2017-10-05' and u.FullName = 'Aaron Saunders'

SELECT Id
FROM
(
	SELECT Id, Consultant__c, AccountSite__c, VisitDate__c, VisitNumber__c, ROW_NUMBER () OVER (PARTITION BY sv.Consultant__c, sv.VisitDate__c, sv.AccountSite__c, sv.VisitNumber__c ORDER BY sv.CreatedDate) rn
	FROM Salesforce..SiteVisit__c sv
) detail
WHERE rn >= 2