/*
========================================================
  Script    : EC_IT143_6.3_fwf_s5_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 5: Create User-Defined Scalar Function
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  WHAT THIS FUNCTION DOES:
    Takes a full name like "Maria Anders"
    Returns only the first name: "Maria"
    Handles edge cases where no space exists.

  NAMING: fn_getFirstName
    fn_  = user-defined function
    get  = retrieval action
    FirstName = what it returns
========================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.fn_getFirstName', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_getFirstName;
GO

CREATE FUNCTION dbo.fn_getFirstName
(
    @FullName NVARCHAR(100)   -- Input: full contact name
)
RETURNS NVARCHAR(50)          -- Output: first name only
AS
BEGIN
    DECLARE @FirstName NVARCHAR(50);

    -- Extract everything LEFT of the first space.
    -- NULLIF handles a name with no space (returns NULL instead of 0).
    -- ISNULL then falls back to the full string length + 1.
    SET @FirstName = LEFT(
        @FullName,
        ISNULL(NULLIF(CHARINDEX(' ', @FullName), 0), LEN(@FullName) + 1) - 1
    );

    RETURN @FirstName;
END;
GO

-- Quick smoke test
SELECT dbo.fn_getFirstName('Maria Anders') AS TestResult;
-- Expected: Maria
GO
