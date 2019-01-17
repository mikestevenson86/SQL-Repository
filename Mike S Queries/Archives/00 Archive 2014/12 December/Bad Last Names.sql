SELECT l.Id, l.Name, u.Name
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE 
l.LastName like '%xx%' or l.LastName like '%l1%' or l.LastName like '%l2%' or l.LastName like '%l3%' or l.LastName like '%(hot%' or l.LastName like '%hot)%' or l.LastName like '%*%'
or l.LastName like '%!%' or l.LastName like '%£%' or l.LastName like '%$%' or l.LastName like '%^%' or l.LastName like '%(CQC)%'