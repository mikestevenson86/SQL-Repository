IF OBJECT_ID ('SalesforceReporting..Sage_SFDC_SageContractNumber') IS NOT NULL
	BEGIN
		DROP TABLE #One
	END
IF OBJECT_ID ('SalesforceReporting..Sage_SFDC_SignDate') IS NOT NULL
	BEGIN
		DROP TABLE #Two
	END
IF OBJECT_ID ('SalesforceReporting..Sage_SFDC_CustomerSignDate') IS NOT NULL
	BEGIN
		DROP TABLE #Thr
	END
IF OBJECT_ID ('SalesforceReporting..Sage_SFDC_CompanySignDate') IS NOT NULL
	BEGIN
		DROP TABLE #Four
	END
IF OBJECT_ID ('SalesforceReporting..Sage_SFDC_FortnightStartDate') IS NOT NULL
	BEGIN
		DROP TABLE #Five
	END
IF OBJECT_ID ('SalesforceReporting..Sage_SFDC_FortnightSignDate') IS NOT NULL
	BEGIN
		DROP TABLE #Six
	END

SELECT c.*, sfc.Id, sfc.AccountId
INTO SalesforceReporting..Sage_SFDC_SageContractNumber
FROM SalesforceReporting..CIT001Contract c
inner join Salesforce..Contract sfc ON c.ContractNo = sfc.Sage_Contract_Number__c
WHERE c.SFDCContractNumber = ''

SELECT sfc.Id, c.CIT001ContractID, c.Duration, c.Signed, sfc.StartDate, sfc.AccountId, c.Value
INTO SalesforceReporting..Sage_SFDC_SignDate
FROM SalesforceReporting..CIT001Contract c
left outer join SalesforceReporting..SLCustomerAccount ca ON c.CustomerID = ca.SLCustomerAccountID
left outer join SalesforceReporting..Sage_SFDC_SageContractNumber one ON c.CIT001ContractID = one.CIT001ContractID
left outer join Salesforce..Account a ON ca.CustomerAccountNumber = a.Sage_Id__c
left outer join Salesforce..Contract sfc ON a.Id = sfc.AccountId and c.Signed = sfc.StartDate
WHERE c.SFDCContractNumber = '' 
and one.CIT001ContractID is null 
and sfc.Id is not null

SELECT sfc.Id, c.CIT001ContractID, c.Duration, c.Signed, c.Value, sfc.StartDate, sfc.AccountId
INTO SalesforceReporting..Sage_SFDC_CustomerSignDate
FROM SalesforceReporting..CIT001Contract c
left outer join SalesforceReporting..SLCustomerAccount ca ON c.CustomerID = ca.SLCustomerAccountID
left outer join SalesforceReporting..Sage_SFDC_SageContractNumber one ON c.CIT001ContractID = one.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_SignDate two ON c.CIT001ContractID = two.CIT001ContractID
left outer join Salesforce..Account a ON ca.CustomerAccountNumber = a.Sage_Id__c
left outer join Salesforce..Contract sfc ON a.Id = sfc.AccountId and c.Signed = sfc.CustomerSignedDate
WHERE c.SFDCContractNumber = '' 
and one.CIT001ContractID is null 
and two.CIT001ContractID is null 
and sfc.Id is not null

SELECT sfc.Id, c.CIT001ContractID, c.Duration, c.Signed, sfc.StartDate, sfc.AccountId, c.Value
INTO SalesforceReporting..Sage_SFDC_CompanySignDate
FROM SalesforceReporting..CIT001Contract c
left outer join SalesforceReporting..SLCustomerAccount ca ON c.CustomerID = ca.SLCustomerAccountID
left outer join SalesforceReporting..Sage_SFDC_SageContractNumber one ON c.CIT001ContractID = one.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_SignDate two ON c.CIT001ContractID = two.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_CustomerSignDate thr ON c.CIT001ContractID = thr.CIT001ContractID
left outer join Salesforce..Account a ON ca.CustomerAccountNumber = a.Sage_Id__c
left outer join Salesforce..Contract sfc ON a.Id = sfc.AccountId and c.Signed = sfc.CompanySignedDate
WHERE c.SFDCContractNumber = '' 
and one.CIT001ContractID is null 
and two.CIT001ContractID is null 
and thr.CIT001ContractID is null 
and sfc.Id is not null

SELECT a.Id, c.CIT001ContractID, c.Duration, c.Signed, sfc.AccountId, c.Value
INTO SalesforceReporting..Sage_SFDC_FortnightStartDate
FROM SalesforceReporting..CIT001Contract c
left outer join SalesforceReporting..SLCustomerAccount ca ON c.CustomerID = ca.SLCustomerAccountID
left outer join SalesforceReporting..Sage_SFDC_SageContractNumber one ON c.CIT001ContractID = one.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_SignDate two ON c.CIT001ContractID = two.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_CustomerSignDate thr ON c.CIT001ContractID = thr.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_CompanySignDate fr ON c.CIT001ContractID = fr.CIT001ContractID
left outer join Salesforce..Account a ON ca.CustomerAccountNumber = a.Sage_Id__c
left outer join Salesforce..Contract sfc ON a.Id = sfc.AccountId and c.Value = sfc.Contract_Value__c and c.Signed between DATEADD(DAY,-7,sfc.StartDate) and DATEADD(DAY,7,sfc.StartDate)
WHERE c.SFDCContractNumber = '' 
and one.CIT001ContractID is null 
and two.CIT001ContractID is null 
and thr.CIT001ContractID is null 
and fr.CIT001ContractID is null
and sfc.Id is not null

SELECT a.Id, c.CIT001ContractID, c.Duration, c.Signed, c.Value, sfc.AccountId
INTO SalesforceReporting..Sage_SFDC_FortnightSignDate
FROM SalesforceReporting..CIT001Contract c
left outer join SalesforceReporting..SLCustomerAccount ca ON c.CustomerID = ca.SLCustomerAccountID
left outer join SalesforceReporting..Sage_SFDC_SageContractNumber one ON c.CIT001ContractID = one.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_SignDate two ON c.CIT001ContractID = two.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_CustomerSignDate thr ON c.CIT001ContractID = thr.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_CompanySignDate fr ON c.CIT001ContractID = fr.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_FortnightStartDate fv ON c.CIT001ContractID = fv.CIT001ContractID
left outer join Salesforce..Account a ON ca.CustomerAccountNumber = a.Sage_Id__c
left outer join Salesforce..Contract sfc ON a.Id = sfc.AccountId and c.Value = sfc.Contract_Value__c and sfc.StartDate between DATEADD(DAY,-7,c.Signed) and DATEADD(DAY,7,c.Signed)
WHERE c.SFDCContractNumber = '' 
and one.CIT001ContractID is null 
and two.CIT001ContractID is null 
and thr.CIT001ContractID is null 
and fr.CIT001ContractID is null
and fv.CIT001ContractID is null
and sfc.Id is not null

SELECT CIT001ContractID, Id, Signed, Duration, Value, AccountId FROM Sage_SFDC_SageContractNumber

SELECT CIT001ContractID, Id, Signed, Duration, Value, AccountId FROM Sage_SFDC_SignDate

SELECT CIT001ContractID, Id, Signed, Duration, Value, AccountId FROM Sage_SFDC_CustomerSignDate

SELECT CIT001ContractID, Id, Signed, Duration, Value, AccountId FROM Sage_SFDC_CompanySignDate

SELECT CIT001ContractID, Id, Signed, Duration, Value, AccountId FROM Sage_SFDC_FortnightStartDate

SELECT CIT001ContractID, Id, Signed, Duration, Value, AccountId FROM Sage_SFDC_FortnightSignDate

SELECT a.Id, c.CIT001ContractID
INTO SalesforceReporting..Sage_SFDC
FROM SalesforceReporting..CIT001Contract c
left outer join SalesforceReporting..SLCustomerAccount ca ON c.CustomerID = ca.SLCustomerAccountID
left outer join SalesforceReporting..Sage_SFDC_SageContractNumber one ON c.CIT001ContractID = one.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_SignDate two ON c.CIT001ContractID = two.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_CustomerSignDate thr ON c.CIT001ContractID = thr.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_CompanySignDate fr ON c.CIT001ContractID = fr.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_FortnightStartDate fv ON c.CIT001ContractID = fv.CIT001ContractID
left outer join SalesforceReporting..Sage_SFDC_FortnightSignDate sx ON c.CIT001ContractID = sx.CIT001ContractID
left outer join Salesforce..Account a ON ca.CustomerAccountNumber = a.Sage_Id__c
WHERE c.SFDCContractNumber = '' 
and one.CIT001ContractID is null 
and two.CIT001ContractID is null 
and thr.CIT001ContractID is null 
and fr.CIT001ContractID is null
and fv.CIT001ContractID is null
and sx.CIT001ContractID is null