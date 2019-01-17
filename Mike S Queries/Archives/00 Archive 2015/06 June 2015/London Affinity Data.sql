SELECT l.Id, o.Id, l.Company, l.Name, l.Position__c, l.Status, l.Suspended_Closed_Reason__c, l.Street, l.City, l.PostalCode, Phone, MobilePhone, Other_Phone__c, Email, Website, l.FT_Employees__c,
l.SIC2007_Code__c, l.SIC2007_Description__c, l.SIC2007_Code2__c, l.SIC2007_Description2__c, l.SIC2007_Code3__c, l.SIC2007_Description3__c
FROM Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
WHERE 
l.FT_Employees__c between 6 and 200 and
(
LEFT(PostalCode, 2) in ('N1', 'E8', 'E9', 'E3', 'W2', 'E2', 'E1',  'W1') or
LEFT(PostalCode, 3) in ('E14', 'SE8',  'SE5', 'Sw9', 'SW8', 'SW3', 'SW7',  'NW1', 'EC1', 'EC2','SW1', 'WC1', 'EC3', 'EC4', 'WC2') or
LEFT(PostalCode, 4) in ('SE10', 'Se14', 'Se15', 'SE16', 'SE17', 'SE11') 
) and
(o.StageName = 'Closed Lost' or (o.MADE_Criteria__c like 'Seminar%' and o.SAT_Date__c is not null and StageName <> 'Closed Won'))

SELECT l.Id, l.Name, c.Name, c.Position__c, l.BillingStreet, l.BillingCity, l.BillingPostalCode, l.Phone, MobilePhone, Other_Phone__c, Email, Website, l.FT_Employees__c,
l.SIC2007_Code__c, l.SIC2007_Description__c, l.SIC2007_Code2__c, l.SIC2007_Description2__c, l.SIC2007_Code3__c, l.SIC2007_Description3__c
FROM Salesforce..Account l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join Salesforce..Contact c ON l.Id = c.AccountId
WHERE 
l.FT_Employees__c between 6 and 200 and
(
LEFT(BillingPostalCode, 2) in ('N1', 'E8', 'E9', 'E3', 'W2', 'E2', 'E1',  'W1') or
LEFT(BillingPostalCode, 3) in ('E14', 'SE8',  'SE5', 'Sw9', 'SW8', 'SW3', 'SW7',  'NW1', 'EC1', 'EC2','SW1', 'WC1', 'EC3', 'EC4', 'WC2') or
LEFT(BillingPostalCode, 4) in ('SE10', 'Se14', 'Se15', 'SE16', 'SE17', 'SE11') 
) and
Type = 'Past Client'