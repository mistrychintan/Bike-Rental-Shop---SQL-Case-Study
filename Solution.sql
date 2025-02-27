USE BIKE_RENTAL_SHOP;

--1. Emily would like to know how many bikes the shop owns by category
--Display the category name and the number of bikes the shop owns in
--each category (call this column number_of_bikes ). Show only the categories
--where the number of bikes is greater than 2 .

SELECT * FROM bike;

SELECT category, COUNT(ID) AS number_of_bikes
	FROM bike
	GROUP BY category
	HAVING COUNT(ID)>2;

--2. Emily needs a list of customer names with the total number of
--memberships purchased by each.
--For each customer, display the customer's name and the count of
--memberships purchased (call this column membership_count ). Sort the
--results by membership_count , starting with the customer who has purchased
--the highest number of memberships.


SELECT customer.customer_name, COUNT(membership.ID) AS membership_count
	FROM customer
	RIGHT JOIN membership ON membership.customer_id = customer.ID
	GROUP BY customer.customer_name
	ORDER BY COUNT(membership.ID) DESC;


--3. Emily is working on a special offer for the winter months. Can you help her
--prepare a list of new rental prices?
--For each bike, display its ID, category, old price per hour (call this column
--old_price_per_hour ), discounted price per hour (call it new_price_per_hour ), old
--price per day (call it old_price_per_day ), and discounted price per day (call it
--new_price_per_day ).

SELECT ID, category, price_per_hour AS old_price_per_hour,
	ROUND(
		CASE 
			WHEN category = 'electric' THEN price_per_hour *.90
			WHEN category = 'mountain bike' THEN price_per_hour *.80
			ELSE price_per_hour * .50
			END,2) AS new_price_per_hour,
	price_per_day AS old_price_per_day,
	ROUND(
		CASE 
			WHEN category = 'electric' THEN price_per_day*.80
			WHEN category = 'mountain bike' THEN price_per_day*.50
			ELSE price_per_day* .50
			END,2) AS new_price_per_day
	FROM bike;

--4. Emily is looking for counts of the rented bikes and of the available bikes in
--each category.
--Display the number of available bikes (call this column
--available_bikes_count ) and the number of rented bikes (call this column
--rented_bikes_count ) by bike category.

SELECT * FROM bike;

SELECT category,
		COUNT(CASE WHEN [status] = 'available' THEN 1 END) AS available_bike_count,
		COUNT(CASE WHEN [status] = 'rented' THEN 1 END) AS rented_bike_count
	FROM bike
	GROUP BY category;

--5. Emily is preparing a sales report. She needs to know the total revenue
--from rentals by month, the total by year, and the all-time across all the
--years. 
--Display the total revenue from rentals for each month, the total for each
--year, and the total across all the years. Do not take memberships into
--account. There should be 3 columns: year , month , and revenue .
--Sort the results chronologically. Display the year total after all the month
--totals for the corresponding year. Show the all-time total as the last row.

--SELECT * FROM rental;
--SELECT YEAR(start_timestamp) AS year,
--		MONTH(start_timestamp) AS month,
--		SUM(total_paid)
--	FROM rental
--	GROUP BY YEAR(start_timestamp),MONTH(start_timestamp);

--SELECT 
--    YEAR(start_timestamp) AS year, 
--    MONTH(start_timestamp) AS month, 
--    SUM(total_paid) AS revenue
--FROM rental
--GROUP BY year(start_timestamp), month(start_timestamp)

--UNION ALL

SELECT 
    YEAR(start_timestamp) AS year, 
    NULL AS month, 
    SUM(total_paid) AS revenue
FROM rental
GROUP BY year(start_timestamp)

UNION ALL

SELECT 
    NULL AS year, 
    NULL AS month, 
    SUM(total_paid) AS revenue
FROM rental

UNION ALL 

SELECT 
    YEAR(start_timestamp) AS year, 
    MONTH(start_timestamp) AS month, 
    SUM(total_paid) AS revenue
FROM rental
GROUP BY year(start_timestamp), month(start_timestamp)

ORDER BY year, month;


--6. Emily has asked you to get the total revenue from memberships for each
--combination of year, month, and membership type.
--Display the year, the month, the name of the membership type (call this
--column membership_type_name ), and the total revenue (call this column
--total_revenue ) for every combination of year, month, and membership type.
--Sort the results by year, month, and name of membership type.

SELECT * FROM membership;

SELECT YEAR(start_date) AS Year,
		MONTH(start_date) AS Month,
		membership_type.[name] AS membership_type_name,
		SUM(total_paid) AS total_revenue
		FROM membership
		join membership_type ON membership.membership_type_id = membership_type.ID
		GROUP BY YEAR(start_date),MONTH(start_date),membership_type.[name]
		ORDER BY YEAR(start_date),MONTH(start_date),membership_type.[name];

--7.Next, Emily would like data about memberships purchased in 2023, with
--subtotals and grand totals for all the different combinations of membership
--types and months.
--Display the total revenue from memberships purchased in 2023 for each
--combination of month and membership type. Generate subtotals and
--grand totals for all possible combinations. There should be 3 columns:
--membership_type_name , month , and total_revenue .


SELECT membership_type.[name] AS membership_type_name,
		MONTH(start_date) AS month,
		SUM(total_paid) AS total_revenue
		FROM membership JOIN membership_type ON membership.membership_type_id = membership_type.ID
		WHERE YEAR(start_date) = 2023
		GROUP BY CUBE(membership_type.name, MONTH(start_date))
		ORDER BY membership_type.name, MONTH(start_date);


--8. Emily wants to segment customers based on the number of rentals and
--see the count of customers in each segment. Use your SQL skills to get
--this!
--Categorize customers based on their rental history as follows:
--Customers who have had more than 10 rentals are categorized as 'more
--than 10' .
--Customers who have had 5 to 10 rentals (inclusive) are categorized as
--'between 5 and 10' .
--Customers who have had fewer than 5 rentals should be categorized as
--'fewer than 5' .
--Calculate the number of customers in each category. Display two columns:
--rental_count_category (the rental count category) and customer_count (the
--number of customers in each category).

WITH cte AS 
(
    SELECT 
        customer_id, 
        COUNT(*) AS rental_count,
        CASE 
            WHEN COUNT(*) > 10 THEN 'more than 10' 
            WHEN COUNT(*) BETWEEN 5 AND 10 THEN 'between 5 and 10'
            ELSE 'fewer than 5'
        END AS category
    FROM rental
    GROUP BY customer_id
)
SELECT 
    category AS rental_count_category, 
    COUNT(*) AS customer_count
FROM cte 
GROUP BY category
ORDER BY customer_count;

