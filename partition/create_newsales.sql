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


set echo off

set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85

REM
REM Interval Partitioning
REM 1.Introduce the concept of Interval Partitioning
REM 2.Create an interval partitioned table
REM 

-- cleanup
set echo on

drop table historical_newsales
/

drop table newsales
/

-- create interval partitioned table

create table newsales
( prod_id number(6) not null
, cust_id number not null
, time_id date not null
, channel_id char(1) not null
, promo_id number(6) not null
, quantity_sold number(3) not null
, amount_sold number(10,2) not null
)
partition by range (time_id)
interval (numtodsinterval(1,'DAY'))
( partition p_before_1_jan_2005 values
 less than (to_date('01-01-2005','dd-mm-yyyy')))
/

