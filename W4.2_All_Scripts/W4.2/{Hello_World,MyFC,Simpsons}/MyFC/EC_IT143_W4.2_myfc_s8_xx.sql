/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s8_ag.sql
  Step          : Step 8 — Call the stored procedure
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 8 executes the stored procedure from Step 7 with
                  a single EXEC statement, completing the full pipeline.
==============================================================================
*/

USE EC_IT143_DA;
GO

/*
------------------------------------------------------------------------------
  CALL THE STORED PROCEDURE
  Triggers: TRUNCATE → INSERT from view → confirmation message
------------------------------------------------------------------------------
*/

EXEC dbo.usp_load_myfc_players_by_position;
GO

-- Verify the final result
SELECT *
FROM   dbo.tbl_myfc_players_by_position
ORDER BY PlayerCount DESC;
GO

/*
  ============================================================================
  FULL PIPELINE SUMMARY — MyFC Answer-Focused Approach
  Question: How many players play each position?
  ============================================================================
  Step 1   EC_IT143_W4.2_myfc_s1_xx.sql    → Define the question
  Step 2   EC_IT143_W4.2_myfc_s2_xx.sql    → Map the answer sub-steps
  Step 3   EC_IT143_W4.2_myfc_s3_xx.sql    → Ad hoc SELECT + GROUP BY
  Step 4   EC_IT143_W4.2_myfc_s4_xx.sql    → CREATE VIEW vw_myfc_players_by_position
  Step 5.1 EC_IT143_W4.2_myfc_s5.1_xx.sql  → SELECT INTO tbl_myfc_players_by_position
  Step 5.2 EC_IT143_W4.2_myfc_s5.2_xx.sql  → Refined table (PK + data types)
  Step 6   EC_IT143_W4.2_myfc_s6_xx.sql    → TRUNCATE + INSERT (ad hoc load)
  Step 7   EC_IT143_W4.2_myfc_s7_xx.sql    → CREATE STORED PROCEDURE
  Step 8   EC_IT143_W4.2_myfc_s8_xx.sql    → EXEC stored procedure
  ============================================================================
*/
