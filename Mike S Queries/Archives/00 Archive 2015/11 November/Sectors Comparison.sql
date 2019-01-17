SELECT sh.clientId, sh.companyName, a.CitationSector__c, a.Name, bs.title
FROM [database].shorthorn.dbo.cit_sh_clients sh
inner join Salesforce..Account a ON LEFT(sh.SFDC_AccountId, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
left outer join [database].shorthorn.dbo.cit_sh_busType bt ON sh.busType = bt.busTypeId
left outer join [database].shorthorn.dbo.cit_sh_businessSectors bs ON bt.BusinessSectorID = bs.Id