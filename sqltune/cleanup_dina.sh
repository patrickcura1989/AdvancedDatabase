#
# Cleanup ADDM snapshot settings
#
sqlplus -s /NOLOG <<EOF >> /tmp/cleanup_dina.log 2>&1 

  connect / as sysdba

  rem -- change INTERVAL setting to 30 minute 
  execute dbms_workload_repository.modify_snapshot_settings(interval => 60); 

  rem -- change ADDM sensitiveness back to normal
  exec dbms_advisor.set_default_task_parameter('ADDM','DB_ACTIVITY_MIN',300);

  connect sh/sh

  drop index sales_time_idx;

  create bitmap index sales_time_bix
  on sales(time_id)
  tablespace example
  local nologging compute statistics;


EOF

#
# Cleanup sql profile
#
sqlplus -s /NOLOG <<EOF > /tmp/cleanup_dina.log 2>&1 

  connect / as sysdba

  set head off
  set timing off
  set feedback off;
  set pagesize 0

spool /tmp/drop_dyn.sql;

select q'#connect / as sysdba;#' from dual;

select q'#execute dbms_sqltune.drop_sql_profile('#' || name || q'#') ;#' 
from dba_sql_profiles ;

select q'#execute dbms_advisor.delete_task('#' || task_name || q'#') ;#' 
from user_advisor_tasks 
where  CREATED > SYSDATE-(1/24);

select q'#connect system/Keyboard1;#' from dual;

select q'#execute dbms_advisor.delete_task('#' || task_name || q'#') ;#' 
from user_advisor_tasks
where  CREATED > SYSDATE-(1/24);

spool off

@/tmp/drop_dyn.sql

EOF

