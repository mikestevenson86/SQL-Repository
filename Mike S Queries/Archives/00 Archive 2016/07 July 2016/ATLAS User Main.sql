SELECT SubjectId, MAX(DateAdd(Month, -1, t.Expiry)) LastDate
INTO #LastLoggedIn
FROM
[AtlasStaging].[identity].Tokens t
GROUP BY SubjectId

SELECT
FirstName FirstName__c,
SecondName SecondName__c,
Email Email__c,
up.Name Profile__c,
u.CreatedOn CreatedOn__c,
ll.LastDate LastLoggedInTime__c,
u.IsActive IsActive__c,
u.ID UserID__c
FROM [AtlasStaging].[Shared].[Users] u
left outer join [AtlasStaging]..UserProfiles up ON u.UserProfileId = up.Id
left outer join #LastLoggedIn ll ON u.Email = ll.SubjectId

DROP TABLE #LastLoggedIn