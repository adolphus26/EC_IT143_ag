/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s5.2_ag.sql
  Step          : Step 5.2 — Refine the table architecture
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May, 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 5.2 drops and re-creates the table with explicit
                  data types, a primary key, and NOT NULL constraints.
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.tbl_myfc_players_by_position', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_myfc_players_by_position;
GO

/*
------------------------------------------------------------------------------
  REFINED TABLE DEFINITION
  Explicit data types, primary key identity column, NOT NULL constraints
------------------------------------------------------------------------------
*/

CREATE TABLE dbo.tbl_myfc_players_by_position (
    -- Surrogate primary key — auto-increments on each row inserted
    PositionID   INT           NOT NULL IDENTITY(1,1),

    -- Position name — VARCHAR(50) matches the source column width
    -- NOT NULL: every row must have a position (NULLs filtered in view)
    Position     VARCHAR(50)   NOT NULL,

    -- Count of players in this position — always a positive integer
    PlayerCount  INT           NOT NULL,

    -- Audit: when this row was loaded into the table
    LoadedAt     DATETIME2     NOT NULL DEFAULT SYSDATETIME(),

    -- Primary key constraint
    CONSTRAINT PK_tbl_myfc_players_by_position PRIMARY KEY (PositionID)
);
GO

-- Verify structure
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tbl_myfc_players_by_position'
ORDER BY ORDINAL_POSITION;
GO

/*
  Table is now empty and refined.
  Step 6 loads it from the view using TRUNCATE + INSERT.
*/
