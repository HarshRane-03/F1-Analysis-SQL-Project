# Formula 1 Performance & 2025 Grid Analysis 🏎️

## Project Overview
This project provides a comprehensive analysis of Formula 1 driver statistics, historical champions, and the projected 2025 grid. Using a relational database, I explore driver efficiency, national rankings, and team performance metrics.

## Features
* **SQL Techniques:** Joins, CTEs (Common Table Expressions), Window Functions (`RANK()`), and Case Statements.
* **Analysis Categories:** * Beginner: Basic filtering and aggregation.
  * Intermediate: Performance categorization and subqueries.
  * Advanced: National point contributions and decade dominance rankings.

## Repository Structure
* `project.sql`: The full SQL script containing table schemas and analysis queries.
* `datasets file `: containing the raw CSV files used to populate the database.

## 🛠️ How to Replicate This Project
Follow these steps to set up the environment and run the analysis:

### 1. Prepare the Database
Open your SQL editor (like MySQL Workbench) and execute the `CREATE TABLE` statements found at the beginning of `project.sql` to set up the `f1_drivers`, `f1_teams`, and `f1_results_history` tables.

### 2. Import the Data
Since the script uses a `DROP TABLE` and `CREATE TABLE` structure, you should import the CSV files from the `/datasets` file using your SQL tool's **Import Wizard**:
* Import `f1_drivers_fixed.csv` into the `f1_drivers` table.

### 3. Run the Analysis
Execute the queries labeled Q1 through Q16 in the `project.sql` file to generate insights on driver win rates, nationality trends, and engine supplier value.

## Key Insights
* **Championship Efficiency:** Comparing 2025 driver performance against historical title-winning seasons.
* **National Dominance:** A ranking of drivers within their respective countries based on total career points.
