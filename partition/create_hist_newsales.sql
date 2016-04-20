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
REM 7.take a standard range partitioned table and extend it to an interval partitioned table. This demonstrates the migration path to this new functionality.
REM 
set echo on
-- create a range partitioned table, that will be migrated to interval partitioning
create table historical_newsales
( prod_id number(6) not null
, cust_id number not null
, time_id date not null
, channel_id char(1) not null
, promo_id number(6) not null
, quantity_sold number(3) not null
, amount_sold number(10,2) not null
)
partition by range (time_id)
(partition p_previous_century values 
less than (to_date('01-JAN-2000','dd-MON-yyyy'))
, partition p_2000 values less than (to_date('01-JAN-2001','dd-MON-yyyy'))
, partition p_2001 values less than (to_date('01-JAN-2002','dd-MON-yyyy'))
, partition p_2002 values less than (to_date('01-JAN-2003','dd-MON-yyyy'))
, partition p_2003 values less than (to_date('01-JAN-2004','dd-MON-yyyy'))
, partition p_2004 values less than (to_date('01-JAN-2005','dd-MON-yyyy'))
, partition p_2005 values less than (to_date('01-JAN-2006','dd-MON-yyyy'))
)
/

