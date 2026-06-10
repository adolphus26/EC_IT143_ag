/*
========================================================
  Script    : EC_IT143_6.3_fwt_s5_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Triggers - Step 5: Test Results
  Date      : June 10, 2026
  DB        : EC_IT143_DA
  Table     : dbo.t_w3_schools_customers
========================================================
  PURPOSE:
    Verify both triggers (LastModifiedDate + LastModifiedBy)
    fire correctly when a row is updated.

  TEST PLAN:
    1. Check a row BEFORE update (both columns should be NULL)
    2. Perform an UPDATE on that row
    3. Check the row AFTER update (both columns should be populated)
    4. Confirm LastModifiedDate is very recent (within last minute)
    5. Confirm LastModifiedBy matches the current SQL login
========================================================
*/

USE EC_IT143_DA;
GO

-- -------------------------------------------------------
-- STEP 1: Check BEFORE state - should be NULL
-- -------------------------------------------------------
SELECT
    CustomerID,
    CustomerName,
    ContactName,
    LastModifiedDate,
    LastModifiedBy
FROM
    dbo.t_w3_schools_customers
WHERE
    CustomerID = 1;
GO

-- -------------------------------------------------------
-- STEP 2: Perform an UPDATE to fire both triggers
-- -------------------------------------------------------
UPDATE dbo.t_w3_schools_customers
SET    ContactName = 'Maria Anders'  -- same value, just triggers the UPDATE
WHERE  CustomerID = 1;
GO

-- -------------------------------------------------------
-- STEP 3: Check AFTER state - both columns should be filled
-- -------------------------------------------------------
SELECT
    CustomerID,
    CustomerName,
    ContactName,
    LastModifiedDate,
    LastModifiedBy
FROM
    dbo.t_w3_schools_customers
WHERE
    CustomerID = 1;
GO

-- -------------------------------------------------------
-- STEP 4: Confirm timestamp is recent (within last 5 minutes)
-- -------------------------------------------------------
SELECT
    CustomerID,
    LastModifiedDate,
    GETDATE()                                  AS RightNow,
    DATEDIFF(SECOND, LastModifiedDate, GETDATE()) AS SecondsAgo
FROM
    dbo.t_w3_schools_customers
WHERE
    CustomerID = 1;
-- SecondsAgo should be 0 or very small
GO

-- -------------------------------------------------------
-- STEP 5: Confirm who made the change
-- -------------------------------------------------------
SELECT
    CustomerID,
    LastModifiedBy,
    SUSER_NAME() AS CurrentUser
FROM
    dbo.t_w3_schools_customers
WHERE
    CustomerID = 1;
-- LastModifiedBy should match CurrentUser
GO
