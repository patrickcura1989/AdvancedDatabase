set echo off
REM RUDIMENTARY PARTITIONING OBE
REM
REM v0.1
REM
REM mwiel	10/18/06	- initial creation
REM hbaer	02/07/07	- first adjustments and extensions
REM
REM
REM
REM
set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85
REM
REM Interval Partitioning
REM 5.Show the segment allocation again-you will see a new segment
REM 
set echo on
-- see how new partitions were created

select partition_name, high_value
from user_tab_partitions
where table_name = 'NEWSALES'
order by partition_position
/

