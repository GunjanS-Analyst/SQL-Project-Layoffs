# 🧮 COVID-19 Layoffs: Insights Through SQL

This SQL project focuses on cleaning and analyzing global layoff data, with a special lens on the COVID-19 era. The aim was to prepare the dataset for analysis, uncover key patterns, and highlight the industries and regions most affected by workforce reductions.

---

## 🔧 Steps Involved

### 🧹 Data Cleaning
- Removed duplicate entries to maintain data integrity  
- Standardized company and industry names for consistency  
- Converted string-based dates into proper `DATE` format  
- Handled blank and null values  
- Removed rows without meaningful layoff information  

### 📊 Exploratory Data Analysis
- Analyzed total layoffs by company, industry, country, and year  
- Identified companies with 100% layoffs (potential shutdowns)  
- Tracked monthly and cumulative layoff trends  
- Extracted top 5 companies with the most layoffs per year  

---

## 💡 Key Observations
- Layoffs peaked during the COVID-19 pandemic  
- The USA experienced the highest number of layoffs  
- Retail, consumer services, and transportation industries were most affected  
- Several companies appeared to shut down completely (100% layoffs)  

---

## 🛠️ Technologies & SQL Concepts Used
- **Tool**: MySQL Workbench  
- **SQL Techniques**:  
  - Window functions (`ROW_NUMBER()`)  
  - Common Table Expressions (CTEs)  
  - Aggregate functions and grouping  
  - Date formatting and transformation  

---

## 📁 Files Included
- `layoffs.sql`: Contains all queries for data cleaning and analysis  
- `layoff_data.csv`: Original dataset (if included)  
- `README.md`: Project overview and documentation  


