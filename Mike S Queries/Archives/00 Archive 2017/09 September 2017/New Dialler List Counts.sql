SELECT Region, BDM, ListNo, MIN(ListID) [List Starts], MAX(ListID) [List Ends], COUNT(ListID) Prospects
FROM NewVoiceMedia..DiallerList_20170908
GROUP BY Region, BDM, ListNo
ORDER BY
Case 
when Region = 'South' then 1
when Region = 'North' then 2
when Region = 'London' then 3
when Region = 'Scotland' then 4
when Region = 'Ireland' then 5
when Region = 'Midlands' then 6 end,
BDM,
ListNo