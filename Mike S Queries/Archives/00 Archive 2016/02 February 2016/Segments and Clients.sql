SELECT a.s__c [Segment], a.CitationSector__c [Citation Sector], clientId [Shorthorn ID], cl.companyName Company, totEmployees [Employee Numbers]
FROM Shorthorn..cit_sh_clients cl
inner join [db01].salesforce.dbo.account a ON cl.clientID = a.Shorthorn_Id__c
WHERE a.IsActive__c = 'true' and s__c is not null
ORDER BY 
case when s__C = 'Bronze' then 1 
when s__C = 'Silver' then 2 
when s__C = 'Gold' then 3 
when s__C = 'Gold+' then 4 else 5 end, [Citation Sector]