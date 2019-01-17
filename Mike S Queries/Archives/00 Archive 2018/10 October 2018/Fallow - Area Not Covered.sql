IF OBJECT_ID('tempdb..#Stage1') IS NOT NULL DROP TABLE #Stage1
IF OBJECT_ID('tempdb..#Stage2') IS NOT NULL DROP TABLE #Stage2
IF OBJECT_ID('tempdb..#Stage3') IS NOT NULL DROP TABLE #Stage3

SELECT 
Id, pca.BDM, pca.UserGroupID
INTO
#Stage1
FROM 
Salesforce..Lead l
inner join SalesforceReporting..PostcodeAssignments pca ON LEFT(PostalCode, 4) = pca.AreaCode
																and LEN(pca.AreaCode) = 4
WHERE 
RecordTypeId = '012D0000000NbJsIAK'
and
IsConverted = 'false'
and
Status in ('Closed','Suspended') 
and 
Suspended_Closed_Reason__c = 'Area Not Covered'

SELECT 
Id, pca.BDM, pca.UserGroupID
INTO
#Stage2
FROM 
Salesforce..Lead l
inner join SalesforceReporting..PostcodeAssignments pca ON LEFT(PostalCode, 3) = pca.AreaCode
																and LEN(pca.AreaCode) = 3
WHERE
RecordTypeId = '012D0000000NbJsIAK'
and
IsConverted = 'false'
and 
Status in ('Closed','Suspended') 
and 
Suspended_Closed_Reason__c = 'Area Not Covered'
and
Id not in (SELECT Id FROM #Stage1)

SELECT 
Id, pca.BDM, pca.UserGroupID
INTO
#Stage3
FROM 
Salesforce..Lead l
inner join SalesforceReporting..PostcodeAssignments pca ON LEFT(PostalCode, 2) = pca.AreaCode
																and LEN(pca.AreaCode) = 2
WHERE
RecordTypeId = '012D0000000NbJsIAK'
and
IsConverted = 'false'
and 
Status in ('Closed','Suspended') 
and 
Suspended_Closed_Reason__c = 'Area Not Covered'
and
Id not in (SELECT Id FROM #Stage1 UNION SELECT Id FROM #Stage2)

SELECT *
FROM
(
	SELECT l.Id, rt.Name RecordType, u.Name CurrentOwner, l.PostalCode, BDM NewOwner 
	FROM 
	(
		SELECT Id, BDM, UserGroupID FROM #Stage1
		UNION
		SELECT Id, BDM, UserGroupID FROM #Stage2
		UNION
		SELECT Id, BDM, UserGroupID FROM #Stage3
	) detail
	left outer join Salesforce..Lead l ON detail.Id = l.Id
	left outer join Salesforce..[User] u ON l.OwnerId = u.Id
	left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
	WHERE
	l.Id is not null
) detail
WHERE NewOwner <> 'Unassigned BDM'