SELECT 
a.Id, 
a.Name, 
c.Name, 
c.position__c, 
a.BillingStreet + ' ' + a.BillingCity + ' ' + a.BillingPostalCode, 
a.phone, 
c.Email, 
a.[Type], 
SIC2007_Code3__c, 
SIC2007_Description3__c,
a.Shorthorn_Id__c

FROM Salesforce..Account a
left outer join Salesforce..Contact c on a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
inner join Salesforce..Contract con on a.Id collate latin1_general_CS_AS = con.AccountId collate latin1_general_CS_AS

WHERE 
con.CQC__c = 'false'
and
con.StartDate <= GETDATE() 
and 
con.EndDate > GETDATE() 
and 
con.Cancellation_Date__c is null 
and 
(
SIC2007_Code3__c in ('84120','86102','86220','87100','87200','87300','87900','88100','88990')
or
CitationSector__c like '%care%'
)
and
a.BillingPostalCode not like 'CF%' and
a.BillingPostalCode not like 'LD%' and
a.BillingPostalCode not like 'LL%' and
a.BillingPostalCode not like 'NP%' and
a.BillingPostalCode not like 'SA%' and
a.BillingPostalCode not like 'AB%' and
a.BillingPostalCode not like 'DD%' and
a.BillingPostalCode not like 'DG%' and
a.BillingPostalCode not like 'EH%' and
a.BillingPostalCode not like 'FK%' and
a.BillingPostalCode not like 'HS%' and
a.BillingPostalCode not like 'IV%' and
a.BillingPostalCode not like 'KA%' and
a.BillingPostalCode not like 'KW%' and
a.BillingPostalCode not like 'KY%' and
a.BillingPostalCode not like 'ML%' and
a.BillingPostalCode not like 'PA%' and
a.BillingPostalCode not like 'PH%' and
a.BillingPostalCode not like 'ZE%' and
a.BillingPostalCode not like 'G1%' and
a.BillingPostalCode not like 'G2%' and
a.BillingPostalCode not like 'G3%' and
a.BillingPostalCode not like 'G4%' and
a.BillingPostalCode not like 'G5%' and
a.BillingPostalCode not like 'G6%' and
a.BillingPostalCode not like 'G7%' and
a.BillingPostalCode not like 'G8%' and
a.BillingPostalCode not like 'G9%'