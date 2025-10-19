CREATE DATABASE financial_analysis;
USE financial_analysis;
-- Create Table
CREATE TABLE company_financials (
    Company_ID INT PRIMARY KEY,
    Company_Name VARCHAR(100),
    Year INT,
    Revenue DECIMAL(12,2),
    Profit DECIMAL(12,2),
    Assets DECIMAL(12,2),
    Liabilities DECIMAL(12,2),
    ROI DECIMAL(5,2),
    StockPrice DECIMAL(10,2),
    RiskScore DECIMAL(5,2)
);
select* from company_financials;
#Calculate Profit Margin & Debt Ratio
-- Profit Margin (%)
SELECT Company_Name, ROUND((Profit / Revenue) * 100, 2) AS Profit_Margin
FROM company_financials;
-- Debt Ratio (%)
SELECT Company_Name, ROUND((Liabilities / Assets) * 100, 2) AS Debt_Ratio
FROM company_financials;
# ROI Ranking
SELECT 
    Company_Name, 
    ROI, 
    RANK() OVER (ORDER BY ROI DESC) AS ROI_Rank
FROM company_financials;

# Calculate Profit Margin & Debt Ratio
SELECT 
    Company_Name,
    ROUND((Profit / Revenue) * 100, 2) AS Profit_Margin,
    ROI,
    ROUND((Liabilities / Assets) * 100, 2) AS Debt_Ratio,
    RiskScore,
    CASE 
        WHEN (Profit / Revenue) * 100 > 20 AND ROI > 10 AND (Liabilities / Assets) * 100 < 50 THEN 'Healthy'
        WHEN (Profit / Revenue) * 100 BETWEEN 10 AND 20 THEN 'Moderate'
        ELSE 'Risky'
    END AS Company_Health
FROM company_financials;

# Identify High Risk Companies
SELECT 
    Company_Name,
    RiskScore,
    ROUND((Liabilities / Assets) * 100, 2) AS Debt_Ratio
FROM company_financials
WHERE RiskScore > 60 OR (Liabilities / Assets) * 100 > 70;

#Investment Potential Prediction
SELECT 
    Company_Name,
    ROI,
    Profit,
    CASE 
        WHEN ROI >= 15 AND Profit >= 100000 THEN 'Excellent Investment'
        WHEN ROI BETWEEN 8 AND 14 THEN 'Moderate Investment'
        ELSE 'High Risk Investment'
    END AS Investment_Potential
FROM company_financials;

#Export Data for Power BI (Optional)


SHOW VARIABLES LIKE 'secure_file_priv';
SELECT * 
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/financial_analysis_output.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM company_financials;































