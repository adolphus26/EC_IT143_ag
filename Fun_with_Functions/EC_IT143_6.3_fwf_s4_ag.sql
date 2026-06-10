/*
========================================================
  Script    : EC_IT143_6.3_fwf_s4_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 4: Research and Test a Solution
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  RESOURCES USED:
    1. https://docs.microsoft.com/en-us/sql/t-sql/functions/left-transact-sql
    2. https://docs.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql
    3. https://stackoverflow.com/questions/4512391/extract-first-word-from-a-string
    4. https://www.w3schools.com/sql/func_sqlserver_charindex.asp

  EDGE CASE:
    What if ContactName has NO space? (single-word name)
    CHARINDEX returns 0 -> LEFT(str, -1) would error.
    FIX: Use NULLIF(CHARINDEX(' ', col), 0) to handle it safely.
========================================================
*/

USE EC_IT143_DA;
GO

-- Test 1: Basic extraction
SELECT TOP 5
    ContactName,
    LEFT(ContactName, CHARINDEX(' ', ContactName) - 1) AS FirstName_Basic
FROM dbo.t_w3_schools_customers;
GO

-- Test 2: Edge-case safe version using NULLIF + ISNULL
SELECT TOP 5
    ContactName,
    LEFT(
        ContactName,
        ISNULL(NULLIF(CHARINDEX(' ', ContactName), 0), LEN(ContactName) + 1) - 1
    ) AS FirstName_Safe
FROM dbo.t_w3_schools_customers;
GO

-- Test 3: Direct spot check on a single string
SELECT LEFT('Maria Anders', CHARINDEX(' ', 'Maria Anders') - 1) AS TestResult;
GO
