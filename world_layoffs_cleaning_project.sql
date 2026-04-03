-- Data cleaning steps to take
-- 1. Create a new table for the raw data to carry out all changes there, while keeping the original table untouched, just incase I make a mistake.
-- 2. Get rid of duplicates
-- 3. Standardize the data
-- 4. Remove null values or blank values
-- 5. Remove any columns or rows that are irrelevant or blank.

-- CREATE NEW TABLE
SELECT *
FROM layoffs;

CREATE TABLE layoffs_1
LIKE layoffs;

SELECT*
FROM layoffs_1;

INSERT INTO layoffs_1
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_1;

-- REMOVE DUPLICATES

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_1;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_1
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `layoffs_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
  
  SELECT *
  FROM layoffs_2;

INSERT INTO layoffs_2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_1;

SELECT *
FROM layoffs_2
WHERE row_num > 1;

DELETE 
FROM layoffs_2
WHERE row_num > 1;

-- Standardizing data

SELECT company, TRIM(company)
FROM layoffs_2;

UPDATE layoffs_2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_2
ORDER BY 1;

SELECT *
FROM layoffs_2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_2
ORDER BY 1;

UPDATE layoffs_2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_2;

UPDATE layoffs_2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_2
MODIFY COLUMN `date` DATE; 

-- Working with NULL and blank values

SELECT *
FROM layoffs_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_2
WHERE industry IS NULL
OR industry = '';

UPDATE layoffs_2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_2
WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry, t1.company
FROM layoffs_2 t1
JOIN layoffs_2 t2
    ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_2 t1
JOIN layoffs_2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Removing irrelevant rows and columns

SELECT *
FROM layoffs_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_2;

ALTER TABLE layoffs_2
DROP COLUMN row_num;
