SELECT l.Id, 'Open' [Status], '' Suspended_Closed_Reason__c, '' Callback_Date_Time__c, '' BDC__c, '' Rating
FROM Salesforce..LeadHistory lh
inner join Salesforce..Lead l ON lh.LeadId collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join Salesforce..[User] u ON l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE 
lh.Field = 'Status'
and lh.NewValue = 'Callback Requested'
and CONVERT(date, lh.CreatedDate) between '2014-10-08' and '2014-10-20' 
and l.[Status] = 'Callback Requested' 
and l.PostalCode like 'NE%' 
and u.Name in ('Ian Gardener','Mel Bailey','Pamela Wilkinson','Lynn Colton','Emma Stewart','Alan Buckley','Derek Day','John Perry')