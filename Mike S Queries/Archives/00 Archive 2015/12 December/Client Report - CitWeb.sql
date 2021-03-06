SELECT compID, COUNT(*) emps
INTO #Emps
FROM CitationMain..cit_tfl_Employee
WHERE [disabled] = 0
GROUP BY compID

SELECT [user_id], COUNT(*) ra
INTO #RA
FROM CitationMain..citation_assessments
GROUP BY [user_id]

SELECT companyID, COUNT(*) passes
INTO #Train
FROM CitationMain..citation_trainer_GroupCourseUserMapping tc
inner join CitationMain..citation_trainer_Users u ON tc.userID = u.userID
WHERE progress = 'p' or completionDate is not null
GROUP BY companyID

SELECT cl.clientID, cl.SFDC_AccountId, em.emps, ra.ra, tr.passes, MAX(CONVERT(datetime, whenUsed)) LastLogin
INTO #Fifteen
FROM Shorthorn..cit_sh_clients cl
inner join CitationMain..citation_CompanyTable2 ct ON cl.sageCode collate latin1_general_CI_AS = ct.sageAC collate latin1_general_CI_AS
left outer join CitationMain..citation_appUsage ap ON ct.uid = ap.compID
inner join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
left outer join #Emps em ON ct.uid = em.compID
left outer join #RA ra ON ct.uid = ra.[user_id]
left outer join #Train tr ON ct.uid = tr.companyID
WHERE ds.renewDate > GETDATE() and ds.dealStatus not in (2,5,10,18)
GROUP BY cl.clientID, cl.SFDC_AccountId, em.emps, ra.ra, tr.passes

SELECT 
ff.clientID [Shorthorn ID], 
a.Id [SFDC ID], 
a.Name Company, 
con.fName + ' ' + con.sName [Primary Contact], 
con.Email, 
ctr.endDate [Contract Expiry Date], 
ctr.Contract_Value__c [Contract Value],
a.S__c Segmentation, 
ISNULL(SUM(ff.emps),0) [CitManager Employees], 
ISNULL(SUM(ff.ra),0) [Risk Assessments], 
ISNULL(SUM(ff.passes),0) [CitTrainer Passes],
MAX(ff.LastLogin) [Last Login Date/Time]

FROM 
#Fifteen ff
inner join [DB01].Salesforce.dbo.Account a ON LEFT(ff.SFDC_AccountId, 15) collate latin1_General_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS and IsActive__c = 'true'
inner join [DB01].Salesforce.dbo.Contract ctr ON a.Id = ctr.AccountID and LatestContract__c = 'true' and Status = 'Active'
left outer join Shorthorn..cit_sh_sites s ON ff.clientID = s.clientID and s.HeadOffice = 1
left outer join Shorthorn..cit_sh_contacts con ON s.genContact = con.contactID


WHERE
ff.LastLogin < '2015-01-01' or ff.LastLogin is null

GROUP BY 
ff.clientID, 
a.Id, 
a.Name, 
con.fName + ' ' + con.sName, 
con.Email, 
ctr.endDate, 
ctr.Contract_Value__c, 
a.S__c 

ORDER BY 
ff.clientID

DROP TABLE #Fifteen
DROP TABLE #Emps
DROP TABLE #RA
DROP TABLE #Train