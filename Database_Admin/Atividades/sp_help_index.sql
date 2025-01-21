ALTER PROCEDURE sp_help_index @table_name NVARCHAR(255) = NULL        
AS BEGIN        
          
 IF (@table_name IS NULL )         
 BEGIN        
  RAISERROR('Usage: exec sp_help_index @table_name',16,1)        
  RETURN;        
 END        
         
 IF OBJECT_ID(@table_name) is null        
 BEGIN        
  RAISERROR('Table not found: %s',16,1,@table_name)        
  RETURN;        
 END  
        
 ;WITH helpindex        
 AS (        
  SELECT i.object_id        
    , object_name(i.object_id) AS [table]  
 , i.index_id         
    , i.name AS [index]        
    , i.type_desc  COLLATE SQL_Latin1_General_CP1_CI_AS AS type_desc        
    , CASE WHEN i.is_unique = 1 THEN 'UNIQUE' ELSE '' END AS [unique]    
 , i.is_primary_key        
    , REPLACE(        
     REPLACE(        
      REPLACE( ISNULL(        
       (  SELECT c.name + CASE WHEN ic.is_descending_key = 1 THEN ' desc' ELSE '' END AS [names]        
         FROM sys.index_columns ic         
           inner join sys.columns c        
          ON ic.object_id = c.object_id        
           and ic.column_id = c.column_id        
         WHERE i.object_id = ic.object_id        
           and i.index_id = ic.index_id        
           and ic.is_included_column = 0        
         FOR XML RAW        
       ), ''), '"/><row names="', ', '        
      ), '<row names="', ''        
     ), '"/>', ''        
    )  as names        
    , REPLACE(        
     REPLACE(        
      REPLACE( ISNULL(        
       (  SELECT c.name + CASE WHEN ic.is_descending_key = 1 THEN ' desc' ELSE '' END AS [names]        
         FROM sys.index_columns ic         
           inner join sys.columns c        
          ON ic.object_id = c.object_id        
           and ic.column_id = c.column_id        
         WHERE i.object_id = ic.object_id        
           and i.index_id = ic.index_id        
           and ic.is_included_column = 1        
         FOR XML RAW        
       ), '') , '"/><row names="', ', '        
      ), '<row names="', ''        
     ), '"/>', ''        
    )  as included  
 ,diu.user_seeks  
 ,diu.user_scans  
 ,diu.user_lookups  
 ,diu.user_updates  
 ,diu.last_user_update as last_used  
 ,i.fill_factor  
  FROM sys.indexes i  
 LEFT JOIN sys.dm_db_index_usage_stats  diu  
 ON diu.object_id = i.object_id  
 AND diu.index_id = i.index_id  
  WHERE i.object_id = object_id(@table_name)        
 ), index_fragmentation as (  
 SELECT database_id, object_id, index_id, partition_number, avg_fragmentation_in_percent, page_count  
 FROM sys.dm_db_index_physical_stats (DB_ID(), object_id(@table_name), null, null, N'LIMITED')   
 WHERE ALLOC_UNIT_TYPE_DESC = 'IN_ROW_DATA' AND PARTITION_NUMBER = 1  
)    
SELECT db_name() as [database]  
 , [table]  
 , [index]        
    , [names] as columns        
    , [included] as included_columns  
 , avg_fragmentation_in_percent  
 , case when fill_factor = 0 then 100 else fill_factor end as fill_factor  
 , page_count  
 , STATS_DATE(helpindex.object_id,helpindex.index_id) AS Statistics_Last_Updated  
 , user_seeks  
 , user_scans  
 , user_lookups  
 , user_updates  
 , last_used  
 , case when is_primary_key = 1 --or [unique] = 'UNIQUE'    
  THEN 'ALTER TABLE [' + [table] + '] drop constraint [' + [index] + ']'    
  ELSE 'DROP INDEX [' + [table] + '].[' + [index] + ']'     
  end as Drop_statement         
 , case when is_primary_key = 1    
  THEN 'ALTER TABLE [' + [table] + '] with check add constraint [' + [index] + '] primary key '+ [type_desc] +' ( '+ [names]+' ) ON [PRIMARY]'    
  ELSE 'CREATE ' + [unique] + ' ' + [type_desc] + ' INDEX [' + [index] + '] ON [' + [table] + '](' + [names] + ') ' + case when [included] <> '' then ' INCLUDE( ' + [included] + ')' else '' end     
  end as Create_statement       
 , case when avg_fragmentation_in_percent >= 30.0 then 'ALTER INDEX [' + [index] + '] ON [' + [table] + '] REBUILD'  
   when avg_fragmentation_in_percent >= 10.0 then 'ALTER INDEX [' + [index] + '] ON [' + [table] + '] REORGANIZE'  
   when user_updates > ( (user_seeks * 100) + ( user_scans * 10 ) + user_lookups ) then 'DROP OR REDESIGN IT'  
   else '' END  
  as index_recomended_action  
 FROM helpindex  
  LEFT JOIN index_fragmentation  
  ON helpindex.object_id = index_fragmentation.object_id  
   AND helpindex.index_id = index_fragmentation.index_id  
/*    
select  case when is_primary_key = 1 --or [unique] = 'UNIQUE'    
   THEN 'ALTER TABLE [' + [table] + '] drop constraint [' + [index] + ']'    
   ELSE 'DROP INDEX [' + [table] + '].[' + [index] + ']'     
  end as Drop_statement     
from helpindex       
union all    
select 'ALTER TABLE [' + @table_name + '] drop constraint [' + name + ']'    
FROM sys.objects    
WHERE type_desc = 'UNIQUE_CONSTRAINT'    
 and parent_object_id = object_id(@table_name)          
order by 1    
*/    
  
SELECT   
 sys.objects.object_id as [object_id]
 , sys.objects.name AS [table]
 , partitions.Rows
 , partitions.SizeMB
 , sys.dm_db_missing_index_details.equality_columns AS equality_columns  
 , sys.dm_db_missing_index_details.inequality_columns AS inequality_columns  
 , sys.dm_db_missing_index_details.included_columns AS included_columns  
 , (CONVERT(FLOAT, sys.dm_db_missing_index_group_stats.user_seeks)+CONVERT(FLOAT, sys.dm_db_missing_index_group_stats.unique_compiles))*CONVERT(FLOAT, sys.dm_db_missing_index_group_stats.avg_total_user_cost)*CONVERT(FLOAT,
 sys.dm_db_missing_index_group_stats.avg_user_impact/100.0) AS Score  
FROM  
 sys.objects  
 JOIN (  
  SELECT  
   object_id, SUM(CASE WHEN index_id BETWEEN 0 AND 1 THEN row_count ELSE 0 END) AS Rows,  
   CONVERT(FLOAT, CONVERT(FLOAT, SUM(in_row_reserved_page_count+lob_reserved_page_count+row_overflow_reserved_page_count))/CONVERT(FLOAT, 128)) AS SizeMB  
  FROM sys.dm_db_partition_stats  
  WHERE sys.dm_db_partition_stats.index_id BETWEEN 0 AND 1 --0=Heap; 1=Clustered; only 1 per table  
  GROUP BY object_id  
 ) AS partitions ON sys.objects.object_id=partitions.object_id  
 JOIN sys.schemas ON sys.objects.schema_id=sys.schemas.schema_id  
 JOIN sys.dm_db_missing_index_details ON sys.objects.object_id=dm_db_missing_index_details.object_id  
 JOIN sys.dm_db_missing_index_groups ON sys.dm_db_missing_index_details.index_handle=sys.dm_db_missing_index_groups.index_handle  
 JOIN sys.dm_db_missing_index_group_stats ON sys.dm_db_missing_index_groups.index_group_handle=sys.dm_db_missing_index_group_stats.group_handle  
WHERE  
 sys.dm_db_missing_index_details.database_id=DB_ID()  
 AND sys.objects.name = @Table_Name  
ORDER BY  
 (CONVERT(FLOAT, sys.dm_db_missing_index_group_stats.user_seeks)+CONVERT(FLOAT, sys.dm_db_missing_index_group_stats.unique_compiles))*CONVERT(FLOAT, sys.dm_db_missing_index_group_stats.avg_total_user_cost)*CONVERT(FLOAT, sys.dm_db_missing_index_group_stats.avg_user_impact/100.0)*-1  
 , sys.dm_db_missing_index_group_stats.user_seeks*-1  
 , sys.dm_db_missing_index_group_stats.avg_total_user_cost*-1  
  
END     
  
  
  