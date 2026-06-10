/*
========================================================
  Script    : EC_IT143_6.3_fwf_s1_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Functions - Step 1: Start with a Question
  Date      : June 10, 2026
  DB        : EC_IT143_DA
  Table     : dbo.t_w3_schools_customers
========================================================
  PURPOSE:
    Identify the simplest, most precise question we need
    to answer before writing any SQL.

  QUESTION:
    How do I extract the FIRST NAME from the ContactName
    column in the t_w3_schools_customers table?

  NOTES:
    - ContactName is stored as "FirstName LastName"
      (example: "Maria Anders")
    - The first name is everything BEFORE the first space.
    - This question is simple, singular, and precise.
========================================================
*/

-- Step 1: Simply look at the ContactName column
-- so we understand the raw data we are working with.

USE EC_IT143_DA;
GO

SELECT TOP 10
    ContactName
FROM
    dbo.t_w3_schools_customers;
GO
