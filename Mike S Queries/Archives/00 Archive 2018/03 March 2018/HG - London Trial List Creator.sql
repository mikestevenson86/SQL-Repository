IF OBJECT_ID ('tempdb..#BDM') IS NOT NULL
	BEGIN
		DROP TABLE #BDM
	END

DECLARE @BDM_Int as Int
SET @BDM_Int = 1

SELECT ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY BDM) Id, BDM
INTO #BDM 
FROM HGLeadScoring..Ranked_LondonTrial_Diallable
WHERE BDM is not null
GROUP BY BDM

TRUNCATE TABLE HGLeadScoring..LondonTrial

WHILE (SELECT COUNT(1) FROM HGLeadScoring..Ranked_LondonTrial_Diallable WHERE Processed = 0 and BDM is not null) > 0
	BEGIN

	INSERT INTO HGLeadScoring..LondonTrial
	(LeadID,BDM,ELTV,InitialRanking)
	SELECT TOP 1 Lead_Id, BDM, ELTV, Ranking
	FROM HGLeadScoring..Ranked_LondonTrial_Diallable
	WHERE Processed = 0 and BDM = (SELECT BDM FROM #BDM WHERE ID = @BDM_Int)
	ORDER BY Ranking

	UPDATE HGLeadScoring..Ranked_LondonTrial_Diallable
	SET Processed = 1
	WHERE Lead_Id = (SELECT TOP 1 Lead_Id FROM HGLeadScoring..Ranked_LondonTrial_Diallable WHERE Processed = 0 and BDM = (SELECT BDM FROM #BDM WHERE ID = @BDM_Int) ORDER BY Ranking)


	IF @BDM_Int = 4
	
		BEGIN
		
			SET @BDM_Int = 1
			
		END
		
	ELSE
	
		BEGIN
		
			SET @BDM_Int = @BDM_Int + 1
		
		END

END