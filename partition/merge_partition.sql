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
REM 6.Do a partition maintenance operation on older Partitions (e.g. MERGE). This will demonstrate the fact that an interval partitioned table can have manually managed older rnage partition components
REM 
-- merge 2 partitions: traditional functionality of course works
set echo on
alter table newsales
merge partitions for(to_date('01-JAN-2005','dd-MON-yyyy'))
, for(to_date('02-JAN-2005','dd-MON-yyyy'))
into partition p_before_3_jan_2005
/

