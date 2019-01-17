IF OBJECT_ID('tempdb..#Crit') IS NOT NULL
	BEGIN
		DROP TABLE #Crit
	END

IF OBJECT_ID('tempdb..#SetOne') IS NOT NULL
	BEGIN
		DROP TABLE #SetOne
	END
	
IF OBJECT_ID('tempdb..#SetTwo') IS NOT NULL
	BEGIN
		DROP TABLE #SetTwo
	END

SELECT COUNT(distinct l.Id) Diallable
INTO #Crit
from Salesforce..lead l
where 
(
RecordTypeId = '012D0000000NbJsIAK'
and Status = 'open'
and isnull(Callback_Date_Time__c,'') = ''
and Toxic_SIC__c <> 'true'
and FT_Employees__c between 6 and 225
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(Phone,'') <> ' ' and isnull(Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(Source__c,'') not like '%lb_%' and isnull(Source__c,'')  not like '%closed lost%' and isnull(Source__c,'')  not like '%marketing lost%' and isnull(Source__c,'')  not like '%toxic%' 
and isnull(CitationSector__c,'') <> 'EDUCATION'
)
or
(
RecordTypeId = '012D0000000NbJsIAK'
and Status = 'open'
and isnull(Callback_Date_Time__c,'') = ''
--and Toxic_SIC__c <> 'true'
and FT_Employees__c between 10 and 225
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(Phone,'') <> ' ' and isnull(Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(Source__c,'') not like '%lb_%' and isnull(Source__c,'')  not like '%closed lost%' and isnull(Source__c,'')  not like '%marketing lost%' and isnull(Source__c,'')  not like '%toxic%' 
--and isnull(CitationSector__c,'') <> 'EDUCATION'
and SIC2007_Code3__c in (56101,55900,55100,56302)
)
and Affinity_Cold__c is not null


SELECT [Month Dialled], SUM(Dials) IndividualDials, (SELECT Diallable FROM #Crit) Diallable,(SELECT Diallable FROM #Crit)- COUNT(distinct ID) UniqueNotDialled
INTO #SetOne
FROM SalesforceReporting..DiallerActivity
WHERE [Month Dialled] = 'July'
GROUP BY [Month Dialled]

SELECT DATENAME(month,l.CreatedDate) [Month Dialled], COUNT(l.Id) InsertedJuly
INTO #SetTwo
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.CreatedById = u.Id
WHERE DATENAME(month,l.CreatedDate) = 'July' and YEAR(l.CreatedDate) = 2017 and u.Name = 'Salesforce Admin'
GROUP BY DATENAME(month,l.CreatedDate)

SELECT detail.[Month Dialled], so.Diallable, COUNT(Id) UniqueDialled, SUM(Closed) UniqueClosed, SUM([Open]) UniqueOpen, so.UniqueNotDialled,
so.IndividualDials, st.InsertedJuly
FROM
(
SELECT [Month Dialled], Id, SUM(case when Status in ('Closed','Suspended') then 1 else 0 end) Closed, SUM(case when Status in ('Open','callback Requested') then 1 else 0 end) [Open]
FROM SalesforceReporting..DiallerActivity
WHERE [Month Dialled] = 'July'
GROUP BY [Month Dialled], Id
) detail
left outer join #SetOne so ON detail.[Month Dialled] = so.[Month Dialled]
left outer join #SetTwo st ON detail.[Month Dialled] = st.[Month Dialled]
GROUP BY detail.[Month Dialled], so.Diallable, so.UniqueNotDialled, so.IndividualDials, st.InsertedJuly