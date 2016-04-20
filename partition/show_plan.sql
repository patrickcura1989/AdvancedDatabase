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

-- see how partition-wise joins kick in

set echo on
-- the query

explain plan for
select /*+ use_hash(o,oi) */ o.order_id
, o.order_date
, sum(oi.quantity) sum_quantity
, sum(oi.sales_amount) sum_sales
from orders o
, order_items oi
where o.order_id = oi.order_id
and o.order_date between to_date('01-SEP-2006','DD-MON-YYYY')
                    and to_date('12-DEC-2006','DD-MON-YYYY')
group by o.order_id
, o.order_date
order by o.order_date
/

-- the execution plan

select * from table(dbms_xplan.display)
/

