/*
========================================================
  Script    : EC_IT143_6.3_fwf_s6_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 6: Compare UDF to Ad Hoc Query
  Date      :June 10, 2026
  DB        : EC_IT143_DA
========================================================
  PURPOSE:
    Side-by-side comparison of the inline ad hoc approach
    vs the fn_getFirstName UDF.
    Every row in the DoTheyMatch column should say "YES - Match".
========================================================
*/

USE EC_IT143_DA;
GO

SELECT TOP 20
    ContactName,

    -- Ad hoc inline approach
    LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
        AS FirstName_AdHoc,

    -- UDF approach
    dbo.fn_getFirstName(ContactName)
        AS FirstName_UDF,

    -- Verification column
    CASE
        WHEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
           = dbo.fn_getFirstName(ContactName)
        THEN 'YES - Match'
        ELSE 'NO - Mismatch!'
    END AS DoTheyMatch

FROM
    dbo.t_w3_schools_customers
ORDER BY
    ContactName;
GO
