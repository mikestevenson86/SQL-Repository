SELECT a.Id, Shorthorn_Id__c, u.fullname
FROM Salesforce..Account a
inner join [database].shorthorn.dbo.cit_sh_deals d ON a.Shorthorn_Id__c = d.clientId and d.renewDate > GETDATE() and d.dealStatus not in (2,5,10,18)
inner join [database].shorthorn.dbo.cit_sh_users u ON d.SalesRep = u.UserId
inner join Salesforce..[User] us ON REPLACE(REPLACE(u.fullname,' ',''),CHAR(39),'') = REPLACE(REPLACE(us.Name,' ',''),CHAR(39),'')
WHERE Shorthorn_Id__c is not null and LEFT(a.Id, 15) collate latin1_general_CS_AS in
(
SELECT ACcountId
FROM SalesforceReporting..AccountOwners
)