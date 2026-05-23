/*
==============================================================================
  Script Name   : EC_IT143_W4.2_simpsons_s1_ag.sql
  Step          : Step 1 — Start with a question
  Community     : Simpsons — Consumer Credit Card Transactions
  Author        : [Adolphus Gibson]
  Date Created  : [May 23, 2026]
  Database      : EC_IT143_DA
  Description   : Step 1 of the Answer-Focused Approach applied to the
                  Simpsons consumer credit card transaction community data set.
==============================================================================
*/

/*
------------------------------------------------------------------------------
  THE QUESTION
------------------------------------------------------------------------------
  What is the total spending amount per card type?

  Why this question?
  ------------------
  A financial analyst or product manager at a credit card company would
  immediately want to know which card type (Visa, Mastercard, etc.) drives
  the most total transaction volume. This is a fundamental business metric
  for portfolio management and marketing strategy decisions.

  Hallmarks of a simple question (checklist):
    [x] Brief       — One sentence, eight words
    [x] Precise     — Asks for a sum grouped by card type
    [x] Singular    — One focus: total spending per card type

  Source tables : Transactions (amount), Cards (card_type)
  Join key      : Transactions.card_id = Cards.card_id
  Key column    : Cards.card_type (grouping column)
  Key measure   : SUM(Transactions.amount)
------------------------------------------------------------------------------
*/
