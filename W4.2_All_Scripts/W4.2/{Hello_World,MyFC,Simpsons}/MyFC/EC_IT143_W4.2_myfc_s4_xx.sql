/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s4_ag.sql
  Step          : Step 4 — Turn the ad hoc query into a view
  Community     : MyFC — Soccer Team Data Set
  Author        : [adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 4 wraps the working ad hoc query from Step 3 inside
                  a CREATE VIEW statement saved in EC_IT143_DA.
                  The view queries across databases using three-part naming.

  View naming convention:
    vw_     = view prefix
    myfc_   = community/project prefix
    players_by_position = describes what the view returns
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.vw_myfc_players_by_position', 'V') IS NOT NULL
    DROP VIEW dbo.vw_myfc_players_by_position;
GO

/*
------------------------------------------------------------------------------
  CREATE VIEW
  Source query : EC_IT143_W4.2_myfc_s3_xx.sql
  Source table : MyFC.dbo.Player
  Answers      : How many players play each position?
------------------------------------------------------------------------------
*/

CREATE VIEW dbo.vw_myfc_players_by_position
AS
    /*
      Returns one row per playing position with a count of players.
      Source data lives in the MyFC database.
      Three-part naming (MyFC.dbo.Player) enables cross-database querying.
      Positions with NULL values are excluded for data cleanliness.
    */
    SELECT
        pos.p_name          AS Position,
        COUNT(p.pl_id)      AS PlayerCount
    FROM MyFC.dbo.tblPlayerDim AS p
        INNER JOIN MyFC.dbo.tblPositionDim AS pos
            ON p.p_id = pos.p_id
    WHERE pos.p_name IS NOT NULL
    GROUP BY pos.p_name;
GO

-- Verify
SELECT *
FROM dbo.vw_myfc_players_by_position
ORDER BY PlayerCount DESC;
GO

/*
  NOTE: ORDER BY is intentionally excluded from the view definition.
  Views should not contain ORDER BY (SQL Server disallows it without TOP).
  Sorting is applied when the view is queried, as shown above.
*/
