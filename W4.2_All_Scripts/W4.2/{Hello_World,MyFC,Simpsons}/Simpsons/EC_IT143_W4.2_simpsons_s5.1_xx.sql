/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s5.1_xx.sql
  Step          : Step 5.1 — SELECT INTO table from view
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Your Full Name]
  Date Created  : [Today's Date]
  Database      : EC_IT143_DA
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.tbl_simpsons_spending_by_card_type', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_simpsons_spending_by_card_type;
GO

SELECT *
INTO   dbo.tbl_simpsons_spending_by_card_type
FROM   dbo.vw_simpsons_spending_by_card_type;
GO

SELECT *
FROM   dbo.tbl_simpsons_spending_by_card_type
ORDER BY TotalSpending DESC;
GO
