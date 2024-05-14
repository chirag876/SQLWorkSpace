----------------------------------------------------SQL SERVER Clauses Theory---------------------------------------------------------------------
/*1 Distinct Clause: It is used to remove duplicates FROM the table. The DISTICT clause is only used with SELECT  statement.

2 GROUP BY Clause: It is used to collect data across multiple records and group the results by one or more columns. It is used with SELECT  
statement.

3 WHERE  Clause: It is used to filter records FROM the table. It is an optional clause that is used to limit the number of rows returned by the
query. We can also say that this clause specifies a condition to return only those records that fulfill the defined conditions. The WHERE  clause
can also work with the UPDATE and DELETE query.

When we perform an operation on the table using the SELECT  statement, it will return all records FROM that table. If our table has many records,
the SELECT  statement can return unnecessary data because the application process only the set of rows at a time. In such a case, we need some 
conditions that return only those records that we want to see in the output table. Thus, we use the WHERE  clause to restrict the query FROM 
fetching unnecessary records FROM a table and return only those rows that meet the condition mentioned in the WHERE  clause.

Operators supported by WHERE  clause are:
=,<=,>=,<,>,<>(NOT EQUAL),IN, BETWEEN,LIKE

4 ORDER BY Clause: It is used to arrange the table's data in ascending or descending order based on the given column or list of columns. It is 
usually used with the SELECT  statement AS  it returns the records without sorting in specific orders. It means SQL Server produces the output in an 
unspecified order. However, using the ORDER BY clause guarantees that the records in the output are sorted in ascending or descending order. 
This clause allows sorting of the table by defining single or multiple columns.

If we do not define ASC or DESC keyword, SQL Server will use ASC AS  the default sorting order. SQL Server considers the NULL value to be the 
lowest. In addition, the ORDER BY clause is the very last clause to be considered when processing a SELECT  statement with an ORDER BY clause.

5 Having Clause: it is used to specify the search condition for a group or an aggregate. It can only work with the SELECT  statement and is usually 
used with the GROUP BY clause. It enables us to filter which group results appear in the results. We used this clause instead of the WHERE  clause
because it places a condition on groups created by the GROUP BY clause, while the WHERE  clause places a condition on the selected columns.
i.e. The HAVING clause was added to SQL because the WHERE  keyword cannot be used with aggregate functions.

Each HAVING condition in SQL can compare one group column or aggregate expression to another group aggregate expression or a constant. We may use
HAVING to place conditions on both column and aggregate values in the group list.

The HAVING clause validates groups in the same way AS  the WHERE  clause validates individual rows. The main benefit of using a HAVING clause is
that aggregates can be included in the search condition, whereas aggregates cannot be used in a WHERE  clause's search condition.

we use the HAVING clause with single or multiple conditions to the groups evaluated by the GROUP BY clause. The final result included only those 
groups that make the evaluation of the condition TRUE. If the condition is found FALSE or UNKNOWN, the groups are filtered out.
*/

----------------------------------------------------SQL SERVER Clauses Practical------------------------------------------------------------------

-----------------------------------------------------Distinct Clause

SELECT  Distinct Age, IsActive FROM Person WHERE  age>24

-----------------------------------------------------GROUP BY using SUM Function
SELECT  FirstName, sum(age) AS  'Total Age' FROM Person GROUP BY FirstName


-----------------------------------------------------GROUP BY using COUNT Function
SELECT  LastName, count(Age) FROM Person GROUP BY LastName

-----------------------------------------------------GROUP BY using MIN Function
SELECT  Gender, Min(Age) FROM Person GROUP BY Gender

-----------------------------------------------------GROUP BY using MAX Function
SELECT  Gender, Max(Age) FROM Person GROUP BY Gender

-----------------------------------------------------Order By

SELECT  FirstName,Qualification FROM Person ORDER BY Qualification --Default order is ASC
SELECT  FirstName,Qualification FROM Person ORDER BY Qualification DESC
SELECT  FirstName,Qualification FROM Person ORDER BY FirstName ASC, Qualification DESC /*This will first order the query by FirstName and then by
LastName*/
SELECT  FirstName,Qualification FROM Person ORDER BY FirstName DESC, Qualification DESC
SELECT  FirstName,Qualification FROM Person ORDER BY Gender
SELECT  FirstName,Qualification FROM Person ORDER BY LEN(FirstName) /*This will order the query according the length of the values of the specified 
column in asc or descending order unless specified. This example uses the LEN() function that returns the number of characters of a string.*/
SELECT  FirstName,Qualification FROM Person ORDER BY LEN(FirstName) DESC

-----------------------------------------------------Having Clause

SELECT  FirstName, sum(age) AS  'Total Age' FROM Person GROUP BY FirstName HAVING SUM(Age)>22
SELECT  LastName, count(Age) FROM Person GROUP BY LastName HAVING COUNT(Age)>0
SELECT  Gender, Min(Age) FROM Person GROUP BY Gender HAVING MIN(Age)<25
SELECT  Gender, Max(Age) FROM Person GROUP BY Gender HAVING MAX(Age)>23
SELECT  Gender, AVG(Age) FROM Person GROUP BY Gender HAVING AVG(Age)<30
