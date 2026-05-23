/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s3_ag.sql
  Step          : Step 3 — Create an ad hoc SQL query
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
==============================================================================
*/

USE EC_IT143_DA;
GO

-- Verify the data first
SELECT TOP 10 * FROM Simpsons.dbo.Planet_Express;
GO

/*
------------------------------------------------------------------------------
  AD HOC QUERY
  Total spending amount and transaction count per card type
  Source: Simpsons.dbo.Transactions JOIN Simpsons.dbo.Cards
  Three-part naming used because source data is in the Simpsons database.
------------------------------------------------------------------------------
*/

-- MAIN QUERY: What is the total spending amount per category?
SELECT
    pe.Category             AS Category,
    COUNT(*)                AS TransactionCount,
    ROUND(SUM(pe.Amount), 2) AS TotalSpending
FROM Simpsons.dbo.Planet_Express AS pe
WHERE pe.Category IS NOT NULL
GROUP BY pe.Category
ORDER BY TotalSpending DESC;
GO

