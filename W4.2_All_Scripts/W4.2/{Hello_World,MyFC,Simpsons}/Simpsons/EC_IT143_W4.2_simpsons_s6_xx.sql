/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s6_ag.sql
  Step          : Step 6 — Load the table from the view (ad hoc)
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
==============================================================================
*/

USE EC_IT143_DA;
GO

TRUNCATE TABLE dbo.tbl_simpsons_spending_by_category;
GO

INSERT INTO dbo.tbl_simpsons_spending_by_category (
    Category,
    TransactionCount,
    TotalSpending
)
SELECT
    Category,
    TransactionCount,
    TotalSpending
FROM dbo.vw_simpsons_spending_by_category;
GO

-- Verify the load
SELECT *
FROM dbo.tbl_simpsons_spending_by_category
ORDER BY TotalSpending DESC;
GO