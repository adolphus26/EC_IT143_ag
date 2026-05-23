/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s4_ag.sql
  Step          : Step 4 — Turn the ad hoc query into a view
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.vw_simpsons_spending_by_category', 'V') IS NOT NULL
    DROP VIEW dbo.vw_simpsons_spending_by_category;
GO

CREATE VIEW dbo.vw_simpsons_spending_by_category
AS

    /*
      Returns total spending and transaction count per spending category.
      Source table : Simpsons.dbo.Planet_Express
      Key columns  : Category (grouping), Amount (measure)
      Answers      : What is the total spending amount per category?
    */
    SELECT
        pe.Category              AS Category,
        COUNT(*)                 AS TransactionCount,
        ROUND(SUM(pe.Amount), 2) AS TotalSpending
    FROM Simpsons.dbo.Planet_Express AS pe
    WHERE pe.Category IS NOT NULL
    GROUP BY pe.Category;
GO

-- Verify
SELECT *
FROM dbo.vw_simpsons_spending_by_category
ORDER BY TotalSpending DESC;
GO