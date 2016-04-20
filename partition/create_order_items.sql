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
REM 3.Create a REF partitioned table that depends on the first created one (e.g. Lineitems, pk-fk order_id)

set echo off

set pagesize 2000
set long 10000
set linesize 200
set feedback on
column partition_name format a25
column high_value format a85


-- Create a table order_items with a reference to the orders table partition scheme


Rem see ORA-14652 for restrictions around REF Partitionining FKs

create table order_items
( order_id number(12) not null
, product_id number not null
, quantity number not null
, sales_amount number not null
, constraint order_items_orders_fk foreign key (order_id) references orders(order_id)
)
partition by reference (order_items_orders_fk)
parallel
/

