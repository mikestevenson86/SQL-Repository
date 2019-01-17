SELECT a.Id
FROM SalesforceReporting..CQCPro_October2017 cqc
left outer join Salesforce..Account a ON LEFT(cqc.Id, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
left outer join Salesforce..Contract c ON a.Current_Contract__c = c.Id
WHERE c.Id is null
ORDER BY a.Id