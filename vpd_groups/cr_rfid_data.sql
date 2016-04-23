set echo on
CREATE TABLE rfid_data
(storage_a VARCHAR2(16),
 date_a VARCHAR2(16),
 storage_b VARCHAR2(16),
 date_b VARCHAR2(16))
TABLESPACE example
/
INSERT INTO rfid_data values ('Shelf 5',2008,'Shelf 3',2004)
/
INSERT INTO rfid_data values ('Shelf 6',2007,'Shelf 1',2005)
/
INSERT INTO rfid_data values ('Shelf 4',2006,'Shelf 2',2003)
/
COMMIT
/