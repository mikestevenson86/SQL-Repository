SELECT 
LEFT(PostCode,2),COUNT(*), 
SUM(case when [Telephone Number] <> '' then 1 else 0 end) HasPhone, 
SUM(case when [Contact email address] <> '' and [company email address] <> '' then 1 else 0 end) HasEmail
FROM 
MarketLocation..citation_full_data_062016
WHERE 
[Nat Employees] >= 226
and
PExists is null 
and 
LEFT(PostCode,2) in ('AB','IV','KW','PA','KA','DG','PH','EH','SY','TF','NE','DH','SR','HG','WV','WS','DE','PL','EX','TR','TQ','DT')
GROUP BY LEFT(PostCode,2)