/*
Month-wise count of new rentals started and month-wise rental revenue
collected (successful payments only), for the full period in the data.
*/

WITH monthly AS (
    SELECT 
        DATE_TRUNC('month', start_date)::date AS month,
        1 AS new_rentals,
        0 AS revenue
    FROM rentals

    UNION ALL

    SELECT 
        DATE_TRUNC('month', payment_date)::date,
        0,
        amount
    FROM payments
    WHERE status = 'success'
)
SELECT
    month,
    SUM(new_rentals) AS new_rentals,
    SUM(revenue) AS revenue
FROM monthly
GROUP BY month
ORDER BY month;