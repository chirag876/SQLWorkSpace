--------------------------------------------------------SQL SERVER CASE Theory--------------------------------------------------------------------

/*The CASE expression is a part of the control flow function that evaluates a list of conditions and gives the output WHEN  the first condition is 
met. It is primarily used to handle conditional statements, same as IF-THEN-ELSE statements in other programming languages. A CASE statement 
evaluates the condition, and WHEN  finds true, it will stop executing and return the result. If it will not find any conditions true, it evaluates 
the ELSE part to return the value and ends. It will give NULL value WHEN  no ELSE block is found and no conditions are met true.

The CASE expression can be used anywhere a valid program or query is used like SELECT, WHERE, and ORDER BY clause. Its main function is to manage 
multiple IF statements in the SELECT clause. In MS SQL Server, the CASE statement allows the user to add several conditions to perform various 
sets of actions.

Types of CASE Statement:

1 Simple CASE Statement: We use the simple CASE statement for equality tests. It determines the result by comparing an expression to a set of 
multiple values to determine the result. In other words, this statement evaluates conditions one by one and returning the expression specified in 
the THEN clause WHEN  the condition and expression are matched.

There is an expression between the CASE keyword and WHEN  clause. For example,CASE

This statement is used for a simple equality check and determines the result by comparing an expression to a set of multiple values.

The simple CASE statement only supports equality tests.


The following are the syntax for Simple CASE statement:

CASE <input_expression>  
     WHEN  Condition1 THEN Statement1  
     WHEN  Condition2 THEN Statement2  
     .  
     .  
     WHEN  ConditionN THEN StatementN  
     ELSE Statement     
END   

Here the CASE statement checks for equality by comparing the expression (input_expression) to a value defined in each WHEN  clause. It gives the 
resultant statement in the corresponding THEN clause if the input_expression matches the WHEN  clause's value. If the input_expression does not 
match any value and the ELSE block is available, the CASE expression will return the ELSE block's result. The CASE expression will give NULL value 
WHEN  the ELSE part is not found, and the input_expression does not match any value in the WHEN  clause.

2 Searched CASE Statement: The searched CASE statement is a more comprehensive expression evaluation format that evaluates a set of Boolean 
expressions to find the result. It allows us to use the comparison operators and logical operators within each Boolean expression.

WHEN  Condition1 THEN Statement1 There is no expression between the CASE keyword and WHEN  clause. For example, CASE WHEN  Condition1 THEN Statement1

This statement tests the conditions for each of the "WHEN " statements separately. It helps us to solve more complex conditions than a simple CASE.

The searched CASE statement supports any operation that returns a Boolean value with Boolean_Expression. It includes the equal and not equal to 
operators.

The following are the syntax for a Simple CASE statement:

CASE  
  WHEN  boolean_expression_1 THEN result_1  
  WHEN  boolean_expression_2 THEN result_2  
  .  
  .  
  WHEN  boolean_expression_N THEN result_N  
  ELSE else_result  
END ;  

This statement starts by evaluating each WHEN  clause's boolean_expression in the order defined in the CASE expression. If the evaluation of
boolean_expression in each WHEN  clause is true, this statement gives the corresponding THEN clause results. If the evaluation is false, this 
statement returns the result specified in the ELSE block. The CASE expression will return NULL if the ELSE block is not found and the 
boolean_expression evaluation is true. The END  clause is optional.

Return Type: 
The CASE expression returns the result depending on the context where it is used. For example:
If it is used in the string context, it returns the string result.
If it is used in a numeric context, it returns the integer, float, decimal value.

Limitations of CASE Statement:

1 The CASE statement does not allow us to control the execution flow of stored procedures and functions in SQL Server.
2 The CASE statement can have several conditions in a Case statement, but it operates only in a sequential model. WHEN  one of the conditions becomes 
true, it stops testing further statements.
3 The CASE statement does not allow us to NULL values in a table.
*/

---------------------------------------------------SQL SERVER CASE Practical----------------------------------------------------------------------

-------------------------------------------------Simple CASE
select * from Person
SELECT CASE 2 WHEN  1 THEN 'Male' WHEN  2 THEN 'Female' ELSE 'Other' END  AS "CASE Result";  

SELECT IsActive, State,  
CASE State  
    WHEN  'Rajasthan' THEN 'Active'
    WHEN  'Harayan' THEN 'Active'   
    ELSE 'Not Active'  
END  AS Activation FROM Person;  

-------------------------------------------------Searched CASE
SELECT IsActive, State,  
CASE   
    WHEN  IsActive =  1 THEN 'Active'
    WHEN  IsActive = 0 THEN 'Not Active'   
    ELSE 'Not Present in the Database'  
END  AS Activation FROM Person;  

-------------------------------------------------Nested CASE
SELECT FirstName, City, Qualification,
CASE
WHEN  Qualification = '12th Pass' THEN
CASE
WHEN  Qualification = 'PHD' THEN 'Level 1 Qualified'
ELSE 'NOT Qualified'
END 
ELSE 'Qualified'
END  AS Entrance
FROM Person

-------------------------------------------------ORDER BY With CASE
SELECT FirstName, City, Qualification
FROM Person
ORDER BY CASE
WHEN  Qualification = 'PHD' THEN City END  DESC,
CASE WHEN  Qualification = 'B.tech' THEN CITY
END 

-------------------------------------------------UPDATE With CASE
update Patient
	set PatientName = case PatientDisease
		WHEN  'Flu' THEN 'Jethalal'
		WHEN  'Fever' THEN 'Lokesh'
		WHEN  'Malaria' THEN 'Mohit'
		WHEN  'Dengue' THEN 'Ashutosh'
		Else PatientName
		END ,
		TotalPatient = case PatientDisease
		WHEN  'Flu' THEN 3
		WHEN  'Fever' THEN 7
		WHEN  'Malaria' THEN 9
		WHEN  'Dengue' THEN 22
		else TotalPatient
		END  
		
-------------------------------------------------Stored Procedure With CASE

CREATE or ALTER PROCEDURE spCaseSelect 
AS   
BEGIN  
	SELECT ID,FirstName,LastName,City,
	CASE WHEN  IsActive=1 THEN 'AccountActive' WHEN  IsActive=0 THEN 'AccountDeactivated' ELSE 'NoInformation' END  AS AccountInformation  
	FROM Person  
END 



