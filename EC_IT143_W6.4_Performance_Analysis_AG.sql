USE AdventureWorks2022;
GO
SELECT *
FROM Person.Address
WHERE City = 'Seattle';


CREATE NONCLUSTERED INDEX IX_Address_City

ON Person.Address(City);
GO

SELECT *
FROM Person.Address
WHERE City='Seattle';

SELECT *
FROM Person.Person
WHERE LastName='Smith';

CREATE NONCLUSTERED INDEX IX_Person_LastName

ON Person.Person(LastName);
GO


