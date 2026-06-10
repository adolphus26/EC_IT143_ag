/*
========================================================
  Script    : EC_IT143_6.3_fwt_s1_ag.sql
  Author    : Adolphus Gibson
  Course    : IT 143 - Database Management
  Step      : Fun with Triggers - Step 1: Start with a Question
  Date      : June 10, 2026
  DB        : EC_IT143_DA
  Table     : dbo.t_w3_schools_customers
========================================================
  QUESTION (simple, precise, singular):
    How can I automatically record WHEN a row in
    t_w3_schools_customers was last modified?

  NOTES:
    We need a column to store the timestamp.
    We need something that AUTOMATICALLY updates it on change.
    That "something" is a TRIGGER.
    Simple. Singular. Precise.
========================================================
*/

USE EC_IT143_DA;
GO

-- Look at the current table structure
-- Notice: there is no LastModifiedDate column yet
SELECT TOP 5
    CustomerID,
    CustomerName,
    ContactName
FROM
    dbo.t_w3_schools_customers;
GO
