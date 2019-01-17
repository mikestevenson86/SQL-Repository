DELETE FROM  SalesforceReporting..toxicdata
WHERE [Prospect ID] in
(
	SELECT td.[Prospect ID]
	FROM SalesforceReporting..toxicdata td
	inner join SalesforceReporting..[20170614_ToxicRelease_SB] tr ON REPLACE(case when td.Phone like '0%' then td.Phone else '0'+td.Phone end,' ','')
																= REPLACE(case when tr.Phone like '0%' then tr.Phone else '0'+tr.Phone end,' ','')
	WHERE ISNULL(tr.Phone,'') <> ''
		UNION
	SELECT td.[Prospect ID]
	FROM SalesforceReporting..toxicdata td
	inner join SalesforceReporting..[20170614_ToxicRelease_SB] tr ON REPLACE(REPLACE(td.[Company   Account],'Ltd',''),'Limited','') = REPLACE(REPLACE(tr.Company,'Ltd',''),'Limited','')
																	and REPLACE(td.[Post Code],' ','') = REPLACE(tr.Postcode,' ','')
	WHERE ISNULL(tr.Company,'') <> '' and ISNULL(tr.PostCode,'') <> ''
)