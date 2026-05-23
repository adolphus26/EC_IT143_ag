/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s5.2_ag.sql
  Step          : Step 5.2 — Refine the table architecture
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.tbl_simpsons_spending_by_category', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_simpsons_spending_by_category;
GO



IF OBJECT_ID('dbo.tbl_simpsons_spending_by_category', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_simpsons_spending_by_category;
GO

CREATE TABLE dbo.tbl_simpsons_spending_by_category (
    CategoryID        INT             NOT NULL IDENTITY(1,1),
    Category          NVARCHAR(100)   NOT NULL,
    TransactionCount  INT             NOT NULL,
    TotalSpending     DECIMAL(12,2)   NOT NULL,
    LoadedAt          DATETIME2       NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_tbl_simpsons_spending_by_category PRIMARY KEY (CategoryID)
);
GO

-- Verify structure
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tbl_simpsons_spending_by_category'
ORDER BY ORDINAL_POSITION;
GO