SELECT AccountId, contact1 Name, 
REPLACE(case when phone1 like '0%' then phone1 else '0'+phone1 end,' ','') Phone, email1 Email, 
address_1 + ' ' + address_2 MailingStreet, address_3 + ' ' + address_4 MailingCity, postcode MailingPostalCode
FROM SalesforceReporting..NATBSClients
WHERE contact1 <> ''
UNION
SELECT AccountId, contact2 Name, 
case when phone2 = '' then REPLACE(case when phone1 like '0%' then phone1 else '0'+phone1 end,' ','') else REPLACE(case when phone2 like '0%' then phone2 else '0'+phone2 end,' ','') end Phone, case when email2 = '' then email1 else email2 end Email, 
address_1 + ' ' + address_2 MailingStreet, address_3 + ' ' + address_4 MailingCity, postcode MailingPostalCode
FROM SalesforceReporting..NATBSClients
WHERE contact2 <> ''