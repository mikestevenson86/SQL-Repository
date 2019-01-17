SELECT *
INTO #CH
FROM SalesforceReporting..call_history
where seqno >= 2254312 and lm_filler2 is not null

SELECT ISNULL(ISNULL(ISNULL(ISNULL(ISNULL(u.Name, g.Name), u2.Name), g2.Name), u3.Name), g3.Name) [Owner] ,ch.*
FROM #CH ch
left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id,15) collate latin1_general_CS_AS
left outer join Salesforce..[User] u ON l.OwnerId = u.Id
left outer join Salesforce..[Group] g ON l.OwnerId = g.Id
left outer join Salesforce..Account a ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(a.Id,15) collate latin1_general_CS_AS
left outer join Salesforce..[User] u2 ON a.OwnerId = u2.Id
left outer join Salesforce..[Group] g2 ON a.OwnerId = g2.Id
left outer join Salesforce..Contact c ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(c.Id,15) collate latin1_general_CS_AS
left outer join Salesforce..[User] u3 ON c.OwnerId = u3.Id
left outer join Salesforce..[Group] g3 ON c.OwnerId = g3.Id

DROP TABLE #CH