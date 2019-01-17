--EXEC SalesforceBackUp..sp_MSforeachtable 'drop table ?'

/*DECLARE @SQL NVarChar(MAX) = N''

SELECT @SQL = @SQL + N'SELECT * INTO SalesforceBackUp.dbo.' 
        + 'LeadHistory' + CONVERT(VarChar(8),GETDATE(),112)  
        + N' FROM Salesforce..LeadHistory' 

exec sp_executesql @SQL*/

USE [SalesforceReporting];
GO
SELECT name AS object_name 
  ,SCHEMA_NAME(schema_id) AS schema_name
  ,type_desc
  ,create_date
  ,modify_date
FROM sys.objects
WHERE create_date < GETDATE() - 7
ORDER BY create_date;
GO
------------------------------------------------------------------------------------------------
DECLARE @tname VARCHAR(100)
DECLARE @sql VARCHAR(max)

DECLARE db_cursor CURSOR FOR 
SELECT name AS tname
FROM SalesforceBackUp.sys.objects
WHERE type_desc = 'USER_TABLE' and create_date < GETDATE() - 7

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @tname  

WHILE @@FETCH_STATUS = 0  
BEGIN  
       SET @sql = 'DROP TABLE ' + @tname
       --EXEC (@sql)
       PRINT @sql

       FETCH NEXT FROM db_cursor INTO @tname  
END  

CLOSE db_cursor  
DEALLOCATE db_cursor