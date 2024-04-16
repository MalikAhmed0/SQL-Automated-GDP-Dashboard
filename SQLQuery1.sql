--Create Database Data_Analyst
--use Data_Analyst

--Step 1: Create the table
IF OBJECT_ID('RAW_DATA_GDP') is not null DROP TABLE RAW_DATA_GDP

CREATE TABLE RAW_DATA_GDP(
DEMO_IND varchar(200),
Indicator varchar(200),
[LOCATION] varchar(200),
Country varchar(200),
[TIME] varchar(200),
[Value] float,
[Flag Codes] varchar(200),
Flags varchar(200)
)

--Step 2: Import data from excel
BULK INSERT RAW_DATA_GDP
FROM 'D:\CAREER JOURNEY\Portfolio\Automated SQL BI Dashboard Project\gdp_raw_data.csv'
WITH (
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '0x0A'
FORMAT='CSV')

--Step 3: Create View for dashboard

--DROP VIEW GDP_Excel_Input

CREATE VIEW GDP_Excel_Input AS

SELECT A.*, B.GDP_per_capita FROM

	(SELECT Country, [TIME] as Year_no, [Value] as GDP
	FROM RAW_DATA_GDP
	where Indicator = 'GDP (current US$)') A

	LEFT JOIN

	(SELECT Country, [TIME] as Year_no, [Value] as GDP_per_capita
	FROM RAW_DATA_GDP
	WHERE Indicator = 'GDP per capita (current US$)') B

	ON A.Country = B.Country and A.Year_no = B.Year_no

--SELECT * FROM GDP_Excel_Input

--Step 4: Create a stored Procedure

CREATE PROCEDURE GDP_Excel_Input_Monthly AS

IF OBJECT_ID('RAW_DATA_GDP') is not null DROP TABLE RAW_DATA_GDP

CREATE TABLE RAW_DATA_GDP(
DEMO_IND varchar(200),
Indicator varchar(200),
[LOCATION] varchar(200),
Country varchar(200),
[TIME] varchar(200),
[Value] float,
[Flag Codes] varchar(200),
Flags varchar(200)
)

--Step 2: Import data from excel
BULK INSERT RAW_DATA_GDP
FROM 'D:\CAREER JOURNEY\Portfolio\Automated SQL BI Dashboard Project\gdp_raw_data.csv'
WITH (FORMAT='CSV')

--EXEC GDP_Excel_Input_Monthly