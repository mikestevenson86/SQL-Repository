DECLARE @Con as VarChar(255)
SET @Con ='Steve Gray-Gratrix'

SELECT Email
FROM [database].shorthorn.dbo.cit_sh_users
WHERE fullname = @Con

SELECT Email
FROM Salesforce..[User]
WHERE Name = @Con

SELECT EMail
FROM SalesforceReporting..HS_Users
WHERE FullName = @Con