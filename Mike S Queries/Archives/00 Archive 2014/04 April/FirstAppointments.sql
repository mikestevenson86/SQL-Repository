SELECT 
op.AccountId Account, 
'https://login.salesforce.com/' + op.AccountID Link, 
op.Name Company,
CONVERT(varchar(10),op.DateMade__c,103) [Date Made],
CONVERT(varchar(10),op.Original_1st_Visit_Date__c,103) [First Appointment Date],
l.SIC2007_Description__c [SIC Industry],
l.CitationSector__c Sector,
op.StageName Stage,
op.MADE_Criteria__c [Made Criteria],
bdc.Name BDC,
u2.Name [Opportunity Creator],
u.Name BDM,
mu.Name [BDM Manager],
a.Total_Employees__c Employees

FROM Opportunity op
inner join Lead l on op.Id = l.ConvertedOpportunityId
inner join Account a on op.AccountId = a.Id
left join [User] u on op.OwnerId = u.id
left join [User] mu on u.ManagerId = mu.id
left join [User] bdc on op.BDC__c = bdc.Id
left join [User] u2 on op.CreatedById = u2.id

WHERE DATEPART(week, op.Original_1st_Visit_Date__c) = DATEPART(week, GETDATE())

ORDER BY op.Original_1st_Visit_Date__c, company