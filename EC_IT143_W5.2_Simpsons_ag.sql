/*
============================================================
Script Header
============================================================
File Name:      EC_IT143_W5.2_Simpsons_xx.sql
Author:         [Adolphus Gibson]
Date Created:   [May 29, 2026]
Course:         IT 143
Description:    This script answers four questions about the
                Simpsons consumer transaction community data
                set. It uses the Family_Data,
                FBS_Viza_Costmo, Planet_Express, and
                tbl_FamilyDataCount tables.
Resources Used:
  1. https://www.w3schools.com/sql/sql_join.asp
  2. https://learn.microsoft.com/en-us/sql/t-sql/functions/sum-transact-sql
============================================================
*/

USE Simpsons;  -- Replace with your actual database name
GO

-- ============================================================
-- QUESTION 1
-- Author: [Adolphus Gibson]
-- Question: Which spending categories have the highest
-- total charges on the Planet Express card, and how do
-- those categories trend over time?
-- Tables used: Planet_Express
-- ============================================================

SELECT
    pe.Category                     AS SpendingCategory,
    FORMAT(pe.Date, 'yyyy-MM')      AS YearMonth,
    SUM(pe.Amount)                  AS TotalSpent,
    COUNT(pe.Description)           AS TransactionCount
FROM
    Planet_Express AS pe
GROUP BY
    pe.Category,
    FORMAT(pe.Date, 'yyyy-MM')
ORDER BY
    YearMonth,
    TotalSpent DESC;
GO

-- ============================================================
-- QUESTION 2
-- Author: [Adolphus Gibson]
-- Question: Which family members currently employed have
-- the longest tenure at the company, and what department
-- and job title do they hold?
-- Tables used: Family_Data
-- ============================================================

SELECT
    fd.First_Name + ' ' + fd.Last_Name  AS FullName,
    fd.Job_Title                        AS JobTitle,
    fd.Department                       AS Department,
    fd.Hire_Date                        AS HireDate,
    fd.Status                           AS EmploymentStatus,
    DATEDIFF(YEAR, fd.Hire_Date,
        GETDATE())                      AS YearsOfService
FROM
    Family_Data AS fd
WHERE
    fd.Status = 'Active'
    AND fd.Termination_Date IS NULL
ORDER BY
    YearsOfService DESC;
GO

-- ============================================================
-- QUESTION 3
-- Author: [Adolphus Gibson]
-- Question: Which departments have the highest number of
-- terminated employees relative to total headcount, and
-- which managers oversee those departments?
-- Tables used: Family_Data
-- ============================================================

SELECT
    fd.Department                               AS Department,
    fd.Manager                                  AS Manager,
    COUNT(fd.Member_ID)                         AS TotalEmployees,
    SUM(CASE WHEN fd.Status = 'Terminated'
             THEN 1 ELSE 0 END)                 AS TerminatedCount,
    ROUND(
        100.0 *
        SUM(CASE WHEN fd.Status = 'Terminated'
                 THEN 1 ELSE 0 END)
        / COUNT(fd.Member_ID), 2)               AS TerminationRatePct
FROM
    Family_Data AS fd
GROUP BY
    fd.Department,
    fd.Manager
ORDER BY
    TerminationRatePct DESC;
GO

-- ============================================================
-- QUESTION 4
-- Author: [Classmate Name] (from 4.3.1 Collaboration Corner)
-- Question: Which family members have the highest total
-- spending across both the Viza Costmo and Planet Express
-- card accounts combined, and does their spending differ
-- significantly between the two accounts?
-- Tables used: FBS_Viza_Costmo, Planet_Express
-- ============================================================

SELECT
    combined.MemberName,
    SUM(combined.VizaSpend)     AS TotalVizaSpend,
    SUM(combined.PlanetSpend)   AS TotalPlanetSpend,
    SUM(combined.VizaSpend)
        + SUM(combined.PlanetSpend) AS CombinedTotalSpend
FROM (
    -- Viza Costmo charges (Debit = money going out)
    SELECT
        vc.Member_Name      AS MemberName,
        vc.Debit            AS VizaSpend,
        0                   AS PlanetSpend
    FROM FBS_Viza_Costmo AS vc
    WHERE vc.Debit IS NOT NULL

    UNION ALL

    -- Planet Express charges
    SELECT
        pe.Card_Member      AS MemberName,
        0                   AS VizaSpend,
        pe.Amount           AS PlanetSpend
    FROM Planet_Express AS pe
    WHERE pe.Amount IS NOT NULL

) AS combined
GROUP BY
    combined.MemberName
ORDER BY
    CombinedTotalSpend DESC;
GO