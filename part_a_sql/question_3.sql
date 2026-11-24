/*
Which	acquisition	channel	brings	customers	with	the	best	payment	success	rate,
and	which	brings	customers	with	the	longest	average	rental	duration?
*/

WITH payment_per_rental AS (
    SELECT
        rental_id,
        COUNT(*) AS total_payments,
        COUNT(CASE WHEN status = 'success' THEN 1 END) AS success_payments
    FROM payments
    GROUP BY rental_id
)
SELECT
    c.channel,
    ROUND((SUM(p.success_payments)*100.0) / SUM(p.total_payments), 2) AS payment_success_rate,
    ROUND(AVG(CASE WHEN r.status = 'closed' THEN r.end_date - r.start_date END), 2) AS avg_rental_duration
FROM customers c
JOIN rentals r ON r.customer_id = c.customer_id
LEFT JOIN payment_per_rental p ON p.rental_id = r.rental_id
GROUP BY c.channel
ORDER BY payment_success_rate DESC;
