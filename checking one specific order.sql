SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    order_purchase_timestamp,
    order_item_id,
    product_id,
    price,
    freight_value,
    payment_sequential, payment_type, payment_installments,
    payment_value
FROM
    orders AS o
        LEFT JOIN
    order_payments AS op ON o.order_id = op.order_id
        LEFT JOIN
    order_items AS oi ON o.order_id = oi.order_id
WHERE
    customer_id = 'f6dd3ec061db4e3987629fe6b26e5cce'
#GROUP BY 1 , 2
#ORDER BY 1;
;

SELECT COUNT(customer_id), COUNT(DISTINCT customer_id)
#customer_id, COUNT(customer_id) AS order_count
FROM orders
#GROUP BY 1
#HAVING COUNT(order_id) > 1
#ORDER BY 2 DESC
#LIMIT 50;
;

SELECT * FROM orders
LIMIT 5;

/*

DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS year_month_date,
    order_status,
    SUM(op.payment_value),
    SUM(oi.price)
    
    */