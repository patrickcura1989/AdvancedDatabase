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

REM New extended composite partitions
REM 1.Recap the concept of composite partitioned tables
REM 2.Introduce the new extension based on business cases (e.g. RANGE-RANGE on oder_date/ship_date
REM 3.Demonstrate the data placement for a business scenario
REM 

REM
REM EXTENDED COMPOSITE PARTITIONING
REM
set echo on

-- show how data was distributed for this business case


select count(1) from shipments subpartition (P_2006_OCT_EARLY) ;
select count(1) from shipments subpartition (P_2006_OCT_AGREED) ;
select count(1) from shipments subpartition (P_2006_OCT_LATE) ;



