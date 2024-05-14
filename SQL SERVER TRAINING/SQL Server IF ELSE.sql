---------------------------------------------------------------SQL Server IF ELSE Theory-------------------------------------------------------------------------------

/* 1 IF Statement: It is a part of the control flow function in SQL Server. Usually, it is a decision-making statement in various programming languages that returns
a value based on the given conditions. This statement executes the code written in IF block when the given condition evaluates to true and when the condition 
evaluates false, then the ELSE statement will be executed.

IF boolean_expression     
 BEGIN  
     { statement_block }  
 END  

In the above syntax, the statement_block in the BEGIN...END block is executed when the boolean_expression is satisfied with the condition. Otherwise, this 
block is skipped, and the program control is moved to the statement after the END keyword. We should know that if the expression contains a SELECT statement,
we need to enclose them in parentheses.

2 IF ELSE Statement: In the real-world scenario, we need to perform some action whenever the condition in the IF statement is TRUE or FALSE. In this case, the
IF…ELSE statement is useful. This statement executes the ELSE statement block when the condition in the IF clause is evaluated FALSE.

IF expression  
 BEGIN  
     Statement block -- It executes when the IF clause expression is TRUE.  
 END  
ELSE  
 BEGIN  
    Statement block -- It executes when the IF clause expression is FALSE.  
END  

3 Nested IF ELSE Statement: Unlike other programming languages, we can nest an IF...ELSE statement inside another IF...ELSE statement in SQL Server. However, 
nesting an IF statement within another statement is bad practice because it makes the code difficult to read and maintain.
*/

---------------------------------------------------------------SQL Server IF ELSE Practical-------------------------------------------------------------------------------

--Program 1 
SELECT * FROM PERSON
DECLARE @Age INT = 23;
IF @Age>=18
BEGIN
PRINT 'YOU CAN VOTE'
END

--Program 2
BEGIN
DECLARE @TotalAge INT
SELECT @TotalAge=Age FROM Person WHERE IsActive = 1 OR IsActive=0 
SELECT @TotalAge 
IF @TotalAge>=40
BEGIN
PRINT 'PLEASE TAKE CARE  OF YOURSELF'
END
END

--Program 3
DECLARE @Age INT = 23;
IF @Age>=18
BEGIN
PRINT 'YOU CAN VOTE'
END
ELSE
BEGIN
PRINT 'YOU CANNOT VOTE'
END

--Program 4
DECLARE @FinalAge INT;  
SET @FinalAge = 23 ;  
IF @FinalAge >= 22  
BEGIN  
  SELECT Id, FirstName, Gender, IsActive, Age  
  FROM Person WHERE Age >= 22  
  ORDER BY IsActive ASC  
END  
ELSE  
BEGIN  
  SELECT Id, FirstName, Gender, IsActive, Age  
  FROM Person WHERE Age < 22  
  ORDER BY IsActive ASC    
END  

--Program 5 Nested IF ELSE
DECLARE @age INT;  
SET @age = 23;  
  
IF @age < 18  
   PRINT 'You are underage';  
ELSE  
BEGIN  
   IF @age < 50  
      PRINT 'You are below 50';  
   ELSE  
      PRINT 'You are senior cetizen';  
END; 



