/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s2_ag.sql
  Step          : Step 2 — Begin creating an answer
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 2 maps the journey from question to answer.
                  We write out where we are and what the next step looks like.
==============================================================================
*/

/*
------------------------------------------------------------------------------
  THE QUESTION (carried forward from Step 1)
  How many players play each position in the MyFC data set?
------------------------------------------------------------------------------

  WHERE WE ARE NOW
  ----------------
  We have the Player table in the MyFC database.
  Relevant columns: player_id, position
  We know we need to GROUP BY position and COUNT player_id.

  MAPPING THE ANSWER — SUB-STEPS
  --------------------------------
  Sub-step 1:
    Query the Player table.
    SELECT the position column.
    Use COUNT(player_id) to count players per group.
    Use GROUP BY position to create one row per position.
    Use ORDER BY player count DESC to rank positions from most to fewest.

  Sub-step 2:
    Label the output columns clearly:
      position        → Position
      COUNT(player_id) → PlayerCount

  Sub-step 3 (refinement consideration):
    Consider whether we want COUNT(*) or COUNT(player_id).
    COUNT(player_id) is more precise — it counts only non-NULL player_ids.
    If position could be NULL, we should decide: include or exclude nulls?
    Decision: use WHERE position IS NOT NULL to keep results clean.

  NOT YET CONCERNED WITH:
  ------------------------
  - Cross-database joins (the Player table is in MyFC, not EC_IT143_DA)
  - We will query MyFC.dbo.Player using three-part naming in Step 3
------------------------------------------------------------------------------
*/
