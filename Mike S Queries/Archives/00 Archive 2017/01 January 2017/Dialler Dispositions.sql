SELECT uMan.Name Manager, u.Name, l.Id, act_date, act_time, ad.description
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join SalesforceReporting..addistats ad ON ch.appl = ad.pappl
												and ch.addi_status = ad.addistatus
												and pappl = 'CLD1'
inner join Salesforce..[User] u ON l.BDC__c = u.Id
inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
WHERE act_date between '2017-01-01' and CONVERT(date, GETDATE()) and call_type in (0,2)
ORDER BY Manager, Name, Id, act_date, act_time