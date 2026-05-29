/*
============================================================
Script Header
============================================================
File Name:      EC_IT143_W5.2_MyFC_ag.sql
Author:         [Adolphus Gibson]
Date Created:   [May 29, 2026]
Course:         IT 143
Description:    This script answers four questions about the
                MyFC soccer community data set. It uses the
                tblPlayerDim, tblPlayerFact, tblPositionDim,
                and tblTeamDim tables.
Resources Used:
  1. https://www.w3schools.com/sql/sql_groupby.asp
  2. https://learn.microsoft.com/en-us/sql/t-sql/queries/select-transact-sql
============================================================
*/

USE MyFC;  -- Replace with your actual database name
GO

-- ============================================================
-- QUESTION 1
-- Author: [Adolphus Gibson]
-- Question: Which players have the most goals this season
-- by position, and how do their salaries compare?
-- Tables used: tblPlayerDim, tblPlayerFact, tblPositionDim
-- ============================================================

SELECT
    pos.p_name          AS Position,
    pl.pl_name          AS PlayerName,
    pl.pl_num           AS JerseyNumber,
    SUM(pf.mtd_salary)  AS TotalSalary
FROM
    tblPlayerDim    AS pl
    INNER JOIN tblPlayerFact    AS pf  ON pl.pl_id = pf.pl_id
    INNER JOIN tblPositionDim   AS pos ON pl.p_id  = pos.p_id
GROUP BY
    pos.p_name,
    pl.pl_name,
    pl.pl_num
ORDER BY
    pos.p_name,
    TotalSalary DESC;
GO

-- ============================================================
-- QUESTION 2
-- Author: [Adolphus Gibson]
-- Question: What is the total monthly salary paid out per
-- team, and which team has the highest payroll?
-- Tables used: tblPlayerDim, tblPlayerFact, tblTeamDim
-- ============================================================

SELECT
    t.t_code            AS TeamCode,
    pf.as_of_date       AS SalaryMonth,
    SUM(pf.mtd_salary)  AS TotalMonthlyPayroll
FROM
    tblPlayerDim    AS pl
    INNER JOIN tblPlayerFact AS pf ON pl.pl_id = pf.pl_id
    INNER JOIN tblTeamDim    AS t  ON pl.t_id  = t.t_id
GROUP BY
    t.t_code,
    pf.as_of_date
ORDER BY
    TotalMonthlyPayroll DESC;
GO

-- ============================================================
-- QUESTION 3
-- Author: [Adolphus Gibson]
-- Question: Which positions have the highest total salary
-- target vs actual salary paid, and which positions are
-- over or under their target?
-- Tables used: tblPositionDim, tblPlayerDim, tblPlayerFact
-- ============================================================

SELECT
    pos.p_name              AS Position,
    pos.p_code              AS PositionCode,
    pos.p_target            AS SalaryTarget,
    SUM(pf.mtd_salary)      AS ActualSalaryPaid,
    (SUM(pf.mtd_salary)
        - pos.p_target)     AS VarianceFromTarget
FROM
    tblPositionDim  AS pos
    INNER JOIN tblPlayerDim  AS pl ON pos.p_id  = pl.p_id
    INNER JOIN tblPlayerFact AS pf ON pl.pl_id  = pf.pl_id
GROUP BY
    pos.p_name,
    pos.p_code,
    pos.p_target
ORDER BY
    VarianceFromTarget DESC;
GO

-- ============================================================
-- QUESTION 4
-- Author: [Classmate Name] (from 4.3.1 Collaboration Corner)
-- Question: Which players have the highest combined salary
-- across all recorded months, and how does that compare
-- across teams and positions?
-- Tables used: tblPlayerDim, tblPlayerFact, tblTeamDim,
--              tblPositionDim
-- ============================================================

SELECT
    pl.pl_name              AS PlayerName,
    t.t_code                AS Team,
    pos.p_name              AS Position,
    COUNT(pf.as_of_date)    AS MonthsRecorded,
    SUM(pf.mtd_salary)      AS TotalCumulativeSalary,
    AVG(pf.mtd_salary)      AS AvgMonthlySalary
FROM
    tblPlayerDim    AS pl
    INNER JOIN tblPlayerFact  AS pf  ON pl.pl_id = pf.pl_id
    INNER JOIN tblTeamDim     AS t   ON pl.t_id  = t.t_id
    INNER JOIN tblPositionDim AS pos ON pl.p_id  = pos.p_id
GROUP BY
    pl.pl_name,
    t.t_code,
    pos.p_name
ORDER BY
    TotalCumulativeSalary DESC;
GO