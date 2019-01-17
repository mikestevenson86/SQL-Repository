IF OBJECT_ID('Salesforce..Lead_Update') IS NULL
	BEGIN
		Print 'No Lead Update table - Please check execution process'
	END

ELSE

	BEGIN
				-- Duration
		
		DECLARE @Time as VarChar(8)
		DECLARE @Complete as int
		DECLARE @Incomplete as int
		DECLARE @Date as datetime
		
		SELECT @Date = '1900-01-01 00:00:00.000'
		
		SELECT @Complete = SUM(case when Error <> '' then 1 else 0 end) FROM Salesforce..Lead_Update with(nolock)
		SELECT @Incomplete = SUM(case when Error = '' then 1 else 0 end) FROM Salesforce..Lead_Update with(nolock)
		
		select TOP 1 @Time = 
		left(right(convert(varchar, 
					dateadd(ms, datediff(ms, P.last_batch, getdate()), '1900-01-01'), 
					121), 12), 8) 
		from master.dbo.sysprocesses P
		where p.program_name = 'Microsoft SQL Server Management Studio - Query                                                                                  '
		and		 P.spid > 50
		and      P.status not in ('background', 'sleeping')
		and      P.cmd not in ('AWAITING COMMAND'
							,'MIRROR HANDLER'
							,'LAZY WRITER'
							,'CHECKPOINT SLEEP'
							,'RA MANAGER')
		order by
		left(right(convert(varchar, 
					dateadd(ms, datediff(ms, P.last_batch, getdate()), '1900-01-01'), 
					121), 12), 8) desc

		SELECT 
		LEFT(CONVERT(VarChar, CONVERT(time, 
		DATEADD(second, ((CONVERT(decimal(18,6), Sum(Left(@Time,2) * 3600 + substring(@Time, 4,2) * 60 + substring(@Time, 7,2)))
		/
		CONVERT(decimal(18,6), @Complete)) * @Incomplete), 0))), 8) [Time Left],
		@Time [Time], @Complete Complete, @Incomplete Incomplete
	
		-- Percentages
		SELECT 
		CONVERT(VarChar, SUM(case when Error in ('Operation Successful.') then 1 else 0 end)) + ' / ' + CONVERT(VarChar,COUNT(Id)) + ' - ' +
		CONVERT(VarChar,
		CONVERT(decimal(18,2),
		CONVERT(decimal(18,2),SUM(case when Error in ('Operation Successful.') then 1 else 0 end))/CONVERT(decimal(18,2),COUNT(Id))*100
		)
		) + '%' Success
		FROM Salesforce..Lead_Update with(nolock)

		SELECT 
		CONVERT(VarChar,SUM(case when Error not in ('Operation Successful.','') then 1 else 0 end)) + ' / ' + CONVERT(VarChar,COUNT(Id)) + ' - ' +
		CONVERT(VarChar,
		CONVERT(decimal(18,2),
		CONVERT(decimal(18,2),SUM(case when Error not in ('Operation Successful.','') then 1 else 0 end))/CONVERT(decimal(18,2),COUNT(Id))*100
		)
		) + '%' Failure
		FROM Salesforce..Lead_Update with(nolock)

		SELECT 
		CONVERT(VarChar,SUM(case when Error in ('') then 1 else 0 end)) + ' / ' + CONVERT(VarChar,COUNT(Id)) + ' - ' +
		CONVERT(VarChar,
		CONVERT(decimal(18,2),
		CONVERT(decimal(18,2),SUM(case when Error in ('') then 1 else 0 end))/CONVERT(decimal(18,2),COUNT(Id))*100
		)) + '%' UnProcessed
		FROM Salesforce..Lead_Update with(nolock)

		-- Breakdown of Update
		SELECT Error, COUNT(*) Prospects
		FROM Salesforce..Lead_Update with(nolock)
		GROUP BY Error

		-- Failed Updates to push back through
		SELECT *
		FROM Salesforce..Lead_Update with(nolock)
		WHERE Error not in ('Operation Successful.','')
	


	END