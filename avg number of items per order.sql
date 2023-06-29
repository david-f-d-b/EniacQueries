# code along 260623

use magist;
WITH sub AS
(
SELECT oi.product_id FROM order_items AS oi
RIGHT JOIN products AS p
ON oi.product_id = p.product_id
)


SELECT p.product_id, COUNT(oi.product_id)
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
AVG(price)
FROM order_items;
#GROUP BY order_id;

SELECT 
AVG(payment_value)
FROM order_payments;

#GROUP BY order_id;
SELECT COUNT(product_id), COUNT(DISTINCT product_id), COUNT(DISTINCT order_id), COUNT(product_id) / COUNT(DISTINCT order_id)
FROM order_items;
