/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s8_ag.sql
  Step          : Step 8 — Call the stored procedure
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
==============================================================================
*/
USE EC_IT143_DA;
GO

EXEC dbo.usp_load_simpsons_spending_by_category;
GO

SELECT *
FROM dbo.tbl_simpsons_spending_by_category
ORDER BY TotalSpending DESC;
GO

/*
  ============================================================================
  FULL PIPELINE SUMMARY — Simpsons Answer-Focused Approach
  Question: What is the total spending amount per card type?
  ============================================================================
  Step 1   EC_IT143_W4.2_simpsons_s1_xx.sql    → Define the question
  Step 2   EC_IT143_W4.2_simpsons_s2_xx.sql    → Map the answer sub-steps
  Step 3   EC_IT143_W4.2_simpsons_s3_xx.sql    → Ad hoc JOIN + GROUP BY query
  Step 4   EC_IT143_W4.2_simpsons_s4_xx.sql    → CREATE VIEW vw_simpsons_spending_by_card_type
  Step 5.1 EC_IT143_W4.2_simpsons_s5.1_xx.sql  → SELECT INTO table
  Step 5.2 EC_IT143_W4.2_simpsons_s5.2_xx.sql  → Refined table (PK + types)
  Step 6   EC_IT143_W4.2_simpsons_s6_xx.sql    → TRUNCATE + INSERT (ad hoc load)
  Step 7   EC_IT143_W4.2_simpsons_s7_xx.sql    → CREATE STORED PROCEDURE
  Step 8   EC_IT143_W4.2_simpsons_s8_xx.sql    → EXEC stored procedure
  ============================================================================
*/
