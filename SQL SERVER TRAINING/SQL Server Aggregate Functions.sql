--------------------------------------------------------SQL SERVER Aggregate Functions Theory-----------------------------------------------------

/*1 MIN() Function: It is used to get the minimum or smallest value of a specified column or expression. It is the most commonly used built-in 
function in the SQL Server. It comes under the numeric function that accepts only one parameter and returns a single result after evaluation to 
summarize the input data set. We can use this function with several clauses such as WHERE, GROUP BY, ORDER BY, and HAVING clause to get the 
filtered output. The MIN() function ignores NULL values.

2 MAX() Function: It is used to get the maximum or largest value in a group of values of a specified column or expression. It is the most commonly 
used built-in function in the SQL Server. This function accepts a single parameter that can be a column or valid expression and returns a single 
result to summarize the input data set. It can also work with the WHERE, GROUP BY, ORDER BY, and HAVING clauses to get the filtered result.
The MAX() function ignores NULL values. It returns NULL when no row is found.

3 SUM() Function: We use this function to calculate the total summed value in a set of values of a specified column or expression. It is a built-in 
function, which accepts a single parameter that can be a column or valid expression and returns a single result to summarize the input data set. 
This function ignores the NULL values. However, it returns NULL when the result set does not have any rows. It can also work with the WHERE, GROUP
BY, ORDER BY, and HAVING clauses to get the filtered result.

4 AVG() Function: We use this function to calculate the average value of an expression. This function ignores the NULL values. However, when the 
result set does not have any rows, it returns NULL. The AVG() is a built-in function usually used with the SELECT statement. This function accepts
only one parameter that can be a column or valid expression and returns a single result to summarize the input data set. It can also work with the
WHERE, GROUP BY, ORDER BY, and HAVING clauses to get the filtered result.

5 COUNT() Function: used for calculating the total number of rows present in the table. When the result set does not have any rows, it returns NULL.
It is usually used with the SELECT statement, and its return type is INT. The COUNT() is a built-in function, which accepts a single parameter 
that can be a column or valid expression and returns a single result to summarize the input data set. This function does not ignore the NULL 
values as it considers them too while calculating the query's result. It can also work with the WHERE, GROUP BY, ORDER BY, and HAVING clauses to
get the filtered result.

SQL Server allows us to use the count function in three forms that are listed below:

COUNT(*): It is used with the SELECT statement to get the total number of rows present in a result set. The result set can contain non-null, null,
and duplicates rows.

COUNT(ALL expression): This function is used to get the total number of rows present in the table without containing null rows.

COUNT(DISTINCT expression): This function is used to calculate only the unique number of rows present in the table without containing null values.

How COUNT() is different from COUNT_BIG() function?

The COUNT and COUNT_BIG function in SQL Server essentially do the same thing, i.e., count the number of items present in the table. 
But sometimes we make a choice between them for the application. In that case, we might prefer which is best for the application 
based on the data types.

The COUNT() function returns the result as an INT, whereas COUNT_BIG() function returns the result as BIGINT data types. Thus, if we 
have a table with millions of records and we need to get the count of these records, the COUNT() function will give an error, but 
the COUNT_BIG() function will display such a result.

Another major difference between them is while creating an index on the view. COUNT() does not allow the creation of the clustered 
index on the view. However, we can create clustered index on view when we use the COUNT_BIG() function.
*/

------------------------------------------------------SQL SERVER Aggregate Functions Practical-----------------------------------------------------

-------------------------------------------------------MIN() Function
SELECT * FROM Person
SELECT MIN(TotalPatient) AS 'MIN PATIENT' FROM Patient

--WHERE Clause with MIN() Function
SELECT Id, PatientName, TotalPatient FROM Patient WHERE TotalPatient = ( SELECT MIN(TotalPatient) AS 'MIN PATIENT' FROM Patient);  
/*Here, SQL Server first evaluates the subquery that uses the MIN() function and then the outer query display the Id, PatientName, TotalPatient
whose TotalPatient is equal to the result of the subquery.*/

--GROUP BY with MIN() Function
SELECT  Gender, Min(Age) FROM Person GROUP BY Gender

--HAVING CLAUSE with MIN() Function
SELECT  Gender, Min(Age) FROM Person GROUP BY Gender HAVING MIN(Age)<25

--DISTINCT CLAUSE with MIN() Function
SELECT MIN(DISTINCT(TotalPatient)) From Patient

-------------------------------------------------------MAX() Function
SELECT MAX(TotalPatient) AS 'MIN PATIENT' FROM Patient

--WHERE Clause with MAX() Function
SELECT Id, PatientName, TotalPatient FROM Patient WHERE TotalPatient = ( SELECT MAX(TotalPatient) AS 'MIN PATIENT' FROM Patient);  
/*Here, SQL Server first evaluates the subquery that uses the MAX() function and then the outer query display the Id, PatientName, TotalPatient
whose TotalPatient is equal to the result of the subquery.*/

--GROUP BY with MAX() Function
SELECT  Gender, MAX(Age) FROM Person GROUP BY Gender

--HAVING CLAUSE with MAX() Function
SELECT  Gender, MAX(Age) FROM Person GROUP BY Gender HAVING MAX(Age)<28

--DISTINCT CLAUSE with MAX() Function
SELECT MAX(DISTINCT(TotalPatient)) From Patient

-------------------------------------------------------SUM() Function
SELECT SUM(Age) AS 'TotalAge' from Person

----DISTINCT CLAUSE with SUM() Function
SELECT SUM(DISTINCT(TotalPatient)) From Patient

--WHERE Clause with SUM() Function
SELECT SUM(Age) FROM Person where IsActive = 1

--GROUP BY with SUM() Function
SELECT  Gender, SUM(Age) FROM Person /*Here we will get an error because we are trying to combine aggregate and non-aggregated columns in a 
SELECT statement so we use group by for combining aggregate and non-aggregated columns in a SELECT statement*/

SELECT  Gender, SUM(Age) FROM Person GROUP BY Gender

--ORDER BY with SUM() Function
SELECT  Gender, SUM(Age) FROM Person GROUP BY Gender ORDER BY SUM(Age)

--HAVING with SUM() Function
SELECT  Gender, SUM(Age) FROM Person GROUP BY Gender HAVING SUM(Age)<34 ORDER BY SUM(Age)

-------------------------------------------------------AVG() Function
SELECT AVG(Age) AS 'TotalAge' from Person

----DISTINCT CLAUSE with AVG() Function
SELECT AVG(DISTINCT(TotalPatient)) From Patient

--WHERE Clause with AVG() Function
SELECT AVG(Age) FROM Person where IsActive = 1

--GROUP BY with AVG() Function
SELECT  Gender, AVG(Age) FROM Person GROUP BY Gender

--ORDER BY with AVG() Function
SELECT  Gender, AVG(Age) FROM Person GROUP BY Gender ORDER BY AVG(Age)

--HAVING with AVG() Function
SELECT  Gender, AVG(Age) FROM Person GROUP BY Gender HAVING AVG(Age)>4 ORDER BY AVG(Age)

-------------------------------------------------------COUNT() Function
SELECT COUNT(*) AS 'TotalPerson' from Person

----DISTINCT CLAUSE with COUNT() Function
SELECT COUNT(DISTINCT(TotalPatient)) From Patient

--WHERE Clause with COUNT() Function
SELECT COUNT(Age) FROM Person where IsActive = 1

--GROUP BY with COUNT() Function
SELECT  Gender, COUNT(Age) FROM Person GROUP BY Gender

--ORDER BY with COUNT() Function
SELECT  Gender, COUNT(Age) FROM Person GROUP BY Gender ORDER BY COUNT(Age)

--HAVING with COUNT() Function
SELECT  Gender, COUNT(Age) FROM Person GROUP BY Gender HAVING COUNT(Age)>2 ORDER BY COUNT(Age)





