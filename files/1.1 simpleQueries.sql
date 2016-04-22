--
-- 1. Use XQuery and fn:collection to count the documents in the PURCHASEORDER 
-- table.
--
select *
  from XMLTABLE
       (
          'count(fn:collection("oradb:/OE/PURCHASEORDER"))'
       )
/
--
-- 2. Use XQuery to select a single document from the PURCHASEORDER table
--
select * 
  from XMLTABLE
       (
          'for $i in fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder[Reference/text()=$REFERENCE]
           return $i'
           passing 'AFRIPP-2010060818343243PDT' as "REFERENCE"
       )
/
--
-- 3. Use XMLSerialize to convert the XMLType to a CLOB. Allows result to be
-- viewed in SQLDeveloper versions that do not support rendering XMLType.
--
select XMLSERIALIZE(CONTENT COLUMN_VALUE AS CLOB INDENT SIZE=2) 
  from XMLTABLE
       (
          'for $i in fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder[Reference/text()=$REFERENCE]
           return $i'
           passing 'AFRIPP-2010060818343243PDT' as "REFERENCE"
       )
/
--
-- 4. XQuery with multiple predicates, returning a single node (Reference)
--
select XMLSERIALIZE(CONTENT COLUMN_VALUE AS CLOB) 
  from XMLTABLE
       (
          'for $i in fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder[CostCenter=$CC and Requestor=$REQUESTOR and count(LineItems/LineItem) > $QUANTITY]/Reference
           return $i'
           passing 'A60' as "CC", 'Diana Lorentz' as "REQUESTOR", 5 as "QUANTITY"
       )
/
--
-- 5. XQuery constructing a new summary document from the documents that match the specified predicates
-- Also demonstrates the use of nested FOR loops, one for the set of PurchaseOrder documents, and one for 
-- the LineItem elements
--
select XMLSERIALIZE(CONTENT COLUMN_VALUE AS CLOB INDENT SIZE=2) 
  from XMLTable
       (
         '<Summary UPC="{$UPC}">
          {
           for $p in fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder
            for $l in $p/LineItems/LineItem[Quantity > $Quantity and Part/text() =$UPC]
            order by $p/Reference
           	return 
           	  <PurchaseOrder reference="{$p/Reference/text()}" lineItem="{fn:data($l/@ItemNumber)}" Quantity="{$l/Quantity}"/>
          }
          </Summary>' 
          passing  '707729113751' as UPC, 3 as "Quantity"
)
/
--
-- 6. Using XMLTable to create an in-line relational view from the documents that match the XQuery expression.
--
select * 
  from xmlTable 
       ( 
          'for $p in fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder 
            for $l in $p/LineItems/LineItem[Quantity > 3 and Part/text() = "707729113751"] 
              return 
              <Result ItemNumber="{fn:data($l/@ItemNumber)}"> 
                { 
                  $p/Reference, 
                  $p/Requestor, 
                  $p/User, 
                  $p/CostCenter, 
                  $l/Quantity 
                } 
                <Description>{fn:data($l/Part/@Description)}</Description> 
                <UnitPrice>{fn:data($l/Part/@UnitPrice)}</UnitPrice> 
                <PartNumber>{$l/Part/text()}</PartNumber> 
             </Result>' 
             columns 
             SEQUENCE      for ordinality, 
             ITEM_NUMBER       NUMBER(3) path '@ItemNumber', 
             REFERENCE     VARCHAR2( 30) path 'Reference', 
             REQUESTOR     VARCHAR2(128) path 'Requestor', 
             USERID        VARCHAR2( 10) path 'User', 
             COSTCENTER    VARCHAR2(  4) path 'CostCenter', 
             DESCRIPTION   VARCHAR2(256) path 'Description',  
             PARTNO        VARCHAR2( 14) path 'PartNumber',  
             QUANTITY       NUMBER(12,4) path 'Quantity',  
             UNITPRICE      NUMBER(14,2) path 'UnitPrice' 
       ) 
/        
--
-- 7. Joining relational and XML tables using XQuery.
--
select REQUESTOR, DEPARTMENT_NAME 
  from HR.EMPLOYEES e, HR.DEPARTMENTS d,
       XMLTABLE
       (
         'for $p in fn:collection("oradb:/OE/PURCHASEORDER")/PurchaseOrder
            where $p/User=$EMAIL and $p/Reference=$REFERENCE
            return $p'
          passing 'AFRIPP-2010060818343243PDT' as "REFERENCE", e.EMAIL as "EMAIL"
          COLUMNS
          REQUESTOR path 'Requestor/text()',
          USERNAME  path 'User'
       )
 where e.DEPARTMENT_ID = d.DEPARTMENT_ID
/
quit

