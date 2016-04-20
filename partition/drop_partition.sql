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

REM 
REM REF Partitioning
REM 6.insert data into the REF partitioned table and show that co-location of  the dependent data is taken place
REM 

set echo off

set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85
set feedback on


-- show the manageability aspects of inheriting the partitioning scheme (drop a partition for the ORDERS table)

set echo on
alter table orders drop partition p_before_jan_2006 update global indexes
/
