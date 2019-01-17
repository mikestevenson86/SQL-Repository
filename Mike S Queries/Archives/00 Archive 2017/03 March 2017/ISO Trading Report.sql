SELECT *
FROM SalesforceReporting..TradingDashboard_ISODeals
UNION
SELECT 
3 rn,
'Conv. %' ISO,
CASE WHEN 
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1) = 0 
	or 
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2)
	/
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1)
	) * 100
END [This Week],
CASE WHEN 
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1) = 0 
	or 
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2)
	/
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1)
	) * 100
END [Last Week],
CASE WHEN 
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1) = 0 
	or 
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2) = 0
THEN 
	0 
ELSE 
	(
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2)
	/
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1)
	) * 100
END TMTD,
CASE WHEN 
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1) = 0 
	or 
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 2)
	/
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 1)
	) * 100
END [TM Forecast]
UNION
SELECT
7 rn,
'Conv. %' ISO,
CASE WHEN 
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5) = 0 
	or 
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6)
	/
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5)
	) * 100
END [This Week],
CASE WHEN 
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5) = 0 
	or 
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6)
	/
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5)
	) * 100
END [Last Week],
CASE WHEN 
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5) = 0 
	or 
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6) = 0
THEN 
	0 
ELSE 
	(
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6)
	/
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5)
	) * 100
END TMTD,
CASE WHEN 
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5) = 0 
	or 
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 6)
	/
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 5)
	) * 100
END [TM Forecast]
UNION
SELECT
11 rn,
'TCV' ISO,
CASE WHEN 
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9) = 0 
	or 
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9)
	) * 100
END [This Week],
CASE WHEN 
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9) = 0 
	or 
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9)
	) * 100
END [Last Week],
CASE WHEN 
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9) = 0 
	or 
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0
THEN 
	0 
ELSE 
	(
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT TMTD FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9)
	) * 100
END TMTD,
CASE WHEN 
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9) = 0 
	or 
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 9)
	) * 100
END [TM Forecast]
UNION
SELECT
12 rn,
'AACV' ISO,
CASE WHEN 
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0 
	or 
	(SELECT SUM(case when [Binary] = 1 /*and Dataset = 'ISO Deals'*/ and
	TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE()),0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end) FROM SalesforceReporting..TradingDashboardDeals) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [This Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT SUM(case when [Binary] = 1 /*and Dataset = 'ISO Deals'*/ and
	TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE()),0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end) FROM SalesforceReporting..TradingDashboardDeals)
	) * 100
END [This Week],
CASE WHEN 
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0 
	or 
	(SELECT SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,4) 
	then [Contract Length ] else 0 end) FROM SalesforceReporting..TradingDashboardDeals) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [Last Week] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,4) 
	then [Contract Length ] else 0 end) FROM SalesforceReporting..TradingDashboardDeals)
	) * 100
END  [Last Week],
CASE WHEN 
	(SELECT [TMTD] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0 
	or 
	(SELECT SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end) FROM SalesforceReporting..TradingDashboardDeals) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [TMTD] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end) FROM SalesforceReporting..TradingDashboardDeals)
	) * 100
END  TMTD,
CASE WHEN 
	(SELECT [TMTD] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10) = 0 
	or 
	(SELECT 
	(
	SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	tdm.TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end)
	/
		(
		SELECT SUM(WD_FLAG) 
		FROM SalesforceReporting..TradingDashboardDate 
		WHERE 
		TradingDashboard_Date between CONVERT(date, CONVERT(VarChar,DATEPART(Year, GETDATE()))+'-01-01') 
		and 
		CONVERT(date, GETDATE())
		)
	)
	* 
	DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
	-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
	-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
	-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end)
	+ 
	SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	tdm.TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end)
	FROM SalesforceReporting..TradingDashboardDeals tdm) = 0
THEN 
	0 
ELSE 
	(
	(SELECT [TM Forecast] FROM SalesforceReporting..TradingDashboard_ISODeals WHERE rn = 10)
	/
	(SELECT 
	(
	SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	tdm.TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end)
	/
		(
		SELECT SUM(WD_FLAG) 
		FROM SalesforceReporting..TradingDashboardDate 
		WHERE 
		TradingDashboard_Date between CONVERT(date, CONVERT(VarChar,DATEPART(Year, GETDATE()))+'-01-01') 
		and 
		CONVERT(date, GETDATE())
		)
	)
	* 
	DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
	-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
	-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
	-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end)
	+ 
	SUM(case when [Binary] = 1 and Dataset = 'ISO Deals' and
	tdm.TradingDashboard_Date between DATEADD(wk,DATEDIFF(wk,0,GETDATE())-1,0) and DATEADD(wk,DATEDIFF(wk,0,GETDATE()),4) 
	then [Contract Length ] else 0 end)
	FROM SalesforceReporting..TradingDashboardDeals tdm)
	) * 100
END [TM Forecast]

ORDER BY rn