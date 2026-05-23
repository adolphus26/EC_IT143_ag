/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s3_ag.sql
  Step          : Step 3 — Create an ad hoc SQL query
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 3 translates Sub-step 1 from our answer map into
                  a working, executable SQL SELECT statement.
                  An ad hoc query is a one-time, direct query run
                  interactively — not yet saved as a view or procedure.
==============================================================================
*/

USE EC_IT143_DA;
GO

/*
------------------------------------------------------------------------------
  AD HOC QUERY — Sub-step 1
  Return the current SQL Server date and time
------------------------------------------------------------------------------
*/

SELECT GETDATE() AS CurrentServerDateTime;

/*
  Expected result: One row, one column.
  Example:  CurrentServerDateTime
            -----------------------
            2025-05-20 14:32:07.123

  Notes:
  - GETDATE() requires no parameters
  - No FROM clause needed (no table is being queried)
  - The AS keyword aliases the column for readability
  - This confirms our SQL Server connection is live and functional
------------------------------------------------------------------------------
*/
