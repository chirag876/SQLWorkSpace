---------------------------------------------SQL Server User Defined Functions--------------------------------------------------------------------

--CREATE TABLE PetShop(Id int IDENTITY(1,1), 
--PetName nvarchar(max), 
--PetAge int, 
--PetType nvarchar(max),
--PetCost bigint, 
--TotalPets bigint,
--Birth Date,
--Weight Bigint
--)

--GO
--CREATE OR ALTER PROCEDURE spInsertIntoPetShop
--@PetName nvarchar(max), 
--@PetAge int, 
--@PetType nvarchar(max),
--@PetCost bigint, 
--@TotalPets bigint,
--@Birth Date,
--@Weight Bigint
--AS
--BEGIN
--INSERT INTO PetShop(PetName,
--PetAge, PetType,PetCost , TotalPets, Birth, Weight)
--VALUES(@PetName,@PetAge,@PetType,@PetCost,@TotalPets,@Birth,@Weight)
--END
--EXEC spInsertIntoPetShop 'GulGul', 2, 'Parrot', 9000, 12, '2011-09-13', 1
/*create table petaudit(Id INT Identity(1,1), PetName nvarchar(max)) This table will be used as trigger table for printing the 
messages of a trigger in a table format*/

-------------------------------------------------Scalor Functions example------------------------------------------------------
--scalor functions may or may not have parameter but always returns single value within in any data type form except text,
--ntext,image, cursor, and timestamp
--When calling a scalor user defined function you must supply a two part name ownername.functionname, dbo stands for database owner.
--We can also call a function using a complete 3 part name databasename.ownername.functionname
--scalor user defined functions can also be used with select where clause.
--select * from PetShop

--Function 1 
GO
CREATE OR ALTER FUNCTION udfTotalPetSale(  
    @TotalPets BIGINT,  
    @PetCost BIGINT
)    
RETURNS BIGINT
AS   
BEGIN  
    RETURN (@TotalPets) * (@PetCost);  
END;
GO
SELECT dbo.udfTotalPetSale(34, 40000) AS DogSale

--Function 2
GO
CREATE OR ALTER FUNCTION udfTotalWeight( 
    @TotalPets BIGINT,  
    @Weight BIGINT 
)  
RETURNS BIGINT
AS   
BEGIN  
DECLARE @FinalWeight BIGINT
    SET @FinalWeight = @TotalPets * @Weight;  
	RETURN @FinalWeight;
END;
GO
SELECT dbo.udfTotalWeight(34,45)

EXEC sp_helptext udfTotalWeight --To check the text of the function

--Function 3 using stored procedure
GO
CREATE OR ALTER PROCEDURE SPFUNC
AS
BEGIN
select * from MULTIVALUEDSUM() 
END
GO

---------------------------------------------------Table - Valued Functions----------------------------------------------------

--Function 1 for Inline Table-Values Function
GO
Create or Alter function UdfPetShop()
returns table
as
return(select * from PetShop)
GO
SELECT * FROM dbo.UdfPetShop()
UPDATE  UdfPetShop() SET PetName = 'Pikachoo' WHERE Id = 1;

--Function 2 for Multi-statement table-valued function (MSTVF)
GO
CREATE OR ALTER FUNCTION MULTIVALUED()  
RETURNS @PetShop TABLE  
(Id INT, PetName nvarchar(max), PetAge int, PetType nvarchar(max)) 
AS  
BEGIN  
INSERT INTO @PetShop
SELECT PS.Id, PS.PetName, PS.PetAge, PS.PetType FROM PetShop PS;
UPDATE   @PetShop   SET PetName = 'pupper' WHERE Id = 1 ;
	RETURN  
END   
GO
SELECT * FROM MULTIVALUED()  

--Function 3 for Multi-statement table-valued function (MSTVF) using aggregate function
GO
CREATE OR ALTER FUNCTION MULTIVALUEDSUM()  
RETURNS @PetShop TABLE  
(TotalPets int) 
AS  
BEGIN  
INSERT INTO @PetShop
SELECT sum(TotalPets)FROM PetShop; 
  	RETURN 
END   
GO
select * from dbo.MULTIVALUEDSUM() 

 


