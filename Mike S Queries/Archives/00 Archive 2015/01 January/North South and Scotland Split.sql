SELECT
case when (ur.Name = 'BDM North' and u.Name not in ('William McFaulds','John McCaffrey')) or u.Name = 'BDM/BDC' then 'North' when ur.Name = 'BDM South' then 'South'
when u.Name in ('William McFaulds','John McCaffrey') then 'Scotland' else 'Uncovered' end Region,
af.Sector,
COUNT(l.Id) [Open Prospects]
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
inner join Salesforce..UserRole ur ON u.userRoleId = ur.Id
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE Affinity_Cold__c like 'Affinity%' and Status = 'open'
GROUP BY
case when (ur.Name = 'BDM North' and u.Name not in ('William McFaulds','John McCaffrey')) or u.Name = 'BDM/BDC' then 'North' when ur.Name = 'BDM South' then 'South'
when u.Name in ('William McFaulds','John McCaffrey') then 'Scotland' else 'Uncovered' end,
af.Sector
ORDER BY Region, af.Sector