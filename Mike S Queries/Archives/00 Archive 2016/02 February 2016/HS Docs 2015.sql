SELECT     
		lettertype as [Letter Type],
		bs.title [Business Sector],
		bt.busType [Business Type],
		COUNT(documentproduceid) AS [Document Count]
FROM         
		CITDOCS_HS..documentproduce AS docprod
		inner join Shorthorn..cit_sh_clients cl ON docprod.clientid = cl.clientID
		inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
		inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
WHERE     
		(docprod.documentdate >= '2015-01-01 00:00:00') 
		AND 
		(docprod.documentdate < '2015-12-31 23:59:59')
		--AND 
		--(winuser = 'alansimmons')
GROUP BY 
		lettertype,
		bs.title,
		bt.busType
		
ORDER BY 
		lettertype,
		bs.title,
		bt.busType
		
SELECT     
		CAST((CASE WHEN mto.col2text IS NOT NULL THEN mto.col2text ELSE mt.col2text END) AS varchar(MAX)) AS [Master Text], 
		COUNT(distinct d.siteid) AS [Site Count], 
		COUNT(distinct d.documentproduceid) AS [Document Count],
		mts.subsection AS [Master Text Subsection], 
		d.lettertype AS [Letter Type],
		bs.title [Business Sector],
		bt.busType [Business Type]
FROM         
		CITDOCS_HS..documentproduce AS d 
		INNER JOIN CITDOCS_HS..mastertemplatetextproduce AS mt ON d.documentproduceid = mt.documentproduceid 
		LEFT OUTER JOIN CITDOCS_HS..mastertemplatesubsection AS mts ON mt.mastertemplatesubsectionid = mts.mastertemplatesubsectionid
		LEFT OUTER JOIN CITDOCS_HS.dbo.mastertemplatetext AS mto ON mt.mastertemplatetextid = mto.mastertemplatetextid 
		left outer join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
		left outer join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
		left outer join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
WHERE
		(d.documentdate >= '2015-01-01 00:00:00') 
		AND 
		(d.documentdate < '2015-12-31 23:59:59')
		--AND 
		--(winuser = 'alansimmons')

GROUP BY 
		CAST((CASE WHEN mto.col2text IS NOT NULL THEN mto.col2text ELSE mt.col2text END) AS varchar(MAX)), 
		mts.subsection, 
		d.lettertype,
		bs.title,
		bt.busType
ORDER BY 
		[Master Text], 
		[Master Text Subsection]