/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s7_ag.sql
  Step          : Step 7 — Stored procedure
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
==============================================================================
*/

USE EC_IT143_DA;
GO

IF OBJECT_ID('dbo.usp_load_simpsons_spending_by_card_type', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_load_simpsons_spending_by_card_type;
GO

CREATE PROCEDURE dbo.usp_load_simpsons_spending_by_card_type
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.tbl_simpsons_spending_by_card_type;

    INSERT INTO dbo.tbl_simpsons_spending_by_card_type (
        CardType,
        TransactionCount,
        TotalSpending
    )
    SELECT
        CardType,
        TransactionCount,
        TotalSpending
    FROM dbo.vw_simpsons_spending_by_card_type;

    PRINT 'usp_load_simpsons_spending_by_card_type: Load completed successfully.';

END;
GO
