SELECT cat.[Name]

,'http://db01/reporting/Pages/ReportViewer.aspx?%2fCitation%2f' + REPLACE(cat.Name, ' ', '+') + '&rs:Command=Render' [Path]

,CAST(extensionSettings AS XML).value('(//ParameterValue/Value)[1]',

'varchar(max)') + ';' + CAST(extensionSettings AS XML).value('(//ParameterValue/Value)[2]',

'varchar(max)') Emails

FROM dbo.Catalog AS cat

INNER JOIN dbo.Subscriptions AS sub

ON cat.ItemID = sub.Report_OID

ORDER BY cat.[Path]

,cat.[Name];