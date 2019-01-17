SELECT 
Id Account_External_Id__c,
client_name Name,
address_1 + ' ' + address_2 BillingStreet,
address_3 + ' ' + address_4 BillingCity,
postcode BillingPostalCode,
REPLACE(case when phone1 like '0%' then phone1 else '0'+phone1 end,' ','') Phone,
notes Notes__c,
case when client_status = 'Active' then 'Client' when client_status = 'On Hold' then 'Pending Client' when client_status = 'Cancelled' then 'Past Client' end Type,
staff_no FT_Employees__c,
sage_code Sage_Id__c
FROM SalesforceReporting..NATBSClients
WHERE AccountId is null and phone1 <> ''