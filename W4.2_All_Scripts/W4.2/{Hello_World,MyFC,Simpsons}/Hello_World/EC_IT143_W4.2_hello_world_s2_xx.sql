/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s2_ag.sql
  Step          : Step 2 — Begin creating an answer
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 2 maps out the journey from question to answer.
                  We write out where we are NOW and what the NEXT logical
                  step looks like. We break the answer into sub-steps.
==============================================================================
*/

/*
------------------------------------------------------------------------------
  THE QUESTION (carried forward from Step 1)
  What is the current date and time on this SQL Server?
------------------------------------------------------------------------------

  WHERE WE ARE NOW
  ----------------
  We have a question. We have a working SQL Server connection.
  We do not yet have any SQL written.

  MAPPING THE ANSWER — SUB-STEPS
  --------------------------------
  Sub-step 1:
    Use the built-in SQL Server function GETDATE() to return the current
    system date and time. This requires no tables — just a SELECT statement.
    GETDATE() returns a DATETIME value.

  Sub-step 2:
    Label the result with a meaningful alias so the output column is
    readable to a non-technical user.
    Example alias: CurrentServerDateTime

  Sub-step 3 (refinement consideration):
    Consider whether we want GETDATE() or SYSDATETIME().
    GETDATE()      → returns datetime  (millisecond precision)
    SYSDATETIME()  → returns datetime2 (nanosecond precision)
    For a "Hello World" exercise, GETDATE() is sufficient.

  NOT YET CONCERNED WITH:
  ------------------------
  - Views (Step 4)
  - Tables (Step 5)
  - Stored procedures (Step 7)
  These will follow naturally once the ad hoc query works in Step 3.
------------------------------------------------------------------------------
*/
