SELECT 
CONVERT(date, act_date) CallDate,
LEFT(act_time,2) OClock, 
SUM(case when call_type in (0,2,4) then 1 else 0 end) LiveConnects,
SUM(case when call_type in (1,3,5) then 1 else 0 end) TotalDropped,
SUM(case when ch.[status] = 'CS' then 1 else 0 end) CallbacksMade,
SUM(case when ch.appl = 'GRID' then 1 else 0 end) CalledCallbacks,
SUM(case when ch.[status] = 'D' then 1 else 0 end) Disconnected,
SUM(case when ch.[status] = 'CL' then 1 else 0 end) Closed,
SUM(case when ch.[status] = 'AP' then 1 else 0 end) AppointmentsMade

FROM 
Enterprise..call_history ch

WHERE 
act_date >= '2014-05-26' 
and 
act_time between '120000' and '140000'

GROUP BY
CONVERT(date, act_date),
LEFT(act_time,2)

ORDER BY
CONVERT(date, act_date),
LEFT(act_time,2)