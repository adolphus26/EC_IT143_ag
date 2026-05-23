/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s8_ag.sql
  Step          : Step 8 — Call the stored procedure
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 8 is the final and simplest step. We call the stored
                  procedure created in Step 7 using a single EXEC statement.
                  This encapsulates all eight steps of the answer-focused
                  approach into one callable unit.
==============================================================================
*/

USE EC_IT143_DA;
GO

/*
------------------------------------------------------------------------------
  CALL THE STORED PROCEDURE
  This single line triggers the entire load pipeline:
    Step 7 stored procedure
      → TRUNCATE tbl_hw_current_datetime
      → INSERT from vw_hw_current_datetime
      → Print confirmation message
------------------------------------------------------------------------------
*/

EXEC dbo.usp_load_hw_current_datetime;
GO

-- Verify: confirm the table was refreshed with current data
SELECT * FROM dbo.tbl_hw_current_datetime;
GO

/*
  Expected output in Messages tab:
    usp_load_hw_current_datetime: Load completed successfully.

  Expected result in Results tab:
    DatetimeID  CurrentServerDateTime          LoadedAt
    ----------  -----------------------------  -----------------------------
    1           2025-05-20 14:32:07.1234567   2025-05-20 14:32:07.1234567

  ============================================================================
  FULL PIPELINE SUMMARY — Hello World Answer-Focused Approach
  ============================================================================
  Step 1  EC_IT143_W4.2_hello_world_s1_xx.sql  → Define the question
  Step 2  EC_IT143_W4.2_hello_world_s2_xx.sql  → Map the answer sub-steps
  Step 3  EC_IT143_W4.2_hello_world_s3_xx.sql  → Ad hoc SELECT query
  Step 4  EC_IT143_W4.2_hello_world_s4_xx.sql  → CREATE VIEW
  Step 5.1 EC_IT143_W4.2_hello_world_s5.1_xx.sql → SELECT INTO table
  Step 5.2 EC_IT143_W4.2_hello_world_s5.2_xx.sql → Refine table (PK + types)
  Step 6  EC_IT143_W4.2_hello_world_s6_xx.sql  → TRUNCATE + INSERT (ad hoc)
  Step 7  EC_IT143_W4.2_hello_world_s7_xx.sql  → CREATE STORED PROCEDURE
  Step 8  EC_IT143_W4.2_hello_world_s8_xx.sql  → EXEC stored procedure
  ============================================================================
*/
