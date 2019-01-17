SELECT
u.Name BDM, 
l.ID SFDC_Id, 
Company CompanyName, 
l.Name ContactName, 
l.Street + ' ' + l.City Address1, 
l.PostalCode, 
l.Phone,
l.MobilePhone,
l.Email,
SIC2007_Code__c [SIC Code Level 1], 
SIC2007_Description__c [SIC Code Level 1 Description], 
SIC2007_Code2__c [SIC Code Level 2], 
SIC2007_Description2__c [SIC Code Level 2 Description], 
SIC2007_Code3__c [SIC Code Level 3], 
SIC2007_Description3__c [SIC Code Level 3 Description],
FT_Employees__c [FT Employees],
Status,
Suspended_Closed_Reason__c [Suspended/Closed Reason]

FROM 
Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS

WHERE 
[Status] in ('Closed','Suspended') 
and 
Affinity_Cold__c = 'Cold' 
and 
FT_Employees__c between 6 and 225

ORDER BY
BDM