SELECT * FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks` LIMIT 1000;

-- Handling missing values 
-- STEP 1: Filling missing values: Replacing missing values with 0.

UPDATE `big-data-analytics-cloud.lab1_eda.nvda_stocks`
SET Open = 0
WHERE Open IS NULL;

UPDATE `big-data-analytics-cloud.lab1_eda.nvda_stocks`
SET High = 0
WHERE High IS NULL;

UPDATE `big-data-analytics-cloud.lab1_eda.nvda_stocks`
SET Low = 0
WHERE Low IS NULL;

UPDATE `big-data-analytics-cloud.lab1_eda.nvda_stocks`
SET Close = 0
WHERE Close IS NULL;

UPDATE `big-data-analytics-cloud.lab1_eda.nvda_stocks`
SET `Adj Close` = 0
WHERE `Adj Close` IS NULL;

UPDATE `big-data-analytics-cloud.lab1_eda.nvda_stocks`
SET Volume = 0
WHERE Volume IS NULL;

-- STEP 2: Ensuring proper Date types using CAST

SELECT
  PARSE_DATE('%Y-%m-%d', CAST(Date AS STRING)) AS Date,
  CAST(Open AS FLOAT64) AS Open,
  CAST(High AS Float64) AS High,
  CAST(Low AS Float64) AS Low,
  CAST(Close AS Float64) AS Close,
  CAST(`Adj Close` AS FLOAT64) AS `Adj Close`,
  CAST(Volume AS INT64) AS Volume
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`;

-- STEP 3: Check for outliers

SELECT
  MIN(Open),
  MAX(Open),
  MIN(High),
  MAX(High),
  MIN(Low),
  MAX(Low),
  MIN(Close),
  MAX(Close),
  MIN(`Adj Close`),
  MAX(`Adj Close`),
  MIN(Volume),
  MAX(Volume)
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`;

-- STEP 4: Checking for duplicate records
SELECT
  DATE,
  COUNT(*) AS Duplicate_records
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`
GROUP BY Date
HAVING COUNT(*) > 1;

-- EXPLORING THE DATA WITH DESCRIPTIIVE STATISTICS
-- Avergae Values for Each Numerical columns

SELECT
  AVG(Open) AS avg_open,
  AVG(High) AS avg_high,
  AVG(Low) AS avg_low,
  AVG(Close) AS avg_close,
  AVG(`Adj Close`) AS avg_adj_close,
  AVG(Volume) AS avg_volume_traded
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`;

-- Refining the query to get average for a specific year like 2023
SELECT
  AVG(Open) AS avg_open_2023,
  AVG(High) AS avg_high_2023,
  AVG(Low) AS avg_low_2023,
  AVG(Close) AS avg_close_2023,
  AVG(`Adj Close`) AS avg_adj_close_2023,
  AVG(Volume) AS avg_volume_2023
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`
WHERE EXTRACT(YEAR FROM Date) = 2023;

-- Refined query to find maximun and minimum by month
SELECT
  EXTRACT(YEAR FROM Date) AS Year,
  EXTRACT(MONTH FROM Date) AS Month,
  MIN(Low) AS min_low_price,
  MAX(High) AS max_high_price
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`
GROUP BY year, month
ORDER BY year, month;

-- Counting the number of trading days
SELECT  
  COUNT(DISTINCT Date) AS count_trading_days
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`;

-- Identify High trading volume days
SELECT
  Date AS high_trading_volume_days,
  Volume
FROM `big-data-analytics-cloud.lab1_eda.nvda_stocks`
WHERE Volume > 10000000
ORDER BY Volume DESC;

-- Refined query to calculate daily percentage change

WITH daily_changes AS (
  SELECT
    Date,
    Close,
    LAG(Close) OVER (ORDER BY Date) AS previous_day_close
  FROM  `big-data-analytics-cloud.lab1_eda.nvda_stocks`
)
SELECT
  ((Close - previous_day_close) / previous_day_close) * 100 AS daily_pct_change
FROM daily_changes
WHERE previous_day_close IS NOT NULL
ORDER BY Date;

-- Stock performance over time
SELECT
  EXTRACT(YEAR FROM Date) AS year,
  AVG(Close) AS avg_close_price
FROM  `big-data-analytics-cloud.lab1_eda.nvda_stocks`
GROUP BY year
ORDER BY year;
