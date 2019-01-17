SELECT *
FROM
(
SELECT 
ISNULL(qa.sf_ID_account, qa2.[SF ID]) SFDCId,
sla.CustomerAccountNumber,
sla.CustomerAccountName,
sla.DateOfLastTransaction,
sll.AddressLine1,
sll.AddressLine2,
sll.AddressLine3,
sll.AddressLine4,
sll.City,
sll.County,
sll.Country,
sll.PostCode,
slx.N0119AccountName,
slx.N0119AccountNumber,
slx.N0119SortCode,
slx.N0119BankPaymentReference,
slx.N0119PayByBACS,
slx.N0119SubmissionsMade,
slx.N0119AUDDISSubmissionDate,
STUFF
		   (
				  (
						 SELECT ', ' + slc.ContactRoleName
						 FROM 
							   CitationQMSLive..SLCustomerContactDefaultsVw slc
						 WHERE
							   sla.SLCustomerAccountID = slc.SLCustomerAccountID
						 ORDER BY slc.ContactRoleName
						 FOR XML PATH ('')
				  ), 1, 1, ''
		   ) ContactRoles,
sld.Contact,
sld.DefaultEmail,
sld.DefaultTelephone,
sld.DefaultMobile,
sld.DefaultWebsite
/*
FROM CitationPLCLive..SLCustomerAccount sla
left outer join CitationPLCLive..SLCustomerLocation sll ON sla.SLCustomerAccountID = sll.SLCustomerAccountID
left outer join CitationPLCLive..SLCustomerAccountX slx ON sla.SLCustomerAccountID = slx.SLCustomerAccountXID
left outer join CitationPLCLive..SLCustomerContactDefaultsVw sld ON sla.SLCustomerAccountID = sld.SLCustomerAccountID
*/
FROM CitationQMSLive..SLCustomerAccount sla
left outer join CitationQMSLive..SLCustomerLocation sll ON sla.SLCustomerAccountID = sll.SLCustomerAccountID
left outer join CitationQMSLive..SLCustomerAccountX slx ON sla.SLCustomerAccountID = slx.SLCustomerAccountXID
left outer join CitationQMSLive..SLCustomerContactDefaultsVw sld ON sla.SLCustomerAccountID = sld.SLCustomerAccountID
left outer join CitationQMSLive..QMSSageAccounts qa ON sla.CustomerAccountNumber = qa.CustomerAccountNumber
left outer join CitationQMSLive..QMSSageAccounts2 qa2 ON sla.CustomerAccountNumber = qa2.[Sage ID]

WHERE
qa.CustomerAccountNumber is not null or sla.CustomerAccountNumber = 'BETT0003' or qa2.[Sage ID] is not null

) detail
GROUP BY 
SFDCId,
CustomerAccountNumber,
CustomerAccountName,
DateOfLastTransaction,
AddressLine1,
AddressLine2,
AddressLine3,
AddressLine4,
City,
County,
Country,
PostCode,
N0119AccountName,
N0119AccountNumber,
N0119SortCode,
N0119BankPaymentReference,
N0119PayByBACS,
N0119SubmissionsMade,
N0119AUDDISSubmissionDate,
ContactRoles,
Contact,
DefaultEmail,
DefaultTelephone,
DefaultMobile,
DefaultWebsite