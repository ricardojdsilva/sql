/********************************************************************************/
/*																				*/
/*	Kroenke, Auer, Vandenberg, and Yoder 										*/
/*	Database Concepts (9th Edition) Chapter 03 	       							*/
/*																				*/
/*	Wedgewood Pacific (WP) Create Tables										*/
/*																				*/
/*	These are the Microsoft SQL Server 2014/2016 SQL code solutions				*/
/*																				*/
/*  Modified by Michael Ma														*/
/********************************************************************************/

USE master;		-- Switch to master database in order to delete the database WP.
				-- SQL Server is case insensitive
				-- https://docs.microsoft.com/en-us/sql/relational-databases/databases/master-database?view=sql-server-ver15
				-- The semicolon (;) is used in SQL code as a statement terminator. It's not mandatory for most SQL Server T-SQL statements
				-- But the semicolon is required in some cases.
				-- Transact-SQL (T-SQL) is Microsoft's and Sybase's proprietary extension to the SQL https://en.wikipedia.org/wiki/Transact-SQL

GO				-- GO is a batch seperator.
				-- Batch is a group of one or more Transact-SQL statements sent at the same time to SQL Server for execution
				-- In certain cases it is required. We will see in later chatpers
				-- Do not use a semicolon as a statement terminator after GO.
				-- GO can be used to repeat a batch multiple times
				-- https://docs.microsoft.com/en-us/sql/t-sql/language-elements/sql-server-utilities-statements-go?view=sql-server-ver15


DROP DATABASE IF EXISTS WP;	
GO				

CREATE DATABASE WP;
GO

USE WP;
GO

CREATE TABLE DEPARTMENT(
	DepartmentName		Char(35)		NOT NULL,
	BudgetCode			Char(30)		NOT NULL,
	OfficeNumber		Char(15)		NOT NULL,
	DepartmentPhone		Char(12)		NOT NULL,
	CONSTRAINT 			DEPARTMENT_PK 	PRIMARY KEY(DepartmentName)
	);

CREATE TABLE EMPLOYEE(
	EmployeeNumber		Int 			NOT NULL IDENTITY (1, 1),
	FirstName			Char(25) 		NOT NULL,
	LastName			Char(25) 		NOT NULL,
	Department			Char(35)		NOT NULL DEFAULT 'Human Resources',
	Position			Char(35)		NULL,
	Supervisor			Int				NULL,
	OfficePhone			Char(12)		NULL,
	EmailAddress		VarChar(100)	NOT NULL UNIQUE,
	CONSTRAINT 			EMPLOYEE_PK 	PRIMARY KEY(EmployeeNumber),
	CONSTRAINT 			EMP_DEPART_FK	FOREIGN KEY(Department)
							REFERENCES DEPARTMENT(DepartmentName)
							ON UPDATE CASCADE,
	CONSTRAINT			EMP_SUPER_FK	FOREIGN KEY(Supervisor)
							REFERENCES EMPLOYEE (EmployeeNumber)						
	);

CREATE TABLE PROJECT (
	ProjectID			Int				NOT NULL IDENTITY (1000, 100),
	ProjectName			Char(50) 		NOT NULL,
	Department			Char(35)		NOT NULL,
	MaxHours			Numeric(8,2)	NOT NULL DEFAULT 100,
    StartDate			Date			NULL,
    EndDate				Date			NULL,
    CONSTRAINT 			PROJECT_PK 		PRIMARY KEY (ProjectID),
	CONSTRAINT 			PROJ_DEPART_FK	FOREIGN KEY(Department)
							REFERENCES DEPARTMENT(DepartmentName)
								ON UPDATE CASCADE
    );

CREATE TABLE ASSIGNMENT (
   	ProjectID			Int	 			NOT NULL,
	EmployeeNumber		Int	 			NOT NULL,
    HoursWorked			Numeric(6,2)	NULL,
   	CONSTRAINT 			ASSIGNMENT_PK 	PRIMARY KEY (ProjectID, EmployeeNumber),
   	CONSTRAINT 			ASSIGN_PROJ_FK  FOREIGN KEY (ProjectID)
							REFERENCES PROJECT (ProjectID)
								ON UPDATE NO ACTION
								ON DELETE CASCADE,
    CONSTRAINT 			ASSIGN_EMP_FK   FOREIGN KEY (EmployeeNumber)
							REFERENCES EMPLOYEE (EmployeeNumber)
								ON UPDATE NO ACTION
								ON DELETE NO ACTION
 	);

/********************************************************************************/