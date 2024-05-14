----------------------------------------------------------SQL Server Stored Procedures Theory-------------------------------------------------------------------------------------
/*A stored procedure is a group of one or more pre-compiled SQL statements into a logical unit. It is stored as an object inside the database server. 
It is a subroutine or a subprogram in the common computing language that has been created and stored in the database. Each procedure in SQL Server 
always contains a name, parameter lists, and Transact-SQL statements. The SQL Database Server stores the stored procedures as named objects. We can 
invoke the procedures by using triggers, other procedures, and applications such as Java, Python, PHP, etc. It can support almost all relational 
database systems.

SQL Server builds an execution plan when the stored procedure is called the first time and stores them in the cache memory. The plan is reused by SQL 
Server in subsequent executions of the stored procedure, allowing it to run quickly and efficiently.

Features of Stored Procedures in SQL Server:
1 Reduced Traffic: A stored procedure reduces network traffic between the application and the database server, resulting in increased performance. It 
is because instead of sending several SQL statements, the application only needs to send the name of the stored procedure and its parameters.

2 Stronger Security: The procedure is always secure because it manages which processes and activities we can perform. It removes the need for 
permissions to be granted at the database object level and simplifies the security layers.

3 Reusable: Stored procedures are reusable. It reduces code inconsistency, prevents unnecessary rewrites of the same code, and makes the code 
transparent to all applications or users.

4 Easy Maintenance: The procedures are easier to maintain without restarting or deploying the application.

5 Improved Performance: Stored Procedure increases the application performance. Once we create the stored procedures and compile them the first time, 
it creates an execution plan reused for subsequent executions. The procedure is usually processed quicker because the query processor does not have to
create a new plan.

Types of Stored Procedures:

1 User-defined Stored Procedures: Database developers or database administrators build user-defined stored procedures. These procedures provide one or
more SQL statements for selecting, updating, or removing data from database tables. A stored procedure specified by the user accepts input parameters 
and returns output parameters. DDL and DML commands are used together in a user-defined procedure.

We can further divide this procedure into two types:

T-SQL Stored Procedures: Transact-SQL procedures are one of the most popular types of SQL Server procedures. It takes parameters and returns them. 
These procedures handle INSERT, UPDATE, and DELETE statements with or without parameters and output row data.

CLR Stored Procedures: The SQL Server procedures are a group of SQL commands, and the CLR indicates the common language runtime. CLR stored procedures
are made up of the CLR and a stored procedure, which is written in a CLR-based language like VB.NET or C#. CLR procedures are .Net objects that run in 
the SQL Server database's memory.

2 System Stored Procedures: The server's administrative tasks depend primarily on system stored procedures. When SQL Server is installed, it creates 
system procedures. The system stored procedures prevent the administrator from querying or modifying the system and database catalog tables directly.
Developers often ignore system stored procedures.

SYNTAX:
CREATE PROCEDURE [schema_name].procedure_name  
                @parameter_name data_type,   
                ....   
                parameter_name data_type  
AS  
   BEGIN  
      -- SQL statements  
      -- SELECT, INSERT, UPDATE, or DELETE statement  
   END  

SET NOCOUNT ON in Stored Procedure: In some cases, we use the SET NOCOUNT ON statement in the stored procedure. This statement prevents the message 
that displays the number of rows affected by SQL queries from being shown. NOCOUNT denotes that the count is turned off. It means that if SET NOCOUNT
ON is set, no message would appear indicating the number of rows affected.

Disadvantages of Stored Procedures:

The following are the limitations of stored procedures in SQL Server:

Debugging: Since debugging stored procedures is never simple, it is not advised to write and execute complex business logic using them. As a result, 
if we will not handle it properly, it can result in a failure.

Dependency: As we know, professional DBAs and database developers handle vast data sets in large organizations. And the application developers must 
depend on them because any minor changes must be referred to a DBA, who can fix bugs in existing procedures or build new ones.

Expensive: Stored procedures are costly to manage in terms of DBAs because organizations would have to pay extra costs for specialist DBAs. A DBA is 
much more qualified to handle complex database procedures.

Specific to a Vendor: Stored procedures written in one platform cannot run on another. Since procedures written in Oracle are more complicated, we 
will need to rewrite the entire procedure for SQL Server

Temporary Stored Procedure
We can create temporary procedures in the same way as we can create temporary tables. The tempdb database is used to create these procedures. We can 
divide the temporary procedures into two types:

1 Local Temporary Stored Procedures: We can create this type of procedure by using the # as prefix and accessed only in the session in which they were
created. When the connection is closed, this process is immediately terminated.

2 Global Temporary Stored Procedure: We can create this type of procedure by using the ## as a prefix and accessed from any sessions. When the 
connection that was used to create the procedure is closed, this procedure is automatically terminated.

*/

--To encrypt the text of stored procedures we can use WITH ENCRYPTION COMMAND before AS keyword
--Whenever we execute a stored Procedures it returns an integer status variable usually zero indicates success and non zero indicates failure.
--We can use the ALTER command alongside CREATE command to change the definition OR functioning of Stored Procedure


----------------------------------------------------------SQL Server Stored Procedures Practical-------------------------------------------------------------------------------------

SELECT * FROM sys.procedures; --This will give you the detail of all the stored procedures present in the database

--The best way for listing all user-defined stored procedures in a database is to use the ROUTINES information schema view as explained below
SELECT * FROM HospitalDatabase.INFORMATION_SCHEMA.ROUTINES  WHERE ROUTINE_TYPE = 'PROCEDURE'  

--creating Stored Procedures without parameters
GO
CREATE OR ALTER PROCEDURE spGetMedicineDetails 
AS 
BEGIN
SELECT  * FROM Medicine
END
spGetMedicineDetails --Executing the Stored Procedures just by writing the name of stored procedures and executing it.
EXEC spGetMedicineDetails --Executing the Stored Procedures by using execute commmand

--Dropping the Procedure
Drop Procedure spGetMedicineDetails

--creating Stored Procedures with input parameters, here we have to pass some value/parameters to get the filtered result
GO
CREATE OR ALTER PROC spHospitalDetails
@Id INT,
@HospitalType VARCHAR(100), 
@DoctorId INT 
AS
BEGIN
SELECT HospitalName,HospitalType, DoctorId FROM Hospital WHERE HospitalType = @HospitalType and DoctorId = @DoctorId
END
EXEC spHospitalDetails 0,'Private' , 1

--STORED PROCEDURES using INPUT parameters with INSERT statement 
GO
CREATE OR ALTER PROC spPatientDetails
@PatientName VARCHAR(20), 
@PatientDisease VARCHAR(30)
AS
BEGIN
INSERT INTO Patient (PatientName, PatientDisease) VALUES(@PatientName,@PatientDisease)
END
EXEC spPatientDetails 'Vinita' , 'Covid'

GO
CREATE OR ALTER PROC spGetPatientDetailsByPatientDisease
@Id INT OUTPUT, 
@PatientName VARCHAR(20),
@PatientDisease VARCHAR(30)
AS
BEGIN
INSERT INTO Patient(PatientName, PatientDisease) VALUES(@PatientName,@PatientDisease)
SET @Id = SCOPE_IDENTITY() /*this will give the detail of column number on which the record is inserted and is generally used with ID column of 
the table.*/
SELECT  @Id /*This will me the parameter value against which the query is executed and which is declared inside the create stored procedure 
statement, we cannot give the parameter which is not declared inside the create stored procedure statement*/
END
EXEC spGetPatientDetailsByPatientDisease 0,'Mahi' , 'Fever'

--Stored Procedures using Input parameters with update statement
GO
CREATE OR ALTER PROC spUpdateDoctorName
@DoctorDesignation VARCHAR(40)
AS
BEGIN
SET NOCOUNT ON --This statement prevents the message that displays the number of rows affected by executing SQL queries.
UPDATE Doctor SET DoctorName = 'Vishesh' WHERE DoctorDesignation=@DoctorDesignation
END
EXEC spUpdateDoctorName 'dentist' 

--We can update multiple columns by explicitly giving their VALUES during execute statement
GO
CREATE OR ALTER PROC spUpdateDoctorName
@DoctorName VARCHAR (30),
@DoctorDesignation VARCHAR(40)
AS
BEGIN
UPDATE Doctor SET DoctorDesignation = @DoctorDesignation WHERE DoctorName = @DoctorName
END
EXEC spUpdateDoctorName  'Ajay', 'Compunder'


--Stored Procedures using Input parameters with Delete statement
GO
CREATE OR ALTER PROC spDeletePatientName
@PatientName VARCHAR (30),
@PatientDisease VARCHAR(40)
AS
BEGIN
DELETE FROM Patient WHERE PatientName = @PatientName
SELECT  @PatientName --This will SELECTthe value which is being deleted
END
EXEC spDeletePatientName  'Amar','Dengue'


----------------------------------------------creating Stored Procedures with Output parameters--------------------------------------------------
/*Stored Procedures with Output parameters will return a value so we have to CREATE a variable to recieve the value returned by stored procedure 
and to hold the value the value of stored procedure returned by it. These output parameters can be of any valid data type, such as integer, 
date, or character.*/
/*When we execute the stored procedure below then it will give the count of total records present for the given parameter*/
GO
CREATE OR ALTER PROC spGetPatientCountByPatientDisease
@PatientDisease VARCHAR(30),
@PatientCount INT OUTPUT
AS
BEGIN
SELECT  @PatientCount = count(Id) FROM Patient WHERE PatientDisease = @PatientDisease
END
DECLARE @PatientTotal INT --Declare an Int Variable that corresponds to the Output parameter in SP  
EXEC spGetPatientCountByPatientDisease 'Cold' , @PatientTotal OUTPUT
PRINT @PatientTotal -- Print the result 

--If we dont specify the output keyword in execute command it will not print anything as it will take it as null
--Declare @PatientTotal INT
--EXEC spGetPatientCountByPatientDisease 'Fever' , @PatientTotal 
--if(@PatientTotal is null)
--Print 'The value is null'
--ELSE 
--print 'The value is not null'
--Print @PatientTotal

--To view the stored procedure script use the below command
EXEC sp_helptext spGetHospitalByTypeAndDoctor

--For getting more details about the stored procedures we can use system system stored procedures named as sp_help
EXEC sp_help spGetPatientCountByPatientDisease

EXEC sp_help Medicine --to get the information about the table, we can use sp_help with any database object OR we can use alt F1 shortcut key

EXEC sp_depends spGetPatientCountByPatientDisease --This will display the dependency of stored Procedures

--Declare Statement
GO
CREATE OR ALTER PROC sp_Prospect_SelectByState
@param nVARCHAR(20)
AS
BEGIN 
DECLARE @State VARCHAR(200);
SELECT  @State = State FROM Person WHERE State like @param + '%';
DECLARE @City VARCHAR(200)=''
SELECT  @City = City FROM Person WHERE City like @param + '%';
-- SELECT  @state
SELECT FirstName,State,City FROM Person WHERE State = @State OR City = @City;
END
EXEC sp_Prospect_SelectByState 'Ra'

Declare @FullName VARCHAR(200) = ''
SELECT  @FullName = concat (FirstName,'',LastName) FROM person
SELECT  @FullName as FullName
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Testing Stored Procedure on big table---------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Person(ID INT IDENTITY(1,1), 
FirstName VARCHAR(20), 
LastName VARCHAR(20), 
City VARCHAR(30), 
State VARCHAR(100),
DOB DATE, Age INT, 
IsActive BIT, 
Gender VARCHAR(10), 
ContactNumber BIGINT,
MinorMajor VARCHAR(30), 
Qualification VARCHAR(100))

INSERT INTO Person(FirstName , 
LastName, 
City , 
State , 
DOB, 
Age, 
IsActive, 
Gender, 
ContactNumber,
MinorMajor, 
Qualification) 
VALUES('Chirag', 'Gupta','Jaipur','Rajasthan','2001-06-17',21,1,'male', 8474738494,'Major', 'B.tech');

GO
CREATE OR ALTER PROC Addvalue
@Id INT , 
@FirstName VARCHAR(20), 
@LastName VARCHAR(20),
@City VARCHAR(30), 
@State VARCHAR(100),
@DOB Date, @Age INT, 
@IsActive bit, 
@Gender VARCHAR(10), 
@ContactNumber BIGINT, 
@MinorMajor VARCHAR(30), 
@Qualification VARCHAR(100)
AS
BEGIN
INSERT INTO Person(FirstName,LastName,City,State,DOB,Age,IsActive,Gender,ContactNumber,MinorMajor,Qualification) 
VALUES(@FirstName,@LastName,@City,@State,@DOB,@age,@IsActive,@Gender,@ContactNumber,@MinorMajor,@Qualification)
END

EXEC Addvalue 0,'Krishna','Mehera', 'Kochin', 'Kerela', '1990-03-11',45,1,'male', 9829743839,'minor', 'Bsc' 

GO
CREATE OR ALTER PROC Supdate
@Age INT,
@Id INT 
/*@FirstName VARCHAR(20),
@LastName VARCHAR(20), 
@City VARCHAR(30), 
@State VARCHAR(100),
@DOB Date,  
@IsActive bit, 
@Gender VARCHAR(10), 
@ContactNumber BIGINT,
@MinorMajor VARCHAR(30), 
@Qualification VARCHAR(100)*/
AS
BEGIN
update Person set age = @Age
/*FirstName = @FirstName,
LastName=@LastName,
City=@City,
State=@State,
DOB=@DOB,
IsActive = @IsActive,
Gender = @Gender,
ContactNumber=@ContactNumber,
MinorMajor=@MinorMajor,
Qualification=@Qualification*/
WHERE Id = @Id
END
EXEC Supdate 23,2

GO
CREATE OR ALTER PROC spSelect
@Id INT
AS
BEGIN
SELECT FirstName, City, Age, IsActive FROM Person WHERE Id = @Id
END

EXEC spSelect 5


----Joins in Stored Procedure without using Parameter-------
GO
CREATE OR ALTER PROC spleftjoin
AS
BEGIN
SELECT d.DoctorDesignation, h.HospitalType FROM Doctor d LEFT JOIN Hospital h on d.Id=h.Id;
END
EXEC spleftjoin

----Joins in Stored Procedure using Parameter-------
GO
CREATE OR ALTER PROC spleftjoinusingparameter
@DoctorName VARCHAR(30)
AS
BEGIN
SELECT d.DoctorDesignation, h.HospitalType FROM Doctor d LEFT JOIN Hospital h on d.Id=h.Id WHERE DoctorName = @DoctorName;
END
EXEC spleftjoinusingparameter 'Vijay'

GO
CREATE OR ALTER PROC spRightJoin
AS
BEGIN
SELECT d.DoctorDesignation, h.HospitalType FROM Doctor d RIGHT JOIN Hospital h on d.Id=h.Id;
END
EXEC spRightJoin

GO
CREATE OR ALTER PROCEDURE sp_Practice_Insert
AS
BEGIN
DECLARE @TotalEmployeeID INT ;
SELECT d.DoctorDesignation, h.HospitalType FROM Doctor d JOIN Hospital h on d.Id=h.Id;
END

GO
CREATE OR ALTER PROCEDURE sp_Practice_Insert
@DoctorName VARCHAR(50)
AS
BEGIN
DECLARE @TotalEmployeeID INT ;
SELECT d.DoctorDesignation, h.HospitalType FROM Doctor d full JOIN Hospital h on d.Id=h.Id WHERE DoctorName = @DoctorName;
END
EXEC spleftjoinusingparameter 'Vijay'
