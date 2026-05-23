/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s6_ag.sql
  Step          : Step 6 — Load the table from the view (ad hoc script)
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May 23,2026]
  Database      : EC_IT143_DA
  Description   : Step 6 loads data from the view into the refined table
                  using the TRUNCATE + INSERT pattern.
==============================================================================
*/

USE EC_IT143_DA;
GO

/*
------------------------------------------------------------------------------
  TRUNCATE: Clear all existing rows (clean slate for reload)
------------------------------------------------------------------------------
*/

TRUNCATE TABLE dbo.tbl_myfc_players_by_position;
GO

/*
------------------------------------------------------------------------------
  INSERT: Load fresh data from the view
  Explicit column list excludes the identity column PositionID and
  the default-value column LoadedAt (both auto-populated by SQL Server)
------------------------------------------------------------------------------
*/

INSERT INTO dbo.tbl_myfc_players_by_position (
    Position,
    PlayerCount
)
SELECT
    Position,
    PlayerCount
FROM dbo.vw_myfc_players_by_position;
GO

-- Verify the load
SELECT *
FROM   dbo.tbl_myfc_players_by_position
ORDER BY PlayerCount DESC;
GO

/*
  Expected result:
    PositionID  Position     PlayerCount  LoadedAt
    ----------  ----------   -----------  ----------------------------
    1           Midfielder   12           2025-05-20 14:32:07.1234567
    2           Defender     10           2025-05-20 14:32:07.1234567
    3           Forward      8            2025-05-20 14:32:07.1234567
    4           Goalkeeper   4            2025-05-20 14:32:07.1234567
*/
