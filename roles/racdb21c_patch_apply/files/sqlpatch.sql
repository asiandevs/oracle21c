set linesize 300;
column description format a55
column action_time format a30
column action format a8
column status format a8
column "patch_id" format 99999999999
column "patch_uid" format 9999999999

select patch_id, patch_uid, description, action_time, action, status
from dba_registry_sqlpatch;
