-- Create and Populate Table

SELECT
CAST(Contract.Id as NCHAR(18)) Id,
Contract.Contract_Value__c + SUM(CIT001UpliftValue.UpliftValue) Post_Indexation_Value__c,
CAST('' as nvarchar(255)) Error
INTO
Salesforce..Contract_Update
FROM 
[SAGE].[Citation PLC].dbo.SOPOrderReturnLine
inner join [SAGE].[Citation PLC].dbo.SOPOrderReturn on
	SOPOrderReturnLine.SOPOrderReturnID = SOPOrderReturn.SOPOrderReturnID
inner join [SAGE].[Citation PLC].dbo.SOPOrderReturnX on
	SOPOrderReturn.SOPOrderReturnID = SOPOrderReturnX.SOPOrderReturnXID
inner join [SAGE].[Citation PLC].dbo.CIT001Contract ON
	SOPOrderReturnX.linkedcontractid = CIT001Contract.CIT001ContractID
INNER JOIN [SAGE].[Citation PLC].dbo.CIT001UpliftValue ON
	SOPOrderReturnLine.SOPOrderReturnLineID = CIT001UpliftValue.SOPOrderReturnLineID
INNER JOIN [SAGE].[Citation PLC].dbo.SLCustomerAccount ON
	SOPOrderReturn.CUSTOMERID = SLCustomerAccount.SLCustomerAccountID
INNER JOIN Salesforce..Contract on
	Contract.Sage_Contract_Number__c = CIT001Contract.ContractNo
	
	GROUP BY Id, Contract_Value__c
	
-- Upload to Salesforce	

exec Salesforce..SF_BulkOps 'Update:batchsize(5)','Salesforce','Contract_Update'

-- Actions from Result

/*
DECLARE @Results as integer

SELECT @Results = COUNT(*) FROM Salesforce..Contract_Update WHERE Error != 'Operation Successful.'

IF @Results = 0
BEGIN
DROP TABLE Salesforce..Contract_Update
END
IF @Results > 0
BEGIN
SELECT * FROM Salesforce..Contract_Update WHERE Error != 'Operation Successful.'
END
*/