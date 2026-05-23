/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s6_ag.sql
  Step          : Step 6 — Load the table from the view (ad hoc script)
  Author        : [Adolphus Gibson]
  Date Created  : [May 23,2026]
  Database      : EC_IT143_DA
  Description   : Step 6 loads data from the view into the refined table
                  using TRUNCATE + INSERT. TRUNCATE clears all existing rows
                  first (clean slate), then INSERT pulls fresh data from
                  the view. This is the standard ETL load pattern.

  Load pattern:
    TRUNCATE  → empties the table (fast, resets identity if desired)
    INSERT    → loads fresh data from the view
==============================================================================
*/

USE EC_IT143_DA;
GO

/*
------------------------------------------------------------------------------
  STEP 1 OF LOAD: TRUNCATE
  Remove all existing rows from the table.
  This ensures we do not accumulate duplicate rows on repeated runs.
  TRUNCATE is faster than DELETE for full-table clears.
------------------------------------------------------------------------------
*/

TRUNCATE TABLE dbo.tbl_hw_current_datetime;
GO

/*
------------------------------------------------------------------------------
  STEP 2 OF LOAD: INSERT from VIEW
  Pull all current rows from the view into the table.
  Note: We specify the column list explicitly (best practice).
  The identity column DatetimeID is NOT listed — SQL Server auto-fills it.
------------------------------------------------------------------------------
*/

INSERT INTO dbo.tbl_hw_current_datetime (CurrentServerDateTime)
SELECT CurrentServerDateTime
FROM   dbo.vw_hw_current_datetime;
GO

-- Verify: confirm the table now contains the loaded data
SELECT * FROM dbo.tbl_hw_current_datetime;
GO

/*
  Expected result:
    DatetimeID  CurrentServerDateTime          LoadedAt
    ----------  -----------------------------  -----------------------------
    1           2025-05-20 14:32:07.1234567   2025-05-20 14:32:07.1234567

  Why TRUNCATE + INSERT instead of just SELECT INTO?
  - SELECT INTO (Step 5.1) creates the table AND loads it in one shot.
  - TRUNCATE + INSERT is used for SUBSEQUENT loads after the table exists.
  - This pattern is the foundation of every ETL refresh cycle.
*/
