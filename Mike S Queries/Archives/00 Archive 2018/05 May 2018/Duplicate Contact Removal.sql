IF OBJECT_ID('Salesforce..Contact_Delete') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Contact_Delete
	END

SELECT 
CAST(c.Id as NCHAR(18)) Id
/*
,c.AccountId
,c.Id NewContact 
,cd.Id OldContact 
,cd.ContactString 
,c.CreatedDate New_Created
,u.Name New_Creator
,cd.CreatedDate Old_Created
*/
,CAST('' as NVarChar(255)) Error

INTO
Salesforce..Contact_Delete

FROM 
Salesforce..Contact c
inner join	(
				SELECT Id, FirstName+LastName+AccountId ContactString, CreatedDate
				FROM Salesforce..Contact
				WHERE FirstName is not null and LastName is not null and AccountId is not null
			) cd ON c.FirstName+c.LastName+c.AccountId = cd.ContactString
					and c.Id <> cd.Id
					and c.CreatedDate > cd.CreatedDate
inner join Salesforce..[User] u ON c.CreatedById = u.Id

WHERE 
c.FirstName is not null and c.LastName is not null and c.AccountId is not null 
and 
CONVERT(date, c.CreatedDate) >= DATEADD(day,-1,CONVERT(date, GETDATE()))
and 
u.Name = 'Mike Stevenson'

exec Salesforce..SF_BulkOps 'Delete:batchsize(50)','Salesforce','Contact_Delete'

INSERT INTO SalesforceReporting..Contacts_Deleted SELECT *, GETDATE() FROM Salesforce..Contact_Delete