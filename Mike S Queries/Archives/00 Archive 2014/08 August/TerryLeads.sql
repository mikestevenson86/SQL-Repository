SELECT Id
INTO #TerryLeads
FROM Salesforce..Lead
WHERE CreatedById = '005D00000036sdEIAQ'

SELECT MIN(lh.Id) MinId, lh.LeadId
INTO #LeadChanged
FROM Salesforce..LeadHistory lh
inner join #TerryLeads tl ON lh.LeadId collate latin1_general_CS_AS = tl.Id collate latin1_general_CS_AS
WHERE lh.Field = 'status'
GROUP BY LeadId

SELECT lh.LeadId, lh.OldValue
INTO #LeadChanges
FROM #LeadChanged lc
inner join Salesforce..LeadHistory lh ON lc.MinId collate latin1_general_CS_AS = lh.Id collate latin1_general_CS_AS

SELECT ISNULL(lcs.OldValue, l.[status]) [Status], COUNT(ISNULL(lcs.LeadId,l.Id)) Records
FROM Salesforce..Lead l
left outer join #LeadChanges lcs ON l.Id collate latin1_general_CS_AS = lcs.LeadId collate latin1_general_CS_AS
inner join #TerryLeads tl ON l.Id collate latin1_general_CS_AS = tl.Id collate latin1_general_CS_AS
GROUP BY ISNULL(lcs.OldValue, l.[status]) 

DROP TABLE #TerryLeads
DROP TABLE #LeadChanged
DROP TABLE #LeadChanges