SELECT COUNT(*)
FROM [database].citationMain.dbo.citation_companytable2
WHERE parentUID = 0 and (CQCDocs_Care_CHN = 'Y' or CQCDocs_Care_CHS = 'Y' or CQCDocs_Care_DCC = 'Y') and sageAC is not null and sageAC <> ''

SELECT COUNT(*)
FROM [database].citationMain.dbo.citation_companytable2
WHERE parentUID = 0 and CQCDocs_Dental = 'Y' and sageAC is not null and sageAC <> ''