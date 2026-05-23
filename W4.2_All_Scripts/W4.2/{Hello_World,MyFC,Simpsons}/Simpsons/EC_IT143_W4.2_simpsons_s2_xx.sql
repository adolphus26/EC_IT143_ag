/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s2_ag.sql
  Step          : Step 2 — Begin creating an answer
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23,2026]
  Database      : EC_IT143_DA
==============================================================================
*/

/*
------------------------------------------------------------------------------
  THE QUESTION (from Step 1)
  What is the total spending amount per card type?
------------------------------------------------------------------------------

  WHERE WE ARE NOW
  ----------------
  We have two tables in the Simpsons database:
    Transactions  — transaction_id, card_id, transaction_date, amount, merchant, category
    Cards         — card_id, card_type, credit_limit, cardholder_name, status

  The answer requires a JOIN because:
    - The amount lives in Transactions
    - The card_type lives in Cards
    - They are linked by card_id

  MAPPING THE ANSWER — SUB-STEPS
  --------------------------------
  Sub-step 1:
    JOIN Transactions to Cards on card_id.
    GROUP BY card_type.
    SUM the amount column per group.
    Use ROUND(..., 2) for clean dollar formatting.
    ORDER BY total spending DESC.

  Sub-step 2:
    Label output clearly:
      card_type        → CardType
      SUM(amount)      → TotalSpending
      COUNT(transaction_id) → TransactionCount (bonus metric — adds value)

  NOT YET CONCERNED WITH:
  - Views, tables, stored procedures (Steps 4–7)
------------------------------------------------------------------------------
*/
