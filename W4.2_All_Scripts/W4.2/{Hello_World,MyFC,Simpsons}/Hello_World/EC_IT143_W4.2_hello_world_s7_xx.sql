/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s7_ag.sql
  Step          : Step 7 — Turn the ad hoc script into a stored procedure
  Author        : [Adolphus Gibson]
  Date Created  : [May 23,2026]
  Database      : EC_IT143_DA
  Description   : Step 7 wraps the TRUNCATE + INSERT load logic from Step 6
                  inside a stored procedure. A stored procedure is a named,
                  saved, executable block of T-SQL stored inside the database.
                  It can be called with a single EXEC statement (Step 8).

  Stored procedure naming convention:
    usp_  prefix = user stored procedure (distinguishes from system procs)
    load_       = describes the action (loading data)
    hw_current_datetime = the target table being loaded
==============================================================================
*/

USE EC_IT143_DA;
GO

-- Drop the stored procedure if it already exists
IF OBJECT_ID('dbo.usp_load_hw_current_datetime', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_load_hw_current_datetime;
GO

/*
------------------------------------------------------------------------------
  CREATE STORED PROCEDURE
  Encapsulates the Step 6 TRUNCATE + INSERT load logic
  Source view  : dbo.vw_hw_current_datetime
  Target table : dbo.tbl_hw_current_datetime
------------------------------------------------------------------------------
*/

CREATE PROCEDURE dbo.usp_load_hw_current_datetime
AS
BEGIN
    SET NOCOUNT ON;   -- Suppresses "N rows affected" messages for clean output

    /*
      TRUNCATE: Remove all existing rows from the target table.
      Ensures clean, non-duplicate data on every execution.
    */
    TRUNCATE TABLE dbo.tbl_hw_current_datetime;

    /*
      INSERT: Load fresh data from the view into the table.
      Column list is explicit — identity column is excluded.
    */
    INSERT INTO dbo.tbl_hw_current_datetime (CurrentServerDateTime)
    SELECT CurrentServerDateTime
    FROM   dbo.vw_hw_current_datetime;

    -- Confirmation message returned to the caller
    PRINT 'usp_load_hw_current_datetime: Load completed successfully.';

END;
GO

/*
  Why store this as a procedure instead of running the script manually?
  ---------------------------------------------------------------------
  1. REUSABILITY  — Call it with one line: EXEC usp_load_hw_current_datetime
  2. SECURITY     — Grant EXEC permission without exposing the underlying SQL
  3. ETL READY    — Any ETL scheduler (SQL Agent, Azure Data Factory) can call it
  4. VERSIONED    — Lives inside the database, backed up with it
  5. DOCUMENTED   — Header and inline comments travel with the procedure forever
*/
