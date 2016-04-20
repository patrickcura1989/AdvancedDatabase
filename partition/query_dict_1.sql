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
REM 4.show the partition setup for the REF partitioned table in the dictionary
REM 

set echo off

set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85
set echo on


-- show how the partitions were created


select table_name, partitioning_type, ref_ptn_constraint_name 
from user_part_tables 
where table_name in ('ORDERS','ORDER_ITEMS');

select table_name, partition_name, high_value 
from user_tab_partitions 
where table_name in ('ORDERS','ORDER_ITEMS') 
order by partition_position, table_name;

select up.table_name, up.partitioning_type, uc.table_name ref_table 
from user_part_tables up, 
(select r.table_name, r.constraint_name from user_constraints uc, user_constraints r 
where uc.constraint_name=r.constraint_name and uc.owner=r.owner) uc 
where up.ref_ptn_constraint_name = uc.constraint_name(+) 
and up.table_name in ('ORDERS','ORDER_ITEMS');
