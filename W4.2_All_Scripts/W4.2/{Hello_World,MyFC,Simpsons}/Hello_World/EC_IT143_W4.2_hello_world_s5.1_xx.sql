/*
==============================================================================
  Script Name   : EC_IT143_W4.2_hello_world_s5.1_ag.sql
  Step          : Step 5.1 — Turn the view into a table (SELECT INTO)
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 5.1 uses SELECT...INTO to create a physical table
                  directly from our view. SELECT INTO is the simplest way
                  to materialize view data into a permanent table.
                  SQL Server automatically infers column names and data types
                  from the view output.

  Naming convention:
    tbl_  prefix = identifies this object as a table
    hw_         = hello world project prefix
    Source view : vw_hw_current_datetime
    Dest table  : tbl_hw_current_datetime
    Symmetry between view and table names makes the data flow obvious.
==============================================================================
*/

USE EC_IT143_DA;
GO

-- Drop the table if it already exists so we can re-run this script cleanly
IF OBJECT_ID('dbo.tbl_hw_current_datetime', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_hw_current_datetime;
GO

/*
------------------------------------------------------------------------------
  CREATE TABLE from VIEW using SELECT INTO
  Source : dbo.vw_hw_current_datetime
  Target : dbo.tbl_hw_current_datetime
------------------------------------------------------------------------------
*/

SELECT *
INTO   dbo.tbl_hw_current_datetime
FROM   dbo.vw_hw_current_datetime;
GO

-- Verify: check the table was created and contains data
SELECT * FROM dbo.tbl_hw_current_datetime;
GO

/*
  What SELECT INTO does:
  1. Reads all rows from the view
  2. Creates a NEW table with matching column names and inferred data types
  3. Inserts those rows into the new table in one operation

  What it does NOT do:
  - It does not create primary keys (we do that in Step 5.2)
  - It does not create constraints or indexes
  - That refinement is Step 5.2
*/
