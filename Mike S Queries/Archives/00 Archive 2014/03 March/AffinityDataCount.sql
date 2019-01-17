SELECT l.Affinity_Industry_Type__c as [salesforce affinity name], c.citationSector__C [Noble Sector],c.listid [Noble List ID],COUNT(l.Id)[count]
FROM Salesforce.dbo.Lead l with(nolock)
inner join noblecustomtables.dbo.cust_citation c with(nolock) ON l.Id = c.sfdc_id
WHERE l.[Status]='open' and l.Affinity_Cold__c like 'Affinity%' and l.Affinity_Industry_Type__c in ('dentists','freight industry','Pharmacy','BICS Member','Horticulture','GGF','Security','Education','Vets','NAFD','UBT','SatNoDeal')
GROUP BY l.Affinity_industry_Type__C, c.citationSector__C, c.listid
ORDER BY listid