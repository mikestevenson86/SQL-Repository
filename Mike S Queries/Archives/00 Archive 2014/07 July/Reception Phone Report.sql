SELECT 
LEFT(cl.[Started (Dist) (Display)],10) CallDate,
cl.[Dev Name (Off)] Agent,
COUNT(*) Calls,
SUM(case when cl.ans = 'Yes' then 1 else 0 end) Answered,
SUM(case when cl.S = 'Abandoned' then 1 else 0 end) Abandoned


FROM 
SalesforceReporting..[Reception_Historic_Call_List] cl
inner join SalesforceReporting..PhoneList pl on cl.[Dev (Off)] = pl.Phone

WHERE
pl.Dept in ('Reception','ELT')

GROUP BY
LEFT(cl.[Started (Dist) (Display)],10),
cl.[Dev Name (Off)]

ORDER BY
LEFT(cl.[Started (Dist) (Display)],10),
cl.[Dev Name (Off)]