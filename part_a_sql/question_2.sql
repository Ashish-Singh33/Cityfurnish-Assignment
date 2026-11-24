/*
For	customers	who	signed	up	in	each calendar month (cohorts), what percentage
had	closed	all	their rentals within 3 months of signup? Show cohort month and
the	percentage.
*/

WITH customer_rentals AS (
    SELECT
        c.customer_id,
        c.signup_date,
        DATE_TRUNC('month', c.signup_date)::date AS cohort_month,
        COUNT(r.rental_id) AS total_rentals,
        COUNT(r.rental_id) FILTER (
            WHERE r.status = 'closed'
              AND r.end_date <= c.signup_date + INTERVAL '3 months'
        ) AS closed_rentals
    FROM customers c
    LEFT JOIN rentals r
        ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.signup_date
),

eligible_customers AS (
    SELECT *
    FROM customer_rentals
    WHERE (cohort_month + INTERVAL '1 month' - INTERVAL '1 day') + INTERVAL '3 months'
          <= (SELECT MAX(end_date) FROM rentals)
)

SELECT
    cohort_month,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE total_rentals > 0
              AND total_rentals = closed_rentals
        ) / COUNT(*),
        2
    ) AS percentage
FROM eligible_customers
GROUP BY cohort_month
ORDER BY cohort_month;