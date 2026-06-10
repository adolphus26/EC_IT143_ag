/*
========================================================
  Script    : EC_IT143_6.3_fwf_s7_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 7: "0 Results Expected" Test
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  PURPOSE:
    If fn_getFirstName is working correctly, this query
    returns ZERO rows. Any result means there is a mismatch.

  HOW IT WORKS:
    A CTE computes both the ad hoc value and UDF value.
    The WHERE clause filters for rows where they do NOT match.
    Zero rows = the function is working perfectly.
========================================================
*/

USE EC_IT143_DA;
GO

WITH cte_compare AS
(
    SELECT
        ContactName,
        LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
            AS AdHocFirstName,
        dbo.fn_getFirstName(ContactName)
            AS UDFFirstName
    FROM
        dbo.t_w3_schools_customers
)
SELECT *
FROM   cte_compare
WHERE  AdHocFirstName <> UDFFirstName;
-- Expected result: 0 rows returned
GO
