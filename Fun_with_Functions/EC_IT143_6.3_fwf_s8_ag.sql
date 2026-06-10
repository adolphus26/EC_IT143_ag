/*
========================================================
  Script    : EC_IT143_6.3_fwf_s8_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 8: Ask the Next Question (Last Name)
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  NEXT QUESTION:
    How do I extract the LAST NAME from ContactName?

  LOGIC:
    Last name = everything AFTER the first space.
    Use CHARINDEX to find the space position.
    Use SUBSTRING to grab from (space + 1) to end of string.
    Formula: SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))

  This restarts the same 8-step process for last name.
  The function created here is: dbo.fn_getLastName
========================================================
*/

USE EC_IT143_DA;
GO

-- -------------------------------------------------------
-- STEP 1-3 Preview: understand and test the logic
-- -------------------------------------------------------
SELECT TOP 10
    ContactName,
    CHARINDEX(' ', ContactName)                             AS SpacePos,
    CHARINDEX(' ', ContactName) + 1                        AS StartOfLastName,
    SUBSTRING(
        ContactName,
        CHARINDEX(' ', ContactName) + 1,
        LEN(ContactName)
    )                                                      AS LastName_AdHoc
FROM
    dbo.t_w3_schools_customers;
GO

-- -------------------------------------------------------
-- STEP 5: Create fn_getLastName function
-- -------------------------------------------------------
IF OBJECT_ID('dbo.fn_getLastName', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_getLastName;
GO

CREATE FUNCTION dbo.fn_getLastName
(
    @FullName NVARCHAR(100)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @LastName   NVARCHAR(50);
    DECLARE @SpacePos   INT;

    SET @SpacePos = CHARINDEX(' ', @FullName);

    -- If no space found, return the whole name
    IF @SpacePos = 0
        SET @LastName = @FullName;
    ELSE
        SET @LastName = SUBSTRING(@FullName, @SpacePos + 1, LEN(@FullName));

    RETURN @LastName;
END;
GO

-- -------------------------------------------------------
-- STEP 6: Side-by-side comparison
-- -------------------------------------------------------
SELECT TOP 10
    ContactName,
    dbo.fn_getFirstName(ContactName) AS FirstName,
    dbo.fn_getLastName(ContactName)  AS LastName
FROM
    dbo.t_w3_schools_customers;
GO

-- -------------------------------------------------------
-- STEP 7: Zero-results test for fn_getLastName
-- -------------------------------------------------------
WITH cte_last AS
(
    SELECT
        ContactName,
        SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName)) AS AdHocLast,
        dbo.fn_getLastName(ContactName) AS UDFLast
    FROM dbo.t_w3_schools_customers
)
SELECT *
FROM   cte_last
WHERE  AdHocLast <> UDFLast;
-- Expected: 0 rows
GO
