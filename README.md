World Layoffs Data Cleaning Project
Project Overview

This project involves a comprehensive data cleaning process of a raw layoffs dataset using MySQL. The goal was to transform messy, unformatted data into a structured format ready for exploratory data analysis (EDA).

Dataset
  Source: Kaggle World Layoffs Dataset
  Description: Contains information on company layoffs, including location, industry, total laid off, and funding stage.

Steps Taken
  Deduplication: Identified and removed duplicate records using ROW_NUMBER() and CTEs.
  
  Standardization:
      Fixed inconsistent naming (e.g., merging "Crypto", "CryptoCurrency", and "Crypto Currency").
      Standardized date formats from strings to DATE types.
      
  Null Value Handling: Populated missing values for "Industry" by joining the table with itself where data was available in                         other rows.
  
  Schema Refinement: Dropped redundant columns and rows with unusable null data to streamline the dataset.

Tools Used
MySQL Workbench: For writing and executing cleaning scripts.
GitHub: For version control and documentation.

How to Use
Import the raw_table_layoffs.csv into your MySQL environment.
Run the world_layoffs_cleaning_project.sql script to perform the transformations.
