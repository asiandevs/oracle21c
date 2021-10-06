select listagg(DB_UNIQUE_NAME,',') within group (order by 1) as list from v$dataguard_config where db_unique_name <> (select db_unique_name from v$database)
/

