-- Prospects - No Real Perosn

SELECT 
COUNT(Id) Total
FROM 
Salesforce..Lead
WHERE 
(
RecordTypeId = '012D0000000NbJsIAK'

and status not in ('approved','pended','data quality')

and ((FT_Employees__c < 225 and CitationSector__c = 'Care') or (FT_Employees__c between 1 and 1000))

and (isnull(SIC2007_Code3__c,0) <> 0 or CitationSector__c is not null)

and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
AND TEXT_BDM__c not in ('Jaquie Watt', 'Jo Brown', 'Justin Robinson', 'Louise Clarke', 'Mark Goodrum', 'Matthew Walker', 'Mike Stevenson', 'Peter Sherlock', 'Susan Turner', 'Tushar Sanghrajka')
)
and
(
LEN(Name) in (0,1,2)
or
Name like 'X%'
or
FirstName = 'BLANK'
or
LastName = 'BLANK'
)

-- Prospect - Incorrect Data Format

SELECT 
COUNT(Id) Total
FROM 
Salesforce..Lead
WHERE 
(
RecordTypeId = '012D0000000NbJsIAK'

and status not in ('approved','pended','data quality')

and ( (FT_Employees__c < 225 and CitationSector__c = 'Care') or (FT_Employees__c between 1 and 1000 )  )

and (isnull(SIC2007_Code3__c,0) <> 0 or CitationSector__c is not null)

and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
AND TEXT_BDM__c not in ('Jaquie Watt', 'Jo Brown', 'Justin Robinson', 'Louise Clarke', 'Mark Goodrum', 'Matthew Walker', 'Mike Stevenson', 'Peter Sherlock', 'Susan Turner', 'Tushar Sanghrajka')
)
and
(
Company collate latin1_general_CS_AS = UPPER(Company) collate latin1_general_CS_AS
or
FirstName collate latin1_general_CS_AS = UPPER(FirstName) collate latin1_general_CS_AS
or
Street collate latin1_general_CS_AS = UPPER(Street) collate latin1_general_CS_AS
or
LastName collate latin1_general_CS_AS = UPPER(LastName) collate latin1_general_CS_AS
)

-- Clients - No Real Person

SELECT COUNT(distinct AccountId)
FROM Salesforce..Account a
inner join Salesforce..Contact c ON a.Id = c.AccountId
WHERE
(
IsActive__c = 'true'
and
Citation_Client__c = 'true'
)
and
(
LEN(c.Name) in (0,1,2)
or
c.Name like 'X%'
or
FirstName = 'BLANK'
or
LastName = 'BLANK'
)

-- Clients - Incorrect Data Format

SELECT COUNT(distinct AccountId)
FROM Salesforce..Account a
inner join Salesforce..Contact c ON a.Id = c.AccountId
WHERE
(
IsActive__c = 'true'
and
Citation_Client__c = 'true'
)
and
(
a.Name collate latin1_general_CS_AS = UPPER(a.Name) collate latin1_general_CS_AS
or
FirstName collate latin1_general_CS_AS = UPPER(FirstName) collate latin1_general_CS_AS
or
BillingStreet collate latin1_general_CS_AS = UPPER(BillingStreet) collate latin1_general_CS_AS
or
LastName collate latin1_general_CS_AS = UPPER(LastName) collate latin1_general_CS_AS
)