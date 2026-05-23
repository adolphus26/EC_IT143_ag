/*
==============================================================================
  Script Name   : EC_IT143_W4.2_myfc_s1_ag.sql
  Step          : Step 1 — Start with a question
  Community     : MyFC — Soccer Team Data Set
  Author        : [Adolphus Gibson]
  Date Created  : [May 23,2026]
  Database      : EC_IT143_DA
  Description   : Step 1 of the Answer-Focused Approach applied to the
                  MyFC soccer team community data set.
                  Define one simple, clear, singular question.
==============================================================================
*/

/*
------------------------------------------------------------------------------
  THE QUESTION
------------------------------------------------------------------------------
  How many players play each position in the MyFC data set?

  Why this question?
  ------------------
  Understanding squad composition by position is one of the most fundamental
  questions a soccer club analyst would ask. A coach or general manager needs
  to know immediately: do we have enough forwards? Are we overloaded at
  midfield? This question has a direct, countable answer.

  Hallmarks of a simple question (checklist):
    [x] Brief       — One sentence, ten words
    [x] Precise     — Asks for a count grouped by position
    [x] Singular    — One focus: player count per position

  Source table  : Player (in the MyFC database)
  Key column    : position (the grouping column)
  Key measure   : COUNT of players per position group
------------------------------------------------------------------------------
*/
