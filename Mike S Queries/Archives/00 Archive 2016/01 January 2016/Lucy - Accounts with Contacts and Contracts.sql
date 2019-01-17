SELECT 
a.Id AccountID, 
a.Name AccountName, 
S__c Segmentation, 
con.Id ContactID, 
FirstName, 
LastName, 
a.BillingStreet AccountStreet, 
a.BillingCity AccountCity, 
a.BillingState AccountCounty, 
a.BillingPostalCode AccountPostCode,
con.Email ContactEmail, 
a.Phone AccountPhone,
IsActive__c IsActive,
HasOptedOutOfEmail EmailOptOut,
Online_Super_User__c OnlineSuperUser,
CitationSector__c CitationSector,
FT_Employees__c FTE,
c.Renewal_Date__c RenewalDate
FROM 
Salesforce..Account a
left outer join Salesforce..Contact con ON a.Id = con.AccountId
left outer join Salesforce..Contract c ON a.Id = c.AccountId
WHERE 
IsActive__c = 'true' 
and HasOptedOutOfEmail <> 'true' 
and Online_Super_User__c = 'yes' 
and CitationSector__c in ('ADMINISTRATIVE AND SUPPORT SERVICE ACTIVITIES','CLEANING','MANUFACTURING','RETAIL EXCLUDING MOTOR') 
and S__c <> 'Gold+' 
and FT_Employees__c <= 30 
and c.Renewal_Date__c > DATEADD(month,9,GETDATE())