--
-- Create a Structured XML Index on the PURCHASEORDER table
-- 
drop index PURCHASEORDER_IDX
/
begin 
  DBMS_XMLINDEX.dropParameter(
                 'PO_SXI_PARAMETERS');
end;
/
begin 
  DBMS_XMLINDEX.registerParameter(
                 'PO_SXI_PARAMETERS',
                 'GROUP   PO_LINEITEM
                    xmlTable PO_INDEX_MASTER ''/PurchaseOrder''
                       COLUMNS
                         REFERENCE 	     varchar2(30) 	PATH ''Reference/text()'',
                         LINEITEM            xmlType   	PATH ''LineItems/LineItem''
                    VIRTUAL xmlTable PO_INDEX_LINEITEM ''/LineItem''
                       PASSING lineitem
                       COLUMNS
                         ITEMNO         number(38)  	 PATH ''@ItemNumber'',
                         UPC            number(14)     PATH ''Part/text()'', 	
                         DESCRIPTION    varchar2(256)  PATH ''Part/@Description''
                 ');
end;                
/
create index PURCHASEORDER_IDX
          on PURCHASEORDER (OBJECT_VALUE)
             indextype is XDB.XMLINDEX
             parameters ('PARAM PO_SXI_PARAMETERS')
/
create unique index REFERENCE_IDX 
       on PO_INDEX_MASTER (REFERENCE)
/ 
create index UPC_IDX 
       on PO_INDEX_LINEITEM (UPC)
/   
call dbms_stats.gather_schema_stats(USER)
/
