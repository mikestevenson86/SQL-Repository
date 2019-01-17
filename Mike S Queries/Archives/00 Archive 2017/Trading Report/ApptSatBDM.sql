SELECT
BDMStatus, 
SUM([Last Week]) [Last Week],
SUM([This Week]) [This Week],
SUM(TMTD) TMTD,
SUM(TMTD_Feedback) TMTD_Feedback,
SUM([TM Forecast]) [TM Forecast],
SUM([Last Week Intra]) [Last Week Intra],
SUM([This Week Intra]) [This Week Intra],
SUM([TMTD Intra]) [TMTD Intra],
SUM([TM Forecast Intra]) [TM Forecast Intra],
SUM([TM Budget]) [TM Budget],
SUM([Last Week LY]) [Last Week LY],
SUM([This Week LY]) [This Week LY],
SUM([TMTD LY]) [TMTD LY],
SUM(TMTD_Feedback_LY) TMTD_Feedback_LY,
SUM([Full TM LY]) [Full TM LY],
SUM([Last Week LY Intra]) [Last Week LY Intra],
SUM([This Week LY Intra]) [This Week LY Intra],
SUM([TMTD LY Intra]) [TMTD LY Intra],
SUM([Full TM LY Intra]) [Full TM LY Intra],
SUM(WorkingDaysRemaining) WorkingDaysRemaining
FROM
(
SELECT 
case when tds.BDM_Non_BDM = 'Non-BDM Sat' then 'Non BDM Sat' else 'BDM Sat' end BDMStatus,  
SUM(case when [Binary] = 1 and [Type] = 'New Business' and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and 
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [This Week],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end) [TMTD],
(
SELECT SUM(case when [Binary] = 1 and [Type] = 'New Business' and 
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end)
FROM SalesforceReporting..TradingDashboardSat tds
) TMTD_Feedback,
(
SUM(case when [Binary] = 1 and [Type] = 'New Business' and 
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end)
/
(
	SELECT SUM(WD_FLAG) 
	FROM SalesforceReporting..TradingDashboardDate 
	WHERE TradingDashboard_Date between DATEADD(mm,DATEDIFF(mm,0,GETDATE()),0) and CONVERT(date, GETDATE()))
) 
* 
(
DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end)
)
+ 
SUM(case when [Binary] = 1 and [Type] = 'New Business' and 
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end) [TM Forecast],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week Intra],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end)  [This Week Intra],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end) [TMTD Intra],
(
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end)
/
(
	SELECT SUM(WD_FLAG) 
	FROM SalesforceReporting..TradingDashboardDate 
	WHERE TradingDashboard_Date between DATEADD(mm,DATEDIFF(mm,0,GETDATE()),0) and CONVERT(date, GETDATE()))
) 
* 
(
DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end)
)
+ 
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end) [TM Forecast Intra],
(
	SELECT SAT
	FROM SalesforceReporting..TradingDashboardBudget tdb 
	left outer join SalesforceReporting..TradingDashboardSat tds ON tdb.Channel = tds.[Generic Made/Sat Criteria]
	WHERE tdb.[Year] = DATEPART(Year, GETDATE()) and tdb.[Month] = DATEPART	(Month, GETDATE())
) [TM Budget],
0 [Last Week LY],
0 [This Week LY],
0 [TMTD LY],
0 TMTD_Feedback_LY,
0 [Full TM LY],
0 [Last Week LY Intra],
0 [This Week LY Intra],
0 [TMTD LY Intra],
0 [Full TM LY Intra],
0 WorkingDaysRemaining

FROM SalesforceReporting..TradingDashboardSat tds

WHERE
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) and DATEPART(Year, TradingDashboard_Date) = DATEPART(Year, GETDATE())

GROUP BY
case when tds.BDM_Non_BDM = 'Non-BDM Sat' then 'Non BDM Sat' else 'BDM Sat' end 

UNION

SELECT
case when tds.BDM_Non_BDM = 'Non-BDM Sat' then 'Non BDM Sat' else 'BDM Sat' end BDMStatus, 
0 [Last Week],
0 [This Week],
0 [TMTD],
0 TMTD_Feedback,
0 [TM Forecast],
0 [Last Week Intra],
0 [This Week Intra],
0 [TMTD Intra],
0 [TM Forecast Intra],
0 [TM Budget],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and 
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week LY],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and 
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [This Week LY],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and
TradingDashboard_Date between CONVERT(date, DATEADD(Year,-1,DATEADD(Month,DATEDIFF(Month,0,GETDATE()),0))) and CONVERT(date, DATEADD(Year,-1,GETDATE())) then 1 else 0 end) [TMTD LY],
(
SELECT SUM(case when [Binary] = 1 and [Type] = 'New Business' and
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE())-1 then 1 else 0 end)
FROM SalesforceReporting..TradingDashboardSat tds
) TMTD_Feedback_LY,
SUM(
case when DATEPART(Year,tds.TradingDashboard_Date) = DATEPART(Year,GETDATE())-1 then 1 else 0 end
) [Full TM LY],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week LY Intra],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [This Week LY Intra],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
TradingDashboard_Date between CONVERT(date, DATEADD(Year,-1,DATEADD(Month,DATEDIFF(Month,0,GETDATE()),0))) and CONVERT(date, DATEADD(Year,-1,GETDATE())) then 1 else 0 end) [TMTD LY Intra],
SUM(case when [Binary] = 1 and [Type] = 'New Business' and [Intra-Month] = 'Intra-Month' and
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) then 1 else 0 end) [Full TM LY Intra],
DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end) WorkingDaysRemaining

FROM SalesforceReporting..TradingDashboardSat tds

WHERE
DATEPART(Month, TradingDashboard_Date) = DATEPART(Month, GETDATE()) and DATEPART(Year, TradingDashboard_Date) = DATEPART(Year, GETDATE())-1

GROUP BY
case when tds.BDM_Non_BDM = 'Non-BDM Sat' then 'Non BDM Sat' else 'BDM Sat' end 
) detail

GROUP BY
BDMStatus