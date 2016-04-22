--
-- Create a Path-Subsetted XML Index on the PURCHASEORDER table
-- 
drop index PURCHASEORDER_IDX
/
create index PURCHASEORDER_IDX
    on PURCHASEORDER (OBJECT_VALUE)
       indextype is XDB.XMLINDEX
       parameters (
        'paths (
           include (
              /PurchaseOrder/Reference
              /PurchaseOrder/LineItems/LineItem/Part/* ))'
       )
/       
call dbms_stats.gather_schema_stats(USER)
/
