
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name-Reeti>
-- Create date: <Create Date,,28-03-2021>
-- Description:	<Description,, Spliting up the customers data based on the country and load them into corresponding country tables >
-- =============================================
CREATE PROCEDURE PatientData_ETL
	
AS
BEGIN
	
	--Declaring variables which we needed
	DECLARE @CountryCount int, @COUNTRY CHAR(5), @tableName char(20), @sql NVARCHAR(MAX)
	
	--Taking the number of cuntries 
	SELECT   @CountryCount=count(DISTINCT COUNTRY) from Customer

	-- Creating temp table just for the country so we can use in table creation
	SELECT DISTINCT COUNTRY,  IDENTITY(INT,1,1) AS ID into #CountryDetail from customer


WHILE @CountryCount>0
BEGIN
	
	
	SELECT @COUNTRY= COUNTRY FROM #CountryDetail WHERE ID=@CountryCount
	set @tableName= 'Table_'+@COUNTRY
	
	--Checking if we have table present int the db, if yes then droping the table. 
	IF  EXISTS ( SELECT TABLE_NAME  FROM INFORMATION_SCHEMA.tables  WHERE TABLE_NAME = @tableName)
	BEGIN
		SET @sql= 'DROP TABLE '+ @tableName
		EXEC (@sql)
	END

	--Putting customer data to the corresponding table 
	SET @sql='SELECT * INTO TABLE_' +@COUNTRY  + 'FROM CUSTOMER WHERE COUNTRY ='''+@COUNTRY+''''
	EXEC(@sql)

	-- Printing the table data 
	SET @sql ='select * from TABLE_'+@COUNTRY
	EXEC (@sql)
	SET @CountryCount = @CountryCount-1
	
END
GO
  


