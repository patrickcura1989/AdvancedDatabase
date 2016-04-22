--
-- Execute a simple SQL query over the relational view of XML content
-- showing the use of SQL Group By. XQuery 1.0 did not support the
-- concept of group by
--
select COSTCENTER, count(*)
  From Purchaseorder_Master_View 
  group by COSTCENTER
/
--
-- Simple Query showing a join betwen the master and detail views
-- with relational predicates on both views.
--
select m.REFERENCE, INSTRUCTIONS, ITEMNO, PARTNO, DESCRIPTION, QUANTITY, UNITPRICE
  from PURCHASEORDER_MASTER_VIEW m, PURCHASEORDER_DETAIL_VIEW d
 where m.REFERENCE = d.REFERENCE
   and m.REQUESTOR = 'Steven King'
   and d.QUANTITY  > 7 
   And D.Unitprice > 25.00
/
--
-- Simple Query showing a join betwen the master and detail views
-- with relational predicate on detail view.
--
Select M.Reference, L.Itemno, L.Partno, L.Description
  from PURCHASEORDER_MASTER_VIEW m, PURCHASEORDER_DETAIL_VIEW l 
 Where M.Reference = L.Reference
   and l.PARTNO in ('717951010490', '43396713994', '12236123248')
/
--
-- SQL Query on detail view making use of SQL Analytics 
-- functionality not provided by XQuery
--
Select Partno, Count(*) "Orders", Quantity "Copies"
  from PURCHASEORDER_DETAIL_VIEW  
 where PARTNO in ('717951010490', '43396713994', '12236123248')
 group by rollup(PARTNO, QUANTITY)
/
--
-- SQL Query on detail view making use of SQL Analytics 
-- functionality not provided by XQuery
--
Select Partno, Reference, Quantity, QUANTITY - LAG(QUANTITY,1,QUANTITY) over (ORDER BY SUBSTR(REFERENCE,INSTR(REFERENCE,'-') + 1)) as DIFFERENCE
  from PURCHASEORDER_DETAIL_VIEW  
 Where Partno = '43396713994'
 order by  SUBSTR(REFERENCE,INSTR(REFERENCE,'-') + 1) DESC
/

