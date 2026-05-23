/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s3_ag.sql
  Step          : Step 3 — Create an ad hoc SQL query
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 3 translates Sub-step 1 from our answer map into
                  a working, executable SELECT statement against the MyFC
                  Player table.
==============================================================================
*/

USE EC_IT143_DA;
GO

/*
------------------------------------------------------------------------------
  AD HOC QUERY
  Count the number of players in each playing position
  Source: MyFC.dbo.Player
  Three-part naming (DatabaseName.SchemaName.TableName) is used because
  the source data lives in the MyFC database, not EC_IT143_DA.
------------------------------------------------------------------------------
*/


-- Verify the join works
SELECT TOP 10
    p.pl_id,
    p.pl_name,
    pos.p_name
FROM MyFC.dbo.tblPlayerDim AS p
    INNER JOIN MyFC.dbo.tblPositionDim AS pos
        ON p.p_id = pos.p_id;
GO

-- MAIN QUERY: How many players play each position?
SELECT
    pos.p_name          AS Position,
    COUNT(p.pl_id)      AS PlayerCount
FROM MyFC.dbo.tblPlayerDim AS p
    INNER JOIN MyFC.dbo.tblPositionDim AS pos
        ON p.p_id = pos.p_id
WHERE pos.p_name IS NOT NULL
GROUP BY pos.p_name
ORDER BY PlayerCount DESC;
GO