SELECT ml.*
FROM SalesforceReporting..MLErrors ml
inner join Salesforce..Lead l ON 
--ml.FirstName = l.Firstname AND ml.LastName = l.LastName AND ml.EMAIL = l.Email
--ml.FirstName = l.Firstname AND ml.LastName = l.LastName AND '0'+ml.Phone = l.Phone AND ml.Company = l.Company
--ml.FirstName = l.Firstname AND ml.LastName = l.LastName AND ml.Street = l.Street AND (ml.City = l.City OR ml.PostalCode = l.PostalCode OR '0'+ml.Phone = l.Phone)
--ml.FirstName = l.Firstname AND ml.LastName = l.LastName AND ml.Street = l.Street AND ml.SALUTATION = l.Salutation
--ml.FirstName = l.Firstname AND ml.LastName = l.LastName AND ml.SALUTATION = l.Salutation AND ml.EMAIL = l.Email
ml.FirstName = l.Firstname AND ml.LastName = l.LastName AND '0'+ml.Phone = l.Phone
WHERE ml.PROSPECT_EXTERNAL_ID__C = '1300105'