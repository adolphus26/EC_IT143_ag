/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s5.1_ag.sql
  Step          : Step 5.1 — Turn the view into a table (SELECT INTO)
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May 23,2026]
  Database      : EC_IT143_DA
  Description   : Step 5.1 materializes the view from Step 4 into a
                  physical table using SELECT INTO. SQL Server infers
                  column names and data types from the view output.
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.tbl_myfc_players_by_position', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_myfc_players_by_position;
GO

/*
------------------------------------------------------------------------------
  CREATE TABLE from VIEW using SELECT INTO
  Source : dbo.vw_myfc_players_by_position
  Target : dbo.tbl_myfc_players_by_position
------------------------------------------------------------------------------
*/

SELECT *
INTO   dbo.tbl_myfc_players_by_position
FROM   dbo.vw_myfc_players_by_position;
GO

-- Verify the raw table was created and data was loaded
SELECT *
FROM   dbo.tbl_myfc_players_by_position
ORDER BY PlayerCount DESC;
GO

/*
  This table now physically holds the view data.
  Step 5.2 will refine it with a primary key and explicit data types.
*/
