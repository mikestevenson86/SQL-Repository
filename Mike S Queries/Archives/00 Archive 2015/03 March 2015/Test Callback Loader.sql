SELECT 
CONVERT(VarChar,Callback_Date_Time__c, 103) CB_Date, 
LEFT(CONVERT(VarChar, Callback_Date_Time__c, 108),2)+LEFT(RIGHT(CONVERT(VarChar, Callback_Date_Time__c, 108),5),2) CB_Time, 
u.DiallerFK__c CB_TSR, 
l.Id SFDC_Id, 
l.Phone CB_phone

FROM 
Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
left outer join Salesforce..[User] u2 ON l.OwnerId = u2.Id

WHERE 
Status = 'Callback Requested' 
and 
uMan.Name in ('Andrae Leon','Richard Clough')
and
CONVERT(date, Callback_Date_Time__c) = '2015-03-24'
and
u.Name not in ('Caroline Ryder-huf','Daniel Bond')
and
(RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null)