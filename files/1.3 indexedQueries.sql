--
-- A set of simple queries to demonstrate how indexing can optimize XQuery operations.
--
select * 
  from XMLTABLE
       (
          'count(fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder[Reference/text()=$REFERENCE])'
           passing 'AFRIPP-2010060818343243PDT' as "REFERENCE"
       )
/
select * 
  from XMLTABLE
       (
          'count(fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder[User/text()=$USER])'
           passing 'AFRIPP' as "USER"
       )
/
select * 
  from XMLTABLE
       (
          'count(fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder[LineItems/LineItem[Part/text()=$UPC]])'
           passing '707729113751' as "UPC"
       )
/
select * 
  from XMLTABLE
       (
          'count(fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder[LineItems/LineItem[Part/text() = $UPC and Quantity > $QUANTITY]])'
           passing '707729113751' as "UPC", 8 as "QUANTITY"
       )
/      
