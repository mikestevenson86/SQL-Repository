SELECT 
CONVERT(date, DueDate) [DueDate],
ContractNo,
ContractNo+'/'+CONVERT(varchar,ROW_NUMBER () OVER (PARTITION BY ContractNo ORDER BY DueDate)) [Invoice No], 
AccountNo SalesLedgerAccountRef,
Narrative,
CONVERT(float,Value) Value,
DayNumber [Day Number for Billing],
DATEADD(day,CONVERT(int, DayNumber)-1, CONVERT(date, DueDate)) [New Date]
INTO #Temp
FROM SalesforceReporting..NEWQMSConsB

SELECT *
FROM #Temp
WHERE CONVERT(float, Value) > 0 and CONVERT(date, DueDate) >= '2015-05-01'
ORDER BY ContractNo, DueDate

DROP TABLE #Temp

----------------------------------------------------------------------------------------------------------------

SELECT 
CONVERT(date, DueDate) DueDate,
ContractNo,
AccountNo SalesLedgerAccountRef,
NominalNo NominalAccount,
Value
FROM SalesforceReporting..NEWQMSConsTO
WHERE CONVERT(float, Value) > 0 and CONVERT(date, DueDate) >= '2015-05-01'
GROUP BY ContractNo, DueDate, AccountNo, NominalNo,Value
ORDER BY ContractNo, DueDate