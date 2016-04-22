--
-- Create a complete XML Index on the PURCHASEORDER table
--
create index PURCHASEORDER_IDX
    on PURCHASEORDER (OBJECT_VALUE)
       indexType is xdb.xmlIndex
/
call dbms_stats.gather_schema_stats(USER)
/
