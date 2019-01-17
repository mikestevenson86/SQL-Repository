begin transaction

UPDATE NobleCustomTables.dbo.cust_citation
SET listid = 12009
FROM NobleCustomTables.dbo.cust_citation c
inner join Salesforce.dbo.Lead l on c.sfdc_id = l.Id
WHERE l.Affinity_Industry_Type__c = 'dentists' and c.listid <> 12009

--commit
--rollback