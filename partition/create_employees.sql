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

set echo on
drop table employees
/

drop table product_returns
/


-- create a table with a virtual column


create table employees
( employee_id number(6) not null
, first_name varchar2(20)
, last_name varchar2(25)
, email varchar2(25)
, phone_number varchar2(20)
, hiredate date
, job_id varchar2(10)
, salary number(8,2)
, commission_pct number(2,2)
, manager_id number(6)
, department_id number(4)
, well_off as (case sign(1000 - (salary + nvl(commission_pct,0)))
                when 1 then 'poor'
                else case sign(3000 - (salary + nvl(commission_pct,0)))
                  when 1 then 'not doing too bad'
                  when 0 then 'on target'
                  else 'filthy rich'
                  end
               end
              ) virtual
)
/
