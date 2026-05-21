/*
==============================================================================
  Script Header
==============================================================================
  Script Name   : EC_IT143_W3.4_AG.sql
                  (Replace "xx" with your initials before submitting,
                   e.g. EC_IT143_W3.4_ag.sql for Adolphus Gibson)

  Course        : IT 143 – Database Management
  Assignment    : 3.4 Adventure Works – Create Answers
  Database      : AdventureWorks (any version — script auto-detects name)
  Author        : [Adolphus Gibson]
  Date Created  : [May 21, 2026]
  Last Modified : [May 21, 2026]

  Description   : This script answers eight business and metadata questions
                  sourced from Assignment 3.3 (Create Questions). Questions
                  span four complexity categories as required:
                    - Marginal Complexity  (Q1, Q2)
                    - Moderate Complexity  (Q3, Q4)
                    - Increased Complexity (Q5, Q6)
                    - Metadata / INFORMATION_SCHEMA (Q7, Q8)

  HOW TO RUN THIS SCRIPT:
    Step 1 — In SSMS Object Explorer, expand your Databases folder.
    Step 2 — You will see a database named something like:
               AdventureWorks, AdventureWorks2019, AdventureWorks2022, etc.
    Step 3 — Right-click that database and choose "New Query".
             This opens a query window already connected to it.
    Step 4 — Paste or open this script and click Execute (F5).
    Step 5 — Alternatively: in the toolbar dropdown at the top of SSMS,
             change the active database to your AdventureWorks database,
             then run the script.

    NOTE: The USE statement below says AdventureWorks2022. If your database
    is named differently (e.g. AdventureWorks2019 or just AdventureWorks),
    change ONLY that one line to match your database name exactly.

  Runtime Estimate:
    Q1  < 1 second   (single table, simple aggregate + ORDER BY)
    Q2  < 1 second   (2 tables joined, ORDER BY)
    Q3  < 1 second   (2 tables, GROUP BY + calculated column)
    Q4  < 1 second   (3 tables, GROUP BY + aggregates)
    Q5  < 2 seconds  (3 tables, GROUP BY month + territory)
    Q6  < 2 seconds  (5 tables, GROUP BY + calculated profit column)
    Q7  < 1 second   (INFORMATION_SCHEMA.COLUMNS metadata view)
    Q8  < 1 second   (INFORMATION_SCHEMA.TABLES + .COLUMNS metadata views)

  SQL Formatting : Follows the 24 Rules SQL Formatting Standard (LearnSQL.com)
                   Keywords in UPPERCASE, 4-space indentation, one clause per line.

  Learning Resources Used:
    1. AdventureWorks Sample Databases – Microsoft Learn (Official Docs)
       https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure

    2. INFORMATION_SCHEMA Views (Transact-SQL) – Microsoft Learn
       https://learn.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/system-information-schema-views-transact-sql

    3. 24 Rules to the SQL Formatting Standard – LearnSQL.com
       https://learnsql.com/blog/sql-formatting-standards/

    4. AdventureWorks Schema Browser & Data Dictionary – Dataedo
       https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/

    5. SQL Project for Beginners: AdventureWorks Sales Dashboard – LearnSQL.com
       https://learnsql.com/blog/sql-project-sales-dashboard-adventureworks/

    6. How to Ask a Good Question – Stack Overflow Help Center
       https://stackoverflow.com/help/how-to-ask

==============================================================================
*/

-- ============================================================================
-- IMPORTANT: If this line errors, change the database name below to match
--            what you see in SSMS Object Explorer under "Databases".
--            Common names: AdventureWorks, AdventureWorks2019, AdventureWorks2022
-- ============================================================================
USE AdventureWorks2022;   -- <-- CHANGE THIS if your DB has a different name
GO

-- Quick check: print the database name we are now connected to
SELECT DB_NAME() AS CurrentDatabase;
GO

-- ============================================================================
-- SECTION 1: MARGINAL COMPLEXITY QUESTIONS
-- Single table reference, 15 words or less, simple aggregates
-- ============================================================================


/*
------------------------------------------------------------------------------
  Q1 — Business User Question (Marginal Complexity)
  Original Author: [Adolphus Gibson]

  Question:
    "What are the top five sales territories ranked by total sales revenue,
     from highest to lowest?"

  Tables: Sales.SalesTerritory (1 table)
  Translation Notes:
    SalesYTD column stores year-to-date revenue per territory.
    TOP 5 with ORDER BY DESC on SalesYTD gives the answer directly.
------------------------------------------------------------------------------
*/

SELECT TOP 5
    Name                        AS TerritoryName,
    [Group]                     AS TerritoryRegion,
    ROUND(SalesYTD, 2)          AS TotalSalesRevenue
FROM Sales.SalesTerritory
ORDER BY SalesYTD DESC;

GO


/*
------------------------------------------------------------------------------
  Q2 — Business User Question (Marginal Complexity)
  Original Author: [Classmate Name]

  Question:
    "Which ten employees have the highest individual sales totals based on
     their year-to-date sales figures?"

  Tables: Sales.SalesPerson, Person.Person
  Translation Notes:
    Sales.SalesPerson holds SalesYTD per salesperson (BusinessEntityID).
    Joined to Person.Person to get readable first/last name.
------------------------------------------------------------------------------
*/

SELECT TOP 10
    p.FirstName + ' ' + p.LastName      AS SalesPersonName,
    ROUND(sp.SalesYTD, 2)               AS SalesYearToDate,
    ROUND(sp.SalesLastYear, 2)          AS SalesPreviousYear
FROM Sales.SalesPerson AS sp
    INNER JOIN Person.Person AS p
        ON sp.BusinessEntityID = p.BusinessEntityID
ORDER BY sp.SalesYTD DESC;

GO


-- ============================================================================
-- SECTION 2: MODERATE COMPLEXITY QUESTIONS
-- Multiple table references, 15–30 words, JOINs required
-- ============================================================================


/*
------------------------------------------------------------------------------
  Q3 — Business User Question (Moderate Complexity)
  Original Author: [Adolphus Gibson]

  Question:
    "I define net margin per unit as list price minus standard cost.
     Which five product subcategories have the lowest average net margin
     per unit? Include subcategory name and calculated average margin."

  Tables: Production.Product, Production.ProductSubcategory
  Translation Notes:
    AVG(ListPrice - StandardCost) grouped by subcategory gives the answer.
    WHERE ListPrice > 0 removes non-sellable internal components.
    ORDER BY ASC surfaces the riskiest (lowest margin) subcategories first.
------------------------------------------------------------------------------
*/

SELECT TOP 5
    ps.Name                                          AS SubcategoryName,
    COUNT(p.ProductID)                               AS ProductCount,
    ROUND(AVG(p.ListPrice - p.StandardCost), 2)      AS AvgNetMarginPerUnit,
    ROUND(AVG(p.ListPrice), 2)                       AS AvgListPrice,
    ROUND(AVG(p.StandardCost), 2)                    AS AvgStandardCost
FROM Production.Product AS p
    INNER JOIN Production.ProductSubcategory AS ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE p.ListPrice > 0
GROUP BY ps.Name
ORDER BY AvgNetMarginPerUnit ASC;

GO


/*
------------------------------------------------------------------------------
  Q4 — Business User Question (Moderate Complexity)
  Original Author: [Classmate Name]

  Question:
    "Which ten individual customers have placed the highest total number of
     orders? Show customer full name, order count, and total amount spent,
     sorted by order count descending."

  Tables: Sales.SalesOrderHeader, Sales.Customer, Person.Person
  Translation Notes:
    SalesOrderHeader has one row per order with CustomerID and TotalDue.
    Sales.Customer links CustomerID to PersonID (individual customers).
    Person.Person supplies the readable name.
    StoreID IS NULL filters to individual buyers (not business stores).
------------------------------------------------------------------------------
*/

SELECT TOP 10
    p.FirstName + ' ' + p.LastName      AS CustomerName,
    COUNT(soh.SalesOrderID)             AS TotalOrders,
    ROUND(SUM(soh.TotalDue), 2)         AS TotalAmountSpent
FROM Sales.SalesOrderHeader AS soh
    INNER JOIN Sales.Customer AS c
        ON soh.CustomerID = c.CustomerID
    INNER JOIN Person.Person AS p
        ON c.PersonID = p.BusinessEntityID
WHERE c.StoreID IS NULL
GROUP BY
    p.FirstName,
    p.LastName
ORDER BY TotalOrders DESC;

GO


-- ============================================================================
-- SECTION 3: INCREASED COMPLEXITY QUESTIONS
-- Multiple tables, 30–50 word story context, advanced grouping/filtering
-- ============================================================================


/*
------------------------------------------------------------------------------
  Q5 — Business User Question (Increased Complexity)
  Original Author: [Adolphus Gibson]

  Question:
    "Our leadership team is preparing for a quarterly sales review covering
     the full year 2013. I need a monthly summary broken down by territory
     group (North America, Europe, Pacific). For each month and group, show
     total order count, total units sold, and total revenue rounded to two
     decimal places. Sort chronologically by month, then alphabetically by
     territory group."

  Tables: Sales.SalesOrderHeader, Sales.SalesOrderDetail, Sales.SalesTerritory
  Translation Notes:
    SalesOrderHeader.TerritoryID links to SalesTerritory.[Group].
    SalesOrderDetail provides OrderQty and LineTotal per order line.
    FORMAT(OrderDate,'yyyy-MM') groups by calendar month.
    Date filter: 2013-01-01 <= OrderDate < 2014-01-01 (avoids time issues).
------------------------------------------------------------------------------
*/

SELECT
    FORMAT(soh.OrderDate, 'yyyy-MM')       AS OrderMonth,
    st.[Group]                             AS TerritoryGroup,
    COUNT(DISTINCT soh.SalesOrderID)       AS TotalOrders,
    SUM(sod.OrderQty)                      AS TotalUnitsSold,
    ROUND(SUM(sod.LineTotal), 2)           AS TotalRevenue
FROM Sales.SalesOrderHeader AS soh
    INNER JOIN Sales.SalesOrderDetail AS sod
        ON soh.SalesOrderID = sod.SalesOrderID
    INNER JOIN Sales.SalesTerritory AS st
        ON soh.TerritoryID = st.TerritoryID
WHERE soh.OrderDate >= '2013-01-01'
  AND soh.OrderDate <  '2014-01-01'
GROUP BY
    FORMAT(soh.OrderDate, 'yyyy-MM'),
    st.[Group]
ORDER BY
    OrderMonth   ASC,
    TerritoryGroup ASC;

GO


/*
------------------------------------------------------------------------------
  Q6 — Business User Question (Increased Complexity)
  Original Author: [Classmate Name]

  Question:
    "We want to understand how our road bike lineup performed in 2012.
     Show a breakdown by product name and color with total quantity sold,
     average unit price, standard cost, and estimated gross profit per unit
     (average unit price minus standard cost). Only include Road Bikes.
     Sort by estimated gross profit per unit from lowest to highest."

  Tables: Sales.SalesOrderDetail, Sales.SalesOrderHeader,
          Production.Product, Production.ProductSubcategory,
          Production.ProductCategory
  Translation Notes:
    Gross profit per unit = AVG(UnitPrice) - StandardCost.
    ps.Name = 'Road Bikes' filters the subcategory.
    OrderDate filter keeps only 2012 sales.
    ISNULL(p.Color,'N/A') handles products without a color value.
------------------------------------------------------------------------------
*/

SELECT
    p.Name                                              AS ProductName,
    ISNULL(p.Color, 'N/A')                             AS Color,
    SUM(sod.OrderQty)                                   AS TotalUnitsSold,
    ROUND(AVG(sod.UnitPrice), 2)                        AS AvgUnitPrice,
    ROUND(p.StandardCost, 2)                            AS StandardCost,
    ROUND(AVG(sod.UnitPrice) - p.StandardCost, 2)       AS EstGrossProfitPerUnit
FROM Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh
        ON sod.SalesOrderID = soh.SalesOrderID
    INNER JOIN Production.Product AS p
        ON sod.ProductID = p.ProductID
    INNER JOIN Production.ProductSubcategory AS ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN Production.ProductCategory AS pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE ps.Name     = 'Road Bikes'
  AND soh.OrderDate >= '2012-01-01'
  AND soh.OrderDate <  '2013-01-01'
GROUP BY
    p.Name,
    p.Color,
    p.StandardCost
HAVING SUM(sod.OrderQty) > 0
ORDER BY EstGrossProfitPerUnit ASC;

GO


-- ============================================================================
-- SECTION 4: METADATA QUESTIONS
-- Querying INFORMATION_SCHEMA system views — no business tables needed
-- NOTE: DB_NAME() dynamically returns the current database name, so these
--       queries work regardless of whether your database is named
--       AdventureWorks, AdventureWorks2019, or AdventureWorks2022.
-- ============================================================================


/*
------------------------------------------------------------------------------
  Q7 — Metadata Question (INFORMATION_SCHEMA)
  Original Author: [Adolphus Gibson]

  Question:
    "Can you give me a list of all tables in the AdventureWorks database that
     contain a column named either 'TerritoryID' or 'SalesPersonID', along
     with the schema name and the specific column name that matched?"

  View: INFORMATION_SCHEMA.COLUMNS
  Translation Notes:
    DB_NAME() is used instead of a hard-coded name so this query works
    on any AdventureWorks version without modification.
    COLUMN_NAME IN (...) handles both column names cleanly.
------------------------------------------------------------------------------
*/

SELECT
    TABLE_CATALOG       AS DatabaseName,
    TABLE_SCHEMA        AS SchemaName,
    TABLE_NAME          AS TableName,
    COLUMN_NAME         AS MatchedColumnName,
    DATA_TYPE           AS DataType,
    ORDINAL_POSITION    AS ColumnPosition
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_CATALOG = DB_NAME()          -- works for any AW version
  AND COLUMN_NAME IN ('TerritoryID', 'SalesPersonID')
ORDER BY
    TABLE_SCHEMA  ASC,
    TABLE_NAME    ASC,
    COLUMN_NAME   ASC;

GO


/*
------------------------------------------------------------------------------
  Q8 — Metadata Question (INFORMATION_SCHEMA)
  Original Author: [Classmate Name]

  Question:
    "I need a complete inventory of the AdventureWorks database. Produce a
     list of all base tables organized by schema name and table name, along
     with a count of columns in each table, sorted by schema then table name."

  Views: INFORMATION_SCHEMA.TABLES, INFORMATION_SCHEMA.COLUMNS
  Translation Notes:
    TABLE_TYPE = 'BASE TABLE' excludes views from the list.
    JOIN on TABLE_SCHEMA + TABLE_NAME links tables to their column counts.
    DB_NAME() keeps the filter version-agnostic.
    CASE expression adds a human-readable width label.
------------------------------------------------------------------------------
*/

SELECT
    t.TABLE_SCHEMA                                   AS SchemaName,
    t.TABLE_NAME                                     AS TableName,
    COUNT(c.COLUMN_NAME)                             AS ColumnCount,
    CASE
        WHEN COUNT(c.COLUMN_NAME) <= 5  THEN 'Narrow  (1-5 cols)'
        WHEN COUNT(c.COLUMN_NAME) <= 15 THEN 'Medium  (6-15 cols)'
        ELSE                                 'Wide    (16+ cols)'
    END                                              AS TableWidth
FROM INFORMATION_SCHEMA.TABLES AS t
    INNER JOIN INFORMATION_SCHEMA.COLUMNS AS c
        ON  t.TABLE_SCHEMA = c.TABLE_SCHEMA
        AND t.TABLE_NAME   = c.TABLE_NAME
WHERE t.TABLE_CATALOG = DB_NAME()        -- works for any AW version
  AND t.TABLE_TYPE    = 'BASE TABLE'
GROUP BY
    t.TABLE_SCHEMA,
    t.TABLE_NAME
ORDER BY
    t.TABLE_SCHEMA ASC,
    t.TABLE_NAME   ASC;

GO


/*
==============================================================================
  End of Script — EC_IT143_W3.4_AG.sql
==============================================================================
*/