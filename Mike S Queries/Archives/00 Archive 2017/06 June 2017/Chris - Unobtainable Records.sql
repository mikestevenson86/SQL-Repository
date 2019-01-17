SELECT AM_Id, ISNULL(l.Id, c.Id) Id, ISNULL(l.Status, 'Contact') [Status]
FROM SalesforceReporting..AnswerMachines_20170629 am
left outer join Salesforce..Lead l ON LEFT(CONVERT(VarChar,am.AM_Id), 15) collate latin1_general_CS_AS = LEFT(CONVERT(VarChar,l.ID), 15) collate latin1_general_CS_AS
left outer join Salesforce..Contact c ON LEFT(CONVERT(VarChar,am.AM_Id), 15) collate latin1_general_CS_AS = LEFT(CONVERT(VarChar,c.Id), 15) collate latin1_general_CS_AS

SELECT NA_Id, ISNULL(l.Id, c.Id) Id, ISNULL(l.Status, 'Contact') [Status]
FROM SalesforceReporting..NoAnswer_20170629 am
left outer join Salesforce..Lead l ON LEFT(CONVERT(VarChar,am.NA_Id), 15) collate latin1_general_CS_AS = LEFT(CONVERT(VarChar,l.ID), 15) collate latin1_general_CS_AS
left outer join Salesforce..Contact c ON LEFT(CONVERT(VarChar,am.NA_Id), 15) collate latin1_general_CS_AS = LEFT(CONVERT(VarChar,c.Id), 15) collate latin1_general_CS_AS

SELECT D_Id, ISNULL(l.Id, c.Id) Id, ISNULL(l.Status, 'Contact') [Status]
FROM SalesforceReporting..Disconnects_20170629 am
left outer join Salesforce..Lead l ON LEFT(CONVERT(VarChar,am.D_Id), 15) collate latin1_general_CS_AS = LEFT(CONVERT(VarChar,l.ID), 15) collate latin1_general_CS_AS
left outer join Salesforce..Contact c ON LEFT(CONVERT(VarChar,am.D_Id), 15) collate latin1_general_CS_AS = LEFT(CONVERT(VarChar,c.Id), 15) collate latin1_general_CS_AS