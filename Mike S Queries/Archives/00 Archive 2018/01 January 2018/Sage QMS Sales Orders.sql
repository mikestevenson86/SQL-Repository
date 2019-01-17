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
CitationQMSLive..SOPOrderReturnLine sop
left outer join CitationQMSLive..SOPOrderReturn sr ON sop.SOPOrderReturnID = sr.SOPOrderReturnID
left outer join CitationQMSLive..SLCustomerAccount sla ON sr.CustomerID = sla.SLCustomerAccountID
left outer join CitationQMSLive..CIT001UpliftValue up ON sop.SOPOrderReturnLineID = up.SOPOrderReturnLineID