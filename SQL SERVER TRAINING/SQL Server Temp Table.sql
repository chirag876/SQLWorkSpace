-----------------------------------------------------------What is Temporary Tables-----------------------------------------------------------------------------

/*A temporary (temp) table in SQL Server is a special table that cannot be stored permanently on the database server. This table keeps a subset 
of data from a regular table and can be reused multiple times in a particular session. We cannot store this table in the memory. Since this 
table exists temporarily on the current database server, it will be deleted automatically when the current session ends, or the user terminates 
the database connection. We can get the temporary tables in the system database "tempdb."*/

/*Temporary tables are convenient when we have a bunch of records in a table and only need to deal with a small group of those records on a 
regular basis. In such cases, we can filter the data once and keep them in a temporary table rather than filtering the data multiple times to 
get the required data. After that, we can run our queries on that temporary table. Thus, the temporary table has a feature that enables us to 
achieve complex tasks quickly.*/

/*We can create temporary tables in two ways:
SELECT INTO
CREATE TABLE Statements*/

/* when we access the temporary tables using select outside the current session then it will show an error message "invalid object named 
#temporary table name" because temporary tables can only be accessed inside the session that generated them.*/

--Temporary tables are stored in the tempdb system database, not at the physical locations.
--Temporary tables are faster in loading data because it stores in the tempdb, and modifications are not logged in the log file.
--The system can drop each temporary table implicitly.

----------------------------------------------------Types of Temporary Table------------------------------------------------------------------------------

/*Local Temporary Table: These tables are stored in tempdb and are visible only to the session that created them. These tables are automatically 
destroyed when we close the connection from the instance of SQL Server. We can define the local temporary table name with the prefix of the hash 
(#) sign. The temp table can be created with the same name in multiple connections.*/

/*Global Temporary Table: These tables are stored in tempdb and are visible to all users and all sessions. These tables are automatically 
destroyed when all users that are referencing the table disconnect the connection or when the last session that uses them has been completed. 
We can define the global temporary table name with the prefix of double hash (#) sign.*/

-------------------------------------------------SQL Server Temporary Table--------------------------------------------------------------------------
--Temporary Table using select statement
CREATE OR ALTER PROC spSelectUsingTemp1
@param nVARCHAR(20)
AS
BEGIN 
DECLARE @State VARCHAR(200)=''
SELECT  @State = State FROM Person WHERE State like @param + '%';
SELECT  @state
--DROP TABLE IF EXISTS #temp1;
SELECT FirstName AS FName ,LastName,State,City INTO #temp1  FROM Person WHERE State = @State;
SELECT  * FROM #temp1
END

EXEC spSelectUsingTemp1  'R'
/* when we access the temporary tables using select outside the current session then it will show an error message "invalid object 
named '#temporary table name'" because temporary tables can only be accessed inside the session that generated them.*/

--Temporary Table using create statement
GO
CREATE OR ALTER PROC spSelectUsingTemp
@param nVARCHAR(20)
AS
BEGIN 
DECLARE @State VARCHAR(200)=''
SELECT  @State = State FROM Person WHERE State like @param + '%';
SELECT  @state
DROP TABLE IF EXISTS #Temp;
CREATE TABLE #Temp
(
 FirstName VARCHAR(100),
 LastName VARCHAR(100),  
 City VARCHAR(100),
 State VARCHAR(100),
 MinorMajor VARCHAR(100)
)
IF(@State IS not NULL)
BEGIN
	INSERT INTO #Temp
	SELECT FirstName,LastName,City,State, MinorMajor FROM Person WHERE State = @State
 SELECT  * FROM #Temp
 END 
 ELSE
 BEGIN
  SELECT  'Amit' as FirstName , 'jain' as LastName
 END
END

EXEC spSelectUsingTemp  'R'
