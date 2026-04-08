WORLD LAYOFFS: DATA CLEANING AND EXPLORATORY ANALYSIS PROJECT

PROJECT OVERVIEW

This project is a comprehensive SQL-based study of global layoffs. It covers the entire data lifecycle from raw data ingestion to cleaning and final insight generation.

DATASET
  
  Source: Kaggle World Layoffs Dataset
  
  Description: Contains information on company layoffs, including location, industry, total laid off, and funding stage.

PROJECT STRUCTURE

  * raw_table_layoffs.csv : The raw dataset

  * world_layoffs_cleaning_project.sql : My script for removing duplicates, standardizing data and handling nulls.

  * world_layoffs_analysis.sql : The exploratory analysis script.
  
KEY SQL TECHNIQUES USED

  -- CTEs & Window Functions : Used for identifying duplicates and ranking layoffs by year.

  -- Aggregations : Calculated rolling totals and funding-to-layoff-ratios.

  -- Data Standardization : Cleaned inconsistent industry naming.

TOP FINDINGS

   1. The Funding Paradox : Companies with over $1B in funding (Post-IPO) still saw massive layoffs, proving that capital doesn't always equal job security

   2. Industry Hits : The Retail and Consumer industries were hit hardest overall during the analysed period.

TOOLS USED

MySQL Workbench: For writing and executing scripts.

GitHub: For version control and documentation.


