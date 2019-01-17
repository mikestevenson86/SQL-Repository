SELECT act_date, seqno, l.Data_Supplier__c, l.Source__c, case when l.Date_Made__c is not null then l.Id else '' end MadeLead
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
WHERE call_type in (0,2,4) and act_date between '2017-01-01' and '2017-01-31'