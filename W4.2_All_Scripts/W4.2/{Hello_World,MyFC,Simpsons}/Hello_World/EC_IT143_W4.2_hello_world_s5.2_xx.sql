/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s5.2_ag.sql
  Step          : Step 5.2 — Refine the table architecture
  Author        : [Adolphus Gibson]
  Date Created  : [May 23,2026]
  Database      : EC_IT143_DA
  Description   : Step 5.2 drops and re-creates the table with a refined
                  architecture: explicit data types, a primary key, and
                  NOT NULL constraints. This replaces the raw SELECT INTO
                  table from Step 5.1 with a production-quality definition.
==============================================================================
*/

USE EC_IT143_DA;
GO

-- Drop and re-create with refined architecture
IF OBJECT_ID('dbo.tbl_hw_current_datetime', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_hw_current_datetime;
GO

/*
------------------------------------------------------------------------------
  REFINED TABLE DEFINITION
  Explicit data types, primary key, and NOT NULL constraint
------------------------------------------------------------------------------
*/

CREATE TABLE dbo.tbl_hw_current_datetime (
    -- Primary key: identity column auto-increments on each load
    DatetimeID            INT           NOT NULL IDENTITY(1,1),

    -- The core column: explicit DATETIME2 for higher precision
    -- DATETIME2 is preferred over DATETIME in modern SQL Server
    CurrentServerDateTime DATETIME2     NOT NULL,

    -- Audit column: records when this row was inserted into the table
    LoadedAt              DATETIME2     NOT NULL DEFAULT SYSDATETIME(),

    -- Primary key constraint
    CONSTRAINT PK_tbl_hw_current_datetime PRIMARY KEY (DatetimeID)
);
GO

-- Verify the empty refined table structure
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tbl_hw_current_datetime'
ORDER BY ORDINAL_POSITION;
GO

/*
  Refinements made vs Step 5.1:
  1. Added DatetimeID INT IDENTITY as primary key (Step 5.1 had none)
  2. Changed DATETIME to DATETIME2 (higher precision, Microsoft recommended)
  3. Added NOT NULL to both data columns (data integrity)
  4. Added LoadedAt audit column with DEFAULT SYSDATETIME()
  5. Named the primary key constraint explicitly (PK_tbl_hw_current_datetime)

  The table is now empty — Step 6 will load it from the view.
*/
