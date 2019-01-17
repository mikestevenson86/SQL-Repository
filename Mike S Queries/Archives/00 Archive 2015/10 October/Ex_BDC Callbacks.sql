SELECT l.Id,
'Open' Status,
'' Suspended_Closed_Reason__c,
'' Callback_Date_Time__c,
'' BDC__c,
'' Rating
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE Status = 'callback requested' and (u.IsActive = 'false' or u.Name is null)