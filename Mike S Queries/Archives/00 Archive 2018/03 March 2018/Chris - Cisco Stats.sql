SELECT 
YEAR(CONVERT(datetime, StartExcelTime)) SORTYEAR,
MONTH(CONVERT(datetime, StartExcelTime)) SORTMONTH,
DATENAME(Month, CONVERT(datetime, StartExcelTime)) + ' ' + CONVERT(VarChar, YEAR(CONVERT(datetime, StartExcelTime))) MonthYear,
COUNT(1) TotalOutboundCalls,
SUM(TalkTime_Secs) TotalOutboundTalkSecs,
AVG(TalkTime_Secs) AverageOutboundTalkSecs,
SUM(CONVERT(decimal(18,5), TalkTime_Secs)) / 60 TotalOutboundTalkMins,
AVG(CONVERT(decimal(18,5), TalkTime_Secs)) / 60 AverageOutboundTalkMins

FROM
SalesforceReporting..Contact_Centre

WHERE
[TYPE] = 'Ext/Out' 
--and YEAR(CONVERT(datetime, StartExcelTime)) = 2017

GROUP BY
YEAR(CONVERT(datetime, StartExcelTime)),
MONTH(CONVERT(datetime, StartExcelTime)),
DATENAME(Month, CONVERT(datetime, StartExcelTime)) + ' ' + CONVERT(VarChar, YEAR(CONVERT(datetime, StartExcelTime)))

ORDER BY
SORTYEAR,
SORTMONTH

