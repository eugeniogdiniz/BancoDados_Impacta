----------------------------------------------------------------------
-- DMVs ( Dynamic Management Views ) - CPU
----------------------------------------------------------------------
-- working threads
SELECT scheduler_id, current_tasks_count, runnable_tasks_count
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255

-- consumers
SELECT TOP 50 SUM(QS.TOTAL_WORKER_TIME) AS
TOTAL_CPU_TIME, SUM(QS.EXECUTION_COUNT) AS
TOTAL_EXECUTION_COUNT, COUNT(*) AS
NUMBER_OF_STATEMENTS,
SQL_TEXT.TEXT,QS.PLAN_HANDLE FROM SYS.DM_EXEC_QUERY_STATS
QS CROSS APPLY SYS.DM_EXEC_SQL_TEXT(SQL_HANDLE) AS SQL_TEXT
GROUP BY SQL_TEXT.TEXT,QS.PLAN_HANDLE
ORDER BY SUM(QS.TOTAL_WORKER_TIME) DESC

----------------------------------------------------------------------
-- DMVs ( Dynamic Management Views ) - MEMORIA
----------------------------------------------------------------------
-- allocation
SELECT type,
       Sum(pages_kb) as pages_kb,
	   (100.00*Sum(pages_kb)) / SUM(sum(pages_kb)) over() as perc
FROM   sys.dm_os_memory_clerks
WHERE  pages_kb != 0
GROUP  BY type
order by perc desc

-- consumers
SELECT TOP 10 session_id,
              login_time,
              host_name,
              program_name,
              login_name,
              nt_domain,
              nt_user_name,
              status,
              cpu_time,
              memory_usage,
              total_scheduled_time,
              total_elapsed_time,
              last_request_start_time,
              last_request_end_time,
              reads,
              writes,
              logical_reads,
              transaction_isolation_level,
              lock_timeout,
              deadlock_priority,
              row_count,
              prev_error
FROM   sys.dm_exec_sessions
ORDER  BY memory_usage DESC 

----------------------------------------------------------------------
-- DMVs ( Dynamic Management Views ) - DISCO
----------------------------------------------------------------------

--Consumers
SELECT TOP 25 Db_name(D.database_id)                               AS
              DATABASE_NAME,
              Quotename(Object_schema_name(D.object_id, D.database_id))
              + N'.'
              + Quotename(Object_name(D.object_id, D.database_id)) AS
              OBJECT_NAME,
              D.database_id,
              D.object_id,
              D.page_io_latch_wait_count,
              D.page_io_latch_wait_in_ms,
              D.range_scans,
              D.index_lookups
FROM   (SELECT database_id,
               object_id,
               Row_number()
                 OVER (
                   partition BY database_id
                   ORDER BY Sum(page_io_latch_wait_in_ms) DESC) AS ROW_NUMBER,
               Sum(page_io_latch_wait_count)                    AS
                      PAGE_IO_LATCH_WAIT_COUNT,
               Sum(page_io_latch_wait_in_ms)                    AS
                      PAGE_IO_LATCH_WAIT_IN_MS,
               Sum(range_scan_count)                            AS RANGE_SCANS,
               Sum(singleton_lookup_count)                      AS INDEX_LOOKUPS
        FROM   sys.Dm_db_index_operational_stats(NULL, NULL, NULL, NULL)
        WHERE  page_io_latch_wait_count > 0
        GROUP  BY database_id,
                  object_id) AS D
       LEFT JOIN (SELECT DISTINCT database_id,
                                  object_id
                  FROM   sys.dm_db_missing_index_details) AS MID
              ON MID.database_id = D.database_id
                 AND MID.object_id = D.object_id
WHERE  D.row_number > 20
ORDER  BY page_io_latch_wait_count DESC 

--Database IO Analysis
WITH iofordatabase
     AS (SELECT Db_name(VFS.database_id)        AS DatabaseName,
                CASE
                  WHEN smf.type = 1 THEN 'LOG_FILE'
                  ELSE 'DATA_FILE'
                END                             AS DatabaseFile_Type,
                Sum(VFS.num_of_bytes_written)   AS IO_Write,
                Sum(VFS.num_of_bytes_read)      AS IO_Read,
                Sum(VFS.num_of_bytes_read
                    + VFS.num_of_bytes_written) AS Total_IO,
                Sum(VFS.io_stall)               AS IO_STALL
         FROM   sys.Dm_io_virtual_file_stats(NULL, NULL) AS VFS
                JOIN sys.master_files AS smf
                  ON VFS.database_id = smf.database_id
                     AND VFS.file_id = smf.file_id
         GROUP  BY Db_name(VFS.database_id),
                   smf.type)
SELECT Row_number() OVER(ORDER BY io_stall DESC)AS RowNumber,
       databasename,
       databasefile_type,
       Cast(1.0 * io_read / ( 1024 * 1024 ) AS DECIMAL(12, 2))  AS IO_Read_MB,
       Cast(1.0 * io_write / ( 1024 * 1024 ) AS DECIMAL(12, 2)) AS IO_Write_MB,
       Cast(1. * total_io / ( 1024 * 1024 ) AS DECIMAL(12, 2))  AS IO_TOTAL_MB,
       Cast(io_stall / 1000. AS DECIMAL(12, 2))                 AS
       IO_STALL_Seconds,
       Cast(100. * io_stall / Sum(io_stall)OVER() AS DECIMAL(10, 2))       AS IO_STALL_Pct
FROM   iofordatabase
ORDER  BY io_stall_seconds DESC; 

----------------------------------------------------------------------
-- DMVs ( Dynamic Management Views ) - Tipos de espera
----------------------------------------------------------------------

-- WAIT TYPES
SELECT TOP 10 [Wait type] = wait_type,
              [Wait time (s)] = wait_time_ms / 1000,
              [% waiting] = CONVERT(DECIMAL(12, 2), wait_time_ms * 100.0 / Sum(
                                                    wait_time_ms)
                                                    OVER())
FROM   sys.dm_os_wait_stats
WHERE  wait_type NOT LIKE '%SLEEP%'
ORDER  BY wait_time_ms DESC; 

----------------------------------------------------------------------
-- DMVs ( Dynamic Management Views ) - Locks
----------------------------------------------------------------------
SELECT DISTINCT l.resource_type,
                l.resource_associated_entity_id,
                CASE
                  WHEN l.resource_type = 'OBJECT' THEN
                  Object_name(l.resource_associated_entity_id)
                  ELSE Object_name(sp.object_id)
                END                                     AS
                resource_associated_entity_name,
                l.request_status,
                l.request_mode,
                request_session_id,
                l.resource_description,
                Substring(qt.text, ( r.statement_start_offset / 2 ) + 1,
                ( CASE
                    WHEN r.statement_end_offset = -1 THEN Len(
                    CONVERT(NVARCHAR(max), qt.text)) *
                                                          2
                    ELSE r.statement_end_offset
                  END - r.statement_start_offset ) / 2) AS query_text
FROM   sys.dm_tran_locks l
       LEFT JOIN sys.partitions sp
              ON sp.hobt_id = l.resource_associated_entity_id
       LEFT JOIN sys.dm_exec_requests r
              ON l.request_session_id = r.session_id
       CROSS apply sys.Dm_exec_sql_text(r.sql_handle) AS qt
WHERE  l.resource_database_id = Db_id()
ORDER  BY 3,
          4 

----------------------------------------------------------------------
-- DMVs ( Dynamic Management Views ) - Blocks
----------------------------------------------------------------------

SELECT DISTINCT t1.resource_type,
                t1.resource_database_id,
                t1.resource_associated_entity_id,
                CASE
                  WHEN t1.resource_type = 'OBJECT' THEN
                  Object_name(t1.resource_associated_entity_id)
                  ELSE Object_name(sp.object_id)
                END                                     AS
                resource_associated_entity_name
                --,OBJECT_NAME(sp.OBJECT_ID) AS ObjectName
                ,
                t1.request_mode,
                t1.request_session_id,
                t2.blocking_session_id,
                Substring(qt.text, ( r.statement_start_offset / 2 ) + 1,
                ( CASE
                    WHEN r.statement_end_offset = -1 THEN Len(
                    CONVERT(NVARCHAR(max), qt.text)) *
                                                          2
                    ELSE r.statement_end_offset
                  END - r.statement_start_offset ) / 2) AS query_text
FROM   sys.dm_tran_locks AS t1
       JOIN sys.dm_os_waiting_tasks AS t2
         ON t1.lock_owner_address = t2.resource_address
       LEFT JOIN sys.partitions sp
              ON sp.hobt_id = t1.resource_associated_entity_id
       LEFT JOIN sys.dm_exec_requests r
              ON t1.request_session_id = r.session_id
       CROSS apply sys.Dm_exec_sql_text(r.sql_handle) AS qt 

----------------------------------------------------------------------
-- DMVs ( Dynamic Management Views ) - Consultas em execução
----------------------------------------------------------------------
create OR ALTER procedure sp_who3 as
SELECT
Sessions.session_id AS SessionID, Sessions.login_name AS LoginName, Sessions.host_name AS HostName, Sessions.program_name AS ProgramName,
Sessions.client_interface_name AS ClientInterfaceName,
Requests.wait_time AS WaitTime, Requests.cpu_time AS CPUTime, Requests.total_elapsed_time AS ElapsedTime,
Requests.reads AS Reads, Requests.writes AS Writes, Requests.logical_reads AS LogicalReads,
Requests.row_count AS [RowCount], Requests.granted_query_memory*8 AS GrantedQueryMemoryKB,
CONVERT(BigInt, (Requests.cpu_time+1))*CONVERT(BigInt, (Requests.reads*10+Requests.writes*10+Requests.logical_reads+1)) AS Score,
CONVERT(BigInt, (Requests.cpu_time+1))*CONVERT(BigInt, (Requests.reads*10+Requests.writes*10+Requests.logical_reads+1)) * 100.0 / sum(CONVERT(BigInt, (Requests.cpu_time+1))*CONVERT(BigInt, (Requests.reads*10+Requests.writes*10+Requests.logical_reads+1))) over() AS
Score_perc,
Statements.text AS BatchText,
LEN(Statements.text) AS BatchTextLength,
Requests.statement_start_offset/2 AS StatementStartPos,
CASE
WHEN Requests.statement_end_offset = -1 THEN LEN(CONVERT(nvarchar(MAX),Statements.text))*2
ELSE Requests.statement_end_offset
END/2 AS StatementEndPos,
(CASE
WHEN Requests.statement_end_offset = -1 THEN LEN(CONVERT(nvarchar(MAX),Statements.text))*2
ELSE Requests.statement_end_offset
END - Requests.statement_start_offset)/2 AS StatementTextLength,
CASE
WHEN Requests.sql_handle IS NULL THEN ' '
ELSE
SubString(
Statements.text,
(Requests.statement_start_offset+2)/2,
(CASE
WHEN Requests.statement_end_offset = -1 THEN LEN(CONVERT(nvarchar(MAX),Statements.text))*2
ELSE Requests.statement_end_offset
END - Requests.statement_start_offset)/2
)
END AS StatementText,
QueryPlans.query_plan AS QueryPlan
FROM
sys.dm_exec_sessions AS Sessions
JOIN sys.dm_exec_requests AS Requests ON Sessions.session_id=Requests.session_id
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS Statements
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS QueryPlans
ORDER BY score DESC
GO

----------------------------------------------------------------------
-- Triggers de sistema
----------------------------------------------------------------------

use master
GO
CREATE TABLE dbo.AUDITORIA ( 
	id int identity(1,1) not null primary key 
	, TimeStamp datetime
	, CurrentUser varchar(100)
	, SystemUser varchar(100)
	, HostName varchar(100)
	, IP varchar(100)
	, DatabaseName varchar(100)
	, ObjectName varchar(100)
	, PostTime datetime
	, EventType varchar(100)
	, SPID int
	, ServerName varchar(100)
	, LoginName varchar(100)
	, UserName varchar(100)
	, ObjectType varchar(100)
	, TsqlCommand  varchar(MAX)
)
go
-- trigger de auditoria
create trigger TRG_PROTECTION ON AUDITORIA FOR delete, update
as 
	raiserror('NO CAN DO',16,1)
	rollback
go
-- permissoes
grant insert on AUDITORIA to public
go
grant select on sys.dm_exec_connections to public
go
--revoke delete, update on AUDITORIA to IIS
go
use [master]
go

CREATE TRIGGER TRG_AUDITORIA
ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS 
--FOR DROP_TABLE, ALTER_TABLE, TRUNCATE_TABLE
AS
SET NOCOUNT ON
DECLARE @data XML 
	set @data = EVENTDATA()
DECLARE @SPID INT 
	set @SPID = @data.value('(/EVENT_INSTANCE/SPID)[1]', 'INT')
DECLARE @IP Varchar(25) 
	select @ip = ''--client_net_address from sys.dm_exec_connections where session_id = @SPID 

INSERT master.dbo.AUDITORIA ([TimeStamp],CurrentUser,SystemUser,HostName,IP,DatabaseName,ObjectName,PostTime,EventType,SPID,ServerName,LoginName,UserName,ObjectType,TsqlCommand)
SELECT
	GETDATE() 
    , CONVERT(nvarchar(100), CURRENT_USER)
	, CONVERT(nvarchar(100), SYSTEM_USER )
	, CONVERT(nvarchar(100), HOST_NAME() )
	, CONVERT(nvarchar(100), @ip ) 
	, db_name()
	, @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(100)')
	, @data.value('(/EVENT_INSTANCE/PostTime)[1]', 'DATETIME')
	, @data.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)')
	, @data.value('(/EVENT_INSTANCE/SPID)[1]', 'INT')
	, @data.value('(/EVENT_INSTANCE/ServerName)[1]', 'NVARCHAR(100)')
	, @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'NVARCHAR(100)')
	, @data.value('(/EVENT_INSTANCE/UserName)[1]', 'NVARCHAR(100)')
	, @data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'NVARCHAR(100)')
	, @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(4000)')
GO

select * from master.dbo.AUDITORIA 

