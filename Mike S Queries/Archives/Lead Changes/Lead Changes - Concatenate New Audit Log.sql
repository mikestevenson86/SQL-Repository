SELECT 
al.CreatedDate, 
al.Source_Id, 
LTRIM(STUFF
		(
              (
                     SELECT ', ' + NewReason
                     FROM 
                           LeadChangeReview..New_AuditLog al2 
                     WHERE
                           al.Source_Id = al2.Source_Id
                           and
                           al.CreatedDate = al2.CreatedDate
                     ORDER BY NewReason
                     FOR XML PATH ('')
              ), 1, 1, ''
	   )) ExclusionReasons,
LTRIM(STUFF
		(
              (
                     SELECT ', ' + NewReason
                     FROM 
                           LeadChangeReview..New_AuditLog al2 
                     WHERE
                           nal.Source_Id = al2.Source_Id
                           and
                           nal.CreatedDate = al2.CreatedDate
                     ORDER BY NewReason
                     FOR XML PATH ('')
              ), 1, 1, ''
	   )) Previous_ExclusionReasons,
case when nal.Source_Id is not null then 'No' else 'Yes' end NewRecord
	   FROM LeadChangeReview..New_AuditLog al
	   left outer join LeadChangeReview..New_AuditLog nal ON al.Source_Id = nal.Source_Id
															and nal.CreatedDate = DATEADD(day,-1,al.CreatedDate)
	   GROUP BY al.CreatedDate, nal.CreatedDate, al.Source_Id, nal.Source_Id, case when nal.Source_Id is not null then 'No' else 'Yes' end