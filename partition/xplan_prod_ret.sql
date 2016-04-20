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
REM Virtual column-based partitioning
REM 1.Introduce the concept of a virtual column (e.g. Extract the month out of a date)
REM 2.Create a simple virtual column and select from it (you can also highlight that you can collect stats on such a column)
REM 3.Create a virtual column-based partitioned table (for demonstration purposes this can be something goofy like adding two column values or so)
REM 4.insert some data and show the data placement based on the virtual column definitions
REM 


-- show partition pruning for queries that use the expression that defines the virtual column (remember you can also gather statistics on the virtual column)

set echo on
explain plan for select * from product_returns where quantity * unit_price = 60000
/


select * from table(dbms_xplan.display) ;

