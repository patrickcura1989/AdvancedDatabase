sqlplus -s /NOLOG <<EOF >> /tmp/setup_dina.log 2>&1 


connect / as sysdba

grant connect, resource, dba to SH;

rem -- event to allow setting very short Flushing interval

alter session set events '13508 trace name context forever, level 1';


rem -- change INTERVAL setting to 2 minutes
rem -- change RETENTION setting to 6 hours (total of 180 snapshots)
execute dbms_workload_repository.modify_snapshot_settings(interval => 2,retention => 360);


rem -- play with ADDM sensitiveness
exec dbms_advisor.set_default_task_parameter('ADDM','DB_ACTIVITY_MIN',30);


alter user sh account unlock;
alter user sh identified by sh;

connect sh/sh

drop index sales_time_bix;
drop index sales_time_idx;
create index sales_time_idx on sales(time_id) compute statistics;


EOF

