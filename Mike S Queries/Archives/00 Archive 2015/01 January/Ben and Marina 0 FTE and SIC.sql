SELECT CONVERT(int,COUNT(l.Id)*0.075) BWProspects
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
WHERE u.Name = 'Ben Williams' and l.Affinity_Cold__c = 'Cold' and ((l.FT_Employees__c is null or l.FT_Employees__c = 0) or
(l.SIC2007_Code3__c is null or l.SIC2007_Code3__c = 0)) and Status = 'open'
and
LEFT(l.PostalCode,4) not in ('EX31','EX33','EX34','EX35','EX39')
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
and l.Area_Code__c not in ('KW','BT','SA','LD','TR','PL')
and
(l.Phone <> '' or l.Phone is not null)
		
SELECT CONVERT(int,COUNT(l.Id)*0.075) MAProspects
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
WHERE u.Name = 'Marina Ashman' and l.Affinity_Cold__c = 'Cold' and ((l.FT_Employees__c is null or l.FT_Employees__c = 0) or
(l.SIC2007_Code3__c is null or l.SIC2007_Code3__c = 0)) and Status = 'open'
and
LEFT(l.PostalCode,4) not in ('EX31','EX33','EX34','EX35','EX39')
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
and l.Area_Code__c not in ('KW','BT','SA','LD','TR','PL')
and
(l.Phone <> '' or l.Phone is not null)
		
SELECT TOP 381 l.Id
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
WHERE u.Name = 'Ben Williams' and l.Affinity_Cold__c = 'Cold' and ((l.FT_Employees__c is null or l.FT_Employees__c = 0) or
(l.SIC2007_Code3__c is null or l.SIC2007_Code3__c = 0)) and Status = 'open'
and
LEFT(l.PostalCode,4) not in ('EX31','EX33','EX34','EX35','EX39')
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
and l.Area_Code__c not in ('KW','BT','SA','LD','TR','PL')
and
(l.Phone <> '' or l.Phone is not null)

SELECT TOP 257 l.Id
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
WHERE u.Name = 'Marina Ashman' and l.Affinity_Cold__c = 'Cold' and ((l.FT_Employees__c is null or l.FT_Employees__c = 0) or
(l.SIC2007_Code3__c is null or l.SIC2007_Code3__c = 0)) and Status = 'open'
and
LEFT(l.PostalCode,4) not in ('EX31','EX33','EX34','EX35','EX39')
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
and l.Area_Code__c not in ('KW','BT','SA','LD','TR','PL')
and
(l.Phone <> '' or l.Phone is not null)