# NVIDIA-Stock-Analysis-Using-GCP-BigQuery-and-SQL

Overview
This project involves the comprehensive analysis and data cleaning of NVIDIA's stock price data using Google Cloud Platform (GCP) and BigQuery. The dataset contains daily stock trading data with fields such as Date, Open, High, Low, Close, Adj Close, and Volume. The analysis focuses on calculating key financial statistics, identifying outliers, and ensuring data quality by handling missing values.

Objectives
Data Cleaning: Handle missing values and ensure proper data types for stock price and volume data.
Data Exploration: Perform exploratory data analysis (EDA) using SQL on BigQuery.
Statistical Analysis: Compute averages, min/max values, and investigate volume outliers.
Insights: Analyze trading volume trends, daily percentage changes in stock prices, and overall stock performance over time.

Technologies Used
Google Cloud Platform (GCP)
BigQuery: Used for running all SQL queries and performing data analysis.
SQL: Primary language for querying and cleaning the stock data.
Google Cloud Console: Interface for managing BigQuery datasets and running SQL queries.

Data Cleaning and Preprocessing
Replaced missing values in Open, High, Low, Close, Adj Close, and Volume with 0 using SQL.
Ensured correct data types for all fields using the CAST() function and standardized date formats with PARSE_DATE().
Checked for outliers, with a particular focus on abnormal trading volumes.

Exploratory Data Analysis (EDA)
Computed key statistics such as average, minimum, and maximum values for stock prices and trading volume.
Analyzed the data to identify days with exceptionally high trading volumes.
Calculated the daily percentage change in stock prices to observe market fluctuations.
Tracked the stock’s performance over time by calculating average closing prices for each year.

SQL Queries
Here are some of the key SQL queries used in this project:

Average Values for Stock Prices:

SELECT AVG(Open), 
       AVG(Close), 
       AVG(High), 
       AVG(Low), 
       AVG(`Adj Close`), 
       AVG(Volume)
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`;

Volume Outlier Detection:
SELECT Date, Volume 
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`
WHERE Volume > 10000000
ORDER BY Volume DESC;

Conclusion
This project demonstrates how to effectively clean and analyze stock market data using SQL and BigQuery within the Google Cloud Platform. The insights gathered from this analysis provide valuable information on stock price trends, trading volumes, and overall market performance for NVIDIA stocks.

