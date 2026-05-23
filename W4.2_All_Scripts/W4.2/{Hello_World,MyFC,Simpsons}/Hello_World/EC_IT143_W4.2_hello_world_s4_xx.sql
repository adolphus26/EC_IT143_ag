/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s4_ag.sql
  Step          : Step 4 — Turn the ad hoc SQL query into a view
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 4 wraps the working ad hoc query from Step 3 inside
                  a CREATE VIEW statement. A view is a saved, named SELECT
                  statement stored inside the database. It can be queried
                  just like a table. Views do not store data — they are
                  virtual tables that re-run their query each time called.

  View naming convention:
    vw_  prefix  = identifies this object as a view
    hw_          = hello world (community/project prefix)
    current_datetime = describes what the view returns
==============================================================================
*/

USE EC_IT143_DA;
GO

-- Drop the view if it already exists so we can re-run this script cleanly
IF OBJECT_ID('dbo.vw_hw_current_datetime', 'V') IS NOT NULL
    DROP VIEW dbo.vw_hw_current_datetime;
GO

/*
------------------------------------------------------------------------------
  CREATE VIEW
  Source query: EC_IT143_W4.2_hello_world_s3_xx.sql
  Answers    : What is the current date and time on this SQL Server?
------------------------------------------------------------------------------
*/

CREATE VIEW dbo.vw_hw_current_datetime
AS
    /*
      Returns the current SQL Server system date and time.
      GETDATE() refreshes every time this view is queried.
      No source table — this is a scalar function view.
    */
    SELECT
        GETDATE()   AS CurrentServerDateTime;
GO

-- Verify the view works immediately after creation
SELECT * FROM dbo.vw_hw_current_datetime;
GO

/*
  Expected result: Same as Step 3 — one row, one column.
  The difference: this result is now retrievable by any authorized user
  simply by querying the view name, without knowing the underlying SQL.
*/
