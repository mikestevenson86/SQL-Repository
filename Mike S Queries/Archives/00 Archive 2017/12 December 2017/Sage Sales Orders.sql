SELECT 
sop.SOPOrderReturnID, 
sop.SOPOrderReturnLineID, 
sop.LineTotalValue, 
sop.NominalAccountRef, 
sr.DocumentNo, 
sr.DocumentDate,
SLCustomerAccountID, 
CustomerAccountNumber,
CustomerAccountName,
OriginalValue, 
up.TotalValue, 
up.UpliftValue
FROM 
CitationPLCLive..SOPOrderReturnLine sop
left outer join CitationPLCLive..SOPOrderReturn sr ON sop.SOPOrderReturnID = sr.SOPOrderReturnID
left outer join CitationPLCLive..SLCustomerAccount sla ON sr.CustomerID = sla.SLCustomerAccountID
left outer join CitationPLCLive..CIT001UpliftValue up ON sop.SOPOrderReturnLineID = up.SOPOrderReturnLineID 