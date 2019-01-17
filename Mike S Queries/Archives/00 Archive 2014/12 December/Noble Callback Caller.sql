SELECT 
CONVERT(VarChar,Callback_Date_Time__c, 103) CB_Date, 
LEFT(CONVERT(VarChar, Callback_Date_Time__c, 108),2)+LEFT(RIGHT(CONVERT(VarChar, Callback_Date_Time__c, 108),5),2) CB_Time, 
u.DiallerFK__c CB_TSR, 
l.Id SFDC_Id, 
l.Phone CB_phone

FROM 
Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id

WHERE 
Status = 'Callback Requested' 
and 
BDC__c is not null 
and 
u.Department = 'Telemarketing'