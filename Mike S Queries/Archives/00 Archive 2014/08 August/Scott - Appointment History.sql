	SELECT lm_filler2, MAX(actdate) maxdate, MAX(acttime) maxtime
	INTO #Appts
	FROM
	(
	SELECT lm_filler2, act_date actdate, act_time acttime
    FROM Enterprise..call_history
    WHERE lm_filler2 like '00QD%' and ([status] = 'AP' or ([status] = 'S' and addi_status = 'A'))
    UNION
    SELECT lm_filler2,act_date actdate, act_time acttime
    FROM SalesforceReporting..call_history
    WHERE lm_filler2 like '00QD%' and ([status] = 'AP' or ([status] = 'S' and addi_status = 'A'))
    ) detail
    GROUP BY lm_filler2
    
    SELECT
    ROW_NUMBER () OVER (PARTITION BY lm_filler2 ORDER BY act_date, act_time) CallNumber,
    lm_filler2,
    act_date,
    act_time,
    [status],
    addi_status,
    maxdate,
    maxtime
    INTO
    #callData
    FROM
    (
    SELECT
    seqno,
    act_date,
    act_time,
    ch.lm_filler2,
    [status],
    addi_status,
    maxdate,
    maxtime
    FROM Enterprise..call_history ch
    inner join #Appts a ON 
    ch.lm_filler2 collate latin1_general_CS_AS = a.lm_filler2 collate latin1_general_CS_AS
    WHERE act_date <= maxdate and act_time <= maxtime
    UNION
    SELECT
    seqno,
    act_date,
    act_time,
    ch.lm_filler2,
    [status],
    addi_status,
    maxdate,
    maxtime
    FROM SalesforceReporting..call_history ch
    inner join #Appts a ON 
    ch.lm_filler2 collate latin1_general_CS_AS = a.lm_filler2 collate latin1_general_CS_AS
    WHERE act_date <= maxdate and act_time <= maxtime
    ) detail
    
    SELECT
    DATEPART(dd,maxdate) [Day],
    DATENAME(dw,maxdate) [DayName],
    DATEPART(MM,maxdate) [Month],
    DATEPART(yy,maxdate) [Year],
    cd.maxtime CallTime,
    l.Id [Salesforce ID],
    l.CitationSector__c [Citation Sector],
    l.SIC2007_Code__c [SIC Code 1],
    l.SIC2007_Code2__c [SIC Code 2],
    l.SIC2007_Code3__c [SIC Code 3],
    MAX(cd.CallNumber) CallsToBook
    
    FROM
    Salesforce..Lead l
    inner join #callData cd ON l.Id collate latin1_general_CS_AS = cd.lm_filler2 collate latin1_general_CS_AS
    
    GROUP BY
    DATEPART(dd,maxdate),
    DATENAME(dw,maxdate) ,
    DATEPART(MM,maxdate),
    DATEPART(yy,maxdate),
    cd.maxtime,
    l.Id,
    l.CitationSector__c,
    l.SIC2007_Code__c,
    l.SIC2007_Code2__c,
    l.SIC2007_Code3__c
    
    ORDER BY
    DATEPART(yy,maxdate),
    DATEPART(MM,maxdate),
    DATEPART(dd,maxdate)
    
    DROP TABLE #Appts
    DROP TABLE #CallData