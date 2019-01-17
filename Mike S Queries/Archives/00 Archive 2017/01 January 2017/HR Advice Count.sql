SELECT 
DATEPART(month,dateOfCall) [Month No],
DATENAME(month,dateOfCall) [Month Name],
COUNT(ad.AdviceId) Advice

FROM 
Shorthorn..cit_sh_advice ad

WHERE
CONVERT(date, dateOfCall) between '2016-01-01' and '2016-12-31'

GROUP BY 
DATEPART(month, DateOfCall), DATENAME(month,dateOfCall)

ORDER BY 
[Month No]

SELECT 
DATEPART(week ,dateOfCall) [Week No],
DATEADD(wk, DATEDIFF(wk, 4, dateOfCall), 4) [Week Ending],
COUNT(ad.AdviceId) Advice

FROM 
Shorthorn..cit_sh_advice ad

WHERE
CONVERT(date, dateOfCall) between '2016-01-01' and '2016-12-31'

GROUP BY 
DATEPART(week, DateOfCall),
DATEADD(wk, DATEDIFF(wk, 4, dateOfCall), 4) 

ORDER BY 
[Week No]