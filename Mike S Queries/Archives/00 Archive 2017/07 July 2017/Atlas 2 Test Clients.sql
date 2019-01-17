select 
       ac.Name + ' - ' + ac.S__c + ' - ' + ac.Serivces_Taken__c + ' - 2.0 Pilot',
       STUFF
    (
            (
                    SELECT CHAR(10) + cast(au.FirstName__c as varchar) + ' ' + cast(au.SecondName__c as varchar) + ' - tel: ' + ISNULL(u.Telephone, 'NONE') + ' - email: ' + ISNULL(u.Email, 'NONE')
                    FROM 
                        ATLAS_User__c au INNER JOIN 
                                         Shared.Users u on au.UserID__c = u.Id
                    WHERE
                        au.Account__c = ac.Id and au.Profile__c like '%Service Owner%' and au.IsActive__c = 'true' and au.Deleted__c = 'false'
                    ORDER BY cast(au.FirstName__c as varchar) + ' ' + cast(au.SecondName__c as varchar)
                    FOR XML PATH ('')
            ), 1, 1, ''
       ) + ' ' + CHAR(10) + 'Client Type: ' + 
       case when c.Migrate = 1 then 'Migrated' else 'Onboarded' end + CHAR(10) + 'Number Of Employees: ' + 
       ISNULL((select CAST(COUNT(*) as varchar) from Employees where CompanyId = c.Id and IsDeleted = 0 and IsActive = 1), '0') + CHAR(10) + 'Number Of Users: ' + 
       ISNULL((select CAST(COUNT(*) as varchar) from Shared.Users where CompanyId = c.Id and IsDeleted = 0 and IsActive = 1), '0') + CHAR(10) + 'Last Logged into Atlas: ' +
       ISNULL((select CAST(MAX(DATEADD(MONTH, -1, cast(Expiry as datetime))) as varchar) from [identity].Tokens where SubjectId in (select Email from Shared.Users where CompanyId = c.Id and IsDeleted = 0 and IsActive = 1)), 'NONE') + CHAR(10) + 'Date Moved to 2.0: 03-August-2017',
       'admin@citation.co.uk', 'Proactive Calls'
From 
       AtlasV2PilotAccounts p INNER JOIN 
       Account ac on p.[Salesforce Id] = ac.Id INNER JOIN 
       Citation.Companies c on c.SalesforceAccountID = ac.Id  
order by 1