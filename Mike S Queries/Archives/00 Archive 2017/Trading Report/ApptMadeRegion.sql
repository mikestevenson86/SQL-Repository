SELECT
(
SELECT 
DateValue 
FROM 
SalesforceReporting..DateChart 
WHERE 
[Weekday] = DATEPART(dw,GETDATE()) 
and 
MonthWeek = DATEPART(WEEK, GETDATE())-DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM,0,GETDATE()), 0))+ 1
and 
[Month] = DATEPART(mm, GETDATE())
and
[YEAR] = DATEPART(yy,GETDATE())-1
) ReportDateLY,
Region,
SUM([Last Week]) [Last Week],
SUM(TMLastWeek) TMLastWeek,
SUM([This Week]) [This Week],
SUM(TMThisWeek) TMThisWeek,
SUM(TMTD) TMTD,
SUM(TMTD_Approved) TMTD_Approved,
SUM(WorkingDaysRemaining) WorkingDaysRemaining,
SUM([TM Forecast]) [TM Forecast],
SUM([TM Budget]) [TM Budget],
SUM([Intra Last Week]) [Intra Last Week],
SUM([Intra This Week]) [Intra This Week],
SUM([Intra TMTD]) [Intra TMTD],
SUM([Intra TMTD All]) [Intra TMTD All],
SUM([Intra TM Budget]) [Intra TM Budget],
SUM([Last Week LY]) [Last Week LY],
SUM([This Week LY]) [This Week LY],
SUM([TMTD LY]) [TMTD LY],
SUM([TMTD Approved LY]) [TMTD Approved LY],
SUM([Full TM LY]) [Full TM LY],
SUM([Intra Last Week LY]) [Intra Last Week LY],
SUM([Intra This Week LY]) [Intra This Week LY],
SUM([Intra TMTD LY]) [Intra TMTD LY],
SUM([Intra TMTD All LY]) [Intra TMTD All LY],
SUM([Intra Full TM LY]) [Intra Full TM LY]/*,
SUM([TM Forecast]) * (SUM([Intra Full TM LY]) / SUM([Full TM LY])) [Intra TM Forecast]
*/
FROM
(
	SELECT 
	tdm.Region,
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week],
	(
		SELECT SUM(WD_Flag)
		FROM SalesforceReporting..TradingDashboardDate td
		WHERE 
		DATEPART(week, dateadd(wk, datediff(wk,0,td.TradingDashboard_Date),0)) = DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)) 
	) TMLastWeek,
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [This Week],
	(
		SELECT SUM(WD_Flag)
		FROM SalesforceReporting..TradingDashboardDate td
		WHERE 
		DATEPART(week, dateadd(wk, datediff(wk,0,td.TradingDashboard_Date),0)) = DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)) 
	) TMThisWeek,
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 then 1 else 0 end) [TMTD],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and [Prospect Status] = 'Approved' then 1 else 0 end) TMTD_Approved,
	DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
	-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
	-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
	-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end) WorkingDaysRemaining,
	(
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 then 1 else 0 end)
	/
	(
		SELECT SUM(WD_FLAG) 
		FROM SalesforceReporting..TradingDashboardDate 
		WHERE 
		TradingDashboard_Date between DATEADD(mm,DATEDIFF(mm,0,GETDATE()),0) and CONVERT(date, GETDATE()))
	) 
	* 
	DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
	-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
	-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
	-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end)
	+ 
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 then 1 else 0 end) [TM Forecast],
	(
		SELECT MADE 
		FROM SalesforceReporting..TradingDashboardBudget tdb 
		left outer join SalesforceReporting..TradingDashboardMade tdm ON tdb.Channel = tdm.Category 
		WHERE tdb.[Year] = DATEPART(Year, GETDATE()) and tdb.[Month] = DATEPART(Month, GETDATE())
	) [TM Budget],
	-- Intra Week
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Intra Last Week],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [Intra This Week],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 then 1 else 0 end) [Intra TMTD],
	(
	SELECT SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
	DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end)
	FROM SalesforceReporting..TradingDashboardMade
	) [Intra TMTD All],
	(
		SELECT MADE 
		FROM SalesforceReporting..TradingDashboardBudget tdb 
		left outer join SalesforceReporting..TradingDashboardMade tdm ON tdb.Channel = tdm.Category 
		WHERE tdb.[Year] = DATEPART(Year, GETDATE()) and tdb.[Month] = DATEPART(Month, GETDATE()) and DATEDIFF(w,TradingDashboard_Date,SatDate)=0
	) [Intra TM Budget],
	0 [Last Week LY],
	0 [This Week LY],
	0 [TMTD LY],
	0 [TMTD Approved LY],
	0 [Full TM LY],
	0 [Intra Last Week LY],
	0 [Intra This Week LY],
	0 [Intra TMTD LY],
	0 [Intra TMTD All LY],
	0 [Intra Full TM LY]

	FROM SalesforceReporting..TradingDashboardMade tdm

	WHERE DATEPART(Month,TradingDashboard_Date) = DATEPART(Month,GETDATE()) and DATEPART(Year,TradingDashboard_Date) = DATEPART(Year,GETDATE())

	GROUP BY
	tdm.Region

	UNION

	SELECT
	tdm.Region,
	0 [Last Week],
	0 TMLastWeek,
	0 [This Week],
	0 TMThisWeek,
	0 TMTD,
	0 TMTD_Approved,
	0 WorkingDaysRemaining,
	0 TM_Forecast,
	0 [TM Budget],
	0 [Intra Last Week],
	0 [Intra This Week],
	0 [Intra TMTD],
	0 [Intra TMTD All],
	0 [Intra TM Budget],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week LY],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and 
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [This Week LY],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and
	TradingDashboard_Date between CONVERT(date, DATEADD(Year,-1,DATEADD(Month,DATEDIFF(Month,0,GETDATE()),0))) and CONVERT(date, DATEADD(Year,-1,GETDATE())) then 1 else 0 end) [TMTD LY],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and [Prospect Status] = 'Approved' and
	TradingDashboard_Date between CONVERT(date, DATEADD(Year,-1,DATEADD(Month,DATEDIFF(Month,0,GETDATE()),0))) and CONVERT(date, DATEADD(Year,-1,GETDATE())) then 1 else 0 end) [TMTD Approved LY],
	SUM(
	case when tdm.[Expected Pipeline to Approval] = 1 then 1 else 0 end
	) [Full TM LY],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Intra Last Week LY],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
	[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [Intra This Week LY],
	SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
	TradingDashboard_Date between CONVERT(date, DATEADD(Year,-1,DATEADD(Month,DATEDIFF(Month,0,GETDATE()),0))) and CONVERT(date, DATEADD(Year,-1,GETDATE())) then 1 else 0 end) [Intra TMTD LY],
	(
	SELECT SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
	TradingDashboard_Date between CONVERT(date, DATEADD(Year,-1,DATEADD(Month,DATEDIFF(Month,0,GETDATE()),0))) and CONVERT(date, DATEADD(Year,-1,GETDATE()))then 1 else 0 end)
	FROM SalesforceReporting..TradingDashboardMade
	) [Intra TMTD All LY],
	SUM(
	case when DATEDIFF(m,TradingDashboard_Date,SatDate)=0 then 1 else 0 end
	) [Intra Full TM LY]

	FROM SalesforceReporting..TradingDashboardMade tdm

	WHERE DATEPART(Month,TradingDashboard_Date) = DATEPART(Month,GETDATE()) and DATEPART(Year,TradingDashboard_Date) = DATEPART(Year,GETDATE())-1

	GROUP BY
	tdm.Region
	) detail

GROUP BY
Region