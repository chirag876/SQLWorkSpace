-------------------------------------------------------SQL Server User Defined Functions Theory--------------------------------------------------------------------

/*Functions are the database objects that has a set of SQL statements to perform a specific operation. A function accepts
input parameters, perform actions, and then return the result. Functions will always return either a single value or a table. Its main 
purpose is to perform the common task easily. We can create functions one time and can use them in multiple locations based on our 
needs. We cannot use of the functions for inserting, deleting, or updating records.

Rules for creating functions:

1 A function must have a name, and the name cannot begin with a special character such as @, $, #, or other similar characters.
2 Functions can only be used with SELECT statement
3 Functions can be used anywhere such as AVG, COUNT, SUM, MIN, DATE, and other functions with the SELECT query.
4 Whenever a function is called, it compiles.
5 Functions must return a value or result.
6 Functions use only input parameters.
7 There is no TRY or CATCH statements in functions.

User-Defined Functions: Functions that are created by the user. These functions help us to simplify our development by encapsulating 
complex business logic and making it available for reuse anywhere based on the needs. The user-defined functions make the code needed 
to query data a lot easier to write. They also improve query readability and functionality, as well as allow other users to replicate 
the same procedures.

SQL Server categorizes the user-defined functions mainly into two types:

A Scalar Functions: Scalar function in SQL Server always accepts parameters, either single or multiple and returns a single value. The 
scalar functions are useful in the simplification of our code. Suppose we might have a complex computation that appears in a number of 
queries. In such a case, we can use a scalar function that encapsulates the formula and uses it in each query instead of in each 
query.

SYNTAX:
CREATE FUNCTION schema_name.function_name (parameter_list)  
RETURNS data_type AS  
BEGIN  
    statements  
    RETURN value  
END  

B Table-Valued Functions: Table-valued functions in SQL Server are the user-defined function that returns data of a table type. Since 
this function's return type is a table, we can use it the same way as we use a table.

We can categorize the table-valued function into two types:

1 Inline Table-Values Functions:This UDF function returns a table variable based on the action performed by the function. A single 
SELECT statement should be used to determine the value of the table variable.

2 Multi-statement table-valued functions (MSTVF): This UDF function returns a table variable based on the action performed by the 
function. It can contain single or multiple statements to produce the result, and it is also a function that returns the result of 
multiple statements in a tabular form. It is useful because we can execute multiple statements in this function and get aggregated 
results into the returned table. We can define this function by using a table variable as the return value. Inside the function, we
execute multiple queries and insert data into this table variable.

When should table-valued functions be used?
Table-valued functions are commonly used as parameterized views. Table-valued functions are more flexible than stored procedures 
because they can be used anywhere tables are used.
*/