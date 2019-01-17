SELECT AuditType, LoadType, Field, OldCrit, NewCrit, COUNT(1) [Changes]
FROM LeadChangeReview..Duplicates_AuditLog with(nolock)
GROUP BY AuditType, LoadType, Field, OldCrit, NewCrit
ORDER BY AuditType, LoadType, Field, OldCrit, NewCrit

SELECT MAX(CreatedDate) FROM LeadChangeReview..Duplicates_AuditLog with(nolock) 

SELECT AuditType, LoadType, Field, OldCrit, NewCrit, COUNT(1) [Changes]
FROM LeadChangeReview..Exclusions_AuditLog with(nolock)
GROUP BY AuditType, LoadType, Field, OldCrit, NewCrit
ORDER BY AuditType, LoadType, Field, OldCrit, NewCrit

SELECT MAX(CreatedDate) FROM LeadChangeReview..Exclusions_AuditLog with(nolock) 