IF OBJECT_ID ('tempdb..#CrossOver') IS NOT NULL
	BEGIN
		DROP TABLE #CrossOver
	END

SELECT BDM, PostCodeArea
INTO #CrossOver
FROM
(
SELECT pcb.BDM, pcb.Length, pcb.PostCodeArea
FROM SalesforceReporting..PostCodeAssignments pca
inner join SalesforceReporting..PostCodeAssignments pcb ON pca.PostCodeArea = LEFT(pcb.PostCodeArea, 3) and pca.BDM <> pcb.BDM
WHERE pca.[Length] = 3
UNION
SELECT pcb.BDM, pcb.Length, pcb.PostCodeArea
FROM SalesforceReporting..PostCodeAssignments pca
inner join SalesforceReporting..PostCodeAssignments pcb ON pca.PostCodeArea = LEFT(pcb.PostCodeArea, 2) and pca.BDM <> pcb.BDM
WHERE pca.[Length] = 2
) detail
ORDER BY BDM, PostCodeArea

SELECT BDM, PostCodes
FROM
(
	SELECT BDM, STUFF
		   (
				  (
						 SELECT ', ' + co2.PostCodeArea
						 FROM 
							   #CrossOver co2
						 WHERE
							   co.BDM = co2.BDM
						 ORDER BY co2.PostCodeArea
						 FOR XML PATH ('')
				  ), 1, 1, ''
		   ) PostCodes, 1 RuleOrder
	FROM #CrossOver co
	GROUP BY BDM
	UNION
	SELECT pca.BDM, STUFF
		   (
				  (
						 SELECT ', ' + pc2.PostCodeArea
						 FROM 
								SalesforceReporting..PostCodeAssignments pc2
								left outer join #CrossOver co2 ON pc2.PostCodeArea = co2.PostCodeArea
						 WHERE
							   co2.PostCodeArea is null
							   and
							   pc2.BDM = pca.BDM
						 ORDER BY pc2.PostCodeArea
						 FOR XML PATH ('')
				  ), 1, 1, ''
		   ) PostCodes, 2 RuleOrder
	FROM SalesforceReporting..PostCodeAssignments pca
	left outer join #CrossOver co ON pca.PostCodeArea = co.PostCodeArea
	WHERE co.PostCodeArea is null
	GROUP BY pca.BDM
) detail
ORDER BY RuleOrder, BDM