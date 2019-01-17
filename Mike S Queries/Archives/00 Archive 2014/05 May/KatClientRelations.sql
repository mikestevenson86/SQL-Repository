SELECT 
ac.Id, 
ac.Name Company,
CONVERT(char,ac.CreatedDate, 103) StartDate, 
ac.Shorthorn_Id__c ShorthornID, 
ac.Sage_Id__c SageID, 
ac.Sector__c Industry,
ac.Total_Employees__c Employees, 
ac.Post_Code__c PostCode,
ag.Agreement_Type__c AgreementType,
ag.ContractTerm,
ag.Contract_Value__c ContractValue,
Case When CONVERT(int,ag.Contract_Value__c) > 0 and (ag.ContractTerm/12) > 0 Then CONVERT(money,(ag.Contract_Value__c/(ag.ContractTerm/12))) else 0 end [Annual Value],
CONVERT(char,ag.EndDate, 103) EndDate

FROM Salesforce..Account ac
left outer join Salesforce..[Contract] ag on ac.Id collate latin1_general_CS_AS = ag.AccountId collate latin1_general_CS_AS

WHERE ac.CreatedDate > '2014-02-14' and ac.[Type] = 'Client'

ORDER BY ac.CreatedDate