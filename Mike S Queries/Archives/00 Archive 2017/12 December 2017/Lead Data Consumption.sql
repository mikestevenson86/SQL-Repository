IF OBJECT_ID('tempdb..#Current') IS NOT NULL
	BEGIN
		DROP TABLE #Current
	END

IF OBJECT_ID('tempdb..#Old') IS NOT NULL
	BEGIN
		DROP TABLE #Old
	END

DECLARE @Table as VarChar(MAX)
DECLARE @Old TABLE (Source__c VarChar(255), Sector__c VarChar(255), TEXT_BDM__c VarChar(255), FTE VarChar(255), Prospects int)

SELECT Source__c, Sector__c, TEXT_BDM__c, 
case when FT_Employees__c between 0 and 20 then '000 - 020'
when FT_Employees__c between 20 and 50 then '020 - 050'
when FT_Employees__c between 50 and 100 then '050 - 100'
when FT_Employees__c between 100 and 200 then '100 - 200'
when FT_Employees__c between 200 and 225 then '200 - 225'
when FT_Employees__c > 225 then '> 225' end FTE,
COUNT(Id) Prospects
INTO #Current
FROM Salesforce..Lead
WHERE
RecordTypeId = '012D0000000NbJsIAK'
		and 
		Status = 'open' 
		and 
		(
			Toxic_SIC__c <> 'true' 
			or 
			(
				Toxic_SIC__c = 'true' 
				and 
				CitationSector__c = 'ACCOMODATION' 
				and 
				SIC2007_Code3__c in ('55100','56101','26302') 
				and 
				FT_Employees__c between 10 and 225
			)
		)
		and           
		(
			(FT_Employees__c < 225 and CitationSector__c = 'Care')
			or 
			FT_Employees__c between 6 and 225
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c in ('WILLIAM MCFAULDS', 'SCOTT ROBERTS', 'DOMINIC MILLER'))
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c = 'GARY SMITH')
			or 
			(FT_Employees__c between 10 and 225 and SIC2007_Code3__c in (56101,55900,55100,56302))
			or 
			(FT_Employees__c between 4 and 225 and ISNULL(CitationSector__c,'') in ('CLEANING','HORTICULTURE'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY'))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'') like '%FUNERAL%')
		)
		and 
		ISNULL(SIC2007_Code3__c,0) <> 0
		and 
		ISNULL(Phone, '') <> ' ' and ISNULL(Phone, '') <> ''
		and 
		ISNULL(IsTPS__c, '') <> 'yes'
		and 
		ISNULL(TEXT_BDM__c, '') not in 
		(
			'Unassigned BDM', 
			'Salesforce Admin', 
			'',
			'Jaquie Watt', 
			'Jo Brown', 
			'Justin Robinson', 
			'Louise Clarke', 
			'Mark Goodrum', 
			'Matthew Walker', 
			'Mike Stevenson', 
			'Peter Sherlock', 
			'Susan Turner', 
			'Tushar Sanghrajka'
		)
		and 
		ISNULL(LeadSource, '') not like '%cross sell - Citation%'
		and 
		ISNULL(LeadSource, '') not like '%cross sell - qms%'
		and 
		ISNULL(CitationSector__c,'') in
		(
		'CARE','GLASS & GLAZING','ARCHITECTURAL & ENGINEERING','MANUFACTURING','CONSTRUCTION','TRANSPORATION AND STORAGE','SPORTS & ENTERTAINMENT',
		'WATER SUPPLY ACTIVITIES','VETERINARY ACTIVITIES','INFORMATION AND COMMUNICATION','ACCOMODATION','CLEANING','ADMINISTRATIVE AND SUPPORT SERVICE ACTIVITIES',
		'RENTING & LEASING','FINANCIAL AND INSURANCE ACTIVITIES','WHOLESALE EXCLUDING MOTOR','AGRICULTURE','DAY NURSERY','HORTICULTURE','MOTORTRADE',
		'FOOD & BEVERAGE','RETAIL EXCLUDING MOTOR','SECURITY','PROFESSIONAL ACTIVITIES','FUNERAL SERVICES','REAL ESTATE ACTIVITIES','B2C SERVICES',
		'DENTAL PRACTICE','HUMAN HEALTH ACTIVITIES'
		)
		GROUP BY
		Source__c, Sector__c, TEXT_BDM__c, 
		case when FT_Employees__c between 0 and 20 then '000 - 020'
		when FT_Employees__c between 20 and 50 then '020 - 050'
		when FT_Employees__c between 50 and 100 then '050 - 100'
		when FT_Employees__c between 100 and 200 then '100 - 200'
		when FT_Employees__c between 200 and 225 then '200 - 225'
		when FT_Employees__c > 225 then '> 225' end

SET @Table = 'SELECT Source__c, Sector__c, TEXT_BDM__c, 
case when FT_Employees__c between 0 and 20 then ''000 - 020''
when FT_Employees__c between 20 and 50 then ''020 - 050''
when FT_Employees__c between 50 and 100 then ''050 - 100''
when FT_Employees__c between 100 and 200 then ''100 - 200''
when FT_Employees__c between 200 and 225 then ''200 - 225''
when FT_Employees__c > 225 then ''> 225'' end FTE,
COUNT(Id) Prospects
FROM SalesforceBackup..Lead' 
+ CONVERT(VarChar, YEAR(DATEADD(day,-1,GETDATE()))) 
+ CONVERT(VarChar, MONTH(DATEADD(day,-1,GETDATE())))
+ CONVERT(VarChar, DAY(DATEADD(day,-1,GETDATE())))
+ ' WHERE
RecordTypeId = ''012D0000000NbJsIAK''
		and 
		Status = ''open''
		and 
		(
			Toxic_SIC__c <> ''true'' 
			or 
			(
				Toxic_SIC__c = ''true'' 
				and 
				CitationSector__c = ''ACCOMODATION'' 
				and 
				SIC2007_Code3__c in (''55100'',''56101'',''26302'') 
				and 
				FT_Employees__c between 10 and 225
			)
		)
		and           
		(
			(FT_Employees__c < 225 and CitationSector__c = ''Care'')
			or 
			FT_Employees__c between 6 and 225
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c in (''WILLIAM MCFAULDS'', ''SCOTT ROBERTS'', ''DOMINIC MILLER''))
			or 
			(FT_Employees__c between 5 and 225 and TEXT_BDM__c = ''GARY SMITH'')
			or 
			(FT_Employees__c between 10 and 225 and SIC2007_Code3__c in (56101,55900,55100,56302))
			or 
			(FT_Employees__c between 4 and 225 and ISNULL(CitationSector__c,'''') in (''CLEANING'',''HORTICULTURE''))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'''') in (''DENTAL PRACTICE'',''DAY NURSERY'',''PHARMACY''))
			or 
			(FT_Employees__c between 3 and 225 and ISNULL(CitationSector__c,'''') like ''%FUNERAL%'')
		)
		and 
		ISNULL(SIC2007_Code3__c, 0) <> 0
		and 
		ISNULL(Phone, '''') <> '' '' and ISNULL(Phone, '''') <> ''''
		and 
		ISNULL(IsTPS__c, '''') <> ''yes''
		and 
		ISNULL(TEXT_BDM__c, '''') not in 
		(
			''Unassigned BDM'', 
			''Salesforce Admin'', 
			'''',
			''Jaquie Watt'', 
			''Jo Brown'', 
			''Justin Robinson'', 
			''Louise Clarke'', 
			''Mark Goodrum'', 
			''Matthew Walker'', 
			''Mike Stevenson'', 
			''Peter Sherlock'', 
			''Susan Turner'', 
			''Tushar Sanghrajka''
		)
		and 
		ISNULL(LeadSource, '''') not like ''%cross sell - Citation%''
		and 
		ISNULL(LeadSource, '''') not like ''%cross sell - qms%''
		and 
		ISNULL(CitationSector__c,'''') in
		(
		''CARE'',''GLASS & GLAZING'',''ARCHITECTURAL & ENGINEERING'',''MANUFACTURING'',''CONSTRUCTION'',''TRANSPORATION AND STORAGE'',''SPORTS & ENTERTAINMENT'',
		''WATER SUPPLY ACTIVITIES'',''VETERINARY ACTIVITIES'',''INFORMATION AND COMMUNICATION'',''ACCOMODATION'',''CLEANING'',''ADMINISTRATIVE AND SUPPORT SERVICE ACTIVITIES'',
		''RENTING & LEASING'',''FINANCIAL AND INSURANCE ACTIVITIES'',''WHOLESALE EXCLUDING MOTOR'',''AGRICULTURE'',''DAY NURSERY'',''HORTICULTURE'',''MOTORTRADE'',
		''FOOD & BEVERAGE'',''RETAIL EXCLUDING MOTOR'',''SECURITY'',''PROFESSIONAL ACTIVITIES'',''FUNERAL SERVICES'',''REAL ESTATE ACTIVITIES'',''B2C SERVICES'',
		''DENTAL PRACTICE'',''HUMAN HEALTH ACTIVITIES''
		)
GROUP BY Source__c, Sector__c, TEXT_BDM__c, case when FT_Employees__c between 0 and 20 then ''000 - 020''
when FT_Employees__c between 20 and 50 then ''020 - 050''
when FT_Employees__c between 50 and 100 then ''050 - 100''
when FT_Employees__c between 100 and 200 then ''100 - 200''
when FT_Employees__c between 200 and 225 then ''200 - 225''
when FT_Employees__c > 225 then ''> 225'' end
ORDER BY Source__c, Sector__c, TEXT_BDM__c, FTE'

INSERT @Old exec (@Table)

SELECT 
c.Source__c [Source], 
c.Sector__c [Citation Sector], 
c.TEXT_BDM__c BDM, 
c.FTE, 
ISNULL(o.Prospects, 0) Yesterday, 
ISNULL(c.Prospects, 0) Today, 
ISNULL(c.Prospects, 0) - ISNULL(o.Prospects, 0) [Difference]

FROM 
#Current c
left outer join @Old o ON ISNULL(c.Source__c, '') = ISNULL(o.Source__c, '')
						and ISNULL(c.Sector__c, '') = ISNULL(o.Sector__c, '')
						and ISNULL(c.TEXT_BDM__c, '') = ISNULL(o.TEXT_BDM__c, '')
						and ISNULL(c.FTE, '') = ISNULL(o.FTE, '')