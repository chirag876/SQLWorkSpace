---------------------------------------------------------Triggers in SQL Server------------------------------------------------------------------------
--Trigger is a special kind of stored procedure that automatically executes when an event occurs in the database server.
--There are three types of triggers 
-- 1 DML Triggers - INSERT, UPDATE, DELETE, these are fired/invoked automatically in response to DML events these are of two types
-- A AFTER/FOR Triggers
-- B INSTEAD OF Triggers
-- 2 DDL Triggers - CREATE, ALTER
-- 3 LOGON Triggers
--Select * from PetShop

GO
CREATE OR ALTER TRIGGER trPetShopInsert
ON PetShop
AFTER INSERT 
AS
BEGIN
PRINT 'Values are inserted.....'
SELECT * FROM INSERTED /*This is a magic table just like a temporary table, this will show us the complete row on which the data is
inserted.*/
END
EXEC spInsertIntoPetShop 'Hudson', 6, 'Peigon', 94060, 21, '2013-09-13', 4

--DROP TRIGGER tr_deleteEmp
GO
CREATE OR ALTER TRIGGER trPetShopDelete
ON PetShop
AFTER DELETE
AS
BEGIN
PRINT  ' Pet is deleted'
SELECT * FROM DELETED
END
DELETE FROM PetShop WHERE Id =15

--create table petaudit(Id INT Identity(1,1), PetName nvarchar(max)
GO
CREATE or alter TRIGGER trPetShopAuditInsert  
ON petshop
FOR Insert 
AS  
BEGIN  
Declare @Id int  
SELECT @Id = Id from Inserted 
--Declare @PetName nvarchar(max)
--SELECT @PetName = PetName From inserted
INSERT INTO petaudit --Here the information of DML information is inserted into audit table
VALUES ('An existing Patient with Id = ' + CAST(@Id AS VARCHAR(10)) + ' is Inserted at ' + CAST(Getdate() AS VARCHAR(22))) 
select * from petaudit
END  
EXEC spInsertIntoPetShop 'Spiky', 5, 'Parrot', 9000, 12, '2011-09-13', 1

GO
CREATE OR ALTER TRIGGER trPetShopUpdate
ON PetShop
AFTER UPDATE
AS
BEGIN
SELECT * FROM INSERTED
SELECT * FROM DELETED
END
UPDATE PetShop SET PetName = 'Harber' WHERE Id = 1

---------------------------------------------------------Cursor in SQL Server------------------------------------------------------------------------
/*SQL Server is very good at handling data in sets but however when we need to process the rows of a table in a row by row by basis 
then we can use cursors, cursors have very low performance and should be avoided, but these cursors can be replaced using joins, cursor 
simply is a pointer to a row.
there different types of cursor:
1 Forward only 
2 static
3 keyset
4 dynamic
*/

--Cursor 1
DECLARE SampleCursor CURSOR SCROLL /*Optional*/ FOR SELECT * FROM PetShop
OPEN SampleCursor
FETCH FIRST  FROM SampleCursor
FETCH NEXT  FROM SampleCursor
FETCH NEXT  FROM SampleCursor
FETCH PRIOR  FROM SampleCursor
FETCH LAST  FROM SampleCursor
FETCH PRIOR  FROM SampleCursor
FETCH ABSOLUTE 4 FROM SampleCursor
CLOSE SampleCursor
DEALLOCATE SampleCursor --It will deallocate the resources used by the cursor

--Cursor 2 using while loop
DECLARE Cursorusingloop CURSOR FOR SELECT * FROM PetShop
OPEN Cursorusingloop
FETCH NEXT FROM Cursorusingloop
WHILE(@@FETCH_STATUS = 0)
BEGIN
PRINT 'Id = ' 
FETCH NEXT FROM Cursorusingloop 
END
CLOSE Cursorusingloop
DEALLOCATE Cursorusingloop 

--SELECT * FROM PERSON
--SELECT * FROM PETSHOP

--Cursor 3 Here we are updating the PetName in PetShop using the ID of the person table using cursor
DECLARE @ID INT
DECLARE @NAME NVARCHAR(MAX)
DECLARE Cursorforupdate CURSOR FOR SELECT ID FROM PERSON
OPEN Cursorforupdate
FETCH NEXT FROM Cursorforupdate INTO @ID
WHILE(@@FETCH_STATUS = 0)
BEGIN
SELECT @NAME = PETNAME FROM PETSHOP WHERE ID = @ID
IF(@NAME = 'HARBER')
BEGIN
UPDATE PERSON SET MinorMajor = 'MINOR' WHERE ID = @ID
END
ELSE
BEGIN
UPDATE PERSON SET MinorMajor = 'MAJOR' WHERE ID = @ID
END
FETCH NEXT FROM Cursorforupdate INTO @ID
END
CLOSE Cursorforupdate
DEALLOCATE Cursorforupdate

--Cursor 4
DECLARE SampleCurs CURSOR SCROLL FOR SELECT PetAge, PetName FROM PetShop
DECLARE @PetAge BIGINT, @PetName NVARCHAR(MAX)
OPEN SampleCurs
FETCH FIRST  FROM SampleCurs INTO @PetAge,@PetName
PRINT 'Pet Details: '+ cast(@PetAge AS VARCHAR(50)) + ' ' +cast(@PetName AS VARCHAR(30))
FETCH NEXT  FROM SampleCurs INTO @PetAge,@PetName
PRINT 'Pet Details: '+ cast(@PetAge AS VARCHAR(50)) + ' '+cast(@PetName AS VARCHAR(30))
FETCH LAST  FROM SampleCurs INTO @PetAge,@PetName
PRINT 'Pet Details: '+ cast(@PetAge AS VARCHAR(50)) + ' '+cast(@PetName AS VARCHAR(30))
FETCH PRIOR  FROM SampleCurs INTO @PetAge,@PetName
PRINT 'Pet Details: '+ cast(@PetAge AS VARCHAR(50)) +' '+ cast(@PetName AS VARCHAR(30))
CLOSE SampleCurs
DEALLOCATE SampleCurs