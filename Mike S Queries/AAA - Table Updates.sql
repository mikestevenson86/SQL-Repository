SELECT t.name,
       user_seeks,
       user_scans,
       user_lookups,
       user_updates,
       last_user_seek,
       last_user_scan,
       last_user_lookup,
       last_user_update
FROM   sys.dm_db_index_usage_stats i
       JOIN sys.tables t
         ON ( t.object_id = i.object_id )
         WHERE name = 'ClientUsage'