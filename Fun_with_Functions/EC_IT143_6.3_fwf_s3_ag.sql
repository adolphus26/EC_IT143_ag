/*
========================================================
  Script    : EC_IT143_6.3_fwf_s3_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 3: Create an Ad Hoc SQL Query
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  PURPOSE:
    Write a quick, informal ad hoc query to prove
    the extraction logic works before wrapping it in a function.

  FUNCTIONS USED:
    LEFT(string, n)      - returns n characters from the left
    CHARINDEX(char, str) - returns position of first matching char
========================================================
*/

USE EC_IT143_DA;
GO

-- Ad hoc: extract first name from ContactName
SELECT TOP 20
    ContactName,
    LEFT(ContactName, CHARINDEX(' ', ContactName) - 1) AS FirstName
FROM
    dbo.t_w3_schools_customers
ORDER BY
    ContactName;
GO
