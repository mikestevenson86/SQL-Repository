/*Find reports stored in TWO and their stored procedures
Acknowledgment to Sankar Reddy
https://www.mssqltips.com/sqlservertip/1839/script-to-determine-sql-server-reporting-services-parameters-path-and-default-values/;
*/
USE MIReports;
/* Name space should be adjusted to match your version of sQL server */
WITH XMLNAMESPACES (
DEFAULT 'http://schemas.microsoft.com/sqlserver/reporting/2008/01/reportdefinition',
'http://schemas.microsoft.com/SQLServer/reporting/reportdesigner' AS rd --ReportDefinition
)
SELECT 
   a.NAME
   /*, a.PATH
   , CASE CHARINDEX('/',a.path, 2)
                WHEN 0 THEN a.Path
                ELSE SUBSTRING(a.Path, 1,
                               CHARINDEX('/', a.path, 2) - 1)
              END AS ROOT_FOLDER
   , x.value ('@Name', 'VARCHAR(100)') AS DataSetName
  , x.value ('data(Query/DataSourceName)[1]', 'VARCHAR(100)') AS DataSourceName
  , ISNULL(x.value ('data(Query/CommandType)[1]', 'VARCHAR(100)'),'') AS CommandType*/
  , x.value ('data(Query/CommandText)[1]', 'VARCHAR(MAX)') AS StoredProcedureName
  , case when su.SubscriptionID is not null then 'Yes' else 'No' end Subscribed
FROM (
   SELECT  PATH
           , NAME
           , CAST(CAST(content AS VARBINARY(MAX)) AS XML) AS ReportXML 
   FROM dbo.Catalog 
   WHERE CONTENT IS NOT NULL AND TYPE = 2
   ) A
CROSS APPLY ReportXML.nodes('/Report/DataSets/DataSet') R(x)
left outer join MIReports..Catalog cl ON a.Name = cl.Name
left outer join MIReports..ReportSchedule rs ON cl.ItemID = rs.ReportID
left outer join MIReports..Subscriptions su ON rs.SubscriptionID = su.SubscriptionID
WHERE 
x.value ('@Name', 'VARCHAR(100)') not like 'ds_Selected%' and x.value ('@Name', 'VARCHAR(100)') not like 'ds_Date%'
and a.PATH not like '/Citation/Wallboards/%'
and a.PATH not like '/Citation/Exceptions/%'
and a.PATH not like '/Citation/Shorthorn/%'
and a.PATH not like '/DemoLogins%'
/*
WHERE CASE CHARINDEX('/', path, 2)
                WHEN 0 THEN Path
                ELSE SUBSTRING(Path, 1,
                               CHARINDEX('/', path, 2) - 1)
              END= '/PR'
			  AND ISNULL(x.value ('data(Query/CommandType)[1]', 'VARCHAR(100)'),'') = 'StoredProcedure'
*/
ORDER BY a.NAME

