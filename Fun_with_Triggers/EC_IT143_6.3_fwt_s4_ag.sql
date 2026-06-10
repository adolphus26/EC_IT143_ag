/*
========================================================
  Script    : EC_IT143_6.3_fwt_s4_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Triggers - Step 4: Create the AFTER UPDATE Triggers
  Date      : June 10, 2026
  DB        : EC_IT143_DA
  Table     : dbo.t_w3_schools_customers
========================================================
  THIS SCRIPT CREATES TWO TRIGGERS:

  TRIGGER 1: trg_customers_setLastModifiedDate
    - Fires AFTER UPDATE on t_w3_schools_customers
    - Sets LastModifiedDate = GETDATE() (current timestamp)
    - Answers: "When was this row last modified?"

  TRIGGER 2: trg_customers_setLastModifiedBy
    - Fires AFTER UPDATE on t_w3_schools_customers
    - Sets LastModifiedBy = SUSER_NAME() (current SQL login)
    - Answers: "Who last modified this row?"

  NOTE: We need the LastModifiedBy column first (added below).
========================================================
*/

USE EC_IT143_DA;
GO

-- -------------------------------------------------------
-- Add LastModifiedBy column if it does not exist
-- -------------------------------------------------------
IF NOT EXISTS (
    SELECT 1
    FROM   INFORMATION_SCHEMA.COLUMNS
    WHERE  TABLE_NAME  = 't_w3_schools_customers'
      AND  COLUMN_NAME = 'LastModifiedBy'
)
BEGIN
    ALTER TABLE dbo.t_w3_schools_customers
    ADD LastModifiedBy NVARCHAR(128) NULL;
    PRINT 'Column LastModifiedBy added.';
END
GO

-- -------------------------------------------------------
-- TRIGGER 1: Track the date/time of last update
-- -------------------------------------------------------
IF OBJECT_ID('dbo.trg_customers_setLastModifiedDate', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_customers_setLastModifiedDate;
GO

CREATE TRIGGER dbo.trg_customers_setLastModifiedDate
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    -- Prevent recursive trigger calls
    SET NOCOUNT ON;

    -- Update LastModifiedDate for every row that was just changed.
    -- INSERTED is the virtual table holding the updated row values.
    UPDATE dbo.t_w3_schools_customers
    SET    LastModifiedDate = GETDATE()
    WHERE  CustomerID IN (SELECT CustomerID FROM INSERTED);
END;
GO

-- -------------------------------------------------------
-- TRIGGER 2: Track WHO made the last update
-- -------------------------------------------------------
IF OBJECT_ID('dbo.trg_customers_setLastModifiedBy', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_customers_setLastModifiedBy;
GO

CREATE TRIGGER dbo.trg_customers_setLastModifiedBy
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- SUSER_NAME() returns the current SQL Server login name.
    -- This tells us WHO made the change.
    UPDATE dbo.t_w3_schools_customers
    SET    LastModifiedBy = SUSER_NAME()
    WHERE  CustomerID IN (SELECT CustomerID FROM INSERTED);
END;
GO

PRINT 'Both triggers created successfully.';
GO
