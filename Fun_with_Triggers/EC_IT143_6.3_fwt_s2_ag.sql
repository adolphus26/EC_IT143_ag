/*
========================================================
  Script    : EC_IT143_6.3_fwt_s2_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Triggers - Step 2: Begin Creating an Answer
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  WHERE I AM NOW:
    The table has no column to track last modification date.
    A DEFAULT constraint only fires on INSERT - not on UPDATE.
    So I cannot use a default alone.

  NEXT LOGICAL STEP:
    1. Add a new column: LastModifiedDate (DATETIME, nullable)
    2. Create an AFTER UPDATE TRIGGER that sets
       LastModifiedDate = GETDATE() whenever a row is updated.

  WHY A TRIGGER?
    A trigger fires automatically on INSERT, UPDATE, or DELETE.
    An AFTER UPDATE trigger runs AFTER the UPDATE completes.
    This is the correct tool to track when data last changed.
========================================================
*/

USE EC_IT143_DA;
GO

-- Add the LastModifiedDate column if it does not exist yet
IF NOT EXISTS (
    SELECT 1
    FROM   INFORMATION_SCHEMA.COLUMNS
    WHERE  TABLE_NAME  = 't_w3_schools_customers'
      AND  COLUMN_NAME = 'LastModifiedDate'
)
BEGIN
    ALTER TABLE dbo.t_w3_schools_customers
    ADD LastModifiedDate DATETIME NULL;
    PRINT 'Column LastModifiedDate added.';
END
ELSE
    PRINT 'Column LastModifiedDate already exists.';
GO

-- Confirm the column is now present
SELECT TOP 3
    CustomerID,
    CustomerName,
    LastModifiedDate
FROM
    dbo.t_w3_schools_customers;
GO
