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
REM Interval Partitioning
REM 7.take a standard range partitioned table and extend it to an interval partitioned table. This demonstrates the migration path to this new functionality.
REM 
set echo on
-- try to insert a new row in 2006 (THIS WILL FAIL)
insert into historical_newsales
values (11160,17450,to_date('02-jan-2006','dd-mon-yyyy'),'I',9999,19,798)
/

