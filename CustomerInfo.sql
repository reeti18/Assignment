CREATE TABLE dbo.Customer(
	[Customer_Name] VARCHAR(255) NOT NULL ,
	[Customer_Id]   int NOT NULL PRIMARY KEY,
	[Open_Date]     CHAR(8) NOT NULL,
	[Last_Consulted_Date] CHAR(8) NULL,
	[Vaccination_Id] CHAR(5) NULL,
	[Dr_Name] VARCHAR(255) NULL ,
	[State] CHAR(5) NULL,
	[Country] CHAR(5) NULL,
	[DOB] CHAR(8) NULL,
	[Is_Active] CHAR(1) NULL
	) 