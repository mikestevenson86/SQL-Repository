SELECT a.Id, Services_Taken_Long__c
FROM Salesforce..Account a
--inner join [database].CitationMain.dbo.citation_CompanyTable2 ct ON a.CitWeb_ID__c = ct.uid
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON a.Shorthorn_Id__c = cl.clientId
inner join [database].Shorthorn.dbo.cit_sh_busType bt ON cl.busType = bt.busTypeId
inner join [database].Shorthorn.dbo.cit_sh_businessSectors bs ON bt.businessSectorId = bs.Id
WHERE a.Citation_Client__c = 'true' and Services_Taken_Long__c = 'Employment Law & HR / Health & Safety' and bs.title in ('Care','Dentists')