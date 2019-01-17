SELECT c.Id
FROM SalesforceReporting..[Delete - Old Contacts - 27-06-2016] d
inner join Salesforce..Contact c ON d.[Account Id] = c.AccountId and d.[Contact Name] = c.Name

SELECT c.Id, 
REPLACE(u.[Contact Name],'"',''), 
u.Email,
u.Phone, 
u.MobilePhone, 
u.OtherPhone, 
REPLACE(u.Position,'"',''),  
u.[Post Code], 
REPLACE(u.Street,'"',''), 
REPLACE(u. City,'"','')
FROM SalesforceReporting..[Update - Contact Changes - 27-06-2016] u
inner join Salesforce..Contact c ON u.[Account Id] = c.AccountId and u.[Contact Name] = c.Name