-- New Crit

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Duplicate' AuditType, NULL OldReason, 'Lead' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.Dupe_Lead = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Duplicate' AuditType, NULL OldReason, 'Account' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.Dupe_Account = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Duplicate' AuditType, NULL OldReason, 'Site' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.Dupe_Site = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Duplicate' AuditType, NULL OldReason, 'Toxic' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.Dupe_Toxic = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Toxic SIC' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.ToxicSIC = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Toxic SIC - Events' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.ToxicSIC_Events = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Bad Company - Exact' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.BadCompany_Exact = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Bad Company - Near' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.BadCompany_Near = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Bad Company - Events' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.BadCompany_Events = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Bad Domain' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.BadDomain = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Bad Domain - NHS' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.BadDomain_NHS = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Bad Position - Events' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.BadPosition_Events = 1 and sv.ML_URN is not null

INSERT INTO LeadChangeReview..New_AuditLog
SELECT CONVERT(date, GETDATE()) CreatedDate, 'ML-API' [Source], sv.ML_URN Source_Id, 'Exclusion' AuditType, NULL OldReason, 'Bad Sector - Events' NewReason
FROM LEADS_ODS.dbo.LeadsSingleViewAuto sv
WHERE sv.BadSector_Events = 1 and sv.ML_URN is not null