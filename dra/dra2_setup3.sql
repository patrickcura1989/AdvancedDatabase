REM For demo purposes ONLY

spool dra2_setup3.txt 

REM  ALTER TABLESPACE example ONLINE;
ALTER SYSTEM FLUSH BUFFER_CACHE;

select * from hr.regions;
select * from hr.locations;
select * from hr.employees;
spool off
exit

