# Global Layoffs (2020–2023) — SQL Data Cleaning & Analysis

This SQL project focuses on cleaning and analyzing global layoff data, with a special emphasis on the impact during the **COVID-19 era**. The objective was to prepare the dataset for meaningful analysis, uncover key patterns, and highlight industries and regions most affected by workforce reductions.

The dataset contains detailed records of layoffs by companies worldwide during the years **2020**, **2021**, **2022**, and **2023**.

---

## Dataset

The dataset contains the following key columns:

- **company** – Name of the company  
- **location** – City or region where the layoffs occurred  
- **industry** – Sector in which the company operates  
- **total_laid_off** – Total number of employees laid off  
- **percentage_laid_off** – Proportion of workforce laid off  
- **date** – Date of the layoff event  
- **stage** – Business stage of the company (e.g., Startup, Public)  
- **country** – Country where layoffs occurred  
- **funds_raised_millions** – Amount of funding raised by the company (in millions)

You can download the dataset from:  
[🔗 Layoffs Dataset on Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022/data)

---

## Steps Involved

### Data Cleaning
- Removed duplicate entries to maintain data integrity using CTEs and `ROW_NUMBER()`
- Standardized inconsistent data (e.g., company and industry names)
- Converted string-based dates into proper `DATE` format
- Filled in missing values through self-joins
- Removed rows lacking layoff information (both `total_laid_off` and `percentage_laid_off` were null)
- Dropped unnecessary columns after processing

### Exploratory Data Analysis (EDA)
- Analyzed total layoffs by company, industry, country, and year
- Identified companies with 100% workforce layoffs (possible shutdowns)
- Explored monthly layoff trends and cumulative patterns over time
- Extracted top 5 companies with the highest layoffs per year

---

## Key Observations
- Layoffs peaked during the height of the COVID-19 pandemic
- The **United States** had the highest concentration of layoffs
- Industries most affected: **Retail, Consumer Services, and Transportation**
- Several companies recorded 100% layoffs, suggesting complete closures

---

## 🛠Technologies & SQL Concepts Used

**Tool:**  
- MySQL Workbench

**SQL Techniques:**  
- `Common Table Expressions (CTEs)`: Used to isolate and remove duplicates  
- `Window Functions`: Leveraged `ROW_NUMBER()` to identify redundant records  
- `Joins`: Used self-joins to fill missing industry values  
- `String Functions`: Applied `TRIM()` and `STR_TO_DATE()` for text cleaning and date conversion  
- `Conditional Updates`: Updated fields based on specific filters (e.g., replacing blanks with NULLs)  
- `Aggregate Queries`: Used `DISTINCT`, `GROUP BY`, and summary functions to support EDA


