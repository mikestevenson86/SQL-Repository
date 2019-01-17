SELECT *
FROM MarketLocation..MainDataSet
WHERE URN in
(
SELECT URN
FROM
(
SELECT URN, ROW_NUMBER() OVER (PARTITION BY URN ORDER BY URN) rn
FROM MarketLocation..MainDataSet
) detail
WHERE rn > 1
)