SELECT 
a.Id,
a.Name,
BillingStreet + ' ' + BillingCity [Address],
BillingPostalCode,
a.Phone,
Email
FROM
Salesforce..Account a
inner join Salesforce..Contact c ON a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
WHERE
Type = 'Client' and
(
BillingPostalCode like 'AB%' or
BillingPostalCode like 'DD%' or
BillingPostalCode like 'DG%' or
BillingPostalCode like 'EH%' or
BillingPostalCode like 'FK%' or
BillingPostalCode like 'G1%' or
BillingPostalCode like 'G2%' or
BillingPostalCode like 'G3%' or
BillingPostalCode like 'G4%' or
BillingPostalCode like 'G5%' or
BillingPostalCode like 'G6%' or
BillingPostalCode like 'G7%' or
BillingPostalCode like 'G8%' or
BillingPostalCode like 'G9%' or
BillingPostalCode like 'IV1 %' or
BillingPostalCode like 'IV2 %' or
BillingPostalCode like 'IV3 %' or
BillingPostalCode like 'IV12%' or
BillingPostalCode like 'IV36%' or
BillingPostalCode like 'IV30%' or
BillingPostalCode like 'IV32%' or
BillingPostalCode like 'IV7 %' or
BillingPostalCode like 'IV31%' or
BillingPostalCode like 'KA%' or
BillingPostalCode like 'KY%' or
BillingPostalCode like 'ML%' or
BillingPostalCode like 'PA1 %' or
BillingPostalCode like 'PA2 %' or
BillingPostalCode like 'PA3 %' or
BillingPostalCode like 'PA4 %' or
BillingPostalCode like 'PA5 %' or
BillingPostalCode like 'PA6 %' or
BillingPostalCode like 'PA7 %' or
BillingPostalCode like 'PA8 %' or
BillingPostalCode like 'PA9 %' or
BillingPostalCode like 'PA10%' or
BillingPostalCode like 'PA11%' or
BillingPostalCode like 'PA12%' or
BillingPostalCode like 'PA13%' or
BillingPostalCode like 'PA14%' or
BillingPostalCode like 'PA15%' or
BillingPostalCode like 'PA16%' or
BillingPostalCode like 'PA17%' or
BillingPostalCode like 'PA18%' or
BillingPostalCode like 'PA19%' or
BillingPostalCode like 'PH%' or
BillingPostalCode like 'TD%')