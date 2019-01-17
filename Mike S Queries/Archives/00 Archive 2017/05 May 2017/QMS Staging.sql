SELECT Id, MAX(QMSId) QMSID
INTO #Temp
FROM SalesforceReporting..QMS_Staging qs
GROUP BY Id

SELECT 
l.Id, 
qms.Company, 
qms.Add_1 + ' ' + qms.Add_2 + ' ' + qms.Add_3 Street, 
Postal_Code1 PostalCode, 
client_company_registration Co_Reg__c,
REPLACE(case when Phone1A like '0%' then Phone1A else '0'+Phone1A end,' ','') Phone,
REPLACE(case when Phone1B like '0%' then Phone1B else '0'+Phone1B end,' ','') MobilePhone,
qms.Email,
qms.sf_ID_account Previous_Account_Id__c,
l.Status,
rt.Name,
'012D0000000KJv8IAG' RecordTypeId,
'Cross Sell - QMS' LeadSource,
'NEW_QMS_May17' Source__c,
ROW_NUMBER () OVER (PARTITION BY qms.QMSId ORDER BY l.Id) rn

FROM #Temp t
inner join Salesforce..Lead l ON t.Id = l.Id
inner join SalesforceReporting..QMS_Accounts_May2017 qms ON t.QMSID = qms.QMSId
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id

WHERE
rt.Name not in ('Citation Winback Client','Citation Employee Referral Record')
and
Status in ('Open','Closed','Suspended')

DROP TABLE #Temp