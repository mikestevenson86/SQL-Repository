DECLARE @BDMString AS NVarChar(500) = 'Mark Kelsall,Gary Smith,James O''Hare,Marina Ashman'

IF OBJECT_ID('tempdb..#BDM') IS NOT NULL
	BEGIN
		DROP TABLE #BDM
	END

CREATE TABLE #BDM
(
BDM VarChar(255)
)

WHILE LEN(@BDMString) > LEN(REPLACE(@BDMString,',',''))
	BEGIN

		INSERT INTO #BDM (BDM) SELECT REPLACE(LEFT(@BDMString,CHARINDEX(',',@BDMString)),',','')
		
		SELECT @BDMString = RIGHT(@BDMString,LEN(@BDMString)-CHARINDEX(',',@BDMString))
		
	END

INSERT INTO #BDM (BDM) SELECT @BDMString

SELECT BDM,Id FROM #BDM inner join Salesforce..[User] u ON #BDM.BDM = u.Name