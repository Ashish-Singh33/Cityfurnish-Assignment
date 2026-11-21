/*
For	customers	who	signed	up	in	each calendar month (cohorts), what percentage
had	closed	all	their rentals within 3 months of signup? Show cohort	month and
the	percentage.
*/

WITH customer_check AS (
    SELECT
        c.customer_id,
        DATE_TRUNC('month', c.signup_date)::date AS cohort_month,
        COUNT(r.rental_id) AS total_rentals,
        COUNT(CASE WHEN r.status = 'closed'
                    AND r.end_date <= c.signup_date + INTERVAL '3 months'
                   THEN 1 END) AS closed_in_time
    FROM customers c
    LEFT JOIN rentals r ON r.customer_id = c.customer_id
    GROUP BY c.customer_id, DATE_TRUNC('month', c.signup_date)::date
)
SELECT
    cohort_month,
    ROUND(AVG(CASE WHEN total_rentals = closed_in_time THEN 1 ELSE 0 END) * 100.0, 2) AS pct_within_3m
FROM customer_check
GROUP BY cohort_month
ORDER BY cohort_month;