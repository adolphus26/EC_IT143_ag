/*
========================================================
  Script    : EC_IT143_6.3_fwt_s6_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Triggers - Step 6: Ask the Next Question
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  NEXT QUESTION:
    How do I confirm BOTH triggers fire together correctly
    across MULTIPLE rows updated at the same time?

  WHY THIS MATTERS:
    Triggers must handle bulk updates (more than one row at once).
    The INSERTED virtual table can contain multiple rows.
    The WHERE CustomerID IN (SELECT CustomerID FROM INSERTED)
    pattern handles this correctly.

  THIS SCRIPT:
    Tests a multi-row UPDATE to verify both triggers
    fire and update ALL affected rows.
========================================================
*/

USE EC_IT143_DA;
GO

-- -------------------------------------------------------
-- Reset test rows first
-- -------------------------------------------------------
UPDATE dbo.t_w3_schools_customers
SET    LastModifiedDate = NULL,
       LastModifiedBy   = NULL
WHERE  CustomerID IN (2, 3, 4);
GO

-- Confirm they are NULL before test
SELECT CustomerID, CustomerName, LastModifiedDate, LastModifiedBy
FROM   dbo.t_w3_schools_customers
WHERE  CustomerID IN (2, 3, 4);
GO

-- -------------------------------------------------------
-- Multi-row UPDATE: should fire both triggers for all 3 rows
-- -------------------------------------------------------
UPDATE dbo.t_w3_schools_customers
SET    City = City   -- Update with same value to trigger the fires
WHERE  CustomerID IN (2, 3, 4);
GO

-- -------------------------------------------------------
-- Verify all 3 rows were stamped by both triggers
-- -------------------------------------------------------
SELECT
    CustomerID,
    CustomerName,
    LastModifiedDate,
    LastModifiedBy
FROM
    dbo.t_w3_schools_customers
WHERE
    CustomerID IN (2, 3, 4);
GO
-- All 3 rows should now have LastModifiedDate and LastModifiedBy populated.

-- -------------------------------------------------------
-- Final summary: View all rows with tracking info
-- -------------------------------------------------------
SELECT
    CustomerID,
    CustomerName,
    LastModifiedDate,
    LastModifiedBy
FROM
    dbo.t_w3_schools_customers
WHERE
    LastModifiedDate IS NOT NULL
ORDER BY
    LastModifiedDate DESC;
GO
