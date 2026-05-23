/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s7_ag.sql
  Step          : Step 7 — Turn the ad hoc script into a stored procedure
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 7 encapsulates the Step 6 TRUNCATE + INSERT load
                  logic inside a stored procedure.
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.usp_load_myfc_players_by_position', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_load_myfc_players_by_position;
GO

/*
------------------------------------------------------------------------------
  CREATE STORED PROCEDURE
  Source view  : dbo.vw_myfc_players_by_position
  Target table : dbo.tbl_myfc_players_by_position
  Answers      : How many players play each position?
------------------------------------------------------------------------------
*/

CREATE PROCEDURE dbo.usp_load_myfc_players_by_position
AS
BEGIN
    SET NOCOUNT ON;

    -- TRUNCATE: clear all existing rows before reload
    TRUNCATE TABLE dbo.tbl_myfc_players_by_position;

    -- INSERT: load fresh data from the view
    INSERT INTO dbo.tbl_myfc_players_by_position (
        Position,
        PlayerCount
    )
    SELECT
        Position,
        PlayerCount
    FROM dbo.vw_myfc_players_by_position;

    PRINT 'usp_load_myfc_players_by_position: Load completed successfully.';

END;
GO

/*
  This stored procedure encapsulates the full load pipeline for the
  MyFC players-by-position analysis. Call it from Step 8 with:
    EXEC dbo.usp_load_myfc_players_by_position;
*/
