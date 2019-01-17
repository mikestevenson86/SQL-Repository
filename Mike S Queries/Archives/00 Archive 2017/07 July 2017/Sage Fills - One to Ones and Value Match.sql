IF OBJECT_ID('tempdb..#Sage') IS NOT NULL
	BEGIN
		DROP TABLE #Sage
	END

SELECT sa.CustomerAccountNumber, ContractNo
INTO #Sage
FROM [SAGE2015].CitationPLCLive.dbo.CIT001Contract c
inner join [SAGE2015].CitationPLCLive.dbo.SLCustomerAccount  sa ON c.CustomerID = sa.SLCustomerAccountID
WHERE CustomerID in
	(
	SELECT CustomerID
	FROM
		(
		SELECT CustomerID, COUNT(CIT001ContractID) deals
		FROM [SAGE2015].CitationPLCLive.dbo.CIT001Contract
		GROUP BY CustomerId
		) detail
	WHERE deals = 1
	)

--UPDATE ds SET SAGE_ContractId = s.ContractNo 
FROM Shorthorn..cit_sh_deals ds
inner join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID
inner join #Sage s ON LTRIM(RTRIM(cl.sageCode)) = LTRIM(RTRIM(s.CustomerAccountNumber))
WHERE ds.clientId in
	(
	SELECT clientId
	FROM
		(
		SELECT d.clientId, COUNT(dealId) deals
		FROM Shorthorn..cit_sh_deals d
		inner join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
		WHERE ISNULL(SAGE_ContractId,'') = '' and ISNULL(cl.sageCode,'') <> ''
		GROUP BY d.clientID
		)detail
	WHERE deals = 1
	)
/*
SELECT ds.clientID, dealId, cl.sageCode
FROM Shorthorn..cit_sh_deals ds
left outer join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID
left outer join #Sage s ON LTRIM(RTRIM(cl.sageCode)) = LTRIM(RTRIM(s.CustomerAccountNumber))
WHERE ds.clientId in
	(
	SELECT clientId
	FROM
		(
		SELECT d.clientId, COUNT(dealId) deals
		FROM Shorthorn..cit_sh_deals d
		inner join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
		WHERE ISNULL(SAGE_ContractId,'') = '' and ISNULL(cl.sageCode,'') <> ''
		GROUP BY d.clientID
		)detail
	WHERE deals = 1
	)
and s.CustomerAccountNumber is null

SELECT ds.clientID, dealId, cl.sageCode
FROM Shorthorn..cit_sh_deals ds
left outer join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID
left outer join [SAGE2015].CitationPLCLive.dbo.SLCustomerAccount s ON cl.sageCode = s.CustomerAccountNumber
WHERE ds.clientId in
	(
	SELECT clientId
	FROM
		(
		SELECT d.clientId, COUNT(dealId) deals
		FROM Shorthorn..cit_sh_deals d
		inner join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
		WHERE ISNULL(SAGE_ContractId,'') = '' and ISNULL(cl.sageCode,'') <> ''
		GROUP BY d.clientID
		)detail
	WHERE deals = 1
	)
and s.CustomerAccountNumber is null
*/

--UPDATE d SET SAGE_ContractID =  c.ContractNo
FROM Shorthorn..cit_sh_deals d
inner join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
inner join [SAGE2015].CitationPLCLive.dbo.SLCustomerAccount ca ON LTRIM(RTRIM(cl.sageCode)) = LTRIM(RTRIM(ca.CustomerAccountNumber))
inner join [SAGE2015].CitationPLCLive.dbo.CIT001Contract c ON ca.SLCustomerAccountID = c.CustomerId and ROUND(d.cost,0) = ROUND(c.value,0)
WHERE ISNULL(SAGE_ContractId,'') = '' and ISNULL(cl.sageCode,'') <> ''