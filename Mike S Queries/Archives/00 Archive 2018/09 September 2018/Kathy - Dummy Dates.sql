SELECT BookYear, BookMonthNo, BookMonth, SUM([#01/01/1980]) [#01/01/1980], SUM([#01/01/2000]) [#01/01/2000]
FROM
(
	SELECT 
	YEAR(signdate + 28) BookYear, 
	MONTH(signdate + 28) BookMonthNo, 
	DATENAME(month, signdate + 28) + ' ' + CONVERT(VarChar, YEAR(signdate + 28)) BookMonth, 
	SUM(case when CONVERT(date, firstVisit) = '1980-01-01' then 1 else 0 end) [#01/01/1980],
	SUM(case when CONVERT(date, firstVisit) = '2000-01-01' then 1 else 0 end) [#01/01/2000]

	FROM 
	Shorthorn..cit_sh_dealsHS 

	WHERE 
	CONVERT(date, firstVisit) in ('1980-01-01','2000-01-01') and YEAR(signdate + 28) in (2017,2018)

	GROUP BY 
	YEAR(signdate + 28), MONTH(signdate + 28), DATENAME(month, signdate + 28) + ' ' + CONVERT(VarChar, YEAR(signdate + 28))
		UNION
	SELECT 
	YEAR(signdate + 98) BookYear, 
	MONTH(signdate + 98) BookMonthNo, 
	DATENAME(month, signdate + 98) + ' ' + CONVERT(VarChar, YEAR(signdate + 98)) BookMonth, 
	SUM(case when CONVERT(date, dateInstalled) = '1980-01-01' then 1 else 0 end) [#01/01/1980],
	SUM(case when CONVERT(date, dateInstalled) = '2000-01-01' then 1 else 0 end) [#01/01/2000]

	FROM 
	Shorthorn..cit_sh_dealsHS 

	WHERE 
	CONVERT(date, dateInstalled) in ('1980-01-01','2000-01-01') and YEAR(signdate + 98) in (2017,2018)

	GROUP BY 
	YEAR(signdate + 98), MONTH(signdate + 98), DATENAME(month, signdate + 98) + ' ' + CONVERT(VarChar, YEAR(signdate + 98))
		UNION
	SELECT 
	YEAR(ds.signDate + 365) BookYear, 
	MONTH(ds.signDate + 365) BookMonthNo, 
	DATENAME(month, ds.signDate + 365) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 365)) BookMonth, 
	SUM(case when CONVERT(date, secVisit) = '1980-01-01' then 1 else 0 end) [#01/01/1980],
	SUM(case when CONVERT(date, secVisit) = '2000-01-01' then 1 else 0 end) [#01/01/2000]

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_deals ds ON dhs.dealID = ds.dealID

	WHERE 
	CONVERT(date, secVisit) in ('1980-01-01','2000-01-01') and ds.dealLength >= 24 and YEAR(ds.signDate + 365) in (2017,2018)

	GROUP BY 
	YEAR(ds.signDate + 365), MONTH(ds.signDate + 365), DATENAME(month, ds.signDate + 365) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 365))
		UNION
	SELECT 
	YEAR(ds.signDate + 730) BookYear, 
	MONTH(ds.signDate + 730) BookMonthNo, 
	DATENAME(month, ds.signDate + 730) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 730)) BookMonth, 
	SUM(case when CONVERT(date, thirVisit) = '1980-01-01' then 1 else 0 end) [#01/01/1980],
	SUM(case when CONVERT(date, thirVisit) = '2000-01-01' then 1 else 0 end) [#01/01/2000]

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_deals ds ON dhs.dealID = ds.dealID

	WHERE 
	CONVERT(date, thirVisit) in ('1980-01-01','2000-01-01') and ds.dealLength >= 36 and YEAR(ds.signDate + 730) in (2017,2018)

	GROUP BY 
	YEAR(ds.signDate + 730), MONTH(ds.signDate + 730), DATENAME(month, ds.signDate + 730) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 730))
		UNION
	SELECT 
	YEAR(ds.signDate + 1095) BookYear, 
	MONTH(ds.signDate + 1095) BookMonthNo, 
	DATENAME(month, ds.signDate + 1095) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 1095)) BookMonth, 
	SUM(case when CONVERT(date, fourthVisit) = '1980-01-01' then 1 else 0 end) [#01/01/1980],
	SUM(case when CONVERT(date, fourthVisit) = '2000-01-01' then 1 else 0 end) [#01/01/2000]

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_deals ds ON dhs.dealID = ds.dealID

	WHERE 
	CONVERT(date, fourthVisit) in ('1980-01-01','2000-01-01') and ds.dealLength >= 48 and YEAR(ds.signDate + 1095) in (2017,2018)

	GROUP BY 
	YEAR(ds.signDate + 1095), MONTH(ds.signDate + 1095), DATENAME(month, ds.signDate + 1095) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 1095))
		UNION
	SELECT 
	YEAR(ds.signDate + 1460) BookYear, 
	MONTH(ds.signDate + 1460) BookMonthNo, 
	DATENAME(month, ds.signDate + 1460) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 1460)) BookMonth, 
	SUM(case when CONVERT(date, fifthVisit) = '1980-01-01' then 1 else 0 end) [#01/01/1980],
	SUM(case when CONVERT(date, fifthVisit) = '2000-01-01' then 1 else 0 end) [#01/01/2000]

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_deals ds ON dhs.dealID = ds.dealID

	WHERE 
	CONVERT(date, fifthVisit) in ('1980-01-01','2000-01-01') and ds.dealLength >= 60 and YEAR(ds.signDate + 1460) in (2017,2018)

	GROUP BY 
	YEAR(ds.signDate + 1460), MONTH(ds.signDate + 1460), DATENAME(month, ds.signDate + 1460) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 1460))
		UNION
	SELECT 
	YEAR(ds.signDate + 1825) BookYear, 
	MONTH(ds.signDate + 1825) BookMonthNo, 
	DATENAME(month, ds.signDate + 1825) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 1825)) BookMonth, 
	SUM(case when CONVERT(date, sixthVisit) = '1980-01-01' then 1 else 0 end) [#01/01/1980],
	SUM(case when CONVERT(date, sixthVisit) = '2000-01-01' then 1 else 0 end) [#01/01/2000]

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_deals ds ON dhs.dealID = ds.dealID

	WHERE 
	CONVERT(date, sixthVisit) in ('1980-01-01','2000-01-01') and ds.dealLength >= 72 and YEAR(ds.signDate + 1825) in (2017,2018)

	GROUP BY 
	YEAR(ds.signDate + 1825), MONTH(ds.signDate + 1825), DATENAME(month, ds.signDate + 1825) + ' ' + CONVERT(VarChar, YEAR(ds.signDate + 1825))
) detail
GROUP BY
BookYear, BookMonthNo, BookMonth
ORDER BY
BookYear, BookMonthNo, BookMonth