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
REM 
set echo on
-- try to insert a new row in 2006 again (NOW IT WILL SUCCEED)
insert into historical_newsales
values (11160,17450,to_date('02-jan-2006','dd-mon-yyyy'),'I',9999,19,798)
/

commit
/
