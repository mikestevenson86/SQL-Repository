-- Temporary Table

SELECT 
MAX(CIT001ContractID) ID, ContractNo, Signed, DATEADD(month,Duration,Signed)EndDate, Value, Duration, CustomerAccountName

INTO 
#Contracts

FROM 
[SAGE].[Citation PLC].dbo.CIT001Contract co

left outer join [SAGE].[Citation PLC].dbo.SLCustomerAccount cu ON co.CustomerID = SLCustomerAccountID

GROUP BY 
ContractNo, ContractNo, Signed, DATEADD(month,Duration,Signed), Value, Duration, CustomerAccountName

-- Final Query

SELECT c.Id, 
CONVERT(date, c.StartDate) StartDate, 
CONVERT(date, con.Signed) SageStartDate,
case when CONVERT(date, c.StartDate) between DATEADD(dd,-1,con.Signed) and DATEADD(dd,1,con.Signed) then 'Yes' else 'No' end Within3DaysSageStart, 
case when CONVERT(date, c.StartDate) <> ISNULL(CONVERT(date, con.Signed), '1899-01-01') then 1 else 0 end FlagSageStart,
CONVERT(date, d.SignDate) ShorthornStartDate,
case when CONVERT(date, c.StartDate) between DATEADD(dd,-1,d.SignDate) and DATEADD(dd,1,d.SignDate) then 'Yes' else 'No' end Within3DaysSHStart,
case when CONVERT(date, c.StartDate) <> ISNULL(CONVERT(date, d.SignDate), '1899-01-01') then 1 else 0 end FlagShorthornStart,

CONVERT(date, c.EndDate) EndDate, 
CONVERT(date, con.EndDate) SageEndDate,
case when CONVERT(date, c.EndDate) between DATEADD(dd,-1,con.EndDate) and DATEADD(dd,1,con.EndDate) then 'Yes' else 'No' end Within3DaysSageEnd,
case when CONVERT(date, c.EndDate) <> ISNULL(CONVERT(date, con.EndDate), '1899-01-01') then 1 else 0 end FlagSageEnd, 
CONVERT(date, d.renewDate) ShorthornEndDate,
case when CONVERT(date, c.EndDate) between DATEADD(dd,-1,d.renewDate) and DATEADD(dd,1,d.renewDate) then 'Yes' else 'No' end Within3DaysSHEnd,
case when CONVERT(date, c.EndDate) <> ISNULL(CONVERT(date, d.renewDate), '1899-01-01') then 1 else 0 end FlagShorthornEnd,

c.ContractTerm, 
con.Duration SageContractTerm, 
case when c.ContractTerm <> ISNULL(con.Duration, -1) then 1 else 0 end FlagSageTerm,
d.dealLength ShorthornContractTerm,
case when c.ContractTerm <> ISNULL(d.dealLength, -1) then 1 else 0 end FlagShorthornTerm,

c.Contract_Value__c ContractValue, 
con.Value SageContractValue, 
case when c.Contract_Value__c <> ISNULL(con.Value, -1) then 1 else 0 end FlagSageValue,
d.Cost ShorthornContractValue,
case when c.Contract_Value__c <> ISNULL(d.Cost, -1) then 1 else 0 end FlagShorthornValue,

c.Renewal_Type__c Status,
case when ds.dealStatus like '%Non-Auto%' then 'Non-Auto' else 'Auto' end ShorthornStatus,
case when c.Renewal_Type__c <> case when ds.dealStatus like '%Non-Auto%' then 'Non-Auto' else 'Auto' end then 1 else 0 end FlagShorthornStatus,

a.Name,
con.CustomerAccountName,
case when a.Name <> ISNULL(con.CustomerAccountName,'') then 1 else 0 end FlagSageName,
cl.companyName,
case when a.Name <> ISNULL(cl.companyName,'') then 1 else 0 end FlagShorthornName

INTO
#Temp

FROM 
Salesforce..Contract c

left outer join Salesforce..Account a ON c.AccountId = a.Id
left outer join #Contracts con ON c.Sage_Contract_Number__c = con.contractNo
left outer join [database].shorthorn.dbo.cit_sh_deals d ON c.Shorthorn_Deal_Id__c = d.dealId
left outer join [database].shorthorn.dbo.cit_sh_Clients cl ON d.clientId = cl.clientId
left outer join [database].shorthorn.dbo.cit_sh_DealStatus ds ON d.dealStatus = ds.DealStatusId

WHERE 
c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and 
(
c.StartDate <> con.Signed or c.StartDate <> d.SignDate or 
c.EndDate <> con.EndDate or c.EndDate <> d.renewDate or 
c.Contract_Value__c <> con.Value or c.Contract_Value__c <> d.Cost or
c.ContractTerm <> con.Duration or c.ContractTerm <> d.dealLength or
c.Renewal_Type__c <> case when ds.dealStatus like '%Non-Auto%' then 'Non-Auto' else 'Auto' end or
a.Name <> con.CustomerAccountName or a.Name <> cl.companyName
)

SELECT 
*,
case when FlagSageEnd = 1 or FlagSageName = 1 or FlagSageStart = 1 or FlagSageTerm = 1 or FlagSageValue = 1 then 1 else 0 end FlagSage,
case when FlagShorthornEnd = 1 or FlagShorthornName = 1 or FlagShorthornStart = 1 or FlagShorthornStatus = 1 or FlagShorthornTerm = 1 or FlagShorthornValue = 1 then 1 else 0 end FlagShorthorn

FROM
#Temp

-- Drop Temp Table

DROP TABLE #Contracts
DROP TABLE #Temp