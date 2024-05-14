-------------------------------------------------------SQL Server WHILE LOOP Theory-------------------------------------------------------------------

/*A WHILE loop is a control flow statement used to repeatedly execute the set of statements until the specified condition is satisfied. This loop 
begins with a given condition, evaluate it, and if it is TRUE, the statements will go inside the loop for further execution. If the condition becomes
FALSE, it will not run. It implies that the while loop in SQL Server could run for zero or more times.

SYNTAX:
WHILE Boolean_Condition  
BEGIN  
   {SQL_statement | statement_block | BREAK | CONTINUE}  
END;  

Boolean_Condition: It's a required condition that will be tested in each iteration to return the TRUE or FALSE result. If it is the SELECT statement, 
it must be surrounded in parenthesis.

Break: It ends the innermost loop instantly, and control flow resumes at the next statement after the loop.

Continue: It jumps to the next iteration without skipping the remaining statements inside the loop. Usually, it causes the loop to restart from the 
beginning.

Nested WHILE Loop: The Nested WHILE Loop in SQL Server is simply a WHILE Loop written inside another WHILE Loop. When we work on multi-layered data,
the Nested WHILE loops are essential. Because this concept is useful in extracting the layered data when we want to select them, it is recommended to
be careful while using the nested loop.

SYNTAX:
WHILE Expression  
 BEGIN  
    WHILE Expression 
        BEGIN  
            --Second WHILE Loop Statements  
            SQL Statements  
        END  
    --This statement is outside the second WHILE loop  
    --Which is the first WHILE loop statement  
    SQL Statements  
 END  
-- This statement is outside the first WHILE loop  
*/

-------------------------------------------------------SQL Server WHILE LOOP Practical-------------------------------------------------------------------

--Program 1 
DECLARE @student INT;  
SET @student = 1;  
WHILE @student <= 10  
BEGIN  
PRINT 'Chirag Gupta';  
SET @student = @student + 1;  
END;  

--Program 2 Infinite While Loop
DECLARE @Person int;  
SET @Person = 1;  
WHILE @Person <= 10  
BEGIN  
PRINT 'Chirag Gupta'  
END;  

--Program 3 Inserting Records with while Loop
select * from Hospital
DECLARE @count INT;  
SET @count = 1;   
WHILE @count <= 19 
BEGIN  
INSERT INTO Hospital VALUES('SMS', 'Government', '23', '4')  
SET @count = @count + 1;  
END; 

--Program 4 Updating Records with while Loop
DECLARE @Update INT;  
SET @Update = 1;   
WHILE @Update<= 10 
BEGIN  
Update Hospital set HospitalName = 'Dhanajay' where Id = 6;  
SET @Update = @Update + 1;  
END;

--Program 5 Break Statement Using while loop
/*Break statement is used to immediately stop the current iteration of the loop, and control flow resumes with the next statement after the loop. In 
general, we will use the IF...ELSE statement to check whether or not a condition has occurred.*/
DECLARE @counting INT;  
SET @counting = 1;   
WHILE @counting <= 10  
BEGIN  
PRINT 'BREAK Statement Example'  
IF @Counting >= 6  
BEGIN  
BREAK 
END  
else
SET @Counting  = @Counting + 1
END
	
--Program 6 While loop using Stored Procedures
Go
CREATE OR ALTER PROCEDURE spwhileloopBreak
AS
DECLARE @counting INT;  
SET @counting = 1;   
WHILE @counting <= 10  
BEGIN  
PRINT 'BREAK Statement Example'  
IF @Counting >= 6  
BEGIN  
BREAK  
END  
SET @Counting  = @Counting + 1
END; 


--Program 7 Update Using While loop
DECLARE @Update INT;  
SET @Update = 1;   
WHILE @Update <= 6
BEGIN  
Update Doctor set TotalDoctor = @Update where id = @Update;  
SET @Update = @Update + 1;  
END;

--Program 8 Update Using While loop
Declare @param int;
Declare @ID int;
set @ID=1;
set @param=1;
while (@param<=(select COUNT(ID)from Person))
begin
if(@ID<=3)
begin
update Person set IsActive=1 where ID=@ID;
end
else
begin
update Person set IsActive=0 where ID=@ID;
end
set @param=@param+1
set @ID=@ID+1
end

