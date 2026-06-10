/*
========================================================
  Script    : EC_IT143_6.3_fwf_s2_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 2: Begin Creating an Answer
  Date      : June 10, 2026
  DB        : EC_IT143_DA
========================================================
  WHERE I AM NOW:
    ContactName = "FirstName LastName" (e.g. "Maria Anders")
    I need everything BEFORE the first space.

  NEXT LOGICAL STEP:
    Use CHARINDEX to find the space position.
    Use LEFT to grab characters before it.
    Logic: LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
    Plain English: "Find the space. Take everything to the left."
========================================================
*/

USE EC_IT143_DA;
GO

-- Think through the logic: show ContactName + where the space is
SELECT TOP 10
    ContactName,
    CHARINDEX(' ', ContactName)         AS SpacePosition,
    CHARINDEX(' ', ContactName) - 1     AS CharactersBeforeSpace
FROM
    dbo.t_w3_schools_customers;
GO
