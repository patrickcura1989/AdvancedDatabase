--
-- Create a Master View, from elements that occur at most once per document
--
create or replace view PURCHASEORDER_MASTER_VIEW 
as
  select m.* 
    from PURCHASEORDER p,
         xmlTable
         (
            '$p/PurchaseOrder'
            passing p.OBJECT_VALUE as "p"
            columns 
            REFERENCE            path  'Reference/text()',
            REQUESTOR            path  'Requestor/text()',
            USERID               path  'User/text()',
            COSTCENTER           path  'CostCenter/text()',
            SHIP_TO_NAME         path  'ShippingInstructions/name/text()',
            SHIP_TO_ADDRESS      path  'ShippingInstructions/address/text()',
            SHIP_TO_PHONE        path  'ShippingInstructions/telephone/text()',
            INSTRUCTIONS         path  'SpecialInstructions/text()'
         ) m
/
--
-- Create a Detail View, from the contents of the LineItem collection. LineItem can
-- more than once is a document. The rows in this view can be joined with the rows
-- in the previous view using REFERENCE, which is common to both views.
--
create or replace view PURCHASEORDER_DETAIL_VIEW 
as
  select m.REFERENCE, l.*
    from PURCHASEORDER p,
         xmlTable
         (
            '$p/PurchaseOrder' 
            passing p.OBJECT_VALUE as "p"
            columns 
            REFERENCE            path  'Reference/text()',
            LINEITEMS    xmlType path  'LineItems/LineItem'
         ) m,
         xmlTable
         (
           '$l/LineItem'
           passing m.LINEITEMS as "l"
           columns
           ITEMNO         path '@ItemNumber', 
           DESCRIPTION    path 'Part/@Description', 
           PARTNO         path 'Part/text()', 
           QUANTITY       path 'Quantity', 
           UNITPRICE      path 'Part/@UnitPrice'
         ) l
/
