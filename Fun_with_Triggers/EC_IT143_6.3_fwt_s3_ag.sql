/*
========================================================
  Script    : EC_IT143_6.3_fwt_s3_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Triggers - Step 3: Research and Test a Solution
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  RESOURCES USED:
    1. https://docs.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql
    2. https://docs.microsoft.com/en-us/sql/t-sql/functions/getdate-transact-sql
    3. https://stackoverflow.com/questions/1505655/sql-server-trigger-to-update-a-field-on-update
    4. https://www.sqlshack.com/learn-sql-sql-triggers/

  KEY TRIGGER CONCEPTS:
    - CREATE TRIGGER fires on INSERT, UPDATE, or DELETE
    - AFTER UPDATE = runs after the UPDATE succeeds
    - GETDATE()    = returns the current server date/time
    - UPDATE(col)  = returns TRUE if that column was part of the UPDATE
    - The INSERTED virtual table holds the new values after the UPDATE

  PLAN:
    CREATE TRIGGER trg_customers_setLastModifiedDate
    ON dbo.t_w3_schools_customers
    AFTER UPDATE
    AS
    BEGIN
        UPDATE dbo.t_w3_schools_customers
        SET    LastModifiedDate = GETDATE()
        WHERE  CustomerID IN (SELECT CustomerID FROM INSERTED)
    END
========================================================
*/

USE EC_IT143_DA;
GO

-- Test GETDATE() to confirm it returns the current timestamp
SELECT GETDATE() AS CurrentServerTime;
GO

-- Test: what does the INSERTED virtual table contain?
-- (We simulate this concept here - it only exists inside a trigger)
-- For now, just confirm the table accepts the column update
UPDATE dbo.t_w3_schools_customers
SET    LastModifiedDate = GETDATE()
WHERE  CustomerID = 1;
GO

SELECT CustomerID, CustomerName, LastModifiedDate
FROM   dbo.t_w3_schools_customers
WHERE  CustomerID = 1;
GO

-- Reset the test row
UPDATE dbo.t_w3_schools_customers
SET    LastModifiedDate = NULL
WHERE  CustomerID = 1;
GO
