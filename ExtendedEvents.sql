SELECT 
    event_data.value('(event/@name)[1]', 'varchar(50)') AS event_name,
    event_data.value('(event/@timestamp)[1]', 'datetime2') AS timestamp,
    event_data.value('(event/data[@name="database_id"]/value)[1]', 'int') AS database_id,
    event_data.value('(event/data[@name="error_number"]/value)[1]', 'int') AS error_number,
    event_data.value('(event/data[@name="severity"]/value)[1]', 'int') AS severity,
    event_data.value('(event/data[@name="message"]/value)[1]', 'varchar(max)') AS message,
    event_data.value('(event/action[@name="sql_text"]/value)[1]', 'varchar(max)') AS sql_text,
    event_data.value('(event/action[@name="username"]/value)[1]', 'varchar(128)') AS username
FROM 
    sys.fn_xe_file_target_read_file('C:\SQLServer\ExtendedEvents\Monitor_Databases*.xel', NULL, NULL, NULL) AS events
CROSS APPLY 
    events.event_data.nodes('//event') AS XEvent(event_data)
WHERE 
    event_data.value('(event/data[@name="database_id"]/value)[1]', 'int') IN (DB_ID('AST_Internal_UsageHealth'), DB_ID('PBRS_ReportServer'), DB_ID('PBRS_ReportServerTempDB'))
ORDER BY 
    timestamp DESC;
