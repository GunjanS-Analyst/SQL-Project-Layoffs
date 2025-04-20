-- DATA CLEANING PROCESS FOR LAYOFFS DATASET

-- STEP 1: Initial Data Inspection
SELECT * FROM layoffs;

-- STEP 2: Preparing the Staging Table
-- Creating a staging table identical to the original for cleaning operations
CREATE TABLE layoffs_staging LIKE layoffs;

-- Verifying the structure
SELECT * FROM layoffs_staging;

-- Inserting data into the staging table
INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- STEP 3: Removing Duplicates

-- Identify potential duplicates using ROW_NUMBER() function
SELECT *, 
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off, 
                     percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

-- Using CTE to isolate duplicate rows
WITH duplicate_cte AS (
    SELECT *, 
        ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off, 
                         percentage_laid_off, `date`, stage, country, funds_raised_millions
        ) AS row_num
    FROM layoffs_staging
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

-- Checking for a specific company (e.g., Casper) for debugging
SELECT * FROM layoffs_staging
WHERE company = 'Casper';

-- Note: Direct DELETE from a CTE is not possible

-- Workaround: Create a second staging table with row_num and remove duplicates
CREATE TABLE layoffs_staging2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT DEFAULT NULL,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Populating the second staging table with row numbers
INSERT INTO layoffs_staging2
SELECT *, 
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off, 
                     percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

-- Removing duplicate rows (row_num > 1)
DELETE FROM layoffs_staging2
WHERE row_num > 1;

-- Confirming duplicates have been removed
SELECT * FROM layoffs_staging2;

-- STEP 4: Standardizing Data

-- Trim spaces from company names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Standardize the 'industry' column where variations like "Crypto ", "Crypto.com", etc. exist
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Remove trailing periods from the 'country' column (e.g., "United States.")
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Fix the data type for the 'date' column from TEXT to DATE
-- First, convert the string to DATE format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Alter the column to actual DATE type
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- STEP 5: Handling Null and Blank Values

-- Identify null or blank values in the 'industry' column
SELECT * FROM layoffs_staging2
WHERE industry IS NULL OR industry = '';

-- Standardize blank values in 'industry' to NULL
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Populate missing 'industry' values based on company name
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL  
  AND t2.industry IS NOT NULL;

-- Check if any nulls remain
SELECT * FROM layoffs_staging2
WHERE industry IS NULL;

-- STEP 6: Removing Incomplete Rows

-- Identify rows with null values in both layoff count and percentage
SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Delete such rows
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- STEP 7: Final Cleanup

-- Drop helper column used for duplicate removal
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Final check
SELECT * FROM layoffs_staging2;
