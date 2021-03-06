SELECT case when [DateStamp] <> '' then DATEADD(day, CONVERT(int, [DateStamp]), '1899-12-31')-1 else NULL end [DateStamp]
      ,[Company Name]
      ,[Sage Code]
      ,CONVERT(int, [Deal Length]) [Deal Length]
      ,[FullName]
      ,[Sub Consul]
      ,[Title]
      ,CONVERT(int, [Contact Id]) [Contact Id]
      ,[Full Name]
      ,CONVERT(int, [Site ID]) [Site ID]
      ,[Post Code]
      ,[Gen Tel]
      ,[Gen Email]
      ,case when [Sign Date] <> '' then DATEADD(day, CONVERT(int, [Sign Date]), '1899-12-31')-1 else NULL end [Sign Date]
      ,case when [Renew Date] <> '' then DATEADD(day, CONVERT(int, [Renew Date]), '1899-12-31')-1 else NULL end [Renew Date]
      ,case when [Last Visit Date] <> '' then DATEADD(day, CONVERT(int, [Last Visit Date]), '1899-12-31')-1 else NULL end [Last Visit Date]
      ,case when [Booked Action] <> '' then DATEADD(day, CONVERT(int, [Booked Action]), '1899-12-31')-1 else NULL end [Booked Action]
      ,[Call Type]
      ,CONVERT(decimal(18,2), [DealValue]) [DealValue]
      ,[Sector]
      ,[Segment]
  INTO SalesforceReporting..Backlog_HS_Overdue
  FROM [SalesforceReporting].[dbo].[HS_OVERDUE]