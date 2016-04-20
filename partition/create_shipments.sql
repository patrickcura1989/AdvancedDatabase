set echo off
REM RUDIMENTARY PARTITIONING OBE
REM
REM v0.1
REM
REM mwiel	10/18/06	- initial creation
REM hbaer	02/07/07	- first adjustments and extensions
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
REM EXTENDED COMPOSITE PARTITIONING
REM

drop table shipments
/

set echo on

-- create table shipments, composite partition by order_date, shipdate

create table shipments
( order_id number not null
, order_date date not null
, ship_date date not null
, customer_id number not null
, sales_amount number not null
)
partition by range (order_date)
subpartition by range (ship_date)
( partition p_2006_jul values
  less than (to_date('01-AUG-2006','dd-MON-yyyy'))
  ( subpartition p_2006_jul_early values
    less than (to_date('15-AUG-2006','dd-MON-yyyy'))
  , subpartition p_2006_jul_agreed values
    less than (to_date('01-SEP-2006','dd-MON-yyyy'))
  , subpartition p_2006_jul_late values less than (maxvalue)
  )
, partition p_2006_aug values
  less than (to_date('01-SEP-2006','dd-MON-yyyy'))
  ( subpartition p_2006_aug_early values
    less than (to_date('15-SEP-2006','dd-MON-yyyy'))
  , subpartition p_2006_aug_agreed values
    less than (to_date('01-OCT-2006','dd-MON-yyyy'))
  , subpartition p_2006_aug_late values less than (maxvalue)
  )
, partition p_2006_sep values
  less than (to_date('01-OCT-2006','dd-MON-yyyy'))
  ( subpartition p_2006_sep_early values
    less than (to_date('15-OCT-2006','dd-MON-yyyy'))
  , subpartition p_2006_sep_agreed values
    less than (to_date('01-NOV-2006','dd-MON-yyyy'))
  , subpartition p_2006_sep_late values less than (maxvalue)
  )
, partition p_2006_oct values
  less than (to_date('01-NOV-2006','dd-MON-yyyy'))
  ( subpartition p_2006_oct_early values
    less than (to_date('15-NOV-2006','dd-MON-yyyy'))
  , subpartition p_2006_oct_agreed values
    less than (to_date('01-DEC-2006','dd-MON-yyyy'))
  , subpartition p_2006_oct_late values less than (maxvalue)
  )
, partition p_2006_nov values
  less than (to_date('01-DEC-2006','dd-MON-yyyy'))
  ( subpartition p_2006_nov_early values
  less than (to_date('15-DEC-2006','dd-MON-yyyy'))
  , subpartition p_2006_nov_agreed values
  less than (to_date('01-JAN-2007','dd-MON-yyyy'))
  , subpartition p_2006_nov_late values less than (maxvalue)
  )
, partition p_2006_dec values
  less than (to_date('01-JAN-2007','dd-MON-yyyy'))
  ( subpartition p_2006_dec_early values
    less than (to_date('15-JAN-2007','dd-MON-yyyy'))
  , subpartition p_2006_dec_agreed values
    less than (to_date('01-FEB-2007','dd-MON-yyyy'))
  , subpartition p_2006_dec_late values less than (maxvalue)
  )
)
/

