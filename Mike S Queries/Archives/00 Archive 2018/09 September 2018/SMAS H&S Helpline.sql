SELECT 
cn.commentDate [Comment Date]
,cn.clientID
,cl.companyName [Client Name]
,cn.siteID [Site ID]
,s.siteName [Site Name]
,cnt.noteType [Note Type]
,cn.commentTitle [Comment Title]
,cn.comments [Comment]
,case when cn.enabled = 1 then 'Yes' else 'No' end [Enabled]
,u.FullName [Consultant]

FROM 
[database].Shorthorn.dbo.cit_sh_ClientNotes cn
left outer join [database].Shorthorn.dbo.cit_sh_clients cl ON cn.clientID = cl.clientID
left outer join [database].Shorthorn.dbo.cit_sh_sites s ON cn.siteID = s.siteID
left outer join [database].Shorthorn.dbo.cit_sh_users u ON cn.citUser = u.userID
left outer join [database].Shorthorn.dbo.cit_sh_ClientNoteType cnt ON cn.noteType = cnt.noteTypeID

WHERE 
cn.clientID = 92448 and commentTitle = 'Helpline feedback' 

ORDER BY 
commentDate desc