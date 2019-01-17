SELECT
clientID [Shorthorn Client ID],
companyName [Company Name],
clienttype [Client Type],
name [Contact Name],
Email [Contact Email],
SUM(B_Logins) B_Logins,
MAX(B_LastLogin) B_LastLogin,
SUM(C_Logins) C_Logins,
MAX(C_LastLogin) C_LastLogin,
SUM(D_Logins) D_Logins,
MAX(D_LastLogin) D_LastLogin,
SUM(F_Logins) F_Logins,
MAX(F_LastLogin) F_LastLogin
INTO
#Temp
FROM
(
SELECT cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email,
ISNULL(SUM(CONVERT(int, b.NumberofLogins)),0) B_Logins, 
MAX(LEFT(b.LastLogin,10)) B_LastLogin,
0 C_Logins, '' C_LastLogin,
0 D_Logins, '' D_LastLogin,
0 E_Logins, '' E_LastLogin,
0 F_Logins, '' F_LastLogin
FROM Shorthorn..cit_sh_clients cl
inner join CitationMain..citation_CompanyTable2 ct ON cl.sageCode = ct.sageAC collate latin1_general_CI_AS
inner join CitationMain..citation_userNew cn ON ct.uid = cn.uid
left outer join ReportServer..[B - HS CitWeb and CitAssess Ex A and E] b ON cn.usUID = b.ClientId
WHERE cl.clientID in (SELECT clientID FROM Shorthorn..cit_sh_deals WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18))
GROUP BY cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email
UNION
SELECT cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email,
0 B_Logins, '' B_LastLogin,
ISNULL(SUM(CONVERT(int, c.NUMBEROFLOGINS)),0) C_Logins, MAX(LEFT(c.LastLogin,10)) C_LastLogin,
0 D_Logins, '' D_LastLogin,
0 E_Logins, '' E_LastLogin,
0 F_Logins, '' F_LastLogin
FROM Shorthorn..cit_sh_clients cl
inner join CitationMain..citation_CompanyTable2 ct ON cl.sageCode = ct.sageAC collate latin1_general_CI_AS
inner join CitationMain..citation_userNew cn ON ct.uid = cn.uid
left outer join ReportServer..[C - CitManager Not Holiday Planner Ex A B and E] c ON cn.usUID = c.ClientId
WHERE cl.clientID in (SELECT clientID FROM Shorthorn..cit_sh_deals WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18))
GROUP BY cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email
UNION
SELECT cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email,
0 B_Logins, '' B_LastLogin,
0 C_Logins, '' C_LastLogin,
ISNULL(SUM(CONVERT(int, d.NUMBEROFLOGINS)),0) D_Logins, MAX(LEFT(d.LastLogin,10)) D_LastLogin,
0 E_Logins, '' E_LastLogin,
0 F_Logins, '' F_LastLogin
FROM Shorthorn..cit_sh_clients cl
inner join CitationMain..citation_CompanyTable2 ct ON cl.sageCode = ct.sageAC collate latin1_general_CI_AS
inner join CitationMain..citation_userNew cn ON ct.uid = cn.uid
left outer join ReportServer..[D - CitManager and Holiday Planner Ex A B and E] d ON cn.usUID = d.ClientId
WHERE cl.clientID in (SELECT clientID FROM Shorthorn..cit_sh_deals WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18))
GROUP BY cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email
UNION
SELECT cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email,
0 B_Logins, '' B_LastLogin,
0 C_Logins, '' C_LastLogin,
0 D_Logins, '' D_LastLogin,
0 E_Logins, '' E_LastLogin,
ISNULL(SUM(CONVERT(int, f.NUMBEROFLOGINS)),0) F_Logins, MAX(LEFT(f.LastLogin,10)) F_LastLogin
FROM Shorthorn..cit_sh_clients cl
inner join CitationMain..citation_CompanyTable2 ct ON cl.sageCode = ct.sageAC collate latin1_general_CI_AS
inner join CitationMain..citation_userNew cn ON ct.uid = cn.uid
left outer join ReportServer..[F - CitTrainer] f ON cn.usUID = f.ClientId
WHERE cl.clientID in (SELECT clientID FROM Shorthorn..cit_sh_deals WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18))
GROUP BY cl.clientID, cl.companyName,cl.ClientType,cn.name,cn.email
) detail
GROUP BY clientID,companyName,clienttype,name,Email 
ORDER BY  [Shorthorn Client ID],[Company Name],[Client Type],[Contact Name],[Contact Email]

SELECT t.*
,d.dealID [Shorthorn Deal ID],d.renewDate [Renewal Date],d.cost [Deal Value],
case when t.B_LastLogin = '' and t.C_LastLogin = '' and t.D_LastLogin = '' and t.F_LastLogin = '' then 'No' else 'Yes' end [Have They Ever Logged In],
case when dhs.dealID is not null and dhr.dealID IS NULL then 'HS'
when dhr.dealID is not null and dhs.dealID is null then 'PEL'
when dhs.dealID is not null and dhr.dealID is not null then 'Combined' end [Deal Type]
FROM #Temp t
left outer join Shorthorn..cit_sh_deals d ON t.[Shorthorn Client ID] = d.clientID and d.dealStatus not in (2,5,10,18) and renewDate > GETDATE()
left outer join Shorthorn..cit_sh_dealsHS dhs ON d.dealID = dhs.dealId
left outer join Shorthorn..cit_sh_dealsPEL dhr ON d.dealID = dhr.dealID
ORDER BY [Shorthorn Client ID], d.dealID

DROP TABLE #Temp