SELECT AccountId, client_name + ' 9001' Name, sage_code sage_Id__c, 
case when [sales_source_9] = 1 then 'E-mail in'
when [sales_source_9] = 2 then 'Call in' 
when [sales_source_9] = 3 then 'Client Referral'
when [sales_source_9] = 4 then 'Consultant Referral'
when [sales_source_9] = 5 then 'Outbound Sales Call' end Description, 
'true' X9001__c,
[9_date_signed] StartDate, [9_End_Date] EndDate, cert_fee Cert_Fee__c, audit_fee Audit_Fee__c,
case when [9_status] = 'Pending' then 'Pending Start' when [9_Status] = 'Current' then 'Active' when [9_status] = 'Out Of Date' then 'Expired' end Status,
'012D0000000Nav7IAC' RecordTypeId
FROM SalesforceReporting..NATBSClients
WHERE [9001] <> 0

SELECT AccountId, client_name + ' 14001' Name, sage_code sage_Id__c, 
case when [sales_source_14] = 1 then 'E-mail in'
when [sales_source_14] = 2 then 'Call in' 
when [sales_source_14] = 3 then 'Client Referral'
when [sales_source_14] = 4 then 'Consultant Referral'
when [sales_source_14] = 5 then 'Outbound Sales Call' end Description, 
'true' X14001__c,
[14_start_date] StartDate, [14_End_Date] EndDate, cert_fee_14 Cert_Fee__c, au_fee_14 Audit_Fee__c,
case when [14_status] = 'Pending' then 'Pending Start' when [14_Status] = 'Current' then 'Active' when [14_status] = 'Out Of Date' then 'Expired' end Status,
'012D0000000Nav7IAC' RecordTypeId
FROM SalesforceReporting..NATBSClients
WHERE [14001] <> 0

SELECT AccountId, client_name + ' 18001' Name, sage_code sage_Id__c, 
case when [sales_source_18] = 1 then 'E-mail in'
when [sales_source_18] = 2 then 'Call in' 
when [sales_source_18] = 3 then 'Client Referral'
when [sales_source_18] = 4 then 'Consultant Referral'
when [sales_source_18] = 5 then 'Outbound Sales Call' end Description, 
'true' X18001__c,
[18_start_date] StartDate, [18_End_Date] EndDate, cert_fee_18 Cert_Fee__c, au_fee_18 Audit_Fee__c,
case when [18_status] = 'Pending' then 'Pending Start' when [18_Status] = 'Current' then 'Active' when [18_status] = 'Out Of Date' then 'Expired' end Status,
'012D0000000Nav7IAC' RecordTypeId
FROM SalesforceReporting..NATBSClients
WHERE [18001] <> 0

SELECT AccountId, client_name + ' 27001' Name, sage_code sage_Id__c, 
case when [sales_source_27] = 1 then 'E-mail in'
when [sales_source_27] = 2 then 'Call in' 
when [sales_source_27] = 3 then 'Client Referral'
when [sales_source_27] = 4 then 'Consultant Referral'
when [sales_source_27] = 5 then 'Outbound Sales Call' end Description, 
[27_start_date] StartDate, [27_End_Date] EndDate, cert_fee_27 Cert_Fee__c, au_fee_27 Audit_Fee__c,
case when [27_status] = 'Pending' then 'Pending Start' when [27_Status] = 'Current' then 'Active' when [27_status] = 'Out Of Date' then 'Expired' end Status,
'012D0000000Nav7IAC' RecordTypeId
FROM SalesforceReporting..NATBSClients
WHERE [27001] <> 0 or [27_Start_date] <> ''