SELECT lm_filler2
INTO #calls
FROM SalesforceReporting..call_history
GROUP BY lm_filler2

SELECT *
FROM SalesforceReporting..SuppReviewTPS s
inner join #calls c ON LEFT(s.sfdc_id, 15) collate latin1_general_CS_AS = LEFT(c.lm_filler2, 15) collate latin1_general_CS_AS
--inner join SalesforceReporting..toxicdata t ON LEFT(c.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(t.[Prospect ID], 15) collate latin1_general_CS_AS

DROP TABLE #calls