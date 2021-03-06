/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID]
      ,[Action]
      ,[EntityTable]
      ,[EntityTableKey]
      ,[AssociationTable]
      ,[AssociationTableKey]
      ,[AuditDate]
      ,u.FullName
  FROM [Shorthorn].[dbo].[cit_sh_auditRecords] au
  left outer join Shorthorn..cit_sh_users u ON au.UserID = u.userID
  WHERE EntityTable = 'cit_sh_contact' and EntityTableKey = 134782
  ORDER BY ID desc
  
SELECT [ID]
      ,[AuditRecordID]
      ,[MemberName]
      ,[OldValue]
      ,[NewValue]
  FROM [Shorthorn].[dbo].[cit_sh_auditRecordFields]
  WHERE AuditRecordID = 5858649