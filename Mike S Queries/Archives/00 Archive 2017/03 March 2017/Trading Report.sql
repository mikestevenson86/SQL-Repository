SELECT 
tdm.Category,
tdm.[Generic Made/Sat Criteria], 
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [This Week],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end) [TMTD],
DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end) WorkingDaysRemaining,
(
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end)
/
(
	SELECT SUM(WD_FLAG) 
	FROM SalesforceReporting..TradingDashboardDate 
	WHERE 
	TradingDashboard_Date between CONVERT(date, CONVERT(VarChar,DATEPART(Year, GETDATE()))+'-01-01') 
	and 
	CONVERT(date, GETDATE()))
) 
* 
DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end)
+ 
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end) [TM Forecast],
(
	SELECT MADE 
	FROM SalesforceReporting..TradingDashboardBudget tdb 
	left outer join SalesforceReporting..TradingDashboardMade tdm ON tdb.Channel = tdm.Category 
	WHERE tdb.[Year] = DATEPART(Year, GETDATE()) and tdb.[Month] = DATEPART(Month, GETDATE())
) [TM Budget],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE())-1 and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Last Week LY],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE())-1 and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [This Week LY],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE())-1 and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end) [TMTD LY],
SUM(
case when DATEPART(Year,tdm.TradingDashboard_Date) = DATEPART(Year,GETDATE())-1 and
tdm.[Expected Pipeline to Approval] = 1 then 1 else 0 end
) [Full TM LY],
-- Intra Week
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Intra Last Week],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [Intra This Week],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end) [Intra TMTD],
case when SUM(
case when DATEPART(Year,tdm.TradingDashboard_Date) = DATEPART(Year,GETDATE())-1 and
DATEDIFF(m,TradingDashboard_Date,SatDate)=0 then 1 else 0 end
) = 0
or
SUM(
case when DATEPART(Year,tdm.TradingDashboard_Date) = DATEPART(Year,GETDATE())-1 and
tdm.[Expected Pipeline to Approval] = 1 then 1 else 0 end
) = 0 then 0 else
(
(
SUM(
case when DATEPART(Year,tdm.TradingDashboard_Date) = DATEPART(Year,GETDATE())-1 and
DATEDIFF(m,TradingDashboard_Date,SatDate)=0 then 1 else 0 end
)
/
SUM(
case when DATEPART(Year,tdm.TradingDashboard_Date) = DATEPART(Year,GETDATE())-1 and
tdm.[Expected Pipeline to Approval] = 1 then 1 else 0 end
)
) * 100
) * 
(
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end)
/
(
	SELECT SUM(WD_FLAG) 
	FROM SalesforceReporting..TradingDashboardDate 
	WHERE 
	TradingDashboard_Date between CONVERT(date, CONVERT(VarChar,DATEPART(Year, GETDATE()))+'-01-01') 
	and 
	CONVERT(date, GETDATE()))
) 
* 
DATEDIFF(dd, GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))
-DATEDIFF(wk,GETDATE(),dateadd(month, datediff(month, 0, getdate())+1, -1))*2
-(CASE WHEN DATENAME(DW, GETDATE()) = 'Sunday' then 1 else 0 end)
-(CASE WHEN DATENAME(DW,dateadd(month, datediff(month, 0, getdate())+1, -1)) = 'Saturday' then 1 else 0 end)
+ 
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE()) and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end) end [Intra TM Forecast],
(
	SELECT MADE 
	FROM SalesforceReporting..TradingDashboardBudget tdb 
	left outer join SalesforceReporting..TradingDashboardMade tdm ON tdb.Channel = tdm.Category 
	WHERE tdb.[Year] = DATEPART(Year, GETDATE()) and tdb.[Month] = DATEPART(Month, GETDATE()) and DATEDIFF(w,TradingDashboard_Date,SatDate)=0
) [Intra TM Budget],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE())-1 and
DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0))) then 1 else 0 end) [Intra Last Week LY],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE())-1 and
DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0))) then 1 else 0 end) [Intra This Week LY],
SUM(case when [Binary] = 1 and [Expected Pipeline to Approval] = 1 and LEFT(YearMonth,4) = DATEPART(Year,GETDATE())-1 and
DATEDIFF(w,TradingDashboard_Date,SatDate)=0 and
(
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate())-1,0)))
or
[Adjusted Date Made] = 'Week'+CONVERT(VarChar,DATEPART(week, dateadd(wk, datediff(wk,0,getdate()),0)))
) then 1 else 0 end) [Intra TMTD LY],
SUM(
case when DATEPART(Year,tdm.TradingDashboard_Date) = DATEPART(Year,GETDATE())-1 and
DATEDIFF(m,TradingDashboard_Date,SatDate)=0 then 1 else 0 end
) [Intra Full TM LY]

FROM SalesforceReporting..TradingDashboardMade tdm

GROUP BY
tdm.Category,
tdm.[Generic Made/Sat Criteria]