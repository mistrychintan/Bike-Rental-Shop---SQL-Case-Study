# Bike-Rental-Shop---SQL-Case-Study

## Introduction
This project is a SQL case study focused on analyzing bike rental shop data to provide business insights. Emily, the shop owner, has several business questions that need to be answered using SQL. The dataset consists of multiple tables related to customers, bikes, rentals, and memberships.


## Dataset Overview
The bike rental shop database contains the following tables:

1. **customer** - Stores customer details (ID, name, email).
2. **bike** - Stores bike details (ID, model, category, rental prices, status).
3. **rental** - Records rental transactions (ID, customer ID, bike ID, rental start time, duration, total paid).
4. **membership_type** - Defines different membership types (ID, name, description, price).
5. **membership** - Records purchased memberships (ID, membership type ID, customer ID, start date, end date, total paid).

## Business Questions and SQL Solutions
The project includes SQL queries that answer the following business questions:

1. **Count of Bikes by Category**  
   - Determine the number of bikes available in each category.

2. **Customer Memberships**  
   - List customer names with the total number of memberships purchased.

3. **Discounted Rental Prices**  
   - Apply winter discounts to bike rentals based on bike type.

4. **Rental and Availability Counts**  
   - Count the number of rented and available bikes by category.

5. **Rental Revenue Analysis**  
   - Calculate total rental revenue by month, by year, and across all years.

6. **Membership Revenue Analysis**  
   - Compute total membership revenue segmented by year, month, and membership type.

7. **2023 Membership Revenue Breakdown**  
   - Generate subtotals and grand totals for memberships purchased in 2023.

8. **Customer Segmentation Based on Rentals**  
   - Classify customers into segments based on the number of rentals.
  
  ## File Structure
- `PROBLEM_STATEMENT-Bike_Rental_Case_Study.pdf` - The case study problem statement.
- - `CREATE_DATABASE` - SQL script to create and populate the dataset.
- `SOLUTION` - SQL queries that solve the business questions.


## Technologies Used
- **SQL (Structured Query Language)**
- **Microsoft SQL Server** (for query execution)

## How to Use
1. Clone the repository:
   ```sh
   git clone [https://github.com/yourusername/bike-rental-sql-case-study.git](https://github.com/mistrychintan/Bike-Rental-Shop---SQL-Case-Study/tree/main)
