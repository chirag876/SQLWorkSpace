-------------------------------------------------------SQL Server System Functions--------------------------------------------------------------------

SELECT ASCII(FirstName) AS Name FROM Person;

SELECT CHAR(65) AS CodeToCharacter;

SELECT CHARINDEX('t', 'Elephant') AS MatchPosition;

SELECT CONCAT('W3Schools', '.com');

SELECT 'I' + ' am' + ' in' + ' 8th' + ' semester'

SELECT CONCAT_WS('.', 'www', 'W3Schools', 'com'); --Adds two or more strings together with a separator.

SELECT DATALENGTH('   W3Schools.com   '); --Return the length of an expression (in bytes) (counts both leading and trailing spaces)

SELECT DIFFERENCE('Juice', 'Jucy');

SELECT FORMAT(123456789, '##-##-#####');

SELECT LEFT('SQL Tutorial', 3 /*Number of character to be extracted from left*/) AS ExtractString;
SELECT LEFT(PetName, 3) FROM PetShop

SELECT LEN('   W3Schools.com   ');

SELECT LOWER('SQL Tutorial is FUN!')
SELECT LOWER(PetName) FROM PetShop

SELECT LTRIM('   SQL Tutorial') AS LeftTrimmedString;

SELECT NCHAR(80) AS NumberCodeToUnicode;

SELECT PATINDEX('%schools%', 'W3Schools.com');

SELECT PATINDEX('%s%com%', 'W3Schools.com');

SELECT PATINDEX('%[ol]%', 'W3Schools.com');

SELECT QUOTENAME('abcdef');

SELECT REPLACE('ABC ABC ABC', 'a', 'c');

SELECT REPLICATE('SQL Tutorial', 5);

SELECT REPLICATE(PetType, 2)
FROM PetShop;

SELECT REVERSE('SQL Tutorial');

SELECT RIGHT('SQL Tutorial', 3) AS ExtractString;