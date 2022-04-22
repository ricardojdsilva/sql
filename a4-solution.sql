-- Assignment 4 Winter 2022

USE WP;

--- Q1
DROP VIEW IF EXISTS EmployeeProjectView;
GO
CREATE VIEW EmployeeProjectView AS
	SELECT	E.EmployeeNumber, FirstName, LastName, E.Department, ProjectName, HoursWorked
	FROM	EMPLOYEE AS E JOIN ASSIGNMENT AS A
				ON E.EmployeeNumber = A.EmployeeNumber
			JOIN PROJECT AS P
				ON A.ProjectID = P.ProjectID
GO

-- Q2
DROP PROCEDURE IF EXISTS ProjectEmpSearch;
GO


CREATE PROCEDURE ProjectEmpSearch @ProjectName Char(50)
AS
SELECT	FirstName, LastName, Department
FROM	EmployeeProjectView
WHERE	ProjectName = @ProjectName;
GO

EXEC ProjectEmpSearch @ProjectName = '2019 Q3 Marketing Plan';

-- Q3
DROP FUNCTION IF EXISTS dbo.ProjectCost;
GO
CREATE FUNCTION dbo.ProjectCost
(
	@ProjectName	Char(50), 
	@HourlyRate		Numeric(8, 2)
)
RETURNS Numeric(8, 2)
AS
BEGIN	
	DECLARE	@Cost	Numeric(8, 2);

	SELECT	@Cost = SUM(HoursWorked) * @HourlyRate
	FROM	EmployeeProjectView
	WHERE	ProjectName = @ProjectName;

	RETURN	@Cost;
END
GO

SELECT	ProjectName, dbo.ProjectCost(ProjectName, 35.0) AS Cost
FROM	PROJECT;